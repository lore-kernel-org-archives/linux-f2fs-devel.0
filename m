From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs-tools: support project quota
Date: Sun, 16 Jul 2017 15:12:51 +0800
Message-ID: <20170716071251.25793-3-chao@kernel.org>
References: <20170716071251.25793-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dWdln-00019h-PU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:15:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dWdlm-0007Ob-P4
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jul 2017 07:15:11 +0000
In-Reply-To: <20170716071251.25793-1-chao@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

This patch introduce a new option '-p' for enabling project quota
functionality during mkfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c            | 4 ++++
 include/f2fs_fs.h       | 5 +++++
 lib/libf2fs.c           | 1 +
 mkfs/f2fs_format.c      | 1 +
 mkfs/f2fs_format_main.c | 8 +++++++-
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 693e4a8..b4f8958 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -90,6 +90,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 
 	DISP_u16(inode, i_extra_isize);
 	DISP_u16(inode, i_padding);
+	DISP_u32(inode, i_projid);
 
 	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
 	DISP_u32(inode, i_addr[ofs + 1]);	/* Pointers to data blocks */
@@ -284,6 +285,9 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_BLKZONED)) {
 		MSG(0, "%s", " zoned block device");
 	}
+	if (f & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
+		MSG(0, "%s", " project quota");
+	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 88ceb61..b49b6f5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -267,6 +267,7 @@ struct f2fs_configuration {
 	int sparse_mode;
 	int zoned_mode;
 	int zoned_model;
+	int project_quota;
 	size_t zone_blocks;
 	double overprovision;
 	double new_overprovision;
@@ -470,6 +471,7 @@ enum {
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
 #define F2FS_FEATURE_BLKZONED	0x0002
+#define F2FS_FEATURE_PRJQUOTA	0x0004
 
 #define MAX_VOLUME_NAME		512
 
@@ -622,6 +624,8 @@ struct f2fs_extent {
 	(offsetof(struct f2fs_inode, i_extra_end) -	\
 	offsetof(struct f2fs_inode, i_extra_isize))	\
 
+#define	F2FS_DEF_PROJID		0	/* default project ID */
+
 #define MAX_INLINE_DATA(node) (sizeof(__le32) *				\
 				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
 				get_extra_isize(node) -			\
@@ -677,6 +681,7 @@ struct f2fs_inode {
 		struct {
 			__le16 i_extra_isize;	/* extra inode attribute size */
 			__le16 i_padding;	/* padding */
+			__le32 i_projid;	/* project id */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		};
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a3091bb..c595130 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -557,6 +557,7 @@ void f2fs_init_configuration(void)
 	c.zoned_mode = 0;
 	c.zoned_model = 0;
 	c.zone_blocks = 0;
+	c.project_quota = 0;
 
 	for (i = 0; i < MAX_DEVICES; i++) {
 		memset(&c.devices[i], 0, sizeof(struct device_info));
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4f2b403..ebb9d3c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -924,6 +924,7 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 	raw_node->i.i_inline = F2FS_EXTRA_ATTR;
 	raw_node->i.i_extra_isize = cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
+	raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
 
 	data_blk_nor = get_sb(main_blkaddr) +
 		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 5525d1c..4ce075c 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -88,7 +88,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:S:z:t:f";
+	static const char *option_string = "qa:c:d:e:l:mo:O:p:s:S:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -135,6 +135,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'O':
 			parse_feature(optarg);
 			break;
+		case 'p':
+			c.project_quota = 1;
+			break;
 		case 's':
 			c.segs_per_sec = atoi(optarg);
 			break;
@@ -180,6 +183,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 
 	if (c.zoned_mode)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
+
+	if (c.project_quota)
+		c.feature |= cpu_to_le32(F2FS_FEATURE_PRJQUOTA);
 }
 
 #ifdef HAVE_LIBBLKID
-- 
2.13.0.90.g1eb437020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
