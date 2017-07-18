From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/6] f2fs: enhance on-disk inode structure scalability
Date: Wed, 19 Jul 2017 00:19:06 +0800
Message-ID: <20170718161907.14453-2-chao@kernel.org>
References: <20170718161907.14453-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718161907.14453-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch add new flag F2FS_EXTRA_ATTR storing in inode.i_inline
to indicate that on-disk structure of current inode is extended.

In order to extend, we changed the inode structure a bit:

Original one:

struct f2fs_inode {
	...
	struct f2fs_extent i_ext;
	__le32 i_addr[DEF_ADDRS_PER_INODE];
	__le32 i_nid[DEF_NIDS_PER_INODE];
}

Extended one:

struct f2fs_inode {
        ...
        struct f2fs_extent i_ext;
	union {
		struct {
			__le16 i_extra_isize;
			__le16 i_padding;
			__le32 i_extra_end[0];
		};
		__le32 i_addr[DEF_ADDRS_PER_INODE];
	};
        __le32 i_nid[DEF_NIDS_PER_INODE];
}

Once F2FS_EXTRA_ATTR is set, we will steal four bytes in the head of
i_addr field for storing i_extra_isize and i_padding. with i_extra_isize,
we can calculate actual size of reserved space in i_addr, available
attribute fields included in total extra attribute fields for current
inode can be described as below:

  +--------------------+
  | .i_mode            |
  | ...                |
  | .i_ext             |
  +--------------------+
  | .i_extra_isize     |-----+
  | .i_padding         |     |
  | .i_prjid           |     |
  | .i_atime_extra     |     |
  | .i_ctime_extra     |     |
  | .i_mtime_extra     |<----+
  | .i_inode_cs        |<----- store blkaddr/inline from here
  | .i_xattr_cs        |
  | ...                |
  +--------------------+
  |                    |
  |    block address   |
  |                    |
  +--------------------+
  | .i_nid             |
  +--------------------+
  |   node_footer      |
  | (nid, ino, offset) |
  +--------------------+

