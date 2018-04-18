From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] f2fs: call unlock_new_inode() before
 d_instantiate()
Date: Wed, 18 Apr 2018 15:48:42 -0700
Message-ID: <20180418224842.195203-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1f8vtc-00077A-LD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 22:49:48 +0000
Received: from mail-pl0-f66.google.com ([209.85.160.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f8vta-0028yt-Ol
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 22:49:48 +0000
Received: by mail-pl0-f66.google.com with SMTP id e7-v6so1994671plt.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Apr 2018 15:49:46 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

xfstest generic/429 sometimes hangs on f2fs, caused by a thread being
unable to take a directory's i_rwsem for write in vfs_rmdir().  In the
test, one thread repeatedly creates and removes a directory, and other
threads repeatedly look up a file in the directory.  The bug is that
f2fs_mkdir() calls d_instantiate() before unlock_new_inode(), resulting
in the directory inode being exposed to lookups before it has been fully
initialized.  And with CONFIG_DEBUG_LOCK_ALLOC, unlock_new_inode()
reinitializes ->i_rwsem, corrupting its state when it is already held.

Fix it by calling unlock_new_inode() before d_instantiate().  This
matches what other filesystems do.

Fixes: 57397d86c62d ("f2fs: add inode operations for special inodes")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d5098efe577c..3a7ed962d2f7 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -294,8 +294,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	alloc_nid_done(sbi, ino);
 
-	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+	d_instantiate(dentry, inode);
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
@@ -597,8 +597,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	err = page_symlink(inode, disk_link.name, disk_link.len);
 
 err_out:
-	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+	d_instantiate(dentry, inode);
 
 	/*
 	 * Let's flush symlink data in order to avoid broken symlink as much as
@@ -661,8 +661,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	alloc_nid_done(sbi, inode->i_ino);
 
-	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+	d_instantiate(dentry, inode);
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
@@ -713,8 +713,8 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 
 	alloc_nid_done(sbi, inode->i_ino);
 
-	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
+	d_instantiate(dentry, inode);
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
