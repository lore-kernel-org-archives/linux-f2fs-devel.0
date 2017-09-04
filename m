From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: introduce read_xattr_block
Date: Mon, 4 Sep 2017 18:58:03 +0800
Message-ID: <20170904105804.8042-2-yuchao0@huawei.com>
References: <20170904105804.8042-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904105804.8042-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit ba38c27eb93e ("f2fs: enhance lookup xattr") introduces
lookup_all_xattrs duplicating from read_all_xattrs, which leaves
lots of similar codes in between them, so introduce new help
read_xattr_block to clean up redundant codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index a1e41649f037..4829f1b38478 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -264,12 +264,31 @@ static int read_inline_xattr(struct inode *inode, struct page *ipage,
 	return 0;
 }
 
+static int read_xattr_block(struct inode *inode, void *txattr_addr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	unsigned int inline_size = inline_xattr_size(inode);
+	struct page *xpage;
+	void *xattr_addr;
+
+	/* The inode already has an extended attribute block. */
+	xpage = get_node_page(sbi, xnid);
+	if (IS_ERR(xpage))
+		return PTR_ERR(xpage);
+
+	xattr_addr = page_address(xpage);
+	memcpy(txattr_addr + inline_size, xattr_addr, VALID_XATTR_BLOCK_SIZE);
+	f2fs_put_page(xpage, 1);
+
+	return 0;
+}
+
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
 				void **base_addr)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
@@ -298,19 +317,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 	/* read from xattr node block */
 	if (xnid) {
-		struct page *xpage;
-		void *xattr_addr;
-
-		/* The inode already has an extended attribute block. */
-		xpage = get_node_page(sbi, xnid);
-		if (IS_ERR(xpage)) {
-			err = PTR_ERR(xpage);
+		err = read_xattr_block(inode, txattr_addr);
+		if (err)
 			goto out;
-		}
-
-		xattr_addr = page_address(xpage);
-		memcpy(txattr_addr + inline_size, xattr_addr, size);
-		f2fs_put_page(xpage, 1);
 	}
 
 	if (last_addr)
@@ -335,7 +344,6 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 static int read_all_xattrs(struct inode *inode, struct page *ipage,
 							void **base_addr)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_header *header;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int size = VALID_XATTR_BLOCK_SIZE;
@@ -357,19 +365,9 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 
 	/* read from xattr node block */
 	if (xnid) {
-		struct page *xpage;
-		void *xattr_addr;
-
-		/* The inode already has an extended attribute block. */
-		xpage = get_node_page(sbi, xnid);
-		if (IS_ERR(xpage)) {
-			err = PTR_ERR(xpage);
+		err = read_xattr_block(inode, txattr_addr);
+		if (err)
 			goto fail;
-		}
-
-		xattr_addr = page_address(xpage);
-		memcpy(txattr_addr + inline_size, xattr_addr, size);
-		f2fs_put_page(xpage, 1);
 	}
 
 	header = XATTR_HDR(txattr_addr);
-- 
2.13.1.388.g69e6b9b4f4a9
