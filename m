From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: introduce f2fs_has_inline_xattr for better
 readability
Date: Wed, 12 Mar 2014 15:59:03 +0800
Message-ID: <001501cf3dc9$0ca56340$25f029c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces a help function f2fs_has_inline_xattr for better
readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |    9 +++++++--
 fs/f2fs/node.c |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f845e92..1f87a04 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -991,9 +991,14 @@ static inline void set_raw_inline(struct f2fs_inode_info *fi,
 		ri->i_inline |= F2FS_INLINE_DATA;
 }
 
+static inline int f2fs_has_inline_xattr(struct inode *inode)
+{
+	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR);
+}
+
 static inline unsigned int addrs_per_inode(struct f2fs_inode_info *fi)
 {
-	if (is_inode_flag_set(fi, FI_INLINE_XATTR))
+	if (f2fs_has_inline_xattr(&fi->vfs_inode))
 		return DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS;
 	return DEF_ADDRS_PER_INODE;
 }
@@ -1007,7 +1012,7 @@ static inline void *inline_xattr_addr(struct page *page)
 
 static inline int inline_xattr_size(struct inode *inode)
 {
-	if (is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR))
+	if (f2fs_has_inline_xattr(inode))
 		return F2FS_INLINE_XATTR_ADDRS << 2;
 	else
 		return 0;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e72b258..c618fad 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1501,7 +1501,7 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 	struct page *ipage;
 	struct f2fs_inode *ri;
 
-	if (!is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR))
+	if (!f2fs_has_inline_xattr(inode))
 		return;
 
 	if (!IS_INODE(page))
-- 
1.7.9.5
