From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2 1/2] f2fs-tools: introduce new option V to
 show version
Date: Tue, 10 Apr 2018 11:28:19 +0800
Message-ID: <20180410032820.80531-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1f5jxu-0007JL-D5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:29:02 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5jxe-004FNl-75
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:29:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new option -V to show the version of f2fs tools
and exit after that.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v2->v1: add -V for all f2fs tools

 fsck/main.c             | 30 +++++++++++++++++++++++++-----
 include/f2fs_fs.h       |  6 ++++++
 mkfs/f2fs_format_main.c |  6 +++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index bbf82c3..ca3b789 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -58,6 +58,7 @@ void fsck_usage()
 	MSG(0, "  -t show directory tree\n");
 	MSG(0, "  -q preserve quota limits\n");
 	MSG(0, "  -y fix all the time\n");
+	MSG(0, "  -V print the version number and exit\n");
 	MSG(0, "  --dry-run do not really fix corruptions\n");
 	exit(1);
 }
@@ -73,6 +74,7 @@ void dump_usage()
 	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -b blk_addr (in 4KB)\n");
+	MSG(0, "  -V print the version number and exit\n");
 
 	exit(1);
 }
@@ -87,6 +89,7 @@ void defrag_usage()
 	MSG(0, "  -l length [default:512 (2MB)]\n");
 	MSG(0, "  -t target block address [default: main_blkaddr + 2MB]\n");
 	MSG(0, "  -i set direction as shrink [default: expand]\n");
+	MSG(0, "  -V print the version number and exit\n");
 	exit(1);
 }
 
@@ -96,6 +99,7 @@ void resize_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -t target sectors [default: device size]\n");
+	MSG(0, "  -V print the version number and exit\n");
 	exit(1);
 }
 
@@ -111,6 +115,7 @@ void sload_usage()
 	MSG(0, "  -t mount point [prefix of target fs path, default:/]\n");
 	MSG(0, "  -T timestamp\n");
 	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -V print the version number and exit\n");
 	exit(1);
 }
 
@@ -160,7 +165,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":ad:fp:q:Sty";
+		const char *option_string = ":ad:fp:q:StyV";
 		int opt = 0;
 		struct option long_opt[] = {
 			{"dry-run", no_argument, 0, 1},
@@ -240,6 +245,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					break;
 				}
 				break;
+			case 'V':
+				show_version(prog);
+				exit(0);
 			case '?':
 				option = optopt;
 			default:
@@ -250,7 +258,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
-		const char *option_string = "d:i:n:s:Sa:b:";
+		const char *option_string = "d:i:n:s:Sa:b:V";
 		static struct dump_option dump_opt = {
 			.nid = 0,	/* default root ino */
 			.start_nat = -1,
@@ -310,6 +318,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%x",
 							&dump_opt.blk_addr);
 				break;
+			case 'V':
+				show_version(prog);
+				exit(0);
 			default:
 				err = EUNKNOWN_OPT;
 				break;
@@ -321,7 +332,7 @@ void f2fs_parse_options(int argc, char *argv[])
 
 		c.private = &dump_opt;
 	} else if (!strcmp("defrag.f2fs", prog)) {
-		const char *option_string = "d:s:Sl:t:i";
+		const char *option_string = "d:s:Sl:t:iV";
 
 		c.func = DEFRAG;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -367,6 +378,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 'i':
 				c.defrag_shrink = 1;
 				break;
+			case 'V':
+				show_version(prog);
+				exit(0);
 			default:
 				err = EUNKNOWN_OPT;
 				break;
@@ -376,7 +390,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("resize.f2fs", prog)) {
-		const char *option_string = "d:t:";
+		const char *option_string = "d:t:V";
 
 		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -400,6 +414,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%"PRIx64"",
 							&c.target_sectors);
 				break;
+			case 'V':
+				show_version(prog);
+				exit(0);
 			default:
 				err = EUNKNOWN_OPT;
 				break;
@@ -409,7 +426,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("sload.f2fs", prog)) {
-		const char *option_string = "C:d:f:p:s:St:T:";
+		const char *option_string = "C:d:f:p:s:St:T:V";
 #ifdef HAVE_LIBSELINUX
 		int max_nr_opt = (int)sizeof(c.seopt_file) /
 			sizeof(c.seopt_file[0]);
@@ -467,6 +484,9 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 'T':
 				c.fixed_time = strtoul(optarg, &p, 0);
 				break;
+			case 'V':
+				show_version(prog);
+				exit(0);
 			default:
 				err = EUNKNOWN_OPT;
 				break;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3bb8e6b..2b0be2d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -12,6 +12,7 @@
 #ifndef __F2FS_FS_H__
 #define __F2FS_FS_H__
 
+#include <stdio.h>
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -1297,4 +1298,9 @@ static inline int is_qf_ino(struct f2fs_super_block *sb, nid_t ino)
 	return 0;
 }
 
+static inline void show_version(const char *prog)
+{
+	MSG(0, "%s %s (%s)\n", prog, F2FS_TOOLS_VERSION, F2FS_TOOLS_DATE);
+}
+
 #endif	/*__F2FS_FS_H */
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 3c70513..c8a0015 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -58,6 +58,7 @@ static void mkfs_usage()
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
 	MSG(0, "  -w wanted sector size\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
+	MSG(0, "  -V print the version number and exit\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
@@ -136,7 +137,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:";
+	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:V";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -209,6 +210,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'w':
 			c.wanted_sector_size = atoi(optarg);
 			break;
+		case 'V':
+			show_version("mkfs.f2fs");
+			exit(0);
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
 			mkfs_usage();
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
