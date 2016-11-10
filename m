From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't wait writeback for datas during checkpoint
Date: Thu, 10 Nov 2016 19:40:03 +0800
Message-ID: <20161110114003.90461-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Normally, while committing checkpoint, we will wait on all pages to be
writebacked no matter the page is data or metadata, so in scenario where
there are lots of data IO being submitted with metadata, we may suffer
long latency for waiting writeback during checkpoint.

Indeed, we only care about persistence for pages with metadata, but not
pages with data, as file system consistent are only related to metadate,
so in order to avoid encountering long latency in above scenario, let's
recognize and reference metadata in submitted IOs, wait writeback only
for metadatas.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  9 +++++++--
 fs/f2fs/debug.c      |  7 ++++---
 fs/f2fs/f2fs.h       | 26 +++++++++++++++++++++++---
 fs/f2fs/gc.c         |  2 ++
 fs/f2fs/node.c       |  1 +
 fs/f2fs/segment.c    |  2 ++
 7 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7bece59..bdf8a50 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1003,7 +1003,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
 	for (;;) {
 		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
 
-		if (!atomic_read(&sbi->nr_wb_bios))
+		if (!get_pages(sbi, F2FS_WB_META))
 			break;
 
 		io_schedule_timeout(5*HZ);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 66d2aee..2fb1ffd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -73,6 +73,7 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
+		bool is_meta = f2fs_is_meta_data(page);
 
 		fscrypt_pullback_bio_page(&page, true);
 
@@ -80,9 +81,10 @@ static void f2fs_write_end_io(struct bio *bio)
 			mapping_set_error(page->mapping, -EIO);
 			f2fs_stop_checkpoint(sbi, true);
 		}
+		dec_page_count(sbi, is_meta ? F2FS_WB_META : F2FS_WB_DATA);
 		end_page_writeback(page);
 	}
-	if (atomic_dec_and_test(&sbi->nr_wb_bios) &&
+	if (!get_pages(sbi, F2FS_WB_META) &&
 				wq_has_sleeper(&sbi->cp_wait))
 		wake_up(&sbi->cp_wait);
 
@@ -111,7 +113,6 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 				struct bio *bio, enum page_type type)
 {
 	if (!is_read_io(bio_op(bio))) {
-		atomic_inc(&sbi->nr_wb_bios);
 		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
@@ -272,6 +273,9 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		verify_block_addr(sbi, fio->old_blkaddr);
 	verify_block_addr(sbi, fio->new_blkaddr);
 
+	if (!is_read)
+		inc_page_count(sbi, fio->is_meta ? F2FS_WB_META : F2FS_WB_DATA);
+
 	down_write(&io->io_rwsem);
 
 	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
@@ -1237,6 +1241,7 @@ static int f2fs_write_data_page(struct page *page,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.is_meta = S_ISDIR(inode->i_mode),
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 2fdf233..f2d87de 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -50,7 +50,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
-	si->wb_bios = atomic_read(&sbi->nr_wb_bios);
+	si->nr_wb_meta = get_pages(sbi, F2FS_WB_META);
+	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
 	si->overp_segs = overprovision_segments(sbi);
@@ -313,8 +314,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - inmem: %4d, wb_bios: %4d\n",
-			   si->inmem_pages, si->wb_bios);
+		seq_printf(s, "  - inmem: %4d, wb_meta: %4d, wb_data: %4d\n",
+			   si->inmem_pages, si->nr_wb_meta, si->nr_wb_data);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 23a937f..95ad091 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -682,6 +682,8 @@ enum count_type {
 	F2FS_DIRTY_META,
 	F2FS_INMEM_PAGES,
 	F2FS_DIRTY_IMETA,
+	F2FS_WB_META,
+	F2FS_WB_DATA,
 	NR_COUNT_TYPE,
 };
 
@@ -715,6 +717,7 @@ struct f2fs_io_info {
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	int op;			/* contains REQ_OP_ */
 	int op_flags;		/* rq_flag_bits */
+	bool is_meta;		/* checkpoint needs to wait its writeback */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
@@ -849,7 +852,6 @@ struct f2fs_sb_info {
 	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	u32 s_next_generation;			/* for NFS support */
-	atomic_t nr_wb_bios;			/* # of writeback bios */
 
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
@@ -1193,6 +1195,23 @@ static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 	return 0;
 }
 
+static inline bool f2fs_is_meta_data(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct inode *inode;
+
+	/* it is bounce page of encrypted regular inode */
+	if (!mapping)
+		return false;
+
+	inode = mapping->host;
+	if (inode->i_ino ==  F2FS_NODE_INO(F2FS_I_SB(inode)) ||
+		inode->i_ino == F2FS_META_INO(F2FS_I_SB(inode)) ||
+		S_ISDIR(inode->i_mode))
+		return true;
+	return false;
+}
+
 #define F2FS_DEFAULT_ALLOCATED_BLOCKS	1
 
 /*
@@ -1263,7 +1282,8 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
 	atomic_inc(&sbi->nr_pages[count_type]);
 
-	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES)
+	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
+		count_type == F2FS_WB_META || count_type == F2FS_WB_DATA)
 		return;
 
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
@@ -2219,7 +2239,7 @@ struct f2fs_stat_info {
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
-	int bg_gc, wb_bios;
+	int bg_gc, nr_wb_meta, nr_wb_data;
 	int inline_xattr, inline_inode, inline_dir, orphans;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f8d8cc96a..6b762d4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -554,6 +554,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 		.type = DATA,
 		.op = REQ_OP_READ,
 		.op_flags = READ_SYNC,
+		.is_meta = true,
 		.encrypted_page = NULL,
 	};
 	struct dnode_of_data dn;
@@ -674,6 +675,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.type = DATA,
 			.op = REQ_OP_WRITE,
 			.op_flags = WRITE_SYNC,
+			.is_meta = S_ISDIR(inode->i_mode),
 			.page = page,
 			.encrypted_page = NULL,
 		};
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d58438f..3c7e00c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1574,6 +1574,7 @@ static int f2fs_write_node_page(struct page *page,
 		.type = NODE,
 		.op = REQ_OP_WRITE,
 		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.is_meta = true,
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 078c571..b34e20a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -261,6 +261,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
 		.op_flags = WRITE_SYNC | REQ_PRIO,
+		.is_meta = false,
 		.encrypted_page = NULL,
 	};
 	bool submit_bio = false;
@@ -1573,6 +1574,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.type = META,
 		.op = REQ_OP_WRITE,
 		.op_flags = WRITE_SYNC | REQ_META | REQ_PRIO,
+		.is_meta = true,
 		.old_blkaddr = page->index,
 		.new_blkaddr = page->index,
 		.page = page,
-- 
2.8.2.311.gee88674
