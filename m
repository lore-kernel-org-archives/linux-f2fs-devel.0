From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: support -p without argument
Date: Sat, 21 Jan 2017 14:00:54 +0800
Message-ID: <20170121060055.47542-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cUojo-0002kZ-6a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 06:01:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cUojm-0000BB-Sf
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 06:01:20 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch allows fsck run -p without argument. So we could use -p as
-p, -p 0, -p 1. '-p' and '-p 0' have the same meaning as '-a'. '-p 1'
check more meta data than '-a'.

Reported-by: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 80 insertions(+), 19 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 39ef8d3..0ac1711 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -17,6 +17,7 @@
  */
 #include "fsck.h"
 #include <libgen.h>
+#include <ctype.h>
 
 struct f2fs_fsck gfsck;
 
@@ -77,13 +78,54 @@ void sload_usage()
 	exit(1);
 }
 
+static void __handle_fsck_args(int optopt)
+{
+	switch (optopt) {
+	case 'p':
+		MSG(0, "Info: Use default preen mode\n");
+		c.preen_mode = PREEN_MODE_0;
+		c.auto_fix = 1;
+		break;
+	default:
+		MSG(0, "\tError: Need argument for -%c\n", optopt);
+		fsck_usage();
+	}
+}
+
+static int is_digits(char *optarg)
+{
+	int i;
+
+	for (i = 0; i < strlen(optarg); i++)
+		if (!isdigit(optarg[i]))
+			break;
+	return i == strlen(optarg);
+}
+
 void f2fs_parse_options(int argc, char *argv[])
 {
 	int option = 0;
 	char *prog = basename(argv[0]);
+	int err = 0;
+
+	if (argc < 2) {
+		MSG(0, "\tError: Device not specified\n");
+		if (c.func == FSCK)
+			fsck_usage();
+		else if (c.func == DUMP)
+			dump_usage();
+		else if (c.func == DEFRAG)
+			defrag_usage();
+		else if (c.func == RESIZE)
+			resize_usage();
+		else if (c.func == SLOAD)
+			sload_usage();
+	}
+	c.devices[0].path = strdup(argv[argc - 1]);
+	argv[argc-- - 1] = 0;
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = "ad:fp:t";
+		const char *option_string = ":ad:fp:t";
 
 		c.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -97,6 +139,16 @@ void f2fs_parse_options(int argc, char *argv[])
 				 *  0: default level, the same as -a
 				 *  1: check meta
 				 */
+				if (optarg[0] == '-') {
+					c.preen_mode = PREEN_MODE_0;
+					optind--;
+					break;
+				} else if (!is_digits(optarg)) {
+					MSG(0, "\tError: Wrong option -%c %s\n",
+							option, optarg);
+					err = 1;
+					break;
+				}
 				c.preen_mode = atoi(optarg);
 				if (c.preen_mode < 0)
 					c.preen_mode = PREEN_MODE_0;
@@ -108,9 +160,19 @@ void f2fs_parse_options(int argc, char *argv[])
 					"preen mode %d\n", c.preen_mode);
 				break;
 			case 'd':
+				if (optarg[0] == '-') {
+					MSG(0, "\tError: Need argument for -%c\n",
+							option);
+					err = 1;
+					break;
+				} else if (!is_digits(optarg)) {
+					MSG(0, "\tError: Wrong option -%c %s\n",
+							option, optarg);
+					err = 1;
+					break;
+				}
 				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n",
-							c.dbg_lv);
+				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
 				break;
 			case 'f':
 				c.fix_on = 1;
@@ -119,11 +181,25 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 't':
 				c.dbg_lv = -1;
 				break;
+			case ':':
+				__handle_fsck_args(optopt);
+				break;
+			case '?':
+				MSG(0, "\tError: Unknown option %c\n", optopt);
+				err = 1;
+				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
-				fsck_usage();
+				err = 1;
 				break;
 			}
+			if (err)
+				fsck_usage();
+		}
+		if (argc > optind) {
+			c.dbg_lv = 0;
+			MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
+			fsck_usage();
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
 		const char *option_string = "d:i:n:s:a:b:";
@@ -287,21 +363,6 @@ void f2fs_parse_options(int argc, char *argv[])
 			}
 		}
 	}
-
-	if ((optind + 1) != argc) {
-		MSG(0, "\tError: Device not specified\n");
-		if (c.func == FSCK)
-			fsck_usage();
-		else if (c.func == DUMP)
-			dump_usage();
-		else if (c.func == DEFRAG)
-			defrag_usage();
-		else if (c.func == RESIZE)
-			resize_usage();
-		else if (c.func == SLOAD)
-			sload_usage();
-	}
-	c.devices[0].path = strdup(argv[optind]);
 }
 
 static void do_fsck(struct f2fs_sb_info *sbi)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
