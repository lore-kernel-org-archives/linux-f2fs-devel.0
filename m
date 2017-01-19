From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] fsck.f2fs: support -p without argument
Date: Fri, 20 Jan 2017 07:19:26 +0800
Message-ID: <20170119231926.GA42028@jaegeuk.local>
References: <20170119030341.12636-1-shengyong1@huawei.com>
	<20170119030341.12636-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cULzY-0004gJ-IG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 23:19:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cULzW-00074e-7K
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jan 2017 23:19:40 +0000
Content-Disposition: inline
In-Reply-To: <20170119030341.12636-2-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: k@vodka.home.kg, piotr.karbowski@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Hi Sheng Yong,

I tested this, but failed on -p with arguments.

Could you take a look at this change?

>From e558ebf31a35619d5625927b50be0c9feef1feac Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 19 Jan 2017 11:03:41 +0800
Subject: [PATCH] fsck.f2fs: support -p without argument

This patch allows fsck run -p without argument. So we could use -p as
-p, -p0, and -p1. '-p' and '-p0' have the same meaning as '-a'.
'-p1' checks more meta data than '-a'.

Reported-by: KARBOWSKI Piotr <piotr.karbowski@gmail.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 29 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 39ef8d3..3a58fbb 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -17,6 +17,7 @@
  */
 #include "fsck.h"
 #include <libgen.h>
+#include <ctype.h>
 
 struct f2fs_fsck gfsck;
 
@@ -77,53 +78,138 @@ void sload_usage()
 	exit(1);
 }
 
+static void __handle_fsck_args(int optopt)
+{
+	switch (optopt) {
+	case 'p':
+		printf("Info: Use default preen mode\n");
+		c.preen_mode = PREEN_MODE_0;
+		c.auto_fix = 1;
+		break;
+	case 'a':
+		c.auto_fix = 1;
+		MSG(0, "Info: Fix the reported corruption.\n");
+		break;
+	case 'f':
+		c.fix_on = 1;
+		MSG(0, "Info: Force to fix corruption\n");
+		break;
+	case 't':
+		c.dbg_lv = -1;
+		break;
+	default:
+		printf("\tError: Need argument for -%c\n", optopt);
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
+		const char *option_string = ":a:d:f:p:t:";
 
 		c.func = FSCK;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'a':
-				c.auto_fix = 1;
-				MSG(0, "Info: Fix the reported corruption.\n");
+			case 'f':
+			case 't':
+				if (optarg) {
+					if (optarg[0] == '-') {
+						optind--;
+						break;
+					}
+					MSG(0, "\tError: Not support arguments"
+						" for -%c\n", option);
+					err = 1;
+				}
 				break;
 			case 'p':
 				/* preen mode has different levels:
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
 				else if (c.preen_mode >= PREEN_MODE_MAX)
-					c.preen_mode = PREEN_MODE_MAX - 1;
+					c.preen_mode =
+						PREEN_MODE_MAX - 1;
 				if (c.preen_mode == PREEN_MODE_0)
 					c.auto_fix = 1;
-				MSG(0, "Info: Fix the reported corruption in "
-					"preen mode %d\n", c.preen_mode);
+				MSG(0, "Info: Fix the reported "
+						"corruption in preen mode %d\n",
+						c.preen_mode);
 				break;
 			case 'd':
+				if (optarg[0] == '-') {
+					printf("\tError: Need argument for -%c\n",
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
-			case 'f':
-				c.fix_on = 1;
-				MSG(0, "Info: Force to fix corruption\n");
+			case ':':
+				__handle_fsck_args(optopt);
 				break;
-			case 't':
-				c.dbg_lv = -1;
+			case '?':
+				MSG(0, "\tError: Unknown option %c\n", optopt);
+				err = 1;
 				break;
 			default:
 				MSG(0, "\tError: Unknown option %c\n", option);
-				fsck_usage();
+				err = 1;
 				break;
 			}
+			if (err)
+				fsck_usage();
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
 		const char *option_string = "d:i:n:s:a:b:";
@@ -287,21 +373,6 @@ void f2fs_parse_options(int argc, char *argv[])
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
