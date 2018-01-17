From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: kill F2FS_INLINE_XATTR_ADDRS for cleanup
Date: Wed, 17 Jan 2018 16:31:36 +0800
Message-ID: <20180117083138.27755-2-yuchao0@huawei.com>
References: <20180117083138.27755-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117083138.27755-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Use get_inline_xattr_addrs directly instead of F2FS_INLINE_XATTR_ADDRS.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 fs/f2fs/f2fs.h | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 67902ad08d7a..b0e75d74fd57 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1200,7 +1200,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
 					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
-					F2FS_INLINE_XATTR_ADDRS(inode));
+					get_inline_xattr_addrs(inode));
 
 		phys += offset;
 		len = inline_xattr_size(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d1bd1ab28f9c..75df68651607 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -416,10 +416,9 @@ struct f2fs_flush_device {
 #define DEF_MIN_INLINE_SIZE		1
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
-#define F2FS_INLINE_XATTR_ADDRS(inode)	get_inline_xattr_addrs(inode)
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
 				(CUR_ADDRS_PER_INODE(inode) -		\
-				F2FS_INLINE_XATTR_ADDRS(inode) -	\
+				get_inline_xattr_addrs(inode) -	\
 				DEF_INLINE_RESERVED_SIZE))
 
 /* for inline dir */
@@ -2330,7 +2329,7 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
 
 static inline unsigned int addrs_per_inode(struct inode *inode)
 {
-	return CUR_ADDRS_PER_INODE(inode) - F2FS_INLINE_XATTR_ADDRS(inode);
+	return CUR_ADDRS_PER_INODE(inode) - get_inline_xattr_addrs(inode);
 }
 
 static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
@@ -2338,7 +2337,7 @@ static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
 	struct f2fs_inode *ri = F2FS_INODE(page);
 
 	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
-					F2FS_INLINE_XATTR_ADDRS(inode)]);
+					get_inline_xattr_addrs(inode)]);
 }
 
 static inline int inline_xattr_size(struct inode *inode)
-- 
2.15.0.55.gc2ece9dc4de6
