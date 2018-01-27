From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: enhance scalibility of {d, id, did,
 x}node disk layout
Date: Sat, 27 Jan 2018 17:43:00 +0800
Message-ID: <20180127094301.29154-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efN1H-0003u8-WE
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:43:32 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efN1F-0000vn-Dw
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:43:31 +0000
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

Scalibility of non-inode disk layout is very bad, it's hard to add or reuse
any fields in current structure, so, for new feature like node checksum
which wants to add 4 bytes field in node structure, the bad scaliblity
becomes a obstacle for its implementation.

In order to enhance scalibility, we introduce a new filesystem feature
'extended_node' which can be enabled via mkfs.f2fs, once this feature is
set, we will add and configure f2fs_super_block::extra_nsize to indicate
extended space used for storing new attribution, accordingly, it needs
to recalculate space of original .addr/.nid/xattr space in node block.

dnode, idnode, didnode, xnode disk layout:
  +----------------------+
  | .addr or .nid, .xatt |
  +----------------------+<----+
  | ......               |     |
  | .epoch               |     |
  | .transaction_id      |     +------ f2fs_super_block::extra_nsize
  | .node_checksum       |     |
  +----------------------+<----+
  |   node_footer        |
  | (nid, ino, offset)   |
  +----------------------+

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h          | 23 +++++++++++++++++++++++
 fs/f2fs/file.c          |  7 ++++---
 fs/f2fs/gc.c            |  9 +++++----
 fs/f2fs/node.c          | 46 +++++++++++++++++++++++++---------------------
 fs/f2fs/node.h          | 13 ++++++++-----
 fs/f2fs/super.c         | 16 +++++++++++-----
 fs/f2fs/sysfs.c         |  7 +++++++
 fs/f2fs/xattr.c         | 10 ++++++----
 fs/f2fs/xattr.h         |  6 ++++--
 include/linux/f2fs_fs.h | 18 ++++++++++--------
 10 files changed, 103 insertions(+), 52 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ac1c09419e2..6f5e41657c62 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -127,6 +127,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
