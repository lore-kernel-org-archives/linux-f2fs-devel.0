From: Randall Huang <huangrandall@google.com>
Subject: [PATCH] f2fs: add boundary check in inline_data_addr
Date: Wed, 12 Jun 2019 16:58:00 +0800
Message-ID: <20190612085800.11947-1-huangrandall@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: huangrandall@google.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add boundary check in case of extra_size is larger
than sizeof array "i_addr"

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 fs/f2fs/f2fs.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 760390f380b6..17f3858a00c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2660,11 +2660,25 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
 	return is_inode_flag_set(inode, FI_DROP_CACHE);
 }
 
+#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
+	(offsetof(struct f2fs_inode, i_extra_end) -	\
+	offsetof(struct f2fs_inode, i_extra_isize))	\
+
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
 	int extra_size = get_extra_isize(inode);
 
+	if (extra_size < 0 || extra_size > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+		extra_size % sizeof(__le32)) {
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_ERR,
+			"%s: inode (ino=%lx) has corrupted i_extra_isize: %d, "
+			"max: %zu",
+			__func__, inode->i_ino, extra_size,
+			F2FS_TOTAL_EXTRA_ATTR_SIZE);
+		extra_size = 0;
+	}
+
 	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
 }
 
@@ -2817,10 +2831,6 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
-#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
-	(offsetof(struct f2fs_inode, i_extra_end) -	\
-	offsetof(struct f2fs_inode, i_extra_isize))	\
-
 #define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
 #define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
 		((offsetof(typeof(*(f2fs_inode)), field) +	\
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