Hence, with this patch, we would enhance scalability of f2fs inode for
storing more newly added attribute.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 v2:
 - update comments.
 - set EXTRA_ATTR flag in new inode when extra_attr feature is set.
 fs/f2fs/data.c          | 15 +++++++----
 fs/f2fs/f2fs.h          | 66 ++++++++++++++++++++++++++++++++++++++-----------
 fs/f2fs/file.c          | 23 +++++++++++------
 fs/f2fs/gc.c            |  2 +-
 fs/f2fs/inode.c         | 32 +++++++++++++++---------
 fs/f2fs/namei.c         |  5 ++++
 fs/f2fs/node.c          |  7 ++++--
 fs/f2fs/recovery.c      |  7 +++---
 fs/f2fs/super.c         | 11 ++++++---
 include/linux/f2fs_fs.h | 13 ++++++++--
 10 files changed, 132 insertions(+), 49 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ca978c32ae00..aefc2a5745d3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -460,10 +460,14 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
 {
 	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
 	__le32 *addr_array;
+	int base = 0;
+
+	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
+		base = get_extra_isize(dn->inode);
 
 	/* Get physical address of data block */
 	addr_array = blkaddr_in_node(rn);
-	addr_array[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
+	addr_array[base + dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
 /*
@@ -507,8 +511,8 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
 
 	for (; count > 0; dn->ofs_in_node++) {
-		block_t blkaddr =
-			datablock_addr(dn->node_page, dn->ofs_in_node);
+		block_t blkaddr = datablock_addr(dn->inode,
+					dn->node_page, dn->ofs_in_node);
 		if (blkaddr == NULL_ADDR) {
 			dn->data_blkaddr = NEW_ADDR;
 			__set_data_blkaddr(dn);
@@ -755,7 +759,8 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
 
-	dn->data_blkaddr = datablock_addr(dn->node_page, dn->ofs_in_node);
+	dn->data_blkaddr = datablock_addr(dn->inode,
+				dn->node_page, dn->ofs_in_node);
 	if (dn->data_blkaddr == NEW_ADDR)
 		goto alloc;
 
@@ -902,7 +907,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:
-	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
 	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
 		if (create) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e06d4e4b4579..cb5e88bc3a98 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -112,6 +112,7 @@ struct f2fs_mount_info {
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
 #define F2FS_FEATURE_BLKZONED	0x0002
+#define F2FS_FEATURE_EXTRA_ATTR	0x0004
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -357,10 +358,10 @@ struct f2fs_flush_device {
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
-
-static inline int get_inline_reserved_size(struct inode *inode);
-#define MAX_INLINE_DATA(inode)	(sizeof(__le32) * (DEF_ADDRS_PER_INODE -\
-				get_inline_reserved_size(inode) -\
+static inline int get_extra_isize(struct inode *inode);
+#define MAX_INLINE_DATA(inode)	(sizeof(__le32) * \
+				(CUR_ADDRS_PER_INODE(inode) - \
+				DEF_INLINE_RESERVED_SIZE - \
 				F2FS_INLINE_XATTR_ADDRS))
 
 /* for inline dir */
@@ -565,7 +566,7 @@ struct f2fs_inode_info {
 	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
 	struct rw_semaphore i_mmap_sem;
 
-	int i_inline_reserved;		/* reserved size in inline data */
+	int i_extra_isize;		/* size of extra space located in i_addr */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -1789,20 +1790,38 @@ static inline bool IS_INODE(struct page *page)
 	return RAW_IS_INODE(p);
 }
 
+static inline int offset_in_addr(struct f2fs_inode *i)
+{
+	return (i->i_inline & F2FS_EXTRA_ATTR) ?
+			(le16_to_cpu(i->i_extra_isize) / sizeof(__le32)) : 0;
+}
+
 static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
 {
 	return RAW_IS_INODE(node) ? node->i.i_addr : node->dn.addr;
 }
 
-static inline block_t datablock_addr(struct page *node_page,
-		unsigned int offset)
+static inline int f2fs_has_extra_attr(struct inode *inode);
+static inline block_t datablock_addr(struct inode *inode,
+			struct page *node_page, unsigned int offset)
 {
 	struct f2fs_node *raw_node;
 	__le32 *addr_array;
+	int base = 0;
+	bool is_inode = IS_INODE(node_page);
 
 	raw_node = F2FS_NODE(node_page);
+
+	/* from GC path only */
+	if (!inode) {
+		if (is_inode)
+			base = offset_in_addr(&raw_node->i);
+	} else if (f2fs_has_extra_attr(inode) && is_inode) {
+		base = get_extra_isize(inode);
+	}
+
 	addr_array = blkaddr_in_node(raw_node);
-	return le32_to_cpu(addr_array[offset]);
+	return le32_to_cpu(addr_array[base + offset]);
 }
 
 static inline int f2fs_test_bit(unsigned int nr, char *addr)
@@ -1893,6 +1912,7 @@ enum {
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
 	FI_HOT_DATA,		/* indicate file is hot */
+	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
@@ -2012,6 +2032,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_DATA_EXIST, &fi->flags);
 	if (ri->i_inline & F2FS_INLINE_DOTS)
 		set_bit(FI_INLINE_DOTS, &fi->flags);
+	if (ri->i_inline & F2FS_EXTRA_ATTR)
+		set_bit(FI_EXTRA_ATTR, &fi->flags);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
@@ -2028,6 +2050,13 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_DATA_EXIST;
 	if (is_inode_flag_set(inode, FI_INLINE_DOTS))
 		ri->i_inline |= F2FS_INLINE_DOTS;
+	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
+		ri->i_inline |= F2FS_EXTRA_ATTR;
+}
+
+static inline int f2fs_has_extra_attr(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_EXTRA_ATTR);
 }
 
 static inline int f2fs_has_inline_xattr(struct inode *inode)
@@ -2038,8 +2067,8 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
 static inline unsigned int addrs_per_inode(struct inode *inode)
 {
 	if (f2fs_has_inline_xattr(inode))
-		return DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS;
-	return DEF_ADDRS_PER_INODE;
+		return CUR_ADDRS_PER_INODE(inode) - F2FS_INLINE_XATTR_ADDRS;
+	return CUR_ADDRS_PER_INODE(inode);
 }
 
 static inline void *inline_xattr_addr(struct page *page)
@@ -2101,9 +2130,9 @@ static inline bool f2fs_is_drop_cache(struct inode *inode)
 static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode *ri = F2FS_INODE(page);
-	int reserved_size = get_inline_reserved_size(inode);
+	int extra_size = get_extra_isize(inode);
 
-	return (void *)&(ri->i_addr[reserved_size]);
+	return (void *)&(ri->i_addr[extra_size + DEF_INLINE_RESERVED_SIZE]);
 }
 
 static inline int f2fs_has_inline_dentry(struct inode *inode)
