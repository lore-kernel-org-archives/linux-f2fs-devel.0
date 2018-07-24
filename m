From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to restrict mount condition when without CONFIG_QUOTA
Date: Wed, 25 Jul 2018 00:55:46 +0800
Message-ID: <20180724165546.12924-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Like quota_ino feature, we need to reject mounting RDWR with image
which enables project_quota feature when there is no CONFIG_QUOTA
be set in kernel.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dbc1cb53581f..bb40f08d2861 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
 			 "without CONFIG_QUOTA");
 		return -EINVAL;
 	}
+	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+		ext4_msg(sb, KERN_ERR,
+			"Filesystem with project quota feature cannot be "
+			"mounted RDWR without CONFIG_QUOTA");
+		return -EINVAL;
+	}
 #endif
 
 	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
-- 
2.16.2.17.g38e79b1fd
