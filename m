From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: give RO message when recovering superblock
Date: Wed, 23 Mar 2016 13:38:19 -0700
Message-ID: <1458765499-22921-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When one of superblocks is missing, f2fs recovers it with the valid one.
But, even if f2fs is mounted as RO, we'd better notify that too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 179304f..9c0af99 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1293,6 +1293,9 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	struct buffer_head *bh;
 	int err;
 
+	if (f2fs_readonly(sbi->sb) || bdev_read_only(sbi->sb->s_bdev))
+		return -EROFS;
+
 	/* write back-up superblock first */
 	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
 	if (!bh)
@@ -1560,7 +1563,7 @@ try_onemore:
 	kfree(options);
 
 	/* recover broken superblock */
-	if (recovery && !f2fs_readonly(sb) && !bdev_read_only(sb->s_bdev)) {
+	if (recovery) {
 		err = f2fs_commit_super(sbi, true);
 		f2fs_msg(sb, KERN_INFO,
 			"Try to recover %dth superblock, ret: %ld",
-- 
2.6.3
