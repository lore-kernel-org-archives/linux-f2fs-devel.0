From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs-tools: enhance scalibility of {d, id,
 did, x}node disk layout
Date: Sat, 27 Jan 2018 17:44:29 +0800
Message-ID: <20180127094430.29483-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efN2X-0001ET-DO
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:44:49 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efN2V-0004uK-9y
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:44:49 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

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
 fsck/dump.c             |  5 +++--
 fsck/mount.c            |  3 +++
 fsck/node.c             |  8 ++++----
 fsck/node.h             |  2 +-
 fsck/xattr.c            |  4 ++--
 fsck/xattr.h            |  7 ++++---
 include/f2fs_fs.h       | 30 +++++++++++++++++++++++++-----
 lib/libf2fs.c           |  1 +
 mkfs/f2fs_format.c      |  2 ++
 mkfs/f2fs_format_main.c |  2 ++
 10 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 7ccb03f121f5..32b68c932356 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -527,7 +527,8 @@ static void dump_node_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 	free(node_blk);
 }
 
-static void dump_data_offset(u32 blk_addr, int ofs_in_node)
+static void dump_data_offset(struct f2fs_sb_info *sbi,
+					u32 blk_addr, int ofs_in_node)
 {
 	struct f2fs_node *node_blk;
 	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
@@ -664,7 +665,7 @@ int dump_info_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr)
 		MSG(0, " - Inode block       : id = 0x%x from 0x%x\n",
 					ni.ino, ino_ni.blk_addr);
 		dump_node_from_blkaddr(sbi, ino_ni.blk_addr);
