From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: split sbi->write_mutex for DATA/NODE/META to
 avoid unnecessary race
Date: Tue, 19 Nov 2013 09:43:20 +0800
Message-ID: <001201cee4c8$de450360$9acf0a20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

All DATA/NODE/META bio buffers in superblock is protected by 
'sbi->write_mutex', but each bio buffer area is independent, So we 
should split write_mutex to three for DATA/NODE/META.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h    |    2 +-
 fs/f2fs/segment.c |    8 ++++----
 fs/f2fs/super.c   |    4 +++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2df1e61..1c67521 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -362,7 +362,7 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
 	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
-	struct mutex write_mutex;		/* mutex for writing IOs */
+	struct mutex write_mutex[NR_PAGE_TYPE];	/* mutex for writing IOs */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 556965f..a36713ae 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -661,9 +661,9 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi, enum
page_type type, bool sync)
 	if (!sbi->bio[btype])
 		return;
 
-	mutex_lock(&sbi->write_mutex);
+	mutex_lock(&sbi->write_mutex[type]);
 	do_submit_bio(sbi, type, sync);
-	mutex_unlock(&sbi->write_mutex);
+	mutex_unlock(&sbi->write_mutex[type]);
 }
 
 static void submit_write_page(struct f2fs_sb_info *sbi, struct page *page,
@@ -674,7 +674,7 @@ static void submit_write_page(struct f2fs_sb_info *sbi,
struct page *page,
 
 	verify_block_addr(sbi, blk_addr);
 
-	mutex_lock(&sbi->write_mutex);
+	mutex_lock(&sbi->write_mutex[type]);
 
 	inc_page_count(sbi, F2FS_WRITEBACK);
 
@@ -709,7 +709,7 @@ retry:
 
 	sbi->last_block_in_bio[type] = blk_addr;
 
-	mutex_unlock(&sbi->write_mutex);
+	mutex_unlock(&sbi->write_mutex[type]);
 	trace_f2fs_submit_write_page(page, blk_addr, type);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f56941c..6928c0a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -874,7 +874,9 @@ static int f2fs_fill_super(struct super_block *sb, void
*data, int silent)
 	mutex_init(&sbi->node_write);
 	sbi->por_doing = false;
 	spin_lock_init(&sbi->stat_lock);
-	mutex_init(&sbi->write_mutex);
+	mutex_init(&sbi->write_mutex[DATA]);
+	mutex_init(&sbi->write_mutex[NODE]);
+	mutex_init(&sbi->write_mutex[META]);
 	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
-- 
1.7.9.5
