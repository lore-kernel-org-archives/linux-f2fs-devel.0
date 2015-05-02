From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/19] f2fs: add sbi and page pointer in f2fs_io_info
Date: Fri,  1 May 2015 17:48:37 -0700
Message-ID: <1430527726-68547-10-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds f2fs_sb_info and page pointers in f2fs_io_info structure.
With this change, we can reduce a lot of parameters for IO functions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  9 +++++++--
 fs/f2fs/data.c       | 47 +++++++++++++++++++++++++++++------------------
 fs/f2fs/f2fs.h       | 18 ++++++++----------
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/gc.c         |  4 +++-
 fs/f2fs/inline.c     |  4 +++-
 fs/f2fs/node.c       |  8 ++++++--
 fs/f2fs/segment.c    | 38 ++++++++++++++++++++------------------
 fs/f2fs/super.c      |  2 +-
 fs/f2fs/trace.c      |  6 +++---
 fs/f2fs/trace.h      |  2 +-
 11 files changed, 82 insertions(+), 58 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 72f64b3..6dbff2b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -52,6 +52,7 @@ struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = META,
 		.rw = READ_SYNC | REQ_META | REQ_PRIO,
 		.blk_addr = index,
@@ -65,7 +66,9 @@ repeat:
 	if (PageUptodate(page))
 		goto out;
 
-	if (f2fs_submit_page_bio(sbi, page, &fio))
+	fio.page = page;
+
+	if (f2fs_submit_page_bio(&fio))
 		goto repeat;
 
 	lock_page(page);
@@ -117,6 +120,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 	struct page *page;
 	block_t blkno = start;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = META,
 		.rw = READ_SYNC | REQ_META | REQ_PRIO
 	};
@@ -160,7 +164,8 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 			continue;
 		}
 
-		f2fs_submit_page_mbio(sbi, page, &fio);
+		fio.page = page;
+		f2fs_submit_page_mbio(&fio);
 		f2fs_put_page(page, 0);
 	}
 out:
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2a3a9cd..81d1fd5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -158,16 +158,16 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
  * Fill the locked page with data located in the block address.
  * Return unlocked page.
  */
-int f2fs_submit_page_bio(struct f2fs_sb_info *sbi, struct page *page,
-					struct f2fs_io_info *fio)
+int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio;
+	struct page *page = fio->page;
 
 	trace_f2fs_submit_page_bio(page, fio);
-	f2fs_trace_ios(page, fio, 0);
+	f2fs_trace_ios(fio, 0);
 
 	/* Allocate a new bio */
-	bio = __bio_alloc(sbi, fio->blk_addr, 1, is_read_io(fio->rw));
+	bio = __bio_alloc(fio->sbi, fio->blk_addr, 1, is_read_io(fio->rw));
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
 		bio_put(bio);
@@ -179,9 +179,9 @@ int f2fs_submit_page_bio(struct f2fs_sb_info *sbi, struct page *page,
 	return 0;
 }
 
-void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
-					struct f2fs_io_info *fio)
+void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 {
+	struct f2fs_sb_info *sbi = fio->sbi;
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io;
 	bool is_read = is_read_io(fio->rw);
@@ -206,17 +206,17 @@ alloc_new:
 		io->fio = *fio;
 	}
 
