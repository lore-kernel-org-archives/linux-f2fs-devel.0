From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: implement -o dirsync
Date: Sun,  9 Nov 2014 22:24:22 -0800
Message-ID: <1415600662-23337-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XniOv-0006Xm-JZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Nov 2014 06:24:33 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XniOu-0003hs-Eg for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Nov 2014 06:24:33 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If a mount option has dirsync, we should call checkpoint for all the directory
operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6312dd2..db3ee09 100644
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
@@ -233,6 +239,9 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
+
 	/* In order to evict this inode, we set it dirty */
 	mark_inode_dirty(inode);
 fail:
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


------------------------------------------------------------------------------
