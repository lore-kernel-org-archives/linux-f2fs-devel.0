From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 RESEND] f2fs: support FIEMAP_FLAG_XATTR
Date: Thu, 11 Jan 2018 14:39:57 +0800
Message-ID: <20180111063957.38318-1-yuchao0@huawei.com>
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
 fs/f2fs/data.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 12155ee90468..3c1a0f1a3e53 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1136,6 +1136,68 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
 	return (blk << inode->i_blkbits);
 }
 
+static int f2fs_xattr_fiemap(struct inode *inode,
+				struct fiemap_extent_info *fieinfo)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct page *page;
+	struct node_info ni;
+	__u64 phys = 0, len;
+	__u32 flags;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
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
+		len = inline_xattr_size(inode);
+
+		f2fs_put_page(page, 1);
+
+		flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED;
+
+		if (!xnid)
+			flags |= FIEMAP_EXTENT_LAST;
+
+		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		if (err || err == 1)
+			return err;
+	}
+
+	if (xnid) {
+		page = f2fs_grab_cache_page(NODE_MAPPING(sbi), xnid, false);
+		if (!page)
+			return -ENOMEM;
+
+		get_node_info(sbi, xnid, &ni);
+
+		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		len = inode->i_sb->s_blocksize;
+
+		f2fs_put_page(page, 1);
+
+		flags = FIEMAP_EXTENT_LAST;
+	}
+
+	if (phys)
+		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+
+	return (err < 0 ? err : 0);
+}
+
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
@@ -1146,12 +1208,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	u32 flags = 0;
 	int ret = 0;
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
 	if (ret)
 		return ret;
 
 	inode_lock(inode);
 
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
+		ret = f2fs_xattr_fiemap(inode, fieinfo);
+		goto out;
+	}
+
 	if (f2fs_has_inline_data(inode)) {
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
-- 
2.15.0.55.gc2ece9dc4de6
