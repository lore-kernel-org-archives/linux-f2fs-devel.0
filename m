From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/7] f2fs: enhance IO path with block plug
Date: Sun, 14 Feb 2016 18:54:33 +0800
Message-ID: <00fd01d16716$2d14e2e0$873ea8a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Try to use block plug in more place as below to let process cache bios
as much as possbile, in order to reduce lock overhead of queue in IO
scheduler.
1) sync_meta_pages
2) ra_meta_pages
3) f2fs_balance_fs_bg

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 12 ++++++++----
 fs/f2fs/segment.c    |  9 +++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c6d4259..359a805 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -143,7 +143,6 @@ bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 							int type, bool sync)
 {
-	block_t prev_blk_addr = 0;
 	struct page *page;
 	block_t blkno = start;
 	struct f2fs_io_info fio = {
@@ -152,10 +151,12 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.rw = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : READA,
 		.encrypted_page = NULL,
 	};
+	struct blk_plug plug;
 
 	if (unlikely(type == META_POR))
 		fio.rw &= ~REQ_META;
 
+	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
 		if (!is_valid_blkaddr(sbi, blkno, type))
@@ -174,9 +175,6 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			/* get sit block addr */
 			fio.blk_addr = current_sit_addr(sbi,
 					blkno * SIT_ENTRY_PER_BLOCK);
-			if (blkno != start && prev_blk_addr + 1 != fio.blk_addr)
-				goto out;
-			prev_blk_addr = fio.blk_addr;
 			break;
 		case META_SSA:
 		case META_CP:
@@ -201,6 +199,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	}
 out:
 	f2fs_submit_merged_bio(sbi, META, READ);
+	blk_finish_plug(&plug);
 	return blkno - start;
 }
 
@@ -287,9 +286,12 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	struct writeback_control wbc = {
 		.for_reclaim = 0,
 	};
+	struct blk_plug plug;
 
 	pagevec_init(&pvec, 0);
 
+	blk_start_plug(&plug);
+
 	while (index <= end) {
 		int i, nr_pages;
 		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
@@ -342,6 +344,8 @@ stop:
 	if (nwritten)
 		f2fs_submit_merged_bio(sbi, type, WRITE);
 
+	blk_finish_plug(&plug);
+
 	return nwritten;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7cb9a54..5d0e6e6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -370,8 +370,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
 			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
-		if (test_opt(sbi, DATA_FLUSH))
+		if (test_opt(sbi, DATA_FLUSH)) {
+			struct blk_plug plug;
+
+			blk_start_plug(&plug);
 			sync_dirty_inodes(sbi, FILE_INODE);
+			blk_finish_plug(&plug);
+		}
 		f2fs_sync_fs(sbi->sb, true);
 		stat_inc_bg_cp_count(sbi->stat_info);
 	}
@@ -2189,7 +2194,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
-	int nrpages = MAX_BIO_BLOCKS(sbi);
+	int nrpages = MAX_BIO_BLOCKS(sbi) * 8;
 
 	do {
 		readed = ra_meta_pages(sbi, start_blk, nrpages, META_SIT, true);
-- 
2.7.0.2.g1b0b6dd