@@ -2194,15 +2223,19 @@ static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 	return kmalloc(size, flags);
 }
 
-static inline int get_inline_reserved_size(struct inode *inode)
+static inline int get_extra_isize(struct inode *inode)
 {
-	return F2FS_I(inode)->i_inline_reserved;
+	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
 #define get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
+#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
+	(offsetof(struct f2fs_inode, i_extra_end) -	\
+	offsetof(struct f2fs_inode, i_extra_isize))	\
+
 /*
  * file.c
  */
@@ -2795,6 +2828,11 @@ static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
+static inline int f2fs_sb_has_extra_attr(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_EXTRA_ATTR);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2706130c261b..6d654de799ae 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -382,7 +382,8 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 				dn.ofs_in_node++, pgofs++,
 				data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 			block_t blkaddr;
-			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+			blkaddr = datablock_addr(dn.inode,
+					dn.node_page, dn.ofs_in_node);
 
 			if (__found_offset(blkaddr, dirty, pgofs, whence)) {
 				f2fs_put_dnode(&dn);
@@ -467,9 +468,13 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	struct f2fs_node *raw_node;
 	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
 	__le32 *addr;
+	int base = 0;
+
+	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
+		base = get_extra_isize(dn->inode);
 
 	raw_node = F2FS_NODE(dn->node_page);
-	addr = blkaddr_in_node(raw_node) + ofs;
+	addr = blkaddr_in_node(raw_node) + base + ofs;
 
 	for (; count > 0; count--, addr++, dn->ofs_in_node++) {
 		block_t blkaddr = le32_to_cpu(*addr);
@@ -927,7 +932,8 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	done = min((pgoff_t)ADDRS_PER_PAGE(dn.node_page, inode) -
 							dn.ofs_in_node, len);
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
-		*blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+		*blkaddr = datablock_addr(dn.inode,
+					dn.node_page, dn.ofs_in_node);
 		if (!is_checkpointed_data(sbi, *blkaddr)) {
 
 			if (test_opt(sbi, LFS)) {
@@ -1003,8 +1009,8 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				ADDRS_PER_PAGE(dn.node_page, dst_inode) -
 						dn.ofs_in_node, len - i);
 			do {
-				dn.data_blkaddr = datablock_addr(dn.node_page,
-								dn.ofs_in_node);
+				dn.data_blkaddr = datablock_addr(dn.inode,
+						dn.node_page, dn.ofs_in_node);
 				truncate_data_blocks_range(&dn, 1);
 
 				if (do_replace[i]) {
@@ -1173,7 +1179,8 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	int ret;
 
 	for (; index < end; index++, dn->ofs_in_node++) {
-		if (datablock_addr(dn->node_page, dn->ofs_in_node) == NULL_ADDR)
+		if (datablock_addr(dn->inode, dn->node_page,
+					dn->ofs_in_node) == NULL_ADDR)
 			count++;
 	}
 
@@ -1184,8 +1191,8 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 
 	dn->ofs_in_node = ofs_in_node;
 	for (index = start; index < end; index++, dn->ofs_in_node++) {
-		dn->data_blkaddr =
-				datablock_addr(dn->node_page, dn->ofs_in_node);
+		dn->data_blkaddr = datablock_addr(dn->inode,
+					dn->node_page, dn->ofs_in_node);
 		/*
 		 * reserve_new_blocks will not guarantee entire block
 		 * allocation.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fa3d2e2df8e7..76ad2c3d88db 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -582,7 +582,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	}
 
 	*nofs = ofs_of_node(node_page);
-	source_blkaddr = datablock_addr(node_page, ofs_in_node);
+	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
 	f2fs_put_page(node_page, 1);
 
 	if (source_blkaddr != blkaddr)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 32ec6b23fe01..0a6699a23dfb 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -49,20 +49,22 @@ void f2fs_set_inode_flags(struct inode *inode)
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 {
+	int extra_size = get_extra_isize(inode);
+
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		if (ri->i_addr[0])
-			inode->i_rdev =
-				old_decode_dev(le32_to_cpu(ri->i_addr[0]));
+		if (ri->i_addr[extra_size])
+			inode->i_rdev = old_decode_dev(
+				le32_to_cpu(ri->i_addr[extra_size]));
 		else
-			inode->i_rdev =
-				new_decode_dev(le32_to_cpu(ri->i_addr[1]));
+			inode->i_rdev = new_decode_dev(
+				le32_to_cpu(ri->i_addr[extra_size + 1]));
 	}
 }
 
 static bool __written_first_block(struct f2fs_inode *ri)
 {
-	block_t addr = le32_to_cpu(ri->i_addr[0]);
+	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
 
 	if (addr != NEW_ADDR && addr != NULL_ADDR)
 		return true;
@@ -71,16 +73,18 @@ static bool __written_first_block(struct f2fs_inode *ri)
 
 static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 {
+	int extra_size = get_extra_isize(inode);
+
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		if (old_valid_dev(inode->i_rdev)) {
-			ri->i_addr[0] =
+			ri->i_addr[extra_size] =
 				cpu_to_le32(old_encode_dev(inode->i_rdev));
-			ri->i_addr[1] = 0;
+			ri->i_addr[extra_size + 1] = 0;
 		} else {
-			ri->i_addr[0] = 0;
-			ri->i_addr[1] =
+			ri->i_addr[extra_size] = 0;
+			ri->i_addr[extra_size + 1] =
 				cpu_to_le32(new_encode_dev(inode->i_rdev));
-			ri->i_addr[2] = 0;
+			ri->i_addr[extra_size + 2] = 0;
 		}
 	}
 }
@@ -153,6 +157,9 @@ static int do_read_inode(struct inode *inode)
 
 	get_inline_info(inode, ri);
 
+	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
+					le16_to_cpu(ri->i_extra_isize) : 0;
+
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
@@ -292,6 +299,9 @@ int update_inode(struct inode *inode, struct page *node_page)
 	ri->i_generation = cpu_to_le32(inode->i_generation);
 	ri->i_dir_level = F2FS_I(inode)->i_dir_level;
 
+	if (f2fs_has_extra_attr(inode))
+		ri->i_extra_isize = cpu_to_le16(F2FS_I(inode)->i_extra_isize);
+
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 760d85223c81..26b4d2b54812 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -72,6 +72,11 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	set_inode_flag(inode, FI_NEW_INODE);
 
+	if (f2fs_sb_has_extra_attr(sbi->sb)) {
+		set_inode_flag(inode, FI_EXTRA_ATTR);
+		F2FS_I(inode)->i_extra_isize = F2FS_TOTAL_EXTRA_ATTR_SIZE;
+	}
+
 	if (test_opt(sbi, INLINE_XATTR))
 		set_inode_flag(inode, FI_INLINE_XATTR);
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5396611df0c3..547b84fc10f6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -655,7 +655,8 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	dn->nid = nids[level];
 	dn->ofs_in_node = offset[level];
 	dn->node_page = npage[level];
-	dn->data_blkaddr = datablock_addr(dn->node_page, dn->ofs_in_node);
+	dn->data_blkaddr = datablock_addr(dn->inode,
+				dn->node_page, dn->ofs_in_node);
 	return 0;
 
 release_pages:
@@ -2263,7 +2264,9 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	dst->i_blocks = cpu_to_le64(1);
 	dst->i_links = cpu_to_le32(1);
 	dst->i_xattr_nid = 0;
-	dst->i_inline = src->i_inline & F2FS_INLINE_XATTR;
+	dst->i_inline = src->i_inline & (F2FS_INLINE_XATTR | F2FS_EXTRA_ATTR);
+	if (dst->i_inline & F2FS_EXTRA_ATTR)
+		dst->i_extra_isize = src->i_extra_isize;
 
 	new_ni = old_ni;
 	new_ni.ino = ino;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 907d6b7dde6a..2d9b8182691f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -361,7 +361,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	return 0;
 
 truncate_out:
-	if (datablock_addr(tdn.node_page, tdn.ofs_in_node) == blkaddr)
+	if (datablock_addr(tdn.inode, tdn.node_page,
+					tdn.ofs_in_node) == blkaddr)
 		truncate_data_blocks_range(&tdn, 1);
 	if (dn->inode->i_ino == nid && !dn->inode_page_locked)
 		unlock_page(dn->inode_page);
@@ -414,8 +415,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	for (; start < end; start++, dn.ofs_in_node++) {
 		block_t src, dest;
 
-		src = datablock_addr(dn.node_page, dn.ofs_in_node);
-		dest = datablock_addr(page, dn.ofs_in_node);
+		src = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
+		dest = datablock_addr(dn.inode, page, dn.ofs_in_node);
 
 		/* skip recovering if dest is the same as src */
 		if (src == dest)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2d236384f938..b30097190605 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -447,8 +447,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
-	fi->i_inline_reserved = DEF_INLINE_RESERVED_SIZE;
-
 	return &fi->vfs_inode;
 }
 
@@ -1306,9 +1304,16 @@ static const struct export_operations f2fs_export_ops = {
 
 static loff_t max_file_blocks(void)
 {
-	loff_t result = (DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS);
+	loff_t result = 0;
 	loff_t leaf_count = ADDRS_PER_BLOCK;
 
+	/*
+	 * note: previously, result is equal to (DEF_ADDRS_PER_INODE -
+	 * F2FS_INLINE_XATTR_ADDRS), but now f2fs try to reserve more
+	 * space in inode.i_addr, it will be more safe to reassign
+	 * result as zero.
+	 */
+
 	/* two direct node blocks */
 	result += (leaf_count * 2);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 060b1c5b0836..0c79ddd40b70 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -186,6 +186,8 @@ struct f2fs_extent {
 #define F2FS_NAME_LEN		255
 #define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
+#define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
+					get_extra_isize(inode))
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define ADDRS_PER_INODE(inode)	addrs_per_inode(inode)
 #define ADDRS_PER_BLOCK		1018	/* Address Pointers in a Direct Block */
@@ -205,6 +207,7 @@ struct f2fs_extent {
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
+#define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
@@ -232,8 +235,14 @@ struct f2fs_inode {
 
 	struct f2fs_extent i_ext;	/* caching a largest extent */
 
-	__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
-
+	union {
+		struct {
+			__le16 i_extra_isize;	/* extra inode attribute size */
+			__le16 i_padding;	/* padding */
+			__le32 i_extra_end[0];	/* for attribute size calculation */
+		};
+		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
+	};
 	__le32 i_nid[DEF_NIDS_PER_INODE];	/* direct(2), indirect(2),
 						double_indirect(1) node id */
 } __packed;
-- 
2.13.0.90.g1eb437020
