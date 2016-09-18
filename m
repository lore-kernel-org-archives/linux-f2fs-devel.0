From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/6] f2fs: fix to return error number of
	read_all_xattrs correctly
Date: Sun, 18 Sep 2016 23:30:04 +0800
Message-ID: <1474212608-6930-2-git-send-email-chao@kernel.org>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1ble56-00027Q-25
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ble55-0004RP-6V
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:36 +0000
In-Reply-To: <1474212608-6930-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

We treat all error in read_all_xattrs as a no memory error, which covers
the real reason of failure in it. Fix it by return correct errno in order
to reflect the real cause.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 1660191..83234dd 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -217,18 +217,20 @@ static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
 	return entry;
 }
 
-static void *read_all_xattrs(struct inode *inode, struct page *ipage)
+static int read_all_xattrs(struct inode *inode, struct page *ipage,
+							void **base_addr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_header *header;
 	size_t size = PAGE_SIZE, inline_size = 0;
 	void *txattr_addr;
+	int err;
 
 	inline_size = inline_xattr_size(inode);
 
 	txattr_addr = kzalloc(inline_size + size, GFP_F2FS_ZERO);
 	if (!txattr_addr)
-		return NULL;
+		return -ENOMEM;
 
 	/* read from inline xattr */
 	if (inline_size) {
@@ -239,8 +241,10 @@ static void *read_all_xattrs(struct inode *inode, struct page *ipage)
 			inline_addr = inline_xattr_addr(ipage);
 		} else {
 			page = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(page))
+			if (IS_ERR(page)) {
+				err = PTR_ERR(page);
 				goto fail;
+			}
 			inline_addr = inline_xattr_addr(page);
 		}
 		memcpy(txattr_addr, inline_addr, inline_size);
@@ -254,8 +258,10 @@ static void *read_all_xattrs(struct inode *inode, struct page *ipage)
 
 		/* The inode already has an extended attribute block. */
 		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
-		if (IS_ERR(xpage))
+		if (IS_ERR(xpage)) {
+			err = PTR_ERR(xpage);
 			goto fail;
+		}
 
 		xattr_addr = page_address(xpage);
 		memcpy(txattr_addr + inline_size, xattr_addr, PAGE_SIZE);
@@ -269,10 +275,11 @@ static void *read_all_xattrs(struct inode *inode, struct page *ipage)
 		header->h_magic = cpu_to_le32(F2FS_XATTR_MAGIC);
 		header->h_refcount = cpu_to_le32(1);
 	}
-	return txattr_addr;
+	*base_addr = txattr_addr;
+	return 0;
 fail:
 	kzfree(txattr_addr);
-	return NULL;
+	return err;
 }
 
 static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
@@ -366,9 +373,9 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	base_addr = read_all_xattrs(inode, ipage);
-	if (!base_addr)
-		return -ENOMEM;
+	error = read_all_xattrs(inode, ipage, &base_addr);
+	if (error)
+		return error;
 
 	entry = __find_xattr(base_addr, index, len, name);
 	if (IS_XATTR_LAST_ENTRY(entry)) {
@@ -402,9 +409,9 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	int error = 0;
 	size_t rest = buffer_size;
 
-	base_addr = read_all_xattrs(inode, NULL);
-	if (!base_addr)
-		return -ENOMEM;
+	error = read_all_xattrs(inode, NULL, &base_addr);
+	if (error)
+		return error;
 
 	list_for_each_xattr(entry, base_addr) {
 		const struct xattr_handler *handler =
@@ -463,9 +470,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (size > MAX_VALUE_LEN(inode))
 		return -E2BIG;
 
-	base_addr = read_all_xattrs(inode, ipage);
-	if (!base_addr)
-		return -ENOMEM;
+	error = read_all_xattrs(inode, ipage, &base_addr);
+	if (error)
+		return error;
 
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, index, len, name);
-- 
2.7.2


------------------------------------------------------------------------------
