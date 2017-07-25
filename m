From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/3] f2fs-tools: support project quota
Date: Wed, 26 Jul 2017 00:06:55 +0800
Message-ID: <20170725160655.11440-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch introduce a new option 'project_quota' for enabling project
quota functionality during mkfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- set projid only if sb has project_quota feature.
- enable project_quota feature only if extra_attr feature is enabled.
 fsck/mount.c            |  4 ++++
 include/f2fs_fs.h       |  4 ++++
 mkfs/f2fs_format.c      |  3 +++
 mkfs/f2fs_format_main.c | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index f41709e..0453f64 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -90,6 +90,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 
 	DISP_u16(inode, i_extra_isize);
 	DISP_u16(inode, i_padding);
+	DISP_u32(inode, i_projid);
 
 	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
 	DISP_u32(inode, i_addr[ofs + 1]);	/* Pointers to data blocks */
@@ -287,6 +288,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
 		MSG(0, "%s", " extra attribute");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
+		MSG(0, "%s", " project quota");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1499da7..380bc2a 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -472,6 +472,7 @@ enum {
 #define F2FS_FEATURE_BLKZONED		0x0002
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
 #define F2FS_FEATURE_EXTRA_ATTR		0x0008
+#define F2FS_FEATURE_PRJQUOTA		0x0010
 
 #define MAX_VOLUME_NAME		512
 
@@ -624,6 +625,8 @@ struct f2fs_extent {
 	(offsetof(struct f2fs_inode, i_extra_end) -	\
 	offsetof(struct f2fs_inode, i_extra_isize))	\
 
+#define	F2FS_DEF_PROJID		0	/* default project ID */
+
 #define MAX_INLINE_DATA(node) (sizeof(__le32) *				\
 				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
 				get_extra_isize(node) -			\
@@ -679,6 +682,7 @@ struct f2fs_inode {
 		struct {
 			__le16 i_extra_isize;	/* extra inode attribute size */
 			__le16 i_padding;	/* padding */
+			__le32 i_projid;	/* project id */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		};
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index acfb56d..abf1078 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -929,6 +929,9 @@ static int f2fs_write_root_inode(void)
 				cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
 	}
 
+	if (c.feature & F2FS_FEATURE_PRJQUOTA)
+		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
+
 	data_blk_nor = get_sb(main_blkaddr) +
 		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
 	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 1a75a6f..90096b7 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -82,6 +82,8 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
 	} else if (!strcmp(features, "extra_attr")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR);
+	} else if (!strcmp(features, "project_quota")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_PRJQUOTA);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
@@ -161,6 +163,14 @@ static void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
+	if (!(c.feature & F2FS_FEATURE_EXTRA_ATTR)) {
+		if (c.feature & F2FS_FEATURE_PRJQUOTA) {
+			MSG(0, "\tInfo: project quota feature should always been"
+				"enabled with extra attr feature\n");
+			exit(1);
+		}
+	}
+
 	if (optind >= argc) {
 		MSG(0, "\tError: Device not specified\n");
 		mkfs_usage();
-- 
2.13.0.90.g1eb437020
