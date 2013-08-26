From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix omitting to update inode page
Date: Mon, 26 Aug 2013 21:28:02 +0900
Message-ID: <1377520082-20526-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

The f2fs_set_link updates its parent inode number, so we should sync this to
the inode block.
Otherwise, the data can be lost after sudden-power-off.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 4e47518..9e90d31 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -447,6 +447,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		else
 			release_orphan_inode(sbi);
 
+		update_inode_page(old_inode):
 		update_inode_page(new_inode);
 	} else {
 		err = f2fs_add_link(new_dentry, old_inode);
-- 
1.8.3.1.437.g0dbd812
