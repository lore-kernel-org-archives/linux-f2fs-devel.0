From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/18] f2fs crypto: add encryption support in
	read/write paths
Date: Fri,  8 May 2015 21:20:46 -0700
Message-ID: <1431145253-2019-11-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGi-0007id-Oh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGh-0003sY-8u for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:40 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds encryption support in read and write paths.

Note that, in f2fs, we need to consider cleaning operation.
In cleaning procedure, we must avoid encrypting and decrypting written blocks.
So, this patch implements move_encrypted_block().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++-
 fs/f2fs/data.c       | 96 ++++++++++++++++++++++++++++++++++++++++------------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/gc.c         | 79 +++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/inline.c     |  1 +
 fs/f2fs/node.c       |  2 ++
 fs/f2fs/segment.c    | 24 ++++++++++---
 8 files changed, 180 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1da20a6..98c31db 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -56,6 +56,7 @@ struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 		.type = META,
 		.rw = READ_SYNC | REQ_META | REQ_PRIO,
 		.blk_addr = index,
+		.encrypted_page = NULL,
 	};
 repeat:
 	page = grab_cache_page(mapping, index);
@@ -122,7 +123,8 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = META,
-		.rw = READ_SYNC | REQ_META | REQ_PRIO
+		.rw = READ_SYNC | REQ_META | REQ_PRIO,
+		.encrypted_page = NULL,
 	};
 
 	for (; nrpages-- > 0; blkno++) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 473b4d4..deb6b69 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -57,6 +57,15 @@ static void mpage_end_io(struct bio *bio, int err)
 	struct bio_vec *bv;
 	int i;
 
+	if (f2fs_bio_encrypted(bio)) {
+		if (err) {
+			f2fs_release_crypto_ctx(bio->bi_private);
+		} else {
+			f2fs_end_io_crypto_work(bio->bi_private, bio);
+			return;
+		}
+	}
+
 	bio_for_each_segment_all(bv, bio, i) {
 		struct page *page = bv->bv_page;
 
@@ -81,6 +90,8 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
 
+		f2fs_restore_and_release_control_page(&page);
+
 		if (unlikely(err)) {
 			set_page_dirty(page);
 			set_bit(AS_EIO, &page->mapping->flags);
@@ -161,7 +172,7 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio;
-	struct page *page = fio->page;
+	struct page *page = fio->encrypted_page ? fio->encrypted_page : fio->page;
 
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
@@ -185,6 +196,7 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io;
 	bool is_read = is_read_io(fio->rw);
+	struct page *bio_page;
 
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
@@ -206,7 +218,9 @@ alloc_new:
 		io->fio = *fio;
 	}
 
-	if (bio_add_page(io->bio, fio->page, PAGE_CACHE_SIZE, 0) <
+	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
+
+	if (bio_add_page(io->bio, bio_page, PAGE_CACHE_SIZE, 0) <
 							PAGE_CACHE_SIZE) {
 		__submit_merged_bio(io);
 		goto alloc_new;
@@ -928,8 +942,12 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
 		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
 		.rw = rw,
+		.encrypted_page = NULL,
 	};
 
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+		return read_mapping_page(mapping, index, NULL);
+
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -1066,26 +1084,14 @@ repeat:
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 		SetPageUptodate(page);
 	} else {
-		struct f2fs_io_info fio = {
-			.sbi = F2FS_I_SB(inode),
-			.type = DATA,
-			.rw = READ_SYNC,
-			.blk_addr = dn.data_blkaddr,
-			.page = page,
-		};
-		err = f2fs_submit_page_bio(&fio);
-		if (err)
-			return ERR_PTR(err);
+		f2fs_put_page(page, 1);
 
-		lock_page(page);
-		if (unlikely(!PageUptodate(page))) {
-			f2fs_put_page(page, 1);
-			return ERR_PTR(-EIO);
-		}
-		if (unlikely(page->mapping != mapping)) {
-			f2fs_put_page(page, 1);
+		page = get_read_data_page(inode, index, READ_SYNC);
+		if (IS_ERR(page))
 			goto repeat;
-		}
+
+		/* wait for read completion */
+		lock_page(page);
 	}
 got_it:
 	if (new_i_size &&
@@ -1548,14 +1554,38 @@ submit_and_realloc:
 			bio = NULL;
 		}
 		if (bio == NULL) {
+			struct f2fs_crypto_ctx *ctx = NULL;
+
+			if (f2fs_encrypted_inode(inode) &&
+					S_ISREG(inode->i_mode)) {
+				struct page *cpage;
+
+				ctx = f2fs_get_crypto_ctx(inode);
+				if (IS_ERR(ctx))
+					goto set_error_page;
+
+				/* wait the page to be moved by cleaning */
+				cpage = find_lock_page(
+						META_MAPPING(F2FS_I_SB(inode)),
+						block_nr);
+				if (cpage) {
+					f2fs_wait_on_page_writeback(cpage,
+									DATA);
+					f2fs_put_page(cpage, 1);
+				}
+			}
+
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, bio_get_nr_vecs(bdev)));
-			if (!bio)
+			if (!bio) {
+				if (ctx)
+					f2fs_release_crypto_ctx(ctx);
 				goto set_error_page;
+			}
 			bio->bi_bdev = bdev;
 			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
 			bio->bi_end_io = mpage_end_io;
