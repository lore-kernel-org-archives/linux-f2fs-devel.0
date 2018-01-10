From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: support FIEMAP_FLAG_XATTR
Date: Wed, 10 Jan 2018 14:21:08 +0800
Message-ID: <20180110062108.16068-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZ9lZ-000304-6W
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 06:21:37 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZ9lW-00054E-TG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 06:21:37 +0000
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

This patch enables ->fiemap to handle FIEMAP_FLAG_XATTR flag for xattr
mapping info lookup purpose.

It makes f2fs passing generic/425 test in fstest.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- relocate inode_lock in separated patch.
- add missing FIEMAP_EXTENT_NOT_ALIGNED to flag in inline xattr case.
 fs/f2fs/data.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 330085d3adfc..8c05e9a74427 100644
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
@@ -1148,10 +1210,15 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	inode_lock(inode);
 
-	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
 	if (ret)
 		goto out;
 
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


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
