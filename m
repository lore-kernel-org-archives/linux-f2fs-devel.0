From: Chao Yu <chao@kernel.org>
Subject: [PATCH] Revert "f2fs: fix to clean previous mount option when remount_fs"
Date: Wed,  5 Jul 2017 12:17:24 +0800
Message-ID: <20170705041724.10171-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Don't clear old mount option before parse new option during ->remount_fs
like other generic filesystems.

This reverts commit 26666c8a4366debae30ae37d0688b2bec92d196a.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f27c141cd8aa..af472f7968d0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -846,7 +846,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	sbi->mount_opt.opt = 0;
 	default_options(sbi);
 
 	/* parse mount options */
-- 
2.13.0.90.g1eb437020
