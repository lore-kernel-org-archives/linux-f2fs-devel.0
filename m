From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: drop the volatile_write flag only
Date: Wed, 10 Jun 2015 06:48:11 -0700
Message-ID: <1433944091-69224-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When aborting volatile_writes, let's drop its flag and give up any further
volatile_writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 096e08c..53c1b74 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1391,11 +1391,9 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	}
 
-	if (f2fs_is_volatile_file(inode)) {
+	if (f2fs_is_volatile_file(inode))
 		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
-		filemap_fdatawrite(inode->i_mapping);
-		set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
-	}
+
 	mnt_drop_write_file(filp);
 	return ret;
 }
-- 
2.1.1

