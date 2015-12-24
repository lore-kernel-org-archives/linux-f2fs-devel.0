From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/4 v2] f2fs: avoid unnecessary f2fs_gc for
 dir operations
Date: Wed, 23 Dec 2015 18:13:11 -0800
Message-ID: <20151224021311.GA40333@jaegeuk.local>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-2-git-send-email-jaegeuk@kernel.org>
	<010101d13d31$cdc1d860$69458920$@samsung.com>
	<20151223185453.GA30505@jaegeuk.local>
	<013801d13deb$2ba86480$82f92d80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBvP6-0008NQ-Jf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:13:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBvP5-0006Jk-Cs for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 02:13:20 +0000
Content-Disposition: inline
In-Reply-To: <013801d13deb$2ba86480$82f92d80$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

Right.
But, in the rename path, we still need to do f2fs_balance_fs, since it produces
another dirty node page in the mean time.

How about this?

>From bbc5bf8f6c940cd75a4d71ce40ce4bd3f647a823 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 22 Dec 2015 11:56:08 -0800
Subject: [PATCH] f2fs: avoid unnecessary f2fs_gc for dir operations

The f2fs_balance_fs doesn't need to cover f2fs_new_inode or f2fs_find_entry
works.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 2c32110..4e27c5c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -128,8 +128,6 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	nid_t ino = 0;
 	int err;
 
-	f2fs_balance_fs(sbi);
-
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -142,6 +140,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	ino = inode->i_ino;
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
@@ -288,12 +288,13 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	int err = -ENOENT;
 
 	trace_f2fs_unlink_enter(dir, dentry);
-	f2fs_balance_fs(sbi);
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &page);
 	if (!de)
 		goto fail;
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 	err = acquire_orphan_inode(sbi);
 	if (err) {
@@ -341,8 +342,6 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (len > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
-	f2fs_balance_fs(sbi);
-
 	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -353,6 +352,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		inode->i_op = &f2fs_symlink_inode_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
@@ -433,8 +434,6 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 	int err;
 
-	f2fs_balance_fs(sbi);
-
 	inode = f2fs_new_inode(dir, S_IFDIR | mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -444,6 +443,8 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 
+	f2fs_balance_fs(sbi);
+
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
@@ -481,8 +482,6 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err = 0;
 
-	f2fs_balance_fs(sbi);
-
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -490,6 +489,8 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	init_special_inode(inode, inode->i_mode, rdev);
 	inode->i_op = &f2fs_special_inode_operations;
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
@@ -516,9 +517,6 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int err;
 
-	if (!whiteout)
-		f2fs_balance_fs(sbi);
-
 	inode = f2fs_new_inode(dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -532,6 +530,8 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	}
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 	err = acquire_orphan_inode(sbi);
 	if (err)
@@ -604,8 +604,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 	}
 
-	f2fs_balance_fs(sbi);
-
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry)
 		goto out;
@@ -635,6 +633,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (!new_entry)
 			goto out_whiteout;
 
+		f2fs_balance_fs(sbi);
+
 		f2fs_lock_op(sbi);
 
 		err = acquire_orphan_inode(sbi);
@@ -666,6 +666,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		update_inode_page(old_inode);
 		update_inode_page(new_inode);
 	} else {
+		f2fs_balance_fs(sbi);
+
 		f2fs_lock_op(sbi);
 
 		err = f2fs_add_link(new_dentry, old_inode);
@@ -763,8 +765,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 								new_inode)))
 		return -EPERM;
 
-	f2fs_balance_fs(sbi);
-
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry)
 		goto out;
@@ -807,6 +807,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out_new_dir;
 	}
 
+	f2fs_balance_fs(sbi);
+
 	f2fs_lock_op(sbi);
 
 	err = update_dent_inode(old_inode, new_inode, &new_dentry->d_name);
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
