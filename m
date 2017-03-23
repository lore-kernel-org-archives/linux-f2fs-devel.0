From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up xattr operation
Date: Thu, 23 Mar 2017 13:38:25 +0800
Message-ID: <20170323053826.37176-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqvSf-0006Ok-7y
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Mar 2017 05:39:01 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqvSb-0001Fv-SP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Mar 2017 05:39:01 +0000
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

1. don't allocate redundant memory in read_all_xattrs.
2. introduce RESERVED_XATTR_SIZE for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/xattr.c | 25 +++++++++++--------------
 fs/f2fs/xattr.h |  3 ++-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index aff7619e3f96..528aed399814 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -250,15 +250,13 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
-	unsigned int inline_size = 0;
+	unsigned int inline_size = inline_xattr_size(inode);
 	int err = 0;
 
-	inline_size = inline_xattr_size(inode);
-
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = kzalloc(inline_size + size + sizeof(__u32),
+	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
 							GFP_F2FS_ZERO);
 	if (!txattr_addr)
 		return -ENOMEM;
@@ -328,13 +326,14 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_header *header;
-	size_t size = PAGE_SIZE, inline_size = 0;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
+	unsigned int size = VALID_XATTR_BLOCK_SIZE;
+	unsigned int inline_size = inline_xattr_size(inode);
 	void *txattr_addr;
 	int err;
 
-	inline_size = inline_xattr_size(inode);
-
-	txattr_addr = kzalloc(inline_size + size, GFP_F2FS_ZERO);
+	txattr_addr = kzalloc(inline_size + size + RESERVED_XATTR_SIZE,
+							GFP_F2FS_ZERO);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -358,19 +357,19 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 	}
 
 	/* read from xattr node block */
-	if (F2FS_I(inode)->i_xattr_nid) {
+	if (xnid) {
 		struct page *xpage;
 		void *xattr_addr;
 
 		/* The inode already has an extended attribute block. */
-		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
+		xpage = get_node_page(sbi, xnid);
 		if (IS_ERR(xpage)) {
 			err = PTR_ERR(xpage);
 			goto fail;
 		}
 
 		xattr_addr = page_address(xpage);
-		memcpy(txattr_addr + inline_size, xattr_addr, PAGE_SIZE);
+		memcpy(txattr_addr + inline_size, xattr_addr, size);
 		f2fs_put_page(xpage, 1);
 	}
 
@@ -392,14 +391,12 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 				void *txattr_addr, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	size_t inline_size = 0;
+	size_t inline_size = inline_xattr_size(inode);
 	void *xattr_addr;
 	struct page *xpage;
 	nid_t new_nid = 0;
 	int err;
 
-	inline_size = inline_xattr_size(inode);
-
 	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
 		if (!alloc_nid(sbi, &new_nid))
 			return -ENOSPC;
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index d5a94928c116..1e7db8d0806e 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -73,7 +73,8 @@ struct f2fs_xattr_entry {
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
 #define MAX_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
-#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - sizeof(__u32))
+#define RESERVED_XATTR_SIZE	(sizeof(__u32))
+#define VALID_XATTR_BLOCK_SIZE	(MAX_XATTR_BLOCK_SIZE - RESERVED_XATTR_SIZE)
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
 						VALID_XATTR_BLOCK_SIZE)
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
