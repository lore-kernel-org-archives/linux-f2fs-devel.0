From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: relocate Kconfig from misc filesystems
Date: Tue,  3 Mar 2015 17:22:33 -0800
Message-ID: <1425432153-99012-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The f2fs has been shipped on many smartphone devices during a couple of years.
So, it is worth to relocate Kconfig into main page from misc filesystems for
developers to choose it more easily.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/Kconfig      | 2 +-
 fs/f2fs/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index ec35851..011f433 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -32,6 +32,7 @@ source "fs/gfs2/Kconfig"
 source "fs/ocfs2/Kconfig"
 source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
+source "fs/f2fs/Kconfig"
 
 config FS_DAX
 	bool "Direct Access (DAX) support"
@@ -217,7 +218,6 @@ source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/exofs/Kconfig"
-source "fs/f2fs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 94e2d2f..05f0f66 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -1,5 +1,5 @@
 config F2FS_FS
-	tristate "F2FS filesystem support (EXPERIMENTAL)"
+	tristate "F2FS filesystem support"
 	depends on BLOCK
 	help
 	  F2FS is based on Log-structured File System (LFS), which supports
-- 
2.1.1
