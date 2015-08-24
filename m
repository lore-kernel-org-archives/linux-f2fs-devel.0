From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: handle f2fs_truncate error correctly
Date: Mon, 24 Aug 2015 17:39:42 +0800
Message-ID: <001a01d0de50$e6830300$b3890900$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZToEy-00027w-P0
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:40:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZToEx-0006Jp-Kt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:40:32 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTK00OM5YVC9L00@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 18:40:24 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes to return error number of f2fs_truncate, so that we
can handle the error correctly in callers.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ece5e70..806439f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1595,7 +1595,7 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 int f2fs_sync_file(struct file *, loff_t, loff_t, int);
 void truncate_data_blocks(struct dnode_of_data *);
 int truncate_blocks(struct inode *, u64, bool);
-void f2fs_truncate(struct inode *, bool);
+int f2fs_truncate(struct inode *, bool);
 int f2fs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int f2fs_setattr(struct dentry *, struct iattr *);
 int truncate_hole(struct inode *, pgoff_t, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7faafb5..86a5c76 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -579,24 +579,30 @@ out:
 	return err;
 }
 
-void f2fs_truncate(struct inode *inode, bool lock)
+int f2fs_truncate(struct inode *inode, bool lock)
 {
+	int err;
+
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 				S_ISLNK(inode->i_mode)))
-		return;
+		return 0;
 
 	trace_f2fs_truncate(inode);
 
 	/* we should check inline_data size */
 	if (f2fs_has_inline_data(inode) && !f2fs_may_inline_data(inode)) {
-		if (f2fs_convert_inline_inode(inode))
-			return;
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			return err;
 	}
 
-	if (!truncate_blocks(inode, i_size_read(inode), lock)) {
-		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty(inode);
-	}
+	err = truncate_blocks(inode, i_size_read(inode), lock);
+	if (err)
+		return err;
+
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 int f2fs_getattr(struct vfsmount *mnt,
@@ -656,7 +662,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 		if (attr->ia_size <= i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
-			f2fs_truncate(inode, true);
+			err = f2fs_truncate(inode, true);
+			if (err)
+				return err;
 			f2fs_balance_fs(F2FS_I_SB(inode));
 		} else {
 			/*
-- 
2.4.2



------------------------------------------------------------------------------
