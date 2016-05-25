From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/12] f2fs: introduce f2fs_i_links_write with
	mark_inode_dirty_sync
Date: Tue, 24 May 2016 17:03:30 -0700
Message-ID: <1464134619-37015-4-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIn-0002Y9-9m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIm-0006vz-8J
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:57 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces f2fs_i_links_write() to call mark_inode_dirty_sync() when
changing inode->i_links.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/dir.c        | 10 +++++-----
 fs/f2fs/f2fs.h       |  9 +++++++++
 fs/f2fs/namei.c      | 24 ++++++------------------
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 94bd5e2..57ca0c6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -535,6 +535,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	}
 
 	clear_nlink(inode);
+	mark_inode_dirty_sync(inode);
 
 	/* truncate all the data during iput */
 	iput(inode);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index dc4beae..f8ca0f3 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -437,7 +437,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		 */
 		if (inode->i_nlink == 0)
 			remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
-		inc_nlink(inode);
+		f2fs_i_links_write(inode, true);
 	}
 	return page;
 
@@ -456,7 +456,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 {
 	if (inode && is_inode_flag_set(inode, FI_NEW_INODE)) {
 		if (S_ISDIR(inode->i_mode)) {
-			inc_nlink(dir);
+			f2fs_i_links_write(dir, true);
 			set_inode_flag(dir, FI_UPDATE_DIR);
 		}
 		clear_inode_flag(inode, FI_NEW_INODE);
@@ -675,7 +675,7 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
 	down_write(&F2FS_I(inode)->i_sem);
 
 	if (S_ISDIR(inode->i_mode)) {
-		drop_nlink(dir);
+		f2fs_i_links_write(dir, false);
 		if (page)
 			update_inode(dir, page);
 		else
@@ -683,9 +683,9 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
 	}
 	inode->i_ctime = CURRENT_TIME;
 
-	drop_nlink(inode);
+	f2fs_i_links_write(inode, false);
 	if (S_ISDIR(inode->i_mode)) {
-		drop_nlink(inode);
+		f2fs_i_links_write(inode, false);
 		f2fs_i_size_write(inode, 0);
 	}
 	up_write(&F2FS_I(inode)->i_sem);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d07ae09..5af9768 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1557,6 +1557,15 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 	set_inode_flag(inode, FI_ACL_MODE);
 }
 
+static inline void f2fs_i_links_write(struct inode *inode, bool inc)
+{
+	if (inc)
+		inc_nlink(inode);
+	else
+		drop_nlink(inode);
+	mark_inode_dirty_sync(inode);
+}
+
 static inline void f2fs_i_blocks_write(struct inode *inode,
 					blkcnt_t diff, bool add)
 {
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cbf61a5..2bcbb42 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -349,9 +349,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-	/* In order to evict this inode, we set it dirty */
-	mark_inode_dirty(inode);
-
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
@@ -704,12 +701,10 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		new_inode->i_ctime = CURRENT_TIME;
 		down_write(&F2FS_I(new_inode)->i_sem);
 		if (old_dir_entry)
-			drop_nlink(new_inode);
-		drop_nlink(new_inode);
+			f2fs_i_links_write(new_inode, false);
+		f2fs_i_links_write(new_inode, false);
 		up_write(&F2FS_I(new_inode)->i_sem);
 
-		mark_inode_dirty(new_inode);
-
 		if (!new_inode->i_nlink)
 			add_orphan_inode(sbi, new_inode->i_ino);
 		else
@@ -729,7 +724,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		}
 
 		if (old_dir_entry) {
-			inc_nlink(new_dir);
+			f2fs_i_links_write(new_dir, true);
 			update_inode_page(new_dir);
 		}
 
@@ -784,8 +779,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			f2fs_dentry_kunmap(old_inode, old_dir_page);
 			f2fs_put_page(old_dir_page, 0);
 		}
-		drop_nlink(old_dir);
-		mark_inode_dirty(old_dir);
+		f2fs_i_links_write(old_dir, false);
 		update_inode_page(old_dir);
 	}
 
@@ -913,10 +907,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	old_dir->i_ctime = CURRENT_TIME;
 	if (old_nlink) {
 		down_write(&F2FS_I(old_dir)->i_sem);
-		if (old_nlink < 0)
-			drop_nlink(old_dir);
-		else
-			inc_nlink(old_dir);
+		f2fs_i_links_write(old_dir, old_nlink > 0);
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
 	mark_inode_dirty(old_dir);
@@ -934,10 +925,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	new_dir->i_ctime = CURRENT_TIME;
 	if (new_nlink) {
 		down_write(&F2FS_I(new_dir)->i_sem);
-		if (new_nlink < 0)
-			drop_nlink(new_dir);
-		else
-			inc_nlink(new_dir);
+		f2fs_i_links_write(new_dir, new_nlink > 0);
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
 	mark_inode_dirty(new_dir);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
