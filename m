From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 1/2] mkfs.f2fs: add option to set the value of reserved segments and overprovision segments
Date: Fri, 17 Feb 2017 20:53:06 +0800
Message-ID: <1487335987-32601-2-git-send-email-yunlong.song@huawei.com>
References: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com, miaoxie@huawei.com, zhouxiyu@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 include/f2fs_fs.h       |  3 +++
 lib/libf2fs.c           |  3 +++
 mkfs/f2fs_format.c      | 21 ++++++++++++++-------
 mkfs/f2fs_format_main.c | 10 +++++++++-
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 97ee297..2a62660 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -304,6 +304,9 @@ struct f2fs_configuration {
 	/* sload parameters */
 	char *from_dir;
 	char *mount_point;
+
+	u_int32_t force_rsvd;
+	u_int32_t force_ovp;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 93d3da9..971fe99 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -573,6 +573,9 @@ void f2fs_init_configuration(void)
 	c.trim = 1;
 	c.ro = 0;
 	c.kd = -1;
+
+	c.force_rsvd = 0;
+	c.force_ovp = 0;
 }
 
 static int is_mounted(const char *mpt, const char *device)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3c13026..42a7bd5 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -337,9 +337,12 @@ static int f2fs_prepare_super_block(void)
 	if (c.overprovision == 0)
 		c.overprovision = get_best_overprovision(sb);
 
-	c.reserved_segments =
-			(2 * (100 / c.overprovision + 1) + 6)
-			* c.segs_per_sec;
+	if (c.force_rsvd)
+		c.reserved_segments = c.force_rsvd;
+	else
+		c.reserved_segments =
+				(2 * (100 / c.overprovision + 1) + 6)
+				* c.segs_per_sec;
 
 	if (c.overprovision == 0 || c.total_segments < F2FS_MIN_SEGMENTS ||
 		(c.devices[0].total_sectors *
@@ -522,13 +525,17 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(cur_data_blkoff[0], 1);
 	set_cp(valid_block_count, 2);
 	set_cp(rsvd_segment_count, c.reserved_segments);
-	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
-			get_cp(rsvd_segment_count)) *
-			c.overprovision / 100);
+	if (c.force_ovp)
+		set_cp(overprov_segment_count, c.force_ovp);
+	else
+		set_cp(overprov_segment_count, (get_sb(segment_count_main) -
+				get_cp(rsvd_segment_count)) *
+				c.overprovision / 100);
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 			get_cp(rsvd_segment_count));
 
-	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.overprovision);
+	if (c.force_rsvd == 0 || c.force_ovp == 0)
+		MSG(0, "Info: Overprovision ratio = %.3lf%%\n", c.overprovision);
 	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
 					get_cp(overprov_segment_count),
 					c.reserved_segments);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 5bb1faf..45c513b 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -39,6 +39,8 @@ static void mkfs_usage()
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
 	MSG(0, "  -m support zoned block device [default:0]\n");
+	MSG(0, "  -r force set reserved segments\n");
+	MSG(0, "  -R force set overprovision segments\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
@@ -72,7 +74,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:z:t:";
+	static const char *option_string = "qa:c:d:e:l:mo:O:s:z:t:r:R:";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -128,6 +130,12 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 't':
 			c.trim = atoi(optarg);
 			break;
+		case 'r':
+			c.force_rsvd = atoi(optarg);
+			break;
+		case 'R':
+			c.force_ovp = atoi(optarg);
+			break;
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
 			mkfs_usage();
-- 
1.8.5.2
