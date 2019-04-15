From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to consider multiple device for readonly check
Date: Mon, 15 Apr 2019 20:35:34 +0800
Message-ID: <20190415123534.25254-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduce f2fs_hw_is_readonly() to check whether lower
device is readonly or not, it adapts multiple device scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       | 14 ++++++++++++++
 fs/f2fs/super.c      |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 90e1bab86269..08b339c665a1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -674,7 +674,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	if (bdev_read_only(sbi->sb->s_bdev)) {
+	if (f2fs_hw_is_readonly(sbi)) {
 		f2fs_msg(sbi->sb, KERN_INFO, "write access "
 			"unavailable, skipping orphan cleanup");
 		return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b98b22039f58..4dd26ef95926 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3587,6 +3587,20 @@ static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
 					f2fs_hw_should_discard(sbi);
 }
 
+static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	if (!f2fs_is_multi_device(sbi))
+		return bdev_read_only(sbi->sb->s_bdev);
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		if (bdev_read_only(FDEV(i).bdev))
+			return true;
+	return false;
+}
+
+
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
 {
 	clear_opt(sbi, ADAPTIVE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cbbb1e35070d..0c3abcc0dd27 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3377,7 +3377,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		 * mount should be failed, when device has readonly mode, and
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
-		if (bdev_read_only(sb->s_bdev) &&
+		if (f2fs_hw_is_readonly(sbi) &&
 				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 			err = -EROFS;
 			goto free_meta;
-- 
2.18.0.rc1
