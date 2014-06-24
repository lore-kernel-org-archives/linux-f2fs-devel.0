From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: reduce region of f2fs_lock_op covered for better
 concurrency
Date: Tue, 24 Jun 2014 14:16:24 +0800
Message-ID: <001701cf8f73$f8abe6a0$ea03b3e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In our rename process, region of f2fs_lock_op covered is too big as some of the
code like f2fs_empty_dir/f2fs_find_entry are not needed to protect by this lock.

So in the extreme case like doing checkpoint when we rename old inode to exist
inode in a large directory could cause lower concurrency.

Let's reduce the region of f2fs_lock_op to fix this.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index f17e34c..143799d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -394,8 +394,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out_old;
 	}
 
-	f2fs_lock_op(sbi);
-
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
@@ -408,6 +406,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (!new_entry)
 			goto out_dir;
 
+		f2fs_lock_op(sbi);
+
 		err = acquire_orphan_inode(sbi);
 		if (err)
 			goto put_out_dir;
@@ -439,9 +439,13 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		update_inode_page(old_inode);
 		update_inode_page(new_inode);
 	} else {
+		f2fs_lock_op(sbi);
+
 		err = f2fs_add_link(new_dentry, old_inode);
-		if (err)
+		if (err) {
+			f2fs_unlock_op(sbi);
 			goto out_dir;
+		}
 
 		if (old_dir_entry) {
 			inc_nlink(new_dir);
@@ -475,6 +479,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 
 put_out_dir:
+	f2fs_unlock_op(sbi);
 	kunmap(new_page);
 	f2fs_put_page(new_page, 0);
 out_dir:
@@ -482,7 +487,6 @@ out_dir:
 		kunmap(old_dir_page);
 		f2fs_put_page(old_dir_page, 0);
 	}
-	f2fs_unlock_op(sbi);
 out_old:
 	kunmap(old_page);
 	f2fs_put_page(old_page, 0);
-- 
1.7.9.5