-	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
+	if (bio_add_page(io->bio, fio->page, PAGE_CACHE_SIZE, 0) <
 							PAGE_CACHE_SIZE) {
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
 
 	io->last_block_in_bio = fio->blk_addr;
-	f2fs_trace_ios(page, fio, 0);
+	f2fs_trace_ios(fio, 0);
 
 	up_write(&io->io_rwsem);
-	trace_f2fs_submit_page_mbio(page, fio);
+	trace_f2fs_submit_page_mbio(fio->page, fio);
 }
 
 /*
@@ -925,6 +925,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	struct extent_info ei;
 	int err;
 	struct f2fs_io_info fio = {
+		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
 		.rw = sync ? READ_SYNC : READA,
 	};
@@ -971,7 +972,8 @@ got_it:
 	}
 
 	fio.blk_addr = dn.data_blkaddr;
-	err = f2fs_submit_page_bio(F2FS_I_SB(inode), page, &fio);
+	fio.page = page;
+	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		return ERR_PTR(err);
 
@@ -998,6 +1000,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
 	struct extent_info ei;
 	int err;
 	struct f2fs_io_info fio = {
+		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
 		.rw = READ_SYNC,
 	};
@@ -1041,7 +1044,8 @@ got_it:
 	}
 
 	fio.blk_addr = dn.data_blkaddr;
-	err = f2fs_submit_page_bio(F2FS_I_SB(inode), page, &fio);
+	fio.page = page;
+	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		return ERR_PTR(err);
 
@@ -1092,11 +1096,13 @@ repeat:
 		SetPageUptodate(page);
 	} else {
 		struct f2fs_io_info fio = {
+			.sbi = F2FS_I_SB(inode),
 			.type = DATA,
 			.rw = READ_SYNC,
 			.blk_addr = dn.data_blkaddr,
+			.page = page,
 		};
-		err = f2fs_submit_page_bio(F2FS_I_SB(inode), page, &fio);
+		err = f2fs_submit_page_bio(&fio);
 		if (err)
 			goto put_err;
 
@@ -1529,8 +1535,9 @@ static int f2fs_read_data_pages(struct file *file,
 	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
 }
 
-int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
+int do_write_data_page(struct f2fs_io_info *fio)
 {
+	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
 	struct dnode_of_data dn;
 	int err = 0;
@@ -1557,11 +1564,11 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 	if (unlikely(fio->blk_addr != NEW_ADDR &&
 			!is_cold_data(page) &&
 			need_inplace_update(inode))) {
-		rewrite_data_page(page, fio);
+		rewrite_data_page(fio);
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
 		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
-		write_data_page(page, &dn, fio);
+		write_data_page(&dn, fio);
 		set_data_blkaddr(&dn);
 		f2fs_update_extent_cache(&dn);
 		trace_f2fs_do_write_data_page(page, OPU);
@@ -1586,8 +1593,10 @@ static int f2fs_write_data_page(struct page *page,
 	bool need_balance_fs = false;
 	int err = 0;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = DATA,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
+		.page = page,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1617,7 +1626,7 @@ write:
 	if (S_ISDIR(inode->i_mode)) {
 		if (unlikely(f2fs_cp_error(sbi)))
 			goto redirty_out;
-		err = do_write_data_page(page, &fio);
+		err = do_write_data_page(&fio);
 		goto done;
 	}
 
@@ -1637,7 +1646,7 @@ write:
 	if (f2fs_has_inline_data(inode))
 		err = f2fs_write_inline_data(inode, page);
 	if (err == -EAGAIN)
-		err = do_write_data_page(page, &fio);
+		err = do_write_data_page(&fio);
 	f2fs_unlock_op(sbi);
 done:
 	if (err && err != -ENOENT)
@@ -1806,11 +1815,13 @@ put_next:
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	} else {
 		struct f2fs_io_info fio = {
+			.sbi = sbi,
 			.type = DATA,
 			.rw = READ_SYNC,
 			.blk_addr = dn.data_blkaddr,
+			.page = page,
 		};
-		err = f2fs_submit_page_bio(sbi, page, &fio);
+		err = f2fs_submit_page_bio(&fio);
 		if (err)
 			goto fail;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2bb9b57..e99a404 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -601,9 +601,11 @@ enum page_type {
 };
 
 struct f2fs_io_info {
+	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	int rw;			/* contains R/RS/W/WS with REQ_META/REQ_PRIO */
 	block_t blk_addr;	/* block address to be written */
+	struct page *page;	/* page to be written */
 };
 
 #define is_read_io(rw)	(((rw) & 1) == READ)
@@ -1601,11 +1603,9 @@ void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
 void write_meta_page(struct f2fs_sb_info *, struct page *);
