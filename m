From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/5] f2fs: trace old block address for CoWed page
Date: Mon, 22 Feb 2016 18:36:38 +0800
Message-ID: <004a01d16d5d$00f9c4d0$02ed4e70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aXnrx-0004wb-5w
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:37:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aXnru-0006Ps-Sn
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:37:33 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2Y0059H2U01690@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 19:37:22 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch enables to trace old block address of CoWed page for better
debugging.

f2fs_submit_page_mbio: dev = (1,0), ino = 1, page_index = 0x1d4f0, oldaddr = 0xfe8ab, newaddr = 0xfee90 rw = WRITE_SYNC, type = NODE
f2fs_submit_page_mbio: dev = (1,0), ino = 1, page_index = 0x1d4f8, oldaddr = 0xfe8b0, newaddr = 0xfee91 rw = WRITE_SYNC, type = NODE
f2fs_submit_page_mbio: dev = (1,0), ino = 1, page_index = 0x1d4fa, oldaddr = 0xfe8ae, newaddr = 0xfee92 rw = WRITE_SYNC, type = NODE

f2fs_submit_page_mbio: dev = (1,0), ino = 134824, page_index = 0x96, oldaddr = 0xf049b, newaddr = 0x2bbe rw = WRITE, type = DATA
f2fs_submit_page_mbio: dev = (1,0), ino = 134824, page_index = 0x97, oldaddr = 0xf049c, newaddr = 0x2bbf rw = WRITE, type = DATA
f2fs_submit_page_mbio: dev = (1,0), ino = 134824, page_index = 0x98, oldaddr = 0xf049d, newaddr = 0x2bc0 rw = WRITE, type = DATA

f2fs_submit_page_mbio: dev = (1,0), ino = 135260, page_index = 0x47, oldaddr = 0xffffffff, newaddr = 0xf2631 rw = WRITE, type = DATA
f2fs_submit_page_mbio: dev = (1,0), ino = 135260, page_index = 0x48, oldaddr = 0xffffffff, newaddr = 0xf2632 rw = WRITE, type = DATA
f2fs_submit_page_mbio: dev = (1,0), ino = 135260, page_index = 0x49, oldaddr = 0xffffffff, newaddr = 0xf2633 rw = WRITE, type = DATA

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c        | 12 +++++++-----
 fs/f2fs/data.c              | 25 ++++++++++++++-----------
 fs/f2fs/f2fs.h              |  2 +-
 fs/f2fs/gc.c                | 10 +++++-----
 fs/f2fs/inline.c            |  2 +-
 fs/f2fs/node.c              |  6 +++---
 fs/f2fs/segment.c           | 10 ++++++----
 fs/f2fs/trace.c             |  6 ++++--
 include/trace/events/f2fs.h | 11 +++++++----
 9 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8d88a96..2bac8a1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -56,7 +56,8 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.sbi = sbi,
 		.type = META,
 		.rw = READ_SYNC | REQ_META | REQ_PRIO,
-		.blk_addr = index,
+		.old_blkaddr = index,
+		.new_blkaddr = index,
 		.encrypted_page = NULL,
 	};
 
@@ -168,24 +169,24 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 					NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
 				blkno = 0;
 			/* get nat block addr */
-			fio.blk_addr = current_nat_addr(sbi,
+			fio.new_blkaddr = current_nat_addr(sbi,
 					blkno * NAT_ENTRY_PER_BLOCK);
 			break;
 		case META_SIT:
 			/* get sit block addr */
-			fio.blk_addr = current_sit_addr(sbi,
+			fio.new_blkaddr = current_sit_addr(sbi,
 					blkno * SIT_ENTRY_PER_BLOCK);
 			break;
 		case META_SSA:
 		case META_CP:
 		case META_POR:
-			fio.blk_addr = blkno;
+			fio.new_blkaddr = blkno;
 			break;
 		default:
 			BUG();
 		}
 
-		page = grab_cache_page(META_MAPPING(sbi), fio.blk_addr);
+		page = grab_cache_page(META_MAPPING(sbi), fio.new_blkaddr);
 		if (!page)
 			continue;
 		if (PageUptodate(page)) {
@@ -194,6 +195,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		}
 
 		fio.page = page;
+		fio.old_blkaddr = fio.new_blkaddr;
 		f2fs_submit_page_mbio(&fio);
 		f2fs_put_page(page, 0);
 	}
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d3a6cd0..a6e7133 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -214,7 +214,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	/* Allocate a new bio */
-	bio = __bio_alloc(fio->sbi, fio->blk_addr, 1, is_read_io(fio->rw));
+	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, 1, is_read_io(fio->rw));
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
 		bio_put(bio);
