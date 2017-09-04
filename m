From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: introduce read_inline_xattr
Date: Mon, 4 Sep 2017 18:58:02 +0800
Message-ID: <20170904105804.8042-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dop5I-0002QK-H5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 10:58:28 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dop5G-0006gF-LW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Sep 2017 10:58:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Commit ba38c27eb93e ("f2fs: enhance lookup xattr") introduces
lookup_all_xattrs duplicating from read_all_xattrs, which leaves
lots of similar codes in between them, so introduce new help
read_inline_xattr to clean up redundant codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 59 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ef3a3721ea6b..a1e41649f037 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -241,6 +241,29 @@ static struct f2fs_xattr_entry *__find_inline_xattr(void *base_addr,
 	return entry;
 }
 
+static int read_inline_xattr(struct inode *inode, struct page *ipage,
+							void *txattr_addr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int inline_size = inline_xattr_size(inode);
+	struct page *page = NULL;
+	void *inline_addr;
+
+	if (ipage) {
+		inline_addr = inline_xattr_addr(ipage);
+	} else {
+		page = get_node_page(sbi, inode->i_ino);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		inline_addr = inline_xattr_addr(page);
+	}
+	memcpy(txattr_addr, inline_addr, inline_size);
+	f2fs_put_page(page, 1);
+
+	return 0;
+}
+
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
@@ -263,21 +286,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 	/* read from inline xattr */
 	if (inline_size) {
-		struct page *page = NULL;
-		void *inline_addr;
-
-		if (ipage) {
-			inline_addr = inline_xattr_addr(ipage);
-		} else {
-			page = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(page)) {
-				err = PTR_ERR(page);
-				goto out;
-			}
-			inline_addr = inline_xattr_addr(page);
-		}
-		memcpy(txattr_addr, inline_addr, inline_size);
-		f2fs_put_page(page, 1);
+		err = read_inline_xattr(inode, ipage, txattr_addr);
+		if (err)
+			goto out;
 
 		*xe = __find_inline_xattr(txattr_addr, &last_addr,
 						index, len, name);
@@ -339,21 +350,9 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 
 	/* read from inline xattr */
 	if (inline_size) {
-		struct page *page = NULL;
-		void *inline_addr;
-
-		if (ipage) {
-			inline_addr = inline_xattr_addr(ipage);
-		} else {
-			page = get_node_page(sbi, inode->i_ino);
-			if (IS_ERR(page)) {
-				err = PTR_ERR(page);
-				goto fail;
-			}
-			inline_addr = inline_xattr_addr(page);
-		}
-		memcpy(txattr_addr, inline_addr, inline_size);
-		f2fs_put_page(page, 1);
+		err = read_inline_xattr(inode, ipage, txattr_addr);
+		if (err)
+			goto fail;
 	}
 
 	/* read from xattr node block */
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