-void write_node_page(struct f2fs_sb_info *, struct page *,
-				unsigned int, struct f2fs_io_info *);
-void write_data_page(struct page *, struct dnode_of_data *,
-			struct f2fs_io_info *);
-void rewrite_data_page(struct page *, struct f2fs_io_info *);
+void write_node_page(unsigned int, struct f2fs_io_info *);
+void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
+void rewrite_data_page(struct f2fs_io_info *);
 void recover_data_page(struct f2fs_sb_info *, struct page *,
 				struct f2fs_summary *, block_t, block_t);
 void allocate_data_block(struct f2fs_sb_info *, struct page *,
@@ -1653,10 +1653,8 @@ void destroy_checkpoint_caches(void);
  * data.c
  */
 void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
-int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *,
-						struct f2fs_io_info *);
-void f2fs_submit_page_mbio(struct f2fs_sb_info *, struct page *,
-						struct f2fs_io_info *);
+int f2fs_submit_page_bio(struct f2fs_io_info *);
+void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
@@ -1668,7 +1666,7 @@ void f2fs_preserve_extent_tree(struct inode *);
 struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
-int do_write_data_page(struct page *, struct f2fs_io_info *);
+int do_write_data_page(struct f2fs_io_info *);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 void init_extent_cache_info(struct f2fs_sb_info *);
 int __init create_extent_cache(void);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffd9b7e..0e58f02 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -271,7 +271,7 @@ flush_out:
 	ret = f2fs_issue_flush(sbi);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
-	f2fs_trace_ios(NULL, NULL, 1);
+	f2fs_trace_ios(NULL, 1);
 	return ret;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ed58211..72667a5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -521,8 +521,10 @@ static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 {
 	struct f2fs_io_info fio = {
+		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
 		.rw = WRITE_SYNC,
+		.page = page,
 	};
 
 	if (gc_type == BG_GC) {
@@ -536,7 +538,7 @@ static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_pages(inode);
 		set_cold_data(page);
-		do_write_data_page(page, &fio);
+		do_write_data_page(&fio);
 		clear_cold_data(page);
 	}
 out:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 99d5148..d9b3033 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -106,8 +106,10 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	struct f2fs_io_info fio = {
+		.sbi = F2FS_I_SB(dn->inode),
 		.type = DATA,
 		.rw = WRITE_SYNC | REQ_PRIO,
+		.page = page,
 	};
 	int dirty, err;
 
@@ -141,7 +143,7 @@ no_update:
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
 	fio.blk_addr = dn->data_blkaddr;
-	write_data_page(page, dn, &fio);
+	write_data_page(dn, &fio);
 	set_data_blkaddr(dn);
 	f2fs_update_extent_cache(dn);
 	f2fs_wait_on_page_writeback(page, DATA);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1676c7a..880d578 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -995,8 +995,10 @@ static int read_node_page(struct page *page, int rw)
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = NODE,
 		.rw = rw,
+		.page = page,
 	};
 
 	get_node_info(sbi, page->index, &ni);
@@ -1011,7 +1013,7 @@ static int read_node_page(struct page *page, int rw)
 		return LOCKED_PAGE;
 
 	fio.blk_addr = ni.blk_addr;
-	return f2fs_submit_page_bio(sbi, page, &fio);
+	return f2fs_submit_page_bio(&fio);
 }
 
 /*
@@ -1293,8 +1295,10 @@ static int f2fs_write_node_page(struct page *page,
 	nid_t nid;
 	struct node_info ni;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = NODE,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE,
+		.page = page,
 	};
 
 	trace_f2fs_writepage(page, NODE);
@@ -1329,7 +1333,7 @@ static int f2fs_write_node_page(struct page *page,
 
 	set_page_writeback(page);
 	fio.blk_addr = ni.blk_addr;
-	write_node_page(sbi, page, nid, &fio);
+	write_node_page(nid, &fio);
 	set_node_addr(sbi, &ni, fio.blk_addr, is_fsync_dnode(page));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	up_read(&sbi->node_write);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f939660..df8bce5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -216,6 +216,7 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 	struct inmem_pages *cur, *tmp;
 	bool submit_bio = false;
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = DATA,
 		.rw = WRITE_SYNC | REQ_PRIO,
 	};
@@ -241,7 +242,8 @@ void commit_inmem_pages(struct inode *inode, bool abort)
 				if (clear_page_dirty_for_io(cur->page))
 					inode_dec_dirty_pages(inode);
 				trace_f2fs_commit_inmem_page(cur->page, INMEM);
-				do_write_data_page(cur->page, &fio);
+				fio.page = cur->page;
+				do_write_data_page(&fio);
 				submit_bio = true;
 			}
 			f2fs_put_page(cur->page, 1);
@@ -1206,56 +1208,56 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
-static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
-			struct f2fs_summary *sum,
-			struct f2fs_io_info *fio)
+static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(page, fio->type);
+	int type = __get_segment_type(fio->page, fio->type);
 
-	allocate_data_block(sbi, page, fio->blk_addr, &fio->blk_addr, sum, type);
+	allocate_data_block(fio->sbi, fio->page, fio->blk_addr,
+					&fio->blk_addr, sum, type);
 
 	/* writeout dirty page into bdev */
