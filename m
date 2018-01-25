From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs-tools: support inode creation time
Date: Thu, 25 Jan 2018 14:58:45 +0800
Message-ID: <20180125065845.63302-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eebV1-0006gl-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 06:59:03 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eebV0-0000Po-22
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 06:59:03 +0000
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

This patch supports inode_crtime feature to enable recording inode
creation time in inode layout.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix address alignment issue.
 fsck/mount.c            | 7 +++++++
 include/f2fs_fs.h       | 5 ++++-
 mkfs/f2fs_format.c      | 5 +++++
 mkfs/f2fs_format_main.c | 7 +++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index fe0d510b019a..54eb061e4ffe 100644
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
index 67f31d8ed982..053ccbe2eaf6 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -550,6 +550,7 @@ enum {
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
+#define F2FS_FEATURE_INODE_CRTIME	0x0100
 
 #define MAX_VOLUME_NAME		512
 
@@ -785,8 +786,10 @@ struct f2fs_inode {
 			__le16 i_inline_xattr_size;	/* inline xattr size, unit: 4 bytes */
 			__le32 i_projid;	/* project id */
 			__le32 i_inode_checksum;/* inode meta checksum */
+			__le64 i_crtime;	/* creation time */
+			__le32 i_crtime_nsec;	/* creation time in nano scale */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
-		};
+		} __attribute__((packed));
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
 	};
 	__le32 i_nid[5];		/* direct(2), indirect(2),
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9d7e18039a88..0fc8b30296ef 100644
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
index e41bcb1a9d0c..e522b2f33562 100644
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
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
