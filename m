From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: sanity check of xattr entry size
Date: Wed, 26 Dec 2018 20:04:24 -0800
Message-ID: <20181227040424.77190-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gcMuR-0003in-1z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Dec 2018 04:04:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gcMuN-002DGk-Ju
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Dec 2018 04:04:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org

There is a security report where f2fs_getxattr() has a hole to expose wrong
memory region when the image is malformed like this.

f2fs_getxattr: entry->e_name_len: 4, size: 12288, buffer_size: 16384, len: 4

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f44b0c38398b..18d5ffbc5e8c 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -288,7 +288,7 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
-				void **base_addr)
+				void **base_addr, int *base_size)
 {
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
@@ -299,8 +299,8 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!size && !inline_size)
 		return -ENODATA;
 
-	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode),
-			inline_size + size + XATTR_PADDING_SIZE, GFP_NOFS);
+	*base_size = inline_size + size + XATTR_PADDING_SIZE;
+	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
@@ -312,8 +312,10 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 		*xe = __find_inline_xattr(inode, txattr_addr, &last_addr,
 						index, len, name);
-		if (*xe)
+		if (*xe) {
+			*base_size = inline_size;
 			goto check;
+		}
 	}
 
 	/* read from xattr node block */
@@ -474,6 +476,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	int error = 0;
 	unsigned int size, len;
 	void *base_addr = NULL;
+	int base_size;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -484,7 +487,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
-				&entry, &base_addr);
+				&entry, &base_addr, &base_size);
 	up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
@@ -498,6 +501,11 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 
 	if (buffer) {
 		char *pval = entry->e_name + entry->e_name_len;
+
+		if (base_size - (pval - (char *)base_addr) < size) {
+			error = -ERANGE;
+			goto out;
+		}
 		memcpy(buffer, pval, size);
 	}
 	error = size;
-- 
2.19.0.605.g01d371f741-goog