-			bio->bi_private = NULL;
+			bio->bi_private = ctx;
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
@@ -1674,6 +1704,7 @@ static int f2fs_write_data_page(struct page *page,
 		.type = DATA,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
 		.page = page,
+		.encrypted_page = NULL,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1718,6 +1749,15 @@ write:
 	else if (has_not_enough_free_secs(sbi, 0))
 		goto redirty_out;
 
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+		f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+		fio.encrypted_page = f2fs_encrypt(inode, page);
+		if (IS_ERR(fio.encrypted_page)) {
+			err = PTR_ERR(fio.encrypted_page);
+			goto out;
+		}
+	}
+
 	err = -EAGAIN;
 	f2fs_lock_op(sbi);
 	if (f2fs_has_inline_data(inode))
@@ -1726,6 +1766,8 @@ write:
 		err = do_write_data_page(&fio);
 	f2fs_unlock_op(sbi);
 done:
+	if (err && fio.encrypted_page)
+		f2fs_restore_control_page(fio.encrypted_page);
 	if (err && err != -ENOENT)
 		goto redirty_out;
 
@@ -1897,6 +1939,7 @@ put_next:
 			.rw = READ_SYNC,
 			.blk_addr = dn.data_blkaddr,
 			.page = page,
+			.encrypted_page = NULL,
 		};
 		err = f2fs_submit_page_bio(&fio);
 		if (err)
@@ -1912,6 +1955,15 @@ put_next:
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
+
+		/* avoid symlink page */
+		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+			err = f2fs_decrypt_one(inode, page);
+			if (err) {
+				f2fs_put_page(page, 1);
+				goto fail;
+			}
+		}
 	}
 out:
 	SetPageUptodate(page);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 544766e..1632151 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -656,6 +656,7 @@ struct f2fs_io_info {
 	int rw;			/* contains R/RS/W/WS with REQ_META/REQ_PRIO */
 	block_t blk_addr;	/* block address to be written */
 	struct page *page;	/* page to be written */
+	struct page *encrypted_page;	/* encrypted page */
 };
 
 #define is_read_io(rw)	(((rw) & 1) == READ)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9f4b34c..d7daff8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -500,7 +500,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 truncate_out:
 	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
-	if (!cache_only)
+	if (!cache_only || !f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
 		set_page_dirty(page);
 	f2fs_put_page(page, 1);
 	return 0;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2e2afeb..43354cb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -518,6 +518,72 @@ static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return 1;
 }
 
