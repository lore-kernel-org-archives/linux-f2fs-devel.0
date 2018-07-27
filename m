From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: add root_owner to give uid/gid
Date: Fri, 27 Jul 2018 17:21:51 +0900
Message-ID: <20180727082151.14903-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fj6r3-000707-Sa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 17:48:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fj6r2-00053D-Gk
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 17:48:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds an option to mkfs.f2fs in order for user to assign uid/gid
to the target partition.
This requires when vold in android formats a sdcard partition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h       | 22 ++++++++++++++++++++++
 lib/libf2fs.c           |  4 ++++
 man/mkfs.f2fs.8         |  8 ++++++++
 mkfs/f2fs_format.c      | 12 ++++++------
 mkfs/f2fs_format_main.c |  7 ++++++-
 5 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 0a1ed84..fe1e31b 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -384,6 +384,8 @@ struct f2fs_configuration {
 	u_int32_t lpf_inum;
 	u_int32_t lpf_dnum;
 	u_int32_t lpf_ino;
+	u_int32_t root_uid;
+	u_int32_t root_gid;
 
 	/* defragmentation parameters */
 	int defrag_shrink;
@@ -1382,4 +1384,24 @@ static inline int parse_feature(struct feature *table, const char *features)
 	free(buf);
 	return 0;
 }
+
+static inline int parse_root_owner(char *ids,
+			u_int32_t *root_uid, u_int32_t *root_gid)
+{
+	char *uid = ids;
+	char *gid = NULL;
+	int i;
+
+	/* uid:gid */
+	for (i = 0; i < strlen(ids) - 1; i++)
+		if (*(ids + i) == ':')
+			gid = ids + i + 1;
+	if (!gid)
+		return -1;
+
+	*root_uid = atoi(uid);
+	*root_gid = atoi(gid);
+	return 0;
+}
+
 #endif	/*__F2FS_FS_H */
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5625cff..a1f8beb 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -615,6 +615,10 @@ void f2fs_init_configuration(void)
 	c.trim = 1;
 	c.kd = -1;
 	c.fixed_time = -1;
+
+	/* default root owner */
+	c.root_uid = getuid();
+	c.root_gid = getgid();
 }
 
 #ifdef HAVE_SETMNTENT
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 29dd68f..f9484eb 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -45,6 +45,10 @@ mkfs.f2fs \- create an F2FS file system
 .B \-q
 ]
 [
+.B \-R
+.I root_owner
+]
+[
 .B \-s
 .I #-of-segments-per-section
 ]
@@ -120,6 +124,10 @@ e.g "encrypt" and so on.
 Quiet mode.
 With it, mkfs.f2fs does not show any messages include the basic messages.
 .TP
+.BI \-R
+Give root_owner option for initial uid/gid assignment.
+Default is set by getuid()/getgid(), and assigned by "-R $uid:$gid".
+.TP
 .BI \-s " #-of-segments-per-section"
 Specify the number of segments per section. A section consists of
 multiple consecutive segments, and is the unit of garbage collection.
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index d039434..f2880eb 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1078,8 +1078,8 @@ static int f2fs_write_root_inode(void)
 		raw_node->i.i_links = cpu_to_le32(3);
 	else
 		raw_node->i.i_links = cpu_to_le32(2);
-	raw_node->i.i_uid = cpu_to_le32(getuid());
-	raw_node->i.i_gid = cpu_to_le32(getgid());
+	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
+	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
 	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
@@ -1236,8 +1236,8 @@ static int f2fs_write_qf_inode(int qtype)
 
 	raw_node->i.i_mode = cpu_to_le16(0x8180);
 	raw_node->i.i_links = cpu_to_le32(1);
-	raw_node->i.i_uid = cpu_to_le32(getuid());
-	raw_node->i.i_gid = cpu_to_le32(getgid());
+	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
+	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
 
 	raw_node->i.i_size = cpu_to_le64(1024 * 6); /* Hard coded */
 	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA(qtype));
@@ -1435,8 +1435,8 @@ static int f2fs_write_lpf_inode(void)
 
 	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
 	raw_node->i.i_links = cpu_to_le32(2);
-	raw_node->i.i_uid = cpu_to_le32(getuid());
-	raw_node->i.i_gid = cpu_to_le32(getgid());
+	raw_node->i.i_uid = cpu_to_le32(c.root_uid);
+	raw_node->i.i_gid = cpu_to_le32(c.root_gid);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
 	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8af70a2..6bcfbb0 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -56,6 +56,7 @@ static void mkfs_usage()
 	MSG(0, "  -o overprovision ratio [default:5]\n");
 	MSG(0, "  -O feature1[feature2,feature3,...] e.g. \"encrypt\"\n");
 	MSG(0, "  -q quiet mode\n");
+	MSG(0, "  -R root_owner [default: 0:0]\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -S sparse mode\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
@@ -104,7 +105,7 @@ static void add_default_options(void)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:E:g:il:mo:O:s:S:z:t:fw:V";
+	static const char *option_string = "qa:c:d:e:E:g:il:mo:O:R:s:S:z:t:fw:V";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -162,6 +163,10 @@ static void f2fs_parse_options(int argc, char *argv[])
 			if (parse_feature(feature_table, optarg))
 				mkfs_usage();
 			break;
+		case 'R':
+			if (parse_root_owner(optarg, &c.root_uid, &c.root_gid))
+				mkfs_usage();
+			break;
 		case 's':
 			c.segs_per_sec = atoi(optarg);
 			break;
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
