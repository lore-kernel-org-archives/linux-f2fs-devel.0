From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: support statx
Date: Wed,  3 May 2017 23:59:12 +0800
Message-ID: <20170503155914.6859-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Last kernel has already support new syscall statx() in commit a528d35e8bfc
("statx: Add a system call to make enhanced file info available"), with
this interface we can show more file info including file creation and some
attribute flags to user.

This patch tries to support this functionality.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cdbf1add2a11..1c1c9bc4f19a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -633,9 +633,30 @@ int f2fs_truncate(struct inode *inode)
 }
 
 int f2fs_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+		 u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	unsigned int flags;
+
+	flags = fi->i_flags & FS_FL_USER_VISIBLE;
+	if (flags & FS_APPEND_FL)
+		stat->attributes |= STATX_ATTR_APPEND;
+	if (flags & FS_COMPR_FL)
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+	if (f2fs_encrypted_inode(inode))
+		stat->attributes |= STATX_ATTR_ENCRYPTED;
+	if (flags & FS_IMMUTABLE_FL)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+	if (flags & FS_NODUMP_FL)
+		stat->attributes |= STATX_ATTR_NODUMP;
+
+	stat->attributes_mask |= (STATX_ATTR_APPEND |
+				  STATX_ATTR_COMPRESSED |
+				  STATX_ATTR_ENCRYPTED |
+				  STATX_ATTR_IMMUTABLE |
+				  STATX_ATTR_NODUMP);
+
 	generic_fillattr(inode, stat);
 	stat->blocks <<= 3;
 	return 0;
-- 
2.12.2.575.gb14f27f
