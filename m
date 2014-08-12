From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/13] f2fs: should convert inline_data during
	the mkwrite
Date: Tue, 12 Aug 2014 12:49:15 -0700
Message-ID: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4S-0007Of-TQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:24 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4Q-000095-8G for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:24 +0000
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

If mkwrite is called to an inode having inline_data, it can overwrite the data
index space as NEW_ADDR. (e.g., the first 4 bytes are coincidently zero)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/file.c   | 11 ++++++++---
 fs/f2fs/inline.c | 20 ++++++++++++--------
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7aef28d..ac3ccc2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -946,7 +946,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	f2fs_balance_fs(sbi);
 repeat:
-	err = f2fs_convert_inline_data(inode, pos + len);
+	err = f2fs_convert_inline_data(inode, pos + len, NULL);
 	if (err)
 		goto fail;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 790a073..c8288c9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1439,7 +1439,7 @@ extern const struct inode_operations f2fs_special_inode_operations;
  */
 bool f2fs_may_inline(struct inode *);
 int f2fs_read_inline_data(struct inode *, struct page *);
-int f2fs_convert_inline_data(struct inode *, pgoff_t);
+int f2fs_convert_inline_data(struct inode *, pgoff_t, struct page *);
 int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
 void truncate_inline_data(struct inode *, u64);
 int recover_inline_data(struct inode *, struct page *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 87cdac4..ecbdf6a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -41,6 +41,11 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 
 	sb_start_pagefault(inode->i_sb);
 
+	/* force to convert with normal data indices */
+	err = f2fs_convert_inline_data(inode, MAX_INLINE_DATA + 1, page);
+	if (err)
+		goto out;
+
 	/* block allocation */
 	f2fs_lock_op(sbi);
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -533,7 +538,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if ((attr->ia_valid & ATTR_SIZE) &&
 			attr->ia_size != i_size_read(inode)) {
-		err = f2fs_convert_inline_data(inode, attr->ia_size);
+		err = f2fs_convert_inline_data(inode, attr->ia_size, NULL);
 		if (err)
 			return err;
 
@@ -622,7 +627,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	ret = f2fs_convert_inline_data(inode, MAX_INLINE_DATA + 1);
+	ret = f2fs_convert_inline_data(inode, MAX_INLINE_DATA + 1, NULL);
 	if (ret)
 		return ret;
 
@@ -678,7 +683,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (ret)
 		return ret;
 
-	ret = f2fs_convert_inline_data(inode, offset + len);
+	ret = f2fs_convert_inline_data(inode, offset + len, NULL);
 	if (ret)
 		return ret;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 5beecce..1ec512d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -124,9 +124,10 @@ out:
 	return err;
 }
 
-int f2fs_convert_inline_data(struct inode *inode, pgoff_t to_size)
+int f2fs_convert_inline_data(struct inode *inode, pgoff_t to_size,
+						struct page *page)
 {
-	struct page *page;
+	struct page *new_page = page;
 	int err;
 
 	if (!f2fs_has_inline_data(inode))
@@ -134,17 +135,20 @@ int f2fs_convert_inline_data(struct inode *inode, pgoff_t to_size)
 	else if (to_size <= MAX_INLINE_DATA)
 		return 0;
 
-	page = grab_cache_page(inode->i_mapping, 0);
-	if (!page)
-		return -ENOMEM;
+	if (!page || page->index != 0) {
+		new_page = grab_cache_page(inode->i_mapping, 0);
+		if (!new_page)
+			return -ENOMEM;
+	}
 
-	err = __f2fs_convert_inline_data(inode, page);
-	f2fs_put_page(page, 1);
+	err = __f2fs_convert_inline_data(inode, new_page);
+	if (!page || page->index != 0)
+		f2fs_put_page(new_page, 1);
 	return err;
 }
 
 int f2fs_write_inline_data(struct inode *inode,
-			   struct page *page, unsigned size)
+				struct page *page, unsigned size)
 {
 	void *src_addr, *dst_addr;
 	struct page *ipage;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
