From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: avoid unnecessary f2fs_gc for dir
	operations
Date: Tue, 22 Dec 2015 16:59:46 -0800
Message-ID: <1450832388-29118-2-git-send-email-jaegeuk@kernel.org>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBXmY-0003yz-Uf
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 00:59:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBXmY-0006Y2-1K for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 00:59:58 +0000
In-Reply-To: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
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

The f2fs_balance_fs doesn't need to cover f2fs_new_inode or f2fs_find_entry
works.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 2c32110..8d2616f 100644
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
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