@@ -235,21 +235,24 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
-	verify_block_addr(sbi, fio->blk_addr);
+	if (fio->old_blkaddr != NEW_ADDR)
+		verify_block_addr(sbi, fio->old_blkaddr);
+	verify_block_addr(sbi, fio->new_blkaddr);
 
 	down_write(&io->io_rwsem);
 
 	if (!is_read)
 		inc_page_count(sbi, F2FS_WRITEBACK);
 
-	if (io->bio && (io->last_block_in_bio != fio->blk_addr - 1 ||
+	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
 						io->fio.rw != fio->rw))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
 		int bio_blocks = MAX_BIO_BLOCKS(sbi);
 
-		io->bio = __bio_alloc(sbi, fio->blk_addr, bio_blocks, is_read);
+		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
+						bio_blocks, is_read);
 		io->fio = *fio;
 	}
 
@@ -261,7 +264,7 @@ alloc_new:
 		goto alloc_new;
 	}
 
-	io->last_block_in_bio = fio->blk_addr;
+	io->last_block_in_bio = fio->new_blkaddr;
 	f2fs_trace_ios(fio, 0);
 
 	up_write(&io->io_rwsem);
@@ -395,7 +398,7 @@ got_it:
 		return page;
 	}
 
-	fio.blk_addr = dn.data_blkaddr;
+	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 	fio.page = page;
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
@@ -1066,11 +1069,10 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	if (err)
 		return err;
 
-	fio->blk_addr = dn.data_blkaddr;
 	fio->old_blkaddr = dn.data_blkaddr;
 
 	/* This page is already truncated */
-	if (fio->blk_addr == NULL_ADDR) {
+	if (fio->old_blkaddr == NULL_ADDR) {
 		ClearPageUptodate(page);
 		goto out_writepage;
 	}
@@ -1079,7 +1081,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 
 		/* wait for GCed encrypted page writeback */
 		f2fs_wait_on_encrypted_page_writeback(F2FS_I_SB(inode),
-							fio->blk_addr);
+							fio->old_blkaddr);
 
 		fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page);
 		if (IS_ERR(fio->encrypted_page)) {
@@ -1094,7 +1096,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (unlikely(fio->blk_addr != NEW_ADDR &&
+	if (unlikely(fio->old_blkaddr != NEW_ADDR &&
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
@@ -1568,7 +1570,8 @@ repeat:
 			.sbi = sbi,
 			.type = DATA,
 			.rw = READ_SYNC,
-			.blk_addr = blkaddr,
+			.old_blkaddr = blkaddr,
+			.new_blkaddr = blkaddr,
 			.page = page,
 			.encrypted_page = NULL,
 		};
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8fc17c0..b57dee6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -659,7 +659,7 @@ struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	int rw;			/* contains R/RS/W/WS with REQ_META/REQ_PRIO */
-	block_t blk_addr;	/* block address to be written */
+	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6b2d704..4af3d80 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -577,10 +577,10 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 
 	/* read page */
 	fio.page = page;
-	fio.blk_addr = dn.data_blkaddr;
+	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
 	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
-					fio.blk_addr,
+					fio.new_blkaddr,
 					FGP_LOCK|FGP_CREAT,
 					GFP_NOFS);
 	if (!fio.encrypted_page)
@@ -607,12 +607,12 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 
 	/* allocate block address */
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
-	allocate_data_block(fio.sbi, NULL, fio.blk_addr,
-					&fio.blk_addr, &sum, CURSEG_COLD_DATA);
+	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &fio.new_blkaddr,
+							&sum, CURSEG_COLD_DATA);
 	fio.rw = WRITE_SYNC;
 	f2fs_submit_page_mbio(&fio);
 
-	dn.data_blkaddr = fio.blk_addr;
+	dn.data_blkaddr = fio.new_blkaddr;
 	set_data_blkaddr(&dn);
 	f2fs_update_extent_cache(&dn);
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 2046251..a89ca37 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -131,7 +131,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
-	fio.blk_addr = dn->data_blkaddr;
+	fio.old_blkaddr = dn->data_blkaddr;
 	write_data_page(dn, &fio);
 	set_data_blkaddr(dn);
 	f2fs_update_extent_cache(dn);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 82cde7a..68506f4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1068,7 +1068,7 @@ static int read_node_page(struct page *page, int rw)
 	if (PageUptodate(page))
 		return LOCKED_PAGE;
 
-	fio.blk_addr = ni.blk_addr;
+	fio.new_blkaddr = fio.old_blkaddr = ni.blk_addr;
 	return f2fs_submit_page_bio(&fio);
 }
 
@@ -1438,9 +1438,9 @@ static int f2fs_write_node_page(struct page *page,
 	}
 
 	set_page_writeback(page);
-	fio.blk_addr = ni.blk_addr;
+	fio.old_blkaddr = ni.blk_addr;
 	write_node_page(nid, &fio);
-	set_node_addr(sbi, &ni, fio.blk_addr, is_fsync_dnode(page));
+	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	up_read(&sbi->node_write);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5d0e6e6..d8e13b0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1385,8 +1385,8 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio->page, fio->type);
 