+static void move_encrypted_block(struct inode *inode, block_t bidx)
+{
+	struct f2fs_io_info fio = {
+		.sbi = F2FS_I_SB(inode),
+		.type = DATA,
+		.rw = READ_SYNC,
+		.encrypted_page = NULL,
+	};
+	struct dnode_of_data dn;
+	struct f2fs_summary sum;
+	struct node_info ni;
+	struct page *page;
+	int err;
+
+	/* do not read out */
+	page = grab_cache_page(inode->i_mapping, bidx);
+	if (!page)
+		return;
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
+	if (err)
+		goto out;
+
+	if (unlikely(dn.data_blkaddr == NULL_ADDR))
+		goto put_out;
+
+	get_node_info(fio.sbi, dn.nid, &ni);
+	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
+
+	/* read page */
+	fio.page = page;
+	fio.blk_addr = dn.data_blkaddr;
+
+	fio.encrypted_page = grab_cache_page(META_MAPPING(fio.sbi), fio.blk_addr);
+	if (!fio.encrypted_page)
+		goto put_out;
+
+	f2fs_submit_page_bio(&fio);
+
+	/* allocate block address */
+	f2fs_wait_on_page_writeback(dn.node_page, NODE);
+
+	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
+					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
+	dn.data_blkaddr = fio.blk_addr;
+
+	/* write page */
+	lock_page(fio.encrypted_page);
+	set_page_writeback(fio.encrypted_page);
+	fio.rw = WRITE_SYNC;
+	f2fs_submit_page_mbio(&fio);
+
+	set_data_blkaddr(&dn);
+	f2fs_update_extent_cache(&dn);
+	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
+	if (page->index == 0)
+		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+
+	f2fs_put_page(fio.encrypted_page, 1);
+put_out:
+	f2fs_put_dnode(&dn);
+out:
+	f2fs_put_page(page, 1);
+}
+
 static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 {
 	struct page *page;
@@ -537,6 +603,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.type = DATA,
 			.rw = WRITE_SYNC,
 			.page = page,
+			.encrypted_page = NULL,
 		};
 		f2fs_wait_on_page_writeback(page, DATA);
 
@@ -606,6 +673,13 @@ next_step:
 			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
+			/* if encrypted inode, let's go phase 3 */
+			if (f2fs_encrypted_inode(inode) &&
+						S_ISREG(inode->i_mode)) {
+				add_gc_inode(gc_list, inode);
+				continue;
+			}
+
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
 			data_page = get_read_data_page(inode,
 					start_bidx + ofs_in_node, READA);
@@ -624,7 +698,10 @@ next_step:
 		if (inode) {
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode))
 								+ ofs_in_node;
-			move_data_page(inode, start_bidx, gc_type);
+			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+				move_encrypted_block(inode, start_bidx);
+			else
+				move_data_page(inode, start_bidx, gc_type);
 			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 5f5b34b..b0b7805 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -113,6 +113,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		.type = DATA,
 		.rw = WRITE_SYNC | REQ_PRIO,
 		.page = page,
+		.encrypted_page = NULL,
 	};
 	int dirty, err;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7717256..d9c5242 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1003,6 +1003,7 @@ static int read_node_page(struct page *page, int rw)
 		.type = NODE,
 		.rw = rw,
 		.page = page,
+		.encrypted_page = NULL,
 	};
 
 	get_node_info(sbi, page->index, &ni);
@@ -1299,6 +1300,7 @@ static int f2fs_write_node_page(struct page *page,
 		.type = NODE,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
 		.page = page,
+		.encrypted_page = NULL,
 	};
 
 	trace_f2fs_writepage(page, NODE);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bdf487a..4c38601 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -219,6 +219,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 		.sbi = sbi,
 		.type = DATA,
 		.rw = WRITE_SYNC | REQ_PRIO,
+		.encrypted_page = NULL,
 	};
 
 	/*
@@ -1246,6 +1247,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.rw = WRITE_SYNC | REQ_META | REQ_PRIO,
 		.blk_addr = page->index,
 		.page = page,
+		.encrypted_page = NULL,
 	};
 
 	set_page_writeback(page);
@@ -1345,20 +1347,34 @@ static inline bool is_merged_page(struct f2fs_sb_info *sbi,
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io = &sbi->write_io[btype];
 	struct bio_vec *bvec;
+	struct page *target;
 	int i;
 
 	down_read(&io->io_rwsem);
-	if (!io->bio)
-		goto out;
+	if (!io->bio) {
+		up_read(&io->io_rwsem);
+		return false;
+	}
 
 	bio_for_each_segment_all(bvec, io->bio, i) {
-		if (page == bvec->bv_page) {
+
+		if (bvec->bv_page->mapping) {
+			target = bvec->bv_page;
+		} else {
+			struct f2fs_crypto_ctx *ctx;
+
+			/* encrypted page */
+			ctx = (struct f2fs_crypto_ctx *)page_private(
+								bvec->bv_page);
+			target = ctx->control_page;
+		}
+
+		if (page == target) {
 			up_read(&io->io_rwsem);
 			return true;
 		}
 	}
 
-out:
 	up_read(&io->io_rwsem);
 	return false;
 }
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
