From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: [PATCH] f2fs: prevent newly created inode from being dirtied
 incorrectly
Date: Thu, 11 Jan 2018 11:26:19 +0900
Message-ID: <1515637579-8360-1-git-send-email-daeho.jeong@samsung.com>
References: <CGME20180111022559epcas2p4b188916d6259160ed9648c9265ce2c8a@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Daeho Jeong <daeho.jeong@samsung.com>, Youngjin Gil <youngjin.gil@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Now, we invoke f2fs_mark_inode_dirty_sync() to make an inode dirty in
advance of creating a new node page for the inode. By this, some inodes
whose node page is not created yet can be linked into the global dirty
list.

If the checkpoint is executed at this moment, the inode will be written
back by writeback_single_inode() and finally update_inode_page() will
fail to detach the inode from the global dirty list because the inode
doesn't have a node page.

The problem is that the inode's state in VFS layer will become clean
after execution of writeback_single_inode() and it's still linked in
the global dirty list of f2fs and this will cause a kernel panic.

So, we will prevent the newly created inode from being dirtied during
the FI_NEW_INODE flag of the inode is set. We will make it dirty
right after the flag is cleared.

Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
Tested-by: Hobin Woo <hobin.woo@samsung.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/inode.c | 3 +++
 fs/f2fs/namei.c | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f4e094e..546c7d6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2116,6 +2116,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_XATTR:
 	case FI_INLINE_DATA:
 	case FI_INLINE_DENTRY:
+	case FI_NEW_INODE:
 		if (set)
 			return;
 	case FI_DATA_EXIST:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b4c4f2b..67dfa16 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -22,6 +22,9 @@
 
 void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 {
+	if (is_inode_flag_set(inode, FI_NEW_INODE))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 28bdf88..bedf225 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -74,12 +74,12 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (err)
 		goto fail_drop;
 
+	set_inode_flag(inode, FI_NEW_INODE);
+
 	/* If the directory encrypted, then we should encrypt the inode. */
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
-	set_inode_flag(inode, FI_NEW_INODE);
-
 	if (f2fs_sb_has_extra_attr(sbi->sb)) {
 		set_inode_flag(inode, FI_EXTRA_ATTR);
 		F2FS_I(inode)->i_extra_isize = F2FS_TOTAL_EXTRA_ATTR_SIZE;
-- 
1.9.1