-	allocate_data_block(fio->sbi, fio->page, fio->blk_addr,
-					&fio->blk_addr, sum, type);
+	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
+					&fio->new_blkaddr, sum, type);
 
 	/* writeout dirty page into bdev */
 	f2fs_submit_page_mbio(fio);
@@ -1398,7 +1398,8 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.sbi = sbi,
 		.type = META,
 		.rw = WRITE_SYNC | REQ_META | REQ_PRIO,
-		.blk_addr = page->index,
+		.old_blkaddr = page->index,
+		.new_blkaddr = page->index,
 		.page = page,
 		.encrypted_page = NULL,
 	};
@@ -1428,11 +1429,12 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	do_write_page(&sum, fio);
-	dn->data_blkaddr = fio->blk_addr;
+	dn->data_blkaddr = fio->new_blkaddr;
 }
 
 void rewrite_data_page(struct f2fs_io_info *fio)
 {
+	fio->new_blkaddr = fio->old_blkaddr;
 	stat_inc_inplace_blocks(fio->sbi);
 	f2fs_submit_page_mbio(fio);
 }
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 145fb65..562ce08 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -29,7 +29,8 @@ static inline void __print_last_io(void)
 			last_io.major, last_io.minor,
 			last_io.pid, "----------------",
 			last_io.type,
-			last_io.fio.rw, last_io.fio.blk_addr,
+			last_io.fio.rw,
+			last_io.fio.new_blkaddr,
 			last_io.len);
 	memset(&last_io, 0, sizeof(last_io));
 }
@@ -101,7 +102,8 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 			last_io.pid == pid &&
 			last_io.type == __file_type(inode, pid) &&
 			last_io.fio.rw == fio->rw &&
-			last_io.fio.blk_addr + last_io.len == fio->blk_addr) {
+			last_io.fio.new_blkaddr + last_io.len ==
+							fio->new_blkaddr) {
 		last_io.len++;
 		return;
 	}
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 851f158..0f56584 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -728,7 +728,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__field(dev_t, dev)
 		__field(ino_t, ino)
 		__field(pgoff_t, index)
-		__field(block_t, blkaddr)
+		__field(block_t, old_blkaddr)
+		__field(block_t, new_blkaddr)
 		__field(int, rw)
 		__field(int, type)
 	),
@@ -737,16 +738,18 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__entry->dev		= page->mapping->host->i_sb->s_dev;
 		__entry->ino		= page->mapping->host->i_ino;
 		__entry->index		= page->index;
-		__entry->blkaddr	= fio->blk_addr;
+		__entry->old_blkaddr	= fio->old_blkaddr;
+		__entry->new_blkaddr	= fio->new_blkaddr;
 		__entry->rw		= fio->rw;
 		__entry->type		= fio->type;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
-		"blkaddr = 0x%llx, rw = %s%s, type = %s",
+		"oldaddr = 0x%llx, newaddr = 0x%llx rw = %s%s, type = %s",
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
-		(unsigned long long)__entry->blkaddr,
+		(unsigned long long)__entry->old_blkaddr,
+		(unsigned long long)__entry->new_blkaddr,
 		show_bio_type(__entry->rw),
 		show_block_type(__entry->type))
 );
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
