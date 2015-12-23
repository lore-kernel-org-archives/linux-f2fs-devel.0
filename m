From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: check inline_data flag at converting time
Date: Tue, 22 Dec 2015 16:59:45 -0800
Message-ID: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We can check inode's inline_data flag  when calling to convert it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   |  8 +++-----
 fs/f2fs/file.c   | 58 ++++++++++++++++++++++----------------------------------
 fs/f2fs/inline.c |  3 +++
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e34b1bd..cf0c9dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1573,11 +1573,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	int err;
 
 	/* we don't need to use inline_data strictly */
-	if (f2fs_has_inline_data(inode)) {
-		err = f2fs_convert_inline_inode(inode);
-		if (err)
-			return err;
-	}
+	err = f2fs_convert_inline_inode(inode);
+	if (err)
+		return err;
 
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7f8ca47..f2effe1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -418,19 +418,18 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
+	int err;
 
 	if (f2fs_encrypted_inode(inode)) {
-		int err = f2fs_get_encryption_info(inode);
+		err = f2fs_get_encryption_info(inode);
 		if (err)
 			return 0;
 	}
 
 	/* we don't need to use inline_data strictly */
-	if (f2fs_has_inline_data(inode)) {
-		int err = f2fs_convert_inline_inode(inode);
-		if (err)
-			return err;
-	}
+	err = f2fs_convert_inline_inode(inode);
+	if (err)
+		return err;
 
 	file_accessed(file);
 	vma->vm_ops = &f2fs_file_vm_ops;
@@ -604,7 +603,7 @@ int f2fs_truncate(struct inode *inode, bool lock)
 	trace_f2fs_truncate(inode);
 
 	/* we should check inline_data size */
-	if (f2fs_has_inline_data(inode) && !f2fs_may_inline_data(inode)) {
+	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			return err;
@@ -688,8 +687,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			truncate_setsize(inode, attr->ia_size);
 
 			/* should convert inline inode here */
-			if (f2fs_has_inline_data(inode) &&
-					!f2fs_may_inline_data(inode)) {
+			if (!f2fs_may_inline_data(inode)) {
 				err = f2fs_convert_inline_inode(inode);
 				if (err)
 					return err;
@@ -786,13 +784,11 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	pgoff_t pg_start, pg_end;
 	loff_t off_start, off_end;
-	int ret = 0;
+	int ret;
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
@@ -951,11 +947,9 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(F2FS_I_SB(inode));
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
 	pg_start = offset >> PAGE_CACHE_SHIFT;
 	pg_end = (offset + len) >> PAGE_CACHE_SHIFT;
@@ -1001,11 +995,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 	f2fs_balance_fs(sbi);
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
 	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
 	if (ret)
@@ -1114,11 +1106,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	f2fs_balance_fs(sbi);
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
@@ -1168,11 +1158,9 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (ret)
 		return ret;
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_convert_inline_inode(inode);
-		if (ret)
-			return ret;
-	}
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index bda7126..8090854 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -177,6 +177,9 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	struct page *ipage, *page;
 	int err = 0;
 
+	if (!f2fs_has_inline_data(inode))
+		return 0;
+
 	page = grab_cache_page(inode->i_mapping, 0);
 	if (!page)
 		return -ENOMEM;
-- 
2.5.4 (Apple Git-61)
