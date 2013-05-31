From: Jason Hrycay <jhrycay@gmail.com>
Subject: f2fs: handle errors from get_node_page calls
Date: Fri, 31 May 2013 12:45:11 -0500
Message-ID: <51A8E1A7.3080403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk.kim@samsung.com, jason.hrycay@motorola.com, C.Fries@motorola.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add check for error pointers returned from get_node_page in order to
avoid dereferencing a bad address on the next use.

Signed-off-by: Jason Hrycay <jason.hrycay@motorola.com>
---
 fs/f2fs/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 0b02dce..ae61f35 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -218,6 +218,8 @@ int f2fs_getxattr(struct inode *inode, int
name_index, const char *name,
 		return -ENODATA;

 	page = get_node_page(sbi, fi->i_xattr_nid);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 	base_addr = page_address(page);

 	list_for_each_xattr(entry, base_addr) {
@@ -268,6 +270,8 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char
*buffer, size_t buffer_size)
 		return 0;

 	page = get_node_page(sbi, fi->i_xattr_nid);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 	base_addr = page_address(page);

 	list_for_each_xattr(entry, base_addr) {
-- 
1.8.0
