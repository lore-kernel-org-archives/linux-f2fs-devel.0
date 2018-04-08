From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: correct return value of f2fs_trim_fs
Date: Sun,  8 Apr 2018 20:39:03 +0800
Message-ID: <20180408123903.16907-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Correct return value in two cases:
- return EINVAL if end boundary is out-of-range.
- return EIO if fs needs off-line check.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7150ab22f968..876dd9a511af 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2435,12 +2435,12 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		return -EINVAL;
 
 	if (end <= MAIN_BLKADDR(sbi))
-		goto out;
+		return -EINVAL;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"Found FS corruption, run fsck to fix.");
-		goto out;
+		return -EIO;
 	}
 
 	/* start/end segment number in main_area */
-- 
2.16.2.17.g38e79b1fd