-		dump_data_offset(ni.blk_addr,
+		dump_data_offset(sbi, ni.blk_addr,
 			le16_to_cpu(sum_entry.ofs_in_node));
 	} else {
 		MSG(0, "FS Userdata Area: Node block from 0x%x\n", blk_addr);
diff --git a/fsck/mount.c b/fsck/mount.c
index 54eb061e4ffe..016e52471f11 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -460,6 +460,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
 		MSG(0, "%s", " inode_crtime");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE)) {
+		MSG(0, "%s", " extended_node");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/fsck/node.c b/fsck/node.c
index 7f4a28b1a5df..f4b8c5a59c5f 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -77,7 +77,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
 	node_blk->footer.cp_ver = ckpt->checkpoint_ver;
 
 	type = CURSEG_COLD_NODE;
-	if (IS_DNODE(node_blk)) {
+	if (IS_DNODE(sbi, node_blk)) {
 		if (S_ISDIR(le16_to_cpu(f2fs_inode->i.i_mode)))
 			type = CURSEG_HOT_NODE;
 		else
@@ -105,8 +105,8 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
  *
  * By default, it sets inline_xattr and inline_data
  */
-static int get_node_path(struct f2fs_node *node, long block,
-				int offset[4], unsigned int noffset[4])
+static int get_node_path(struct f2fs_sb_info *sbi, struct f2fs_node *node,
+			long block, int offset[4], unsigned int noffset[4])
 {
 	const long direct_index = ADDRS_PER_INODE(&node->i);
 	const long direct_blks = ADDRS_PER_BLOCK;
@@ -191,7 +191,7 @@ void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	int level, i;
 	int ret;
 
-	level = get_node_path(dn->inode_blk, index, offset, noffset);
+	level = get_node_path(sbi, dn->inode_blk, index, offset, noffset);
 
 	nids[0] = dn->nid;
 	parent = dn->inode_blk;
diff --git a/fsck/node.h b/fsck/node.h
index cbf7ed708bb2..28e703a7ea71 100644
--- a/fsck/node.h
+++ b/fsck/node.h
@@ -87,7 +87,7 @@ static inline void inc_inode_blocks(struct dnode_of_data *dn)
 	dn->idirty = 1;
 }
 
-static inline int IS_DNODE(struct f2fs_node *node_page)
+static inline int IS_DNODE(struct f2fs_sb_info *sbi, struct f2fs_node *node_page)
 {
 	unsigned int ofs = ofs_of_node(node_page);
 
diff --git a/fsck/xattr.c b/fsck/xattr.c
index 1d15d1b7fa82..9ee306649bee 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -131,7 +131,7 @@ int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *na
 
 	len = strlen(name);
 
-	if (len > F2FS_NAME_LEN || size > MAX_VALUE_LEN)
+	if (len > F2FS_NAME_LEN || size > MAX_VALUE_LEN(sbi))
 		return -ERANGE;
 
 	if (ino < 3)
@@ -174,7 +174,7 @@ int f2fs_setxattr(struct f2fs_sb_info *sbi, nid_t ino, int index, const char *na
 		 * If value is NULL, it is remove operation.
 		 * In case of update operation, we calculate free.
 		 */
-		free = MIN_OFFSET - ((char *)last - (char *)base_addr);
+		free = MIN_OFFSET(sbi) - ((char *)last - (char *)base_addr);
 		if (found)
 			free = free + ENTRY_SIZE(here);
 		if (free < newsize) {
diff --git a/fsck/xattr.h b/fsck/xattr.h
index e4a98e224a93..6a75fd34cdb0 100644
--- a/fsck/xattr.h
+++ b/fsck/xattr.h
@@ -127,10 +127,11 @@ static inline int f2fs_acl_count(int size)
 			!IS_XATTR_LAST_ENTRY(entry); \
 			entry = XATTR_NEXT_ENTRY(entry))
 
-#define MIN_OFFSET	XATTR_ALIGN(PAGE_SIZE -			\
-		sizeof(struct node_footer) - sizeof(__u32))
+#define MIN_OFFSET(s)	XATTR_ALIGN(PAGE_SIZE -			\
+		sizeof(struct node_footer) - sizeof(__u32) -	\
+		get_extra_nsize(s->raw_super) * sizeof(__le32))
 
-#define MAX_VALUE_LEN	(MIN_OFFSET -				\
+#define MAX_VALUE_LEN(s)	(MIN_OFFSET(s) -		\
 		sizeof(struct f2fs_xattr_header) -		\
 		sizeof(struct f2fs_xattr_entry))
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 548a3e85a1d5..1692cd5433ca 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -363,6 +363,7 @@ struct f2fs_configuration {
 	int ro;
 	int preserve_limits;		/* preserve quota limits */
 	int large_nat_bitmap;
+	unsigned short extra_nsize;
 	__le32 feature;			/* defined features */
 
 	/* defragmentation parameters */
@@ -552,6 +553,7 @@ enum {
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
+#define F2FS_FEATURE_EXTENDED_NODE	0x0200
 
 #define MAX_VOLUME_NAME		512
 
@@ -609,7 +611,8 @@ struct f2fs_super_block {
 	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
 	struct f2fs_device devs[MAX_DEVICES];	/* device list */
 	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
-	__u8 reserved[315];		/* valid reserved region */
+	__le16 extra_nsize;		/* extra node size */
+	__u8 reserved[313];		/* valid reserved region */
 } __attribute__((packed));
 
 /*
@@ -699,11 +702,13 @@ struct f2fs_extent {
 /* 200 bytes for inline xattrs by default */
 #define DEFAULT_INLINE_XATTR_ADDRS	50
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
+#define DEF_ADDRS_PER_BLOCK	1018	/* Address Pointers in a Direct Block */
+#define DEF_NIDS_PER_BLOCK	1018	/* Node IDs in an Indirect Block */
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					__get_extra_isize(inode))
 #define ADDRS_PER_INODE(i)	addrs_per_inode(i)
-#define ADDRS_PER_BLOCK         1018	/* Address Pointers in a Direct Block */
-#define NIDS_PER_BLOCK          1018	/* Node IDs in an Indirect Block */
+#define ADDRS_PER_BLOCK		addrs_per_dnode(sbi->raw_super)
+#define NIDS_PER_BLOCK		nids_per_idnode(sbi->raw_super)
 
 #define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
 #define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
@@ -805,14 +810,14 @@ struct f2fs_inode {
 #pragma pack(1)
 #endif
 struct direct_node {
-	__le32 addr[ADDRS_PER_BLOCK];	/* array of data block address */
+	__le32 addr[DEF_ADDRS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
 
 #ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
 #endif
 struct indirect_node {
-	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
+	__le32 nid[DEF_NIDS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
 
 enum {
@@ -1209,6 +1214,21 @@ static inline int __get_extra_isize(struct f2fs_inode *inode)
 	return 0;
 }
 
+static inline int get_extra_nsize(struct f2fs_super_block *sb)
+{
+	return le16_to_cpu(sb->extra_nsize) / sizeof(__le32);
+}
+
+static inline long addrs_per_dnode(struct f2fs_super_block *sb)
+{
+	return DEF_ADDRS_PER_BLOCK - get_extra_nsize(sb);
+}
+
+static inline long nids_per_idnode(struct f2fs_super_block *sb)
+{
+	return DEF_NIDS_PER_BLOCK - get_extra_nsize(sb);
+}
+
 extern struct f2fs_configuration c;
 static inline int get_inline_xattr_addrs(struct f2fs_inode *inode)
 {
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index e8b1842b7391..61962cf7d461 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -624,6 +624,7 @@ void f2fs_init_configuration(void)
 	c.kd = -1;
 	c.dry_run = 0;
 	c.large_nat_bitmap = 0;
+	c.extra_nsize = 0;
 	c.fixed_time = -1;
 }
 
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 93e9feaecda6..51337b53a795 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -426,6 +426,8 @@ static int f2fs_prepare_super_block(void)
 					qtype, next_ino - 1);
 	}
 
+	sb->extra_nsize = cpu_to_le16(c.extra_nsize);
+
 	if (total_zones <= 6) {
 		MSG(1, "\tError: %d zones: Need more zones "
 			"by shrinking zone size\n", total_zones);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index b6f36853cd3e..93922b0af068 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -95,6 +95,8 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
 	} else if (!strcmp(features, "inode_crtime")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CRTIME);
+	} else if (!strcmp(features, "extended_node")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_EXTENDED_NODE);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
