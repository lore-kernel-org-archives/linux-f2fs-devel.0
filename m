From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support FIEMAP_FLAG_XATTR
Date: Thu, 4 Jan 2018 18:09:20 +0800
Message-ID: <20180104100920.22204-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch enables ->fiemap to handle FIEMAP_FLAG_XATTR flag for xattr
mapping info lookup purpose.

It makes f2fs passing generic/425 test in fstest.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 71838f53734e..31e4fe17ea12 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1128,6 +1128,58 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
 	return (blk << inode->i_blkbits);
 }
 
+static int f2fs_xattr_fiemap(struct inode *inode,
+				struct fiemap_extent_info *fieinfo)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct page *page;
+	struct node_info ni;
+	__u64 phys = 0;
+	__u64 length;
+	__u32 flags = FIEMAP_EXTENT_LAST;
+	int err = 0;
+
+	if (f2fs_has_inline_xattr(inode)) {
+		int offset;
+
+		page = f2fs_grab_cache_page(NODE_MAPPING(sbi),
+						inode->i_ino, false);
+		if (!page)
+			return -ENOMEM;
+
+		get_node_info(sbi, inode->i_ino, &ni);
+
+		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		offset = offsetof(struct f2fs_inode, i_addr) +
+					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
+					F2FS_INLINE_XATTR_ADDRS(inode));
+
+		phys += offset;
+		length = inline_xattr_size(inode);
+
+		f2fs_put_page(page, 1);
+
+		flags |= FIEMAP_EXTENT_DATA_INLINE;
+	} else if (F2FS_I(inode)->i_xattr_nid) {
+		page = f2fs_grab_cache_page(NODE_MAPPING(sbi),
+					F2FS_I(inode)->i_xattr_nid, false);
+		if (!page)
+			return -ENOMEM;
+
+		get_node_info(sbi, F2FS_I(inode)->i_xattr_nid, &ni);
+
+		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		length = inode->i_sb->s_blocksize;
+
+		f2fs_put_page(page, 1);
+	}
+
+	if (phys)
+		err = fiemap_fill_next_extent(fieinfo, 0, phys, length, flags);
+
+	return (err < 0 ? err : 0);
+}
+
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
@@ -1138,18 +1190,23 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u32 flags = 0;
 	int ret = 0;
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
+		ret = f2fs_xattr_fiemap(inode, fieinfo);
+		goto out;
+	}
+
 	if (f2fs_has_inline_data(inode)) {
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
-			return ret;
+			goto out;
 	}
 
-	inode_lock(inode);
-
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
-- 
2.15.0.55.gc2ece9dc4de6
