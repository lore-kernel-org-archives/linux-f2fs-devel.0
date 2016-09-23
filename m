From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove dirty inode pages in error path
Date: Fri, 23 Sep 2016 14:11:05 -0700
Message-ID: <20160923211105.20848-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When getting EIO while handling orphan inodes, we can get some dirty node
pages. Then, f2fs_write_node_pages() called by iput(node_inode) will try
to flush node pages. But in this case, we should prevent to do that, since
we will try again from the start.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e7bb153..fbded38 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1892,6 +1892,7 @@ free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
 free_node_inode:
+	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	mutex_lock(&sbi->umount_mutex);
 	release_ino_entry(sbi, true);
 	f2fs_leave_shrinker(sbi);
-- 
2.8.3
