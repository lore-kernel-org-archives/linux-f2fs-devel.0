From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 3/3] f2fs: avoid to set wrong pino of inode when
 rename dir
Date: Sat, 21 Dec 2013 18:03:28 +0800
Message-ID: <000201cefe33$ff3c9270$fdb5b750$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

When we rename a dir to new name which is not exist previous,
we will set pino of parent inode with ino of child inode in f2fs_set_link.
It destroy consistency of pino, it should be fixed.

Thanks for previous work of Shu Tan.

Signed-off-by: Shu Tan <shu.tan@samsung.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c   |    3 ---
 fs/f2fs/namei.c |    2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c6c9280..b1b32ea 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -256,9 +256,6 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
-	/* update parent inode number before releasing dentry page */
-	F2FS_I(inode)->i_pino = dir->i_ino;
-
 	f2fs_put_page(page, 1);
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 575adac..a68838d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -424,6 +424,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		}
 
 		f2fs_set_link(new_dir, new_entry, new_page, old_inode);
+		F2FS_I(old_inode)->i_pino = new_dir->i_ino;
 
 		new_inode->i_ctime = CURRENT_TIME;
 		if (old_dir_entry)
@@ -457,6 +458,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (old_dir != new_dir) {
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
+			F2FS_I(old_inode)->i_pino = new_dir->i_ino;
 		} else {
 			kunmap(old_dir_page);
 			f2fs_put_page(old_dir_page, 0);
-- 
1.7.9.5
