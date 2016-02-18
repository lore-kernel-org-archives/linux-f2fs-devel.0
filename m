From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set flush_merge by default
Date: Thu, 18 Feb 2016 10:51:39 -0800
Message-ID: <1455821499-1167-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This helps mitigating redundant cache_flush commands.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fa4bbe0..d643907 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -775,6 +775,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, EXTENT_CACHE);
+	set_opt(sbi, FLUSH_MERGE);
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.6.3
