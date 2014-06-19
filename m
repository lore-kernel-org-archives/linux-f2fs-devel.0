From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: support ->tmpfile()
Date: Thu, 19 Jun 2014 16:23:19 +0800
Message-ID: <001901cf8b97$d7dea910$879bfb30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WxXdr-000880-NT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 08:24:19 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WxXdp-0003ts-QH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 08:24:19 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7E00HSTQ09SA00@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 17:24:09 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Add function f2fs_tmpfile() to support O_TMPFILE file creation, and modify logic
of init_inode_metadata to enable linkat temp file.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c   |   10 ++++++++-
 fs/f2fs/namei.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 966acb0..09760d5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -333,10 +333,12 @@ static int make_empty_dir(struct inode *inode,
 static struct page *init_inode_metadata(struct inode *inode,
 		struct inode *dir, const struct qstr *name)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct page *page;
 	int err;
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
+	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE) &&
+			inode->i_nlink) {
 		page = new_inode_page(inode, name);
 		if (IS_ERR(page))
 			return page;
@@ -370,6 +372,12 @@ static struct page *init_inode_metadata(struct inode *inode,
 	 */
 	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK)) {
 		file_lost_pino(inode);
+		/*
+		 * If link the tmpfile to alias through linkat path,
+		 * we should remove this inode from orphan list.
+		 */
+		if (inode->i_nlink == 0)
+			remove_orphan_inode(sbi, inode->i_ino);
 		inc_nlink(inode);
 	}
 	return page;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 9138c32..0d55517 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
+#include <linux/dcache.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -488,6 +489,68 @@ out:
 	return err;
 }
 
+static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct super_block *sb = dir->i_sb;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct inode *inode;
+	struct page *page;
+	int err;
+
+	inode = f2fs_new_inode(dir, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &f2fs_file_inode_operations;
+	inode->i_fop = &f2fs_file_operations;
+	inode->i_mapping->a_ops = &f2fs_dblock_aops;
+
+	f2fs_lock_op(sbi);
+	err = acquire_orphan_inode(sbi);
+	if (err)
+		goto out;
+	/*
+	 * add this non-linked tmpfile to orphan list, in this way we could
+	 * remove all unused data of tmpfile after abnormal power-off.
+	 */
+	add_orphan_inode(sbi, inode->i_ino);
+
+	page = new_inode_page(inode, NULL);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto remove_out;
+	}
+
+	err = f2fs_init_acl(inode, dir, page);
+	if (err)
+		goto unlock_out;
+
+	err = f2fs_init_security(inode, dir, NULL, page);
+	if (err)
+		goto unlock_out;
+
+	f2fs_put_page(page, 1);
+	f2fs_unlock_op(sbi);
+
+	alloc_nid_done(sbi, inode->i_ino);
+	mark_inode_dirty(inode);
+	d_tmpfile(dentry, inode);
+	unlock_new_inode(inode);
+	return 0;
+unlock_out:
+	f2fs_put_page(page, 1);
+remove_out:
+	remove_orphan_inode(sbi, inode->i_ino);
+out:
+	f2fs_unlock_op(sbi);
+	clear_nlink(inode);
+	unlock_new_inode(inode);
+	make_bad_inode(inode);
+	iput(inode);
+	alloc_nid_failed(sbi, inode->i_ino);
+	return err;
+}
+
 const struct inode_operations f2fs_dir_inode_operations = {
 	.create		= f2fs_create,
 	.lookup		= f2fs_lookup,
@@ -498,6 +561,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.rmdir		= f2fs_rmdir,
 	.mknod		= f2fs_mknod,
 	.rename		= f2fs_rename,
+	.tmpfile	= f2fs_tmpfile,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
 	.get_acl	= f2fs_get_acl,
-- 
1.7.9.5



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
