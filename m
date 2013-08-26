From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/5] f2fs: introduce __find_xattr for readability
Date: Mon, 26 Aug 2013 20:16:39 +0900
Message-ID: <1377515801-15243-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1377515801-15243-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

The __find_xattr is to search the wanted xattr entry starting from the
base_addr.

If not found, the returned entry is the last empty xattr entry that can be
allocated newly.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/xattr.c | 46 +++++++++++++++++++++-------------------------
 fs/f2fs/xattr.h |  3 +--
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 3bc307c..45a8ef8 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -246,6 +246,22 @@ static inline const struct xattr_handler *f2fs_xattr_handler(int name_index)
 	return handler;
 }
 
+static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int name_index,
+					size_t name_len, const char *name)
+{
+	struct f2fs_xattr_entry *entry;
+
+	list_for_each_xattr(entry, base_addr) {
+		if (entry->e_name_index != name_index)
+			continue;
+		if (entry->e_name_len != name_len)
+			continue;
+		if (!memcmp(entry->e_name, name, name_len))
+			break;
+	}
+	return entry;
+}
+
 int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 		void *buffer, size_t buffer_size)
 {
@@ -253,8 +269,7 @@ int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_xattr_entry *entry;
 	struct page *page;
-	void *base_addr;
-	int error = 0, found = 0;
+	int error = 0;
 	size_t value_len, name_len;
 
 	if (name == NULL)
@@ -267,19 +282,9 @@ int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 	page = get_node_page(sbi, fi->i_xattr_nid);
 	if (IS_ERR(page))
 		return PTR_ERR(page);
-	base_addr = page_address(page);
 
-	list_for_each_xattr(entry, base_addr) {
-		if (entry->e_name_index != name_index)
-			continue;
-		if (entry->e_name_len != name_len)
-			continue;
-		if (!memcmp(entry->e_name, name, name_len)) {
-			found = 1;
-			break;
-		}
-	}
-	if (!found) {
+	entry = __find_xattr(page_address(page), name_index, name_len, name);
+	if (IS_XATTR_LAST_ENTRY(entry)) {
 		error = -ENODATA;
 		goto cleanup;
 	}
@@ -417,18 +422,9 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
 	}
 
 	/* find entry with wanted name. */
-	found = 0;
-	list_for_each_xattr(here, base_addr) {
-		if (here->e_name_index != name_index)
-			continue;
-		if (here->e_name_len != name_len)
-			continue;
-		if (!memcmp(here->e_name, name, name_len)) {
-			found = 1;
-			break;
-		}
-	}
+	here = __find_xattr(base_addr, name_index, name_len, name);
 
+	found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
 	last = here;
 
 	while (!IS_XATTR_LAST_ENTRY(last))
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 3c0817b..c3ec042 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -51,7 +51,7 @@ struct f2fs_xattr_entry {
 
 #define XATTR_HDR(ptr)		((struct f2fs_xattr_header *)(ptr))
 #define XATTR_ENTRY(ptr)	((struct f2fs_xattr_entry *)(ptr))
-#define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr)+1))
+#define XATTR_FIRST_ENTRY(ptr)	(XATTR_ENTRY(XATTR_HDR(ptr) + 1))
 #define XATTR_ROUND		(3)
 
 #define XATTR_ALIGN(size)	((size + XATTR_ROUND) & ~XATTR_ROUND)
@@ -69,7 +69,6 @@ struct f2fs_xattr_entry {
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
 
-
 #define MIN_OFFSET	XATTR_ALIGN(PAGE_SIZE - \
 			sizeof(struct node_footer) - \
 			sizeof(__u32))
-- 
1.8.3.1.437.g0dbd812

