From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [f2fs-dev] [PATCH RFC] f2fs: flush cp pack except cp page2 at first
Date: Wed, 24 Jan 2018 06:53:54 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCD261D@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we attempt to flush the whole cp pack in a single bio,
however, when suddenly power off at this time, we could meet an
extreme scenario that cp page1 and cp page2 are updated and latest,
but payload or current summaries are still outdated.
(see reliable write in UFS spec)

This patch write the whole cp pack except cp page2 with FLUSH
at first, and then write the cp page2 with an extra independent
bio with FLUSH.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/checkpoint.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/f2fs.h       |  3 ++-
 fs/f2fs/segment.c    | 11 +++++++++--
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 14d2fed..e7f5e85 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -300,6 +300,35 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	return 0;
 }
 
+static int sync_meta_page_locked(struct f2fs_sb_info *sbi,
+	struct page *page,
+	enum page_type type, enum iostat_type io_type)
+{
+	struct writeback_control wbc = {
+		.for_reclaim = 0,
+	};
+	int err;
+
+	BUG_ON(page->mapping != META_MAPPING(sbi));
+	BUG_ON(!PageDirty(page));
+
+	f2fs_wait_on_page_writeback(page, META, true);
+
+	BUG_ON(PageWriteback(page));
+	if (unlikely(!clear_page_dirty_for_io(page)))
+		BUG();
+
+	err = __f2fs_write_meta_page(page, &wbc, io_type);
+	if (err) {
+		f2fs_put_page(page, 1);
+		return err;
+	}
+	f2fs_put_page(page, 0);
+
+	f2fs_submit_merged_write(sbi, type);
+	return err;
+}
+
 long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
@@ -1172,6 +1201,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
 	int err;
+	struct page *cp_page2;
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
@@ -1250,7 +1280,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		blk = start_blk + sbi->blocks_per_seg - nm_i->nat_bits_blocks;
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
 			update_meta_page(sbi, nm_i->nat_bits +
-					(i << F2FS_BLKSIZE_BITS), blk + i);
+					(i << F2FS_BLKSIZE_BITS), blk + i, NULL);
 
 		/* Flush all the NAT BITS pages */
 		while (get_pages(sbi, F2FS_DIRTY_META)) {
@@ -1271,11 +1301,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		return err;
 
 	/* write out checkpoint buffer at block 0 */
-	update_meta_page(sbi, ckpt, start_blk++);
+	update_meta_page(sbi, ckpt, start_blk++, NULL);
 
 	for (i = 1; i < 1 + cp_payload_blks; i++)
 		update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
-							start_blk++);
+							start_blk++, NULL);
 
 	if (orphan_num) {
 		write_orphan_inodes(sbi, start_blk);
@@ -1297,9 +1327,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
-	/* writeout checkpoint block */
-	update_meta_page(sbi, ckpt, start_blk);
-
 	/* wait for previous submitted node/meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
@@ -1313,12 +1340,19 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* Here, we only have one bio having CP pack */
+	/* Here, we only have one bio having CP pack except cp page 2 */
 	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
 
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
 
+	/* write and flush checkpoint cp page 2 */
+	update_meta_page(sbi, ckpt, start_blk, &cp_page2);
+	sync_meta_page_locked(sbi, cp_page2, META_FLUSH, FS_CP_META_IO);
+
+	/* wait for previous submitted meta pages writeback */
+	wait_on_all_pages_writeback(sbi);
+
 	release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a4fb89d..7877ea3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2680,7 +2680,8 @@ void allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
-void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
+void update_meta_page(struct f2fs_sb_info *sbi,
+	void *src, block_t blk_addr, struct page **metapage);
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 						enum iostat_type io_type);
 void write_node_page(unsigned int nid, struct f2fs_io_info *fio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 40e1d20..f48a536 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1988,19 +1988,26 @@ struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 	return get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
-void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr)
+void update_meta_page(struct f2fs_sb_info *sbi,
+	void *src, block_t blk_addr, struct page **metapage)
 {
 	struct page *page = grab_meta_page(sbi, blk_addr);
 
 	memcpy(page_address(page), src, PAGE_SIZE);
 	set_page_dirty(page);
+
+	if (unlikely(metapage)) {
+		*metapage = page;
+		return;
+	}
+
 	f2fs_put_page(page, 1);
 }
 
 static void write_sum_page(struct f2fs_sb_info *sbi,
 			struct f2fs_summary_block *sum_blk, block_t blk_addr)
 {
-	update_meta_page(sbi, (void *)sum_blk, blk_addr);
+	update_meta_page(sbi, (void *)sum_blk, blk_addr, NULL);
 }
 
 static void write_current_sum_page(struct f2fs_sb_info *sbi,
-- 
2.1.4