+#define F2FS_FEATURE_EXTENDED_NODE	0x0200
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -416,6 +417,7 @@ struct f2fs_flush_device {
 #define DEF_INLINE_RESERVED_SIZE	1
 #define DEF_MIN_INLINE_SIZE		1
 static inline int get_extra_isize(struct inode *inode);
+static inline int get_extra_nsize(struct super_block *sb);
 static inline int get_inline_xattr_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
 				(CUR_ADDRS_PER_INODE(inode) -		\
@@ -1123,6 +1125,7 @@ struct f2fs_sb_info {
 	int inline_xattr_size;			/* inline xattr size */
 	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
 	int readdir_ra;				/* readahead inode in readdir */
+	unsigned int extra_nsize;		/* extra attr size in {d,id,did,x}node */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
@@ -2344,6 +2347,16 @@ static inline unsigned int addrs_per_inode(struct inode *inode)
 	return CUR_ADDRS_PER_INODE(inode) - get_inline_xattr_addrs(inode);
 }
 
+static inline unsigned int addrs_per_dnode(struct inode *inode)
+{
+	return DEF_ADDRS_PER_BLOCK - get_extra_nsize(inode->i_sb);
+}
+
+static inline unsigned int nids_per_idnode(struct inode *inode)
+{
+	return DEF_NIDS_PER_BLOCK - get_extra_nsize(inode->i_sb);
+}
+
 static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
@@ -2533,6 +2546,11 @@ static inline int get_extra_isize(struct inode *inode)
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
+static inline int get_extra_nsize(struct super_block *sb)
+{
+	return F2FS_SB(sb)->extra_nsize / sizeof(__le32);
+}
+
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
 	return F2FS_I(inode)->i_inline_xattr_size;
@@ -3229,6 +3247,11 @@ static inline int f2fs_sb_has_inode_crtime(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CRTIME);
 }
 
+static inline int f2fs_sb_has_extended_node(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_EXTENDED_NODE);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d56c3b7a8ba1..b8810843dc21 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -540,7 +540,7 @@ void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 
 void truncate_data_blocks(struct dnode_of_data *dn)
 {
-	truncate_data_blocks_range(dn, ADDRS_PER_BLOCK);
+	truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
 }
 
 static int truncate_partial_data_page(struct inode *inode, u64 from,
@@ -978,7 +978,8 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	} else if (ret == -ENOENT) {
 		if (dn.max_level == 0)
 			return -ENOENT;
-		done = min((pgoff_t)ADDRS_PER_BLOCK - dn.ofs_in_node, len);
+		done = min((pgoff_t)ADDRS_PER_BLOCK(inode) - dn.ofs_in_node,
+									len);
 		blkaddr += done;
 		do_replace += done;
 		goto next;
@@ -1122,7 +1123,7 @@ static int __exchange_data_block(struct inode *src_inode,
 	int ret;
 
 	while (len) {
-		olen = min((pgoff_t)4 * ADDRS_PER_BLOCK, len);
+		olen = min((pgoff_t)4 * ADDRS_PER_BLOCK(src_inode), len);
 
 		src_blkaddr = f2fs_kvzalloc(F2FS_I_SB(src_inode),
 					sizeof(block_t) * olen, GFP_KERNEL);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3b26aa19430b..0da1e218a1ec 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -538,7 +538,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
  */
 block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 {
-	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
+	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK(inode) + 4;
 	unsigned int bidx;
 
 	if (node_ofs == 0)
@@ -547,13 +547,14 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 	if (node_ofs <= 2) {
 		bidx = node_ofs - 1;
 	} else if (node_ofs <= indirect_blks) {
-		int dec = (node_ofs - 4) / (NIDS_PER_BLOCK + 1);
+		int dec = (node_ofs - 4) / (NIDS_PER_BLOCK(inode) + 1);
 		bidx = node_ofs - 2 - dec;
 	} else {
-		int dec = (node_ofs - indirect_blks - 3) / (NIDS_PER_BLOCK + 1);
+		int dec = (node_ofs - indirect_blks - 3) /
+					(NIDS_PER_BLOCK(inode) + 1);
 		bidx = node_ofs - 5 - dec;
 	}
-	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode);
+	return bidx * ADDRS_PER_BLOCK(inode) + ADDRS_PER_INODE(inode);
 }
 
 static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7cded843cf18..bc8424babf36 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -461,7 +461,8 @@ static void ra_node_pages(struct page *parent, int start, int n)
 
 	/* Then, try readahead for siblings of the desired node */
 	end = start + n;
-	end = min(end, NIDS_PER_BLOCK);
+	end = min_t(unsigned int, end, DEF_NIDS_PER_BLOCK -
+					get_extra_nsize(sbi->sb));
 	for (i = start; i < end; i++) {
 		nid = get_nid(parent, i, false);
 		ra_node_page(sbi, nid);
@@ -473,9 +474,10 @@ static void ra_node_pages(struct page *parent, int start, int n)
 pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
 {
 	const long direct_index = ADDRS_PER_INODE(dn->inode);
-	const long direct_blks = ADDRS_PER_BLOCK;
-	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
-	unsigned int skipped_unit = ADDRS_PER_BLOCK;
+	const long direct_blks = ADDRS_PER_BLOCK(dn->inode);
+	const long indirect_blks = ADDRS_PER_BLOCK(dn->inode) *
+					NIDS_PER_BLOCK(dn->inode);
+	unsigned int skipped_unit = ADDRS_PER_BLOCK(dn->inode);
 	int cur_level = dn->cur_level;
 	int max_level = dn->max_level;
 	pgoff_t base = 0;
@@ -484,7 +486,7 @@ pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
 		return pgofs + 1;
 
 	while (max_level-- > cur_level)
-		skipped_unit *= NIDS_PER_BLOCK;
+		skipped_unit *= NIDS_PER_BLOCK(dn->inode);
 
 	switch (dn->max_level) {
 	case 3:
@@ -509,10 +511,11 @@ static int get_node_path(struct inode *inode, long block,
 				int offset[4], unsigned int noffset[4])
 {
 	const long direct_index = ADDRS_PER_INODE(inode);
-	const long direct_blks = ADDRS_PER_BLOCK;
-	const long dptrs_per_blk = NIDS_PER_BLOCK;
-	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
-	const long dindirect_blks = indirect_blks * NIDS_PER_BLOCK;
+	const long direct_blks = ADDRS_PER_BLOCK(inode);
+	const long dptrs_per_blk = NIDS_PER_BLOCK(inode);
+	const long indirect_blks = ADDRS_PER_BLOCK(inode) *
+					NIDS_PER_BLOCK(inode);
+	const long dindirect_blks = indirect_blks * NIDS_PER_BLOCK(inode);
 	int n = 0;
 	int level = 0;
 
@@ -758,7 +761,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 	int i, ret;
 
 	if (dn->nid == 0)
-		return NIDS_PER_BLOCK + 1;
+		return NIDS_PER_BLOCK(dn->inode) + 1;
 
 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);
 
@@ -768,11 +771,11 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 		return PTR_ERR(page);
 	}
 
-	ra_node_pages(page, ofs, NIDS_PER_BLOCK);
+	ra_node_pages(page, ofs, NIDS_PER_BLOCK(dn->inode));
 
 	rn = F2FS_NODE(page);
 	if (depth < 3) {
-		for (i = ofs; i < NIDS_PER_BLOCK; i++, freed++) {
+		for (i = ofs; i < NIDS_PER_BLOCK(dn->inode); i++, freed++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
 			if (child_nid == 0)
 				continue;
@@ -784,16 +787,16 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 				dn->node_changed = true;
 		}
 	} else {
-		child_nofs = nofs + ofs * (NIDS_PER_BLOCK + 1) + 1;
-		for (i = ofs; i < NIDS_PER_BLOCK; i++) {
+		child_nofs = nofs + ofs * (NIDS_PER_BLOCK(dn->inode) + 1) + 1;
+		for (i = ofs; i < NIDS_PER_BLOCK(dn->inode); i++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
 			if (child_nid == 0) {
-				child_nofs += NIDS_PER_BLOCK + 1;
+				child_nofs += NIDS_PER_BLOCK(dn->inode) + 1;
 				continue;
 			}
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
-			if (ret == (NIDS_PER_BLOCK + 1)) {
+			if (ret == (NIDS_PER_BLOCK(dn->inode) + 1)) {
 				if (set_nid(page, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
@@ -847,10 +850,10 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		nid[i + 1] = get_nid(pages[i], offset[i + 1], false);
 	}
 
-	ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK);
+	ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK(dn->inode));
 
 	/* free direct nodes linked to a partial indirect node */
-	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
+	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK(dn->inode); i++) {
 		child_nid = get_nid(pages[idx], i, false);
 		if (!child_nid)
 			continue;
@@ -922,10 +925,10 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		err = truncate_partial_nodes(&dn, ri, offset, level);
 		if (err < 0 && err != -ENOENT)
 			goto fail;
-		nofs += 1 + NIDS_PER_BLOCK;
+		nofs += 1 + NIDS_PER_BLOCK(inode);
 		break;
 	case 3:
-		nofs = 5 + 2 * NIDS_PER_BLOCK;
+		nofs = 5 + 2 * NIDS_PER_BLOCK(inode);
 		if (!offset[level - 1])
 			goto skip_partial;
 		err = truncate_partial_nodes(&dn, ri, offset, level);
@@ -2278,7 +2281,8 @@ int recover_xattr_data(struct inode *inode, struct page *page)
 	update_inode_page(inode);
 
 	/* 3: update and set xattr node page dirty */
-	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), VALID_XATTR_BLOCK_SIZE);
+	memcpy(F2FS_NODE(xpage), F2FS_NODE(page),
+				VALID_XATTR_BLOCK_SIZE(inode));
 
 	set_page_dirty(xpage);
 	f2fs_put_page(xpage, 1);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 081ef0d672bf..b051196b5d5b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -338,17 +338,20 @@ static inline bool is_recoverable_dnode(struct page *page)
  */
 static inline bool IS_DNODE(struct page *node_page)
 {
+	struct f2fs_sb_info *sbi = F2FS_P_SB(node_page);
 	unsigned int ofs = ofs_of_node(node_page);
+	unsigned int nids_per_block = DEF_NIDS_PER_BLOCK -
+					get_extra_nsize(sbi->sb);
 
 	if (f2fs_has_xattr_block(ofs))
 		return true;
 
-	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
-			ofs == 5 + 2 * NIDS_PER_BLOCK)
+	if (ofs == 3 || ofs == 4 + nids_per_block ||
+			ofs == 5 + 2 * nids_per_block)
 		return false;
-	if (ofs >= 6 + 2 * NIDS_PER_BLOCK) {
-		ofs -= 6 + 2 * NIDS_PER_BLOCK;
-		if (!((long int)ofs % (NIDS_PER_BLOCK + 1)))
+	if (ofs >= 6 + 2 * nids_per_block) {
+		ofs -= 6 + 2 * nids_per_block;
+		if (!((long int)ofs % (nids_per_block + 1)))
 			return false;
 	}
 	return true;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f6fb8d9928bc..368f63d7bad2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1901,10 +1901,12 @@ static const struct export_operations f2fs_export_ops = {
 	.get_parent = f2fs_get_parent,
 };
 
-static loff_t max_file_blocks(void)
+static loff_t max_file_blocks(struct super_block *sb)
 {
+	unsigned int nids_per_block = DEF_NIDS_PER_BLOCK -
+					get_extra_nsize(sb);
+	loff_t leaf_count = DEF_ADDRS_PER_BLOCK - get_extra_nsize(sb);
 	loff_t result = 0;
-	loff_t leaf_count = ADDRS_PER_BLOCK;
 
 	/*
 	 * note: previously, result is equal to (DEF_ADDRS_PER_INODE -
@@ -1917,11 +1919,11 @@ static loff_t max_file_blocks(void)
 	result += (leaf_count * 2);
 
 	/* two indirect node blocks */
-	leaf_count *= NIDS_PER_BLOCK;
+	leaf_count *= nids_per_block;
 	result += (leaf_count * 2);
 
 	/* one double indirect node block */
-	leaf_count *= NIDS_PER_BLOCK;
+	leaf_count *= nids_per_block;
 	result += leaf_count;
 
 	return result;
@@ -2554,6 +2556,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_sb_buf;
 	}
 #endif
+
+	if (f2fs_sb_has_extended_node(sb))
+		sbi->extra_nsize = le16_to_cpu(raw_super->extra_nsize);
+
 	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
@@ -2566,7 +2572,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_options;
 
-	sbi->max_file_blocks = max_file_blocks();
+	sbi->max_file_blocks = max_file_blocks(sb);
 	sb->s_maxbytes = sbi->max_file_blocks <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d978c7b6ea04..f25a6fc0a17e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -116,6 +116,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_inode_crtime(sb))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "inode_crtime");
+	if (f2fs_sb_has_extended_node(sb))
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "extended_node");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
@@ -236,6 +239,7 @@ enum feat_id {
 	FEAT_FLEXIBLE_INLINE_XATTR,
 	FEAT_QUOTA_INO,
 	FEAT_INODE_CRTIME,
+	FEAT_EXTENDED_NODE,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -251,6 +255,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_FLEXIBLE_INLINE_XATTR:
 	case FEAT_QUOTA_INO:
 	case FEAT_INODE_CRTIME:
+	case FEAT_EXTENDED_NODE:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
 	return 0;
@@ -329,6 +334,7 @@ F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
 F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
+F2FS_FEATURE_RO_ATTR(extended_node, FEAT_EXTENDED_NODE);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -383,6 +389,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(flexible_inline_xattr),
 	ATTR_LIST(quota_ino),
 	ATTR_LIST(inode_crtime),
+	ATTR_LIST(extended_node),
 	NULL,
 };
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae2dfa709f5d..d847b2b11659 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -278,7 +278,8 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 		return PTR_ERR(xpage);
 
 	xattr_addr = page_address(xpage);
-	memcpy(txattr_addr + inline_size, xattr_addr, VALID_XATTR_BLOCK_SIZE);
+	memcpy(txattr_addr + inline_size, xattr_addr,
+				VALID_XATTR_BLOCK_SIZE(inode));
 	f2fs_put_page(xpage, 1);
 
 	return 0;
@@ -291,7 +292,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 {
 	void *cur_addr, *txattr_addr, *last_addr = NULL;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE : 0;
+	unsigned int size = xnid ? VALID_XATTR_BLOCK_SIZE(inode) : 0;
 	unsigned int inline_size = inline_xattr_size(inode);
 	int err = 0;
 
@@ -346,7 +347,7 @@ static int read_all_xattrs(struct inode *inode, struct page *ipage,
 {
 	struct f2fs_xattr_header *header;
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
-	unsigned int size = VALID_XATTR_BLOCK_SIZE;
+	unsigned int size = VALID_XATTR_BLOCK_SIZE(inode);
 	unsigned int inline_size = inline_xattr_size(inode);
 	void *txattr_addr;
 	int err;
@@ -454,7 +455,8 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 	if (inline_size)
 		memcpy(inline_addr, txattr_addr, inline_size);
-	memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
+	memcpy(xattr_addr, txattr_addr + inline_size,
+					VALID_XATTR_BLOCK_SIZE(inode));
 
 	if (inline_size)
 		set_page_dirty(ipage ? ipage : in_page);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index dbcd1d16e669..8ddc94ea5d00 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -72,10 +72,12 @@ struct f2fs_xattr_entry {
 		for (entry = XATTR_FIRST_ENTRY(addr);\
 				!IS_XATTR_LAST_ENTRY(entry);\
 				entry = XATTR_NEXT_ENTRY(entry))
-#define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
+#define VALID_XATTR_BLOCK_SIZE(i)	(PAGE_SIZE -		\
+				sizeof(struct node_footer) -	\
+				F2FS_I_SB(i)->extra_nsize)
 #define XATTR_PADDING_SIZE	(sizeof(__u32))
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
-						VALID_XATTR_BLOCK_SIZE)
+						VALID_XATTR_BLOCK_SIZE(i))
 
 #define MAX_VALUE_LEN(i)	(MIN_OFFSET(i) -			\
 				sizeof(struct f2fs_xattr_header) -	\
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f7f09907e69d..a6bacfdd378d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -111,7 +111,8 @@ struct f2fs_super_block {
 	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
 	struct f2fs_device devs[MAX_DEVICES];	/* device list */
 	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
-	__u8 reserved[315];		/* valid reserved region */
+	__le16 extra_nsize;		/* extra node size */
+	__u8 reserved[313];		/* valid reserved region */
 } __packed;
 
 /*
@@ -192,15 +193,16 @@ struct f2fs_extent {
 /* 200 bytes for inline xattrs by default */
 #define DEFAULT_INLINE_XATTR_ADDRS	50
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
+#define DEF_ADDRS_PER_BLOCK	1018	/* Address Pointers in a Direct Block */
+#define DEF_NIDS_PER_BLOCK	1018	/* Node IDs in an Indirect Block */
+#define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					get_extra_isize(inode))
-#define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define ADDRS_PER_INODE(inode)	addrs_per_inode(inode)
-#define ADDRS_PER_BLOCK		1018	/* Address Pointers in a Direct Block */
-#define NIDS_PER_BLOCK		1018	/* Node IDs in an Indirect Block */
-
+#define ADDRS_PER_BLOCK(inode)	addrs_per_dnode(inode)
+#define NIDS_PER_BLOCK(inode)	nids_per_idnode(inode)
 #define ADDRS_PER_PAGE(page, inode)	\
-	(IS_INODE(page) ? ADDRS_PER_INODE(inode) : ADDRS_PER_BLOCK)
+	(IS_INODE(page) ? ADDRS_PER_INODE(inode) : ADDRS_PER_BLOCK(inode))
 
 #define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
 #define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
@@ -265,11 +267,11 @@ struct f2fs_inode {
 } __packed;
 
 struct direct_node {
-	__le32 addr[ADDRS_PER_BLOCK];	/* array of data block address */
+	__le32 addr[DEF_ADDRS_PER_BLOCK];	/* array of data block address */
 } __packed;
 
 struct indirect_node {
-	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
+	__le32 nid[DEF_NIDS_PER_BLOCK];	/* array of data block address */
 } __packed;
 
 enum {
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
