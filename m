From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack
Date: Thu, 24 Nov 2016 18:32:36 -0800
Message-ID: <20161125023236.80473-1-jaegeuk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't guarantee cp_addr is fixed by cp_version.
This is to sync with f2fs-tools.

Cc: stable@vger.kernel.org
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  5 +++++
 fs/f2fs/f2fs.h       | 14 +++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 54cc6a9..bf2f44c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -789,6 +789,11 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		f2fs_put_page(cur_page, 1);
 	}
 done:
+	if (cur_page == cp1)
+		sbi->cur_cp_pack = 1;
+	else
+		sbi->cur_cp_pack = 2;
+
 	f2fs_put_page(cp1, 1);
 	f2fs_put_page(cp2, 1);
 	return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62383d2..e22e7e1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -792,6 +792,7 @@ struct f2fs_sb_info {
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
+	int cur_cp_pack;			/* remain current cp pack */
 	spinlock_t cp_lock;			/* for flag in ckpt */
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
@@ -1352,19 +1353,10 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
 {
-	block_t start_addr;
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	unsigned long long ckpt_version = cur_cp_version(ckpt);
-
-	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
+	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
 
-	/*
-	 * odd numbered checkpoint should at cp segment 0
-	 * and even segment must be at cp segment 1
-	 */
-	if (!(ckpt_version & 1))
+	if (sbi->cur_cp_pack == 2)
 		start_addr += sbi->blocks_per_seg;
-
 	return start_addr;
 }
 
-- 
2.8.3
