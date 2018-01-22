From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: support inode creation time
Date: Mon, 22 Jan 2018 17:55:38 +0800
Message-ID: <20180122095538.39191-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch supports inode_crtime feature to enable recording inode
creation time in inode layout.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c            | 7 +++++++
 include/f2fs_fs.h       | 3 +++
 mkfs/f2fs_format.c      | 5 +++++
 mkfs/f2fs_format_main.c | 7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 0a5b986..f264571 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -233,6 +233,10 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 			DISP_u32(inode, i_projid);
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
 			DISP_u32(inode, i_inode_checksum);
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+			DISP_u64(inode, i_crtime);
+			DISP_u32(inode, i_crtime_nsec);
+		}
 	}
 
 	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
@@ -453,6 +457,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
 		MSG(0, "%s", " quota_ino");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+		MSG(0, "%s", " inode_crtime");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 67f31d8..7d136f3 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -550,6 +550,7 @@ enum {
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
+#define F2FS_FEATURE_INODE_CRTIME	0x0100
 
 #define MAX_VOLUME_NAME		512
 
@@ -785,6 +786,8 @@ struct f2fs_inode {
 			__le16 i_inline_xattr_size;	/* inline xattr size, unit: 4 bytes */
 			__le32 i_projid;	/* project id */
 			__le32 i_inode_checksum;/* inode meta checksum */
+			__le64 i_crtime; 	/* creation time */
+			__le32 i_crtime_nsec;	/* creation time in nano scale */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		};
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9d7e180..0fc8b30 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1021,6 +1021,11 @@ static int f2fs_write_root_inode(void)
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
 		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
 
+	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+		raw_node->i.i_crtime = cpu_to_le32(time(NULL));
+		raw_node->i.i_crtime_nsec = 0;
+	}
+
 	data_blk_nor = get_sb(main_blkaddr) +
 		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
 	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e41bcb1..e522b2f 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -92,6 +92,8 @@ static void parse_feature(const char *features)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
 	} else if (!strcmp(features, "quota")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
+	} else if (!strcmp(features, "inode_crtime")) {
+		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CRTIME);
 	} else {
 		MSG(0, "Error: Wrong features\n");
 		mkfs_usage();
@@ -187,6 +189,11 @@ static void f2fs_parse_options(int argc, char *argv[])
 				"enabled with extra attr feature\n");
 			exit(1);
 		}
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
+			MSG(0, "\tInfo: inode crtime feature should always been"
+				"enabled with extra attr feature\n");
+			exit(1);
+		}
 	}
 
 	if (optind >= argc) {
-- 
2.14.1.145.gb3622a4ee
