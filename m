From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: support flexible inline xattr size
Date: Mon, 4 Sep 2017 18:58:29 +0800
Message-ID: <20170904105829.8214-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch makes mkfs to support flexible inline xattr feature, also
this enables fsck to recognize new disk-layout of inode which be of
flexible inline xattr size.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/f2fs.h             |  7 +++----
 fsck/mount.c            |  5 ++++-
 include/f2fs_fs.h       | 24 ++++++++++++++++++------
 lib/libf2fs.c           |  4 +---
 mkfs/f2fs_format_main.c |  7 +++++++
 5 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 871cffc5a377..4fb6009d6187 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -454,14 +454,13 @@ static inline int map_de_type(umode_t mode)
 
 static inline void *inline_xattr_addr(struct f2fs_inode *inode)
 {
-	return (void *)&(inode->i_addr[DEF_ADDRS_PER_INODE_INLINE_XATTR]);
+	return (void *)&(inode->i_addr[DEF_ADDRS_PER_INODE -
+				get_inline_xattr_addrs(inode)]);
 }
 
 static inline int inline_xattr_size(struct f2fs_inode *inode)
 {
-	if (inode->i_inline & F2FS_INLINE_XATTR)
-		return F2FS_INLINE_XATTR_ADDRS << 2;
-	return 0;
+	return get_inline_xattr_addrs(inode) * sizeof(__le32);
 }
 
 extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
diff --git a/fsck/mount.c b/fsck/mount.c
index 7a8aeae7e935..7a2831492653 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -89,7 +89,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 			le32_to_cpu(inode->i_ext.len));
 
 	DISP_u16(inode, i_extra_isize);
-	DISP_u16(inode, i_padding);
+	DISP_u16(inode, i_inline_xattr_size);
 	DISP_u32(inode, i_projid);
 	DISP_u32(inode, i_inode_checksum);
 
@@ -294,6 +294,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
 		MSG(0, "%s", " inode checksum");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
+		MSG(0, "%s", " flexible inline xattr");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index bd609b9cf612..f4fa624fa040 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -477,6 +477,7 @@ enum {
 #define F2FS_FEATURE_EXTRA_ATTR		0x0008
 #define F2FS_FEATURE_PRJQUOTA		0x0010
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
+#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 
 #define MAX_VOLUME_NAME		512
 
@@ -598,13 +599,12 @@ struct f2fs_extent {
 } __attribute__((packed));
 
 #define F2FS_NAME_LEN		255
-#define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
+/* 200 bytes for inline xattrs by default */
+#define DEFAULT_INLINE_XATTR_ADDRS	50
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					__get_extra_isize(inode))
 #define ADDRS_PER_INODE(i)	addrs_per_inode(i)
-#define DEF_ADDRS_PER_INODE_INLINE_XATTR				\
-		(DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS)
 #define ADDRS_PER_BLOCK         1018	/* Address Pointers in a Direct Block */
 #define NIDS_PER_BLOCK          1018	/* Node IDs in an Indirect Block */
 
@@ -632,11 +632,13 @@ struct f2fs_extent {
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
 #define MAX_INLINE_DATA(node) (sizeof(__le32) *				\
-				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
+				(DEF_ADDRS_PER_INODE -			\
+				get_inline_xattr_addrs(&node->i) -	\
 				get_extra_isize(node) -			\
 				DEF_INLINE_RESERVED_SIZE))
 #define DEF_MAX_INLINE_DATA	(sizeof(__le32) *			\
-				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
+				(DEF_ADDRS_PER_INODE -			\
+				DEFAULT_INLINE_XATTR_ADDRS -		\
 				F2FS_TOTAL_EXTRA_ATTR_SIZE -		\
 				DEF_INLINE_RESERVED_SIZE))
 #define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) \
@@ -685,7 +687,7 @@ struct f2fs_inode {
 	union {
 		struct {
 			__le16 i_extra_isize;	/* extra inode attribute size */
-			__le16 i_padding;	/* padding */
+			__le16 i_inline_xattr_size;	/* inline xattr size, unit: 4 bytes */
 			__le32 i_projid;	/* project id */
 			__le32 i_inode_checksum;/* inode meta checksum */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
@@ -1041,6 +1043,16 @@ static inline int __get_extra_isize(struct f2fs_inode *inode)
 	return 0;
 }
 
+extern struct f2fs_configuration c;
+static inline int get_inline_xattr_addrs(struct f2fs_inode *inode)
+{
+	if (!(inode->i_inline & F2FS_INLINE_XATTR))
+		return 0;
+	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)))
+		return DEFAULT_INLINE_XATTR_ADDRS;
+	return le16_to_cpu(inode->i_inline_xattr_size);
+}
+
 #define get_extra_isize(node)	__get_extra_isize(&node->i)
 
 #define F2FS_ZONED_NONE		0
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 0c593f61f23e..a9ea91ac9a92 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -456,9 +456,7 @@ f2fs_hash_t f2fs_dentry_hash(const unsigned char *name, int len)
 
 unsigned int addrs_per_inode(struct f2fs_inode *i)
 {
-	if (i->i_inline & F2FS_INLINE_XATTR)
-		return CUR_ADDRS_PER_INODE(i) - F2FS_INLINE_XATTR_ADDRS;
-	return CUR_ADDRS_PER_INODE(i);
+	return CUR_ADDRS_PER_INODE(i) - get_inline_xattr_addrs(i);
 }
 
 /*
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index adbbff93315c..ef62777283ed 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -86,6 +86,8 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_PRJQUOTA);
 	} else if (!strcmp(features, "inode_checksum")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM);
+	} else if (!strcmp(features, "flexible_inline_xattr")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
@@ -176,6 +178,11 @@ static void f2fs_parse_options(int argc, char *argv[])
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR)) {
+			MSG(0, "\tInfo: flexible inline xattr feature should always been"
+				"enabled with extra attr feature\n");
+			exit(1);
+		}
 	}
 
 	if (optind >= argc) {
-- 
2.13.1.388.g69e6b9b4f4a9
