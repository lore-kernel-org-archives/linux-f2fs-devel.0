From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: implement -o dirsync
Date: Mon, 10 Nov 2014 06:49:24 -0800
Message-ID: <20141110144924.GA25172@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1415600662-23337-1-git-send-email-jaegeuk@kernel.org>
 <20141110074712.GD14659@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141110074712.GD14659@lcm>
Sender: linux-kernel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o call sync after mark_inode_dirty

If a mount option has dirsync, we should call checkpoint for all the directory
operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6312dd2..2bee559 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -138,6 +138,9 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	stat_inc_inline_inode(inode);
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
 	handle_failed_inode(inode);
@@ -164,6 +167,9 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	f2fs_unlock_op(sbi);
 
 	d_instantiate(dentry, inode);
+
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
@@ -235,6 +241,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	/* In order to evict this inode, we set it dirty */
 	mark_inode_dirty(inode);
+
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 fail:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
@@ -268,6 +277,9 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return err;
 out:
 	handle_failed_inode(inode);
@@ -304,6 +316,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 
 out_fail:
@@ -346,8 +360,12 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, inode->i_ino);
+
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
 	handle_failed_inode(inode);
@@ -461,6 +479,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	f2fs_unlock_op(sbi);
+
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 
 put_out_dir:
@@ -600,6 +621,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	update_inode_page(new_dir);
 
 	f2fs_unlock_op(sbi);
+
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out_undo:
 	/* Still we may fail to recover name info of f2fs_inode here */
-- 
2.1.1
