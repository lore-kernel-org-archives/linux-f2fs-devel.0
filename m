From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: should not make_bad_inode on f2fs_link failure
Date: Wed, 22 May 2013 12:33:03 +0900
Message-ID: <1369193584-2963-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

If -ENOSPC is met during f2fs_link, we should not make the inode as bad.
The inode is still alive.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 729b285..71aa305 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -191,7 +191,6 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	return 0;
 out:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
-	make_bad_inode(inode);
 	iput(inode);
 	return err;
 }
-- 
1.8.1.3.566.gaa39828
