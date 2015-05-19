From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: introduce update_meta_page
Date: Tue, 19 May 2015 17:40:04 +0800
Message-ID: <006201d09217$e27a18a0$a76e49e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add a help function update_meta_page() to update meta page with specified
buffer.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 26 ++++++--------------------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.c    | 26 ++++++++++++++++----------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7b7a9d8..b70bbe1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -888,10 +888,8 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
 	nid_t last_nid = nm_i->next_scan_nid;
 	block_t start_blk;
-	struct page *cp_page;
 	unsigned int data_sum_blocks, orphan_blocks;
 	__u32 crc32 = 0;
-	void *kaddr;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
 
@@ -988,19 +986,11 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk = __start_cp_addr(sbi);
 
 	/* write out checkpoint buffer at block 0 */
-	cp_page = grab_meta_page(sbi, start_blk++);
-	kaddr = page_address(cp_page);
-	memcpy(kaddr, ckpt, F2FS_BLKSIZE);
-	set_page_dirty(cp_page);
-	f2fs_put_page(cp_page, 1);
-
-	for (i = 1; i < 1 + cp_payload_blks; i++) {
-		cp_page = grab_meta_page(sbi, start_blk++);
-		kaddr = page_address(cp_page);
-		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE, F2FS_BLKSIZE);
-		set_page_dirty(cp_page);
-		f2fs_put_page(cp_page, 1);
-	}
+	update_meta_page(sbi, ckpt, start_blk++);
+
+	for (i = 1; i < 1 + cp_payload_blks; i++)
+		update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
+							start_blk++);
 
 	if (orphan_num) {
 		write_orphan_inodes(sbi, start_blk);
@@ -1015,11 +1005,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	/* writeout checkpoint block */
-	cp_page = grab_meta_page(sbi, start_blk);
-	kaddr = page_address(cp_page);
-	memcpy(kaddr, ckpt, F2FS_BLKSIZE);
-	set_page_dirty(cp_page);
-	f2fs_put_page(cp_page, 1);
+	update_meta_page(sbi, ckpt, start_blk);
 
 	/* wait for previous submitted node/meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5119167..7e93fcf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1690,6 +1690,7 @@ int npages_for_summary_flush(struct f2fs_sb_info *, bool);
 void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
+void update_meta_page(struct f2fs_sb_info *, void *, block_t);
 void write_meta_page(struct f2fs_sb_info *, struct page *);
 void write_node_page(unsigned int, struct f2fs_io_info *);
 void write_data_page(struct dnode_of_data *, struct f2fs_io_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bdf874a..0b2bdd2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -502,12 +502,8 @@ void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 		err = f2fs_issue_discard(sbi, blkaddr, 1);
 	}
 
-	if (err) {
-		struct page *page = grab_meta_page(sbi, blkaddr);
-		memset(page_address(page), 0, F2FS_BLKSIZE);
-		set_page_dirty(page);
-		f2fs_put_page(page, 1);
-	}
+	if (err)
+		update_meta_page(sbi, NULL, blkaddr);
 }
 
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
@@ -788,16 +784,26 @@ struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 	return get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
-static void write_sum_page(struct f2fs_sb_info *sbi,
-			struct f2fs_summary_block *sum_blk, block_t blk_addr)
+void update_meta_page(struct f2fs_sb_info *sbi, void *src,
+							block_t blk_addr)
 {
 	struct page *page = grab_meta_page(sbi, blk_addr);
-	void *kaddr = page_address(page);
-	memcpy(kaddr, sum_blk, PAGE_CACHE_SIZE);
+	void *dst = page_address(page);
+
+	if (src)
+		memcpy(dst, src, PAGE_CACHE_SIZE);
+	else
+		memset(dst, 0, PAGE_CACHE_SIZE);
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 }
 
+static void write_sum_page(struct f2fs_sb_info *sbi,
+			struct f2fs_summary_block *sum_blk, block_t blk_addr)
+{
+	update_meta_page(sbi, (void *)sum_blk, blk_addr);
+}
+
 static int is_next_segment_free(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-- 
2.3.3