-	f2fs_submit_page_mbio(sbi, page, fio);
+	f2fs_submit_page_mbio(fio);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 {
 	struct f2fs_io_info fio = {
+		.sbi = sbi,
 		.type = META,
 		.rw = WRITE_SYNC | REQ_META | REQ_PRIO,
 		.blk_addr = page->index,
+		.page = page,
 	};
 
 	set_page_writeback(page);
-	f2fs_submit_page_mbio(sbi, page, &fio);
+	f2fs_submit_page_mbio(&fio);
 }
 
-void write_node_page(struct f2fs_sb_info *sbi, struct page *page,
-			unsigned int nid, struct f2fs_io_info *fio)
+void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 {
 	struct f2fs_summary sum;
+
 	set_summary(&sum, nid, 0, 0);
-	do_write_page(sbi, page, &sum, fio);
+	do_write_page(&sum, fio);
 }
 
-void write_data_page(struct page *page, struct dnode_of_data *dn,
-				struct f2fs_io_info *fio)
+void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	struct f2fs_sb_info *sbi = fio->sbi;
 	struct f2fs_summary sum;
 	struct node_info ni;
 
 	f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
-	do_write_page(sbi, page, &sum, fio);
+	do_write_page(&sum, fio);
 	dn->data_blkaddr = fio->blk_addr;
 }
 
-void rewrite_data_page(struct page *page, struct f2fs_io_info *fio)
+void rewrite_data_page(struct f2fs_io_info *fio)
 {
-	stat_inc_inplace_blocks(F2FS_P_SB(page));
-	f2fs_submit_page_mbio(F2FS_P_SB(page), page, fio);
+	stat_inc_inplace_blocks(fio->sbi);
+	f2fs_submit_page_mbio(fio);
 }
 
 void recover_data_page(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8584168..138fa93 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -520,7 +520,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	} else {
 		f2fs_balance_fs(sbi);
 	}
-	f2fs_trace_ios(NULL, NULL, 1);
+	f2fs_trace_ios(NULL, 1);
 
 	return 0;
 }
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 875aa81..145fb65 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -80,7 +80,7 @@ out:
 	radix_tree_preload_end();
 }
 
-void f2fs_trace_ios(struct page *page, struct f2fs_io_info *fio, int flush)
+void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 {
 	struct inode *inode;
 	pid_t pid;
@@ -91,8 +91,8 @@ void f2fs_trace_ios(struct page *page, struct f2fs_io_info *fio, int flush)
 		return;
 	}
 
-	inode = page->mapping->host;
-	pid = page_private(page);
+	inode = fio->page->mapping->host;
+	pid = page_private(fio->page);
 
 	major = MAJOR(inode->i_sb->s_dev);
 	minor = MINOR(inode->i_sb->s_dev);
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index 1041dbe..dc5cd26 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -33,7 +33,7 @@ struct last_io_info {
 };
 
 extern void f2fs_trace_pid(struct page *);
-extern void f2fs_trace_ios(struct page *, struct f2fs_io_info *, int);
+extern void f2fs_trace_ios(struct f2fs_io_info *, int);
 extern void f2fs_build_trace_ios(void);
 extern void f2fs_destroy_trace_ios(void);
 #else
-- 
2.1.1
