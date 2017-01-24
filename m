From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: enhance lookup xattr
Date: Tue, 24 Jan 2017 20:39:51 +0800
Message-ID: <20170124123951.114223-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cW0On-0007Bp-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 12:40:33 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cW0Of-0004C4-Rr
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 12:40:33 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, in getxattr we will load all entries both in inline xattr and
xattr node block, and then do the lookup in all entries, but our lookup
flow shows low efficiency, since if we can lookup and hit in inline xattr
of inode page cache first, we don't need to load and lookup xattr node
block, which can obviously save cpu time and IO latency.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/xattr.h |   7 +--
 2 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index c47ce2f330a1..a1d4de409289 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -217,6 +217,112 @@ static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
 	return entry;
 }
 
+static struct f2fs_xattr_entry *__find_inline_xattr(void *base_addr,
+					void **last_addr, int index,
+					size_t len, const char *name)
+{
+	struct f2fs_xattr_entry *entry;
+	unsigned int inline_size = F2FS_INLINE_XATTR_ADDRS << 2;
+
+	list_for_each_xattr(entry, base_addr) {
+		if ((void *)entry + sizeof(__u32) > base_addr + inline_size ||
+			(void *)XATTR_NEXT_ENTRY(entry) + sizeof(__u32) >
+			base_addr + inline_size) {
+			*last_addr = entry;
+			return NULL;
+		}
+		if (entry->e_name_index != index)
+			continue;
+		if (entry->e_name_len != len)
+			continue;
+		if (!memcmp(entry->e_name, name, len))
+			break;
+	}
+	return entry;
+}
+
+static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
+				unsigned int index, unsigned int len,
+				const char *name, struct f2fs_xattr_entry **xe,
+				void **base_addr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	void *cur_addr, *txattr_addr, *last_addr = NULL;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
+	unsigned int inline_size = 0;
+	int err = 0;
+
+	inline_size = inline_xattr_size(inode);
+
+	if (!size && !inline_size)
+		return -ENODATA;
+
+	txattr_addr = kzalloc(inline_size + size + sizeof(__u32),
+							GFP_F2FS_ZERO);
+	if (!txattr_addr)
+		return -ENOMEM;
+
+	/* read from inline xattr */
+	if (inline_size) {
+		struct page *page = NULL;
+		void *inline_addr;
+
+		if (ipage) {
+			inline_addr = inline_xattr_addr(ipage);
+		} else {
+			page = get_node_page(sbi, inode->i_ino);
+			if (IS_ERR(page)) {
+				err = PTR_ERR(page);
+				goto out;
+			}
+			inline_addr = inline_xattr_addr(page);
+		}
+		memcpy(txattr_addr, inline_addr, inline_size);
+		f2fs_put_page(page, 1);
+
+		*xe = __find_inline_xattr(txattr_addr, &last_addr,
+						index, len, name);
+		if (*xe)
+			goto check;
+	}
+
+	/* read from xattr node block */
+	if (xnid) {
+		struct page *xpage;
+		void *xattr_addr;
+
+		/* The inode already has an extended attribute block. */
+		xpage = get_node_page(sbi, xnid);
+		if (IS_ERR(xpage)) {
+			err = PTR_ERR(xpage);
+			goto out;
+		}
+
+		xattr_addr = page_address(xpage);
+		memcpy(txattr_addr + inline_size, xattr_addr, size);
+		f2fs_put_page(xpage, 1);
+	}
+
+	if (last_addr)
+		cur_addr = XATTR_HDR(last_addr) - 1;
+	else
+		cur_addr = txattr_addr;
+
+	*xe = __find_xattr(cur_addr, index, len, name);
+check:
+	if (IS_XATTR_LAST_ENTRY(*xe)) {
+		err = -ENODATA;
+		goto out;
+	}
+
+	*base_addr = txattr_addr;
+	return 0;
+out:
+	kzfree(txattr_addr);
+	return err;
+}
+
 static int read_all_xattrs(struct inode *inode, struct page *ipage,
 							void **base_addr)
 {
@@ -348,8 +454,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	}
 
 	xattr_addr = page_address(xpage);
-	memcpy(xattr_addr, txattr_addr + inline_size, PAGE_SIZE -
-						sizeof(struct node_footer));
+	memcpy(xattr_addr, txattr_addr + inline_size, MAX_XATTR_BLOCK_SIZE);
 	set_page_dirty(xpage);
 	f2fs_put_page(xpage, 1);
 
@@ -361,10 +466,11 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 int f2fs_getxattr(struct inode *inode, int index, const char *name,
 		void *buffer, size_t buffer_size, struct page *ipage)
 {
-	struct f2fs_xattr_entry *entry;
-	void *base_addr;
+	struct f2fs_xattr_entry *entry = NULL;
 	int error = 0;
-	size_t size, len;
+	unsigned int size, len;
+	char *pval;
+	void *base_addr;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -373,30 +479,26 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	error = read_all_xattrs(inode, ipage, &base_addr);
+	error = lookup_all_xattrs(inode, ipage, index, len, name,
+				&entry, &base_addr);
 	if (error)
 		return error;
 
-	entry = __find_xattr(base_addr, index, len, name);
-	if (IS_XATTR_LAST_ENTRY(entry)) {
-		error = -ENODATA;
-		goto cleanup;
-	}
-
-	size = le16_to_cpu(entry->e_value_size);
+	size = __le16_to_cpu(entry->e_value_size);
 
 	if (buffer && size > buffer_size) {
 		error = -ERANGE;
-		goto cleanup;
+		goto out;
 	}
 
+	pval = entry->e_name + entry->e_name_len;
+
 	if (buffer) {
 		char *pval = entry->e_name + entry->e_name_len;
 		memcpy(buffer, pval, size);
 	}
 	error = size;
-
-cleanup:
+out:
 	kzfree(base_addr);
 	return error;
 }
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index f990de20cdcd..d5a94928c116 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -72,9 +72,10 @@ struct f2fs_xattr_entry {
 		for (entry = XATTR_FIRST_ENTRY(addr);\
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
-
-#define MIN_OFFSET(i)	XATTR_ALIGN(inline_xattr_size(i) + PAGE_SIZE -	\
-				sizeof(struct node_footer) - sizeof(__u32))
+#define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
+#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
+#define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
+						VALID_XATTR_BLOCK_SIZE)
 
 #define MAX_VALUE_LEN(i)	(MIN_OFFSET(i) -			\
 				sizeof(struct f2fs_xattr_header) -	\
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
