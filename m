From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: show parse errors neatly
Date: Sat, 21 Jan 2017 14:00:55 +0800
Message-ID: <20170121060055.47542-2-jaegeuk@kernel.org>
References: <20170121060055.47542-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cUojz-0002IK-Iu
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 06:01:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cUojy-0005HU-HC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Jan 2017 06:01:31 +0000
In-Reply-To: <20170121060055.47542-1-jaegeuk@kernel.org>
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

This patch is just to clean up.

Cc: Sheng Yong <shengyong1@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.h |   8 ++++
 fsck/main.c | 140 ++++++++++++++++++++++++++++++++++++------------------------
 2 files changed, 93 insertions(+), 55 deletions(-)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index f21e199..5a6f018 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -21,6 +21,14 @@ enum {
 	PREEN_MODE_MAX
 };
 
+enum {
+	NOERROR,
+	EWRONG_OPT,
+	ENEED_ARG,
+	EUNKNOWN_OPT,
+	EUNKNOWN_ARG,
+};
+
 /* fsck.c */
 struct orphan_info {
 	u32 nr_inodes;
diff --git a/fsck/main.c b/fsck/main.c
index 0ac1711..6c94a70 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -78,20 +78,6 @@ void sload_usage()
 	exit(1);
 }
 
-static void __handle_fsck_args(int optopt)
-{
-	switch (optopt) {
-	case 'p':
-		MSG(0, "Info: Use default preen mode\n");
-		c.preen_mode = PREEN_MODE_0;
-		c.auto_fix = 1;
-		break;
-	default:
-		MSG(0, "\tError: Need argument for -%c\n", optopt);
-		fsck_usage();
-	}
-}
-
 static int is_digits(char *optarg)
 {
 	int i;
@@ -102,24 +88,29 @@ static int is_digits(char *optarg)
 	return i == strlen(optarg);
 }
 
+static void error_out(void)
+{
+	if (c.func == FSCK)
+		fsck_usage();
+	else if (c.func == DUMP)
+		dump_usage();
+	else if (c.func == DEFRAG)
+		defrag_usage();
+	else if (c.func == RESIZE)
+		resize_usage();
+	else if (c.func == SLOAD)
+		sload_usage();
+}
+
 void f2fs_parse_options(int argc, char *argv[])
 {
 	int option = 0;
 	char *prog = basename(argv[0]);
-	int err = 0;
+	int err = NOERROR;
 
 	if (argc < 2) {
 		MSG(0, "\tError: Device not specified\n");
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
+		error_out();
 	}
 	c.devices[0].path = strdup(argv[argc - 1]);
 	argv[argc-- - 1] = 0;
@@ -144,9 +135,7 @@ void f2fs_parse_options(int argc, char *argv[])
 					optind--;
 					break;
 				} else if (!is_digits(optarg)) {
-					MSG(0, "\tError: Wrong option -%c %s\n",
-							option, optarg);
-					err = 1;
+					err = EWRONG_OPT;
 					break;
 				}
 				c.preen_mode = atoi(optarg);
@@ -161,14 +150,10 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 			case 'd':
 				if (optarg[0] == '-') {
-					MSG(0, "\tError: Need argument for -%c\n",
-							option);
-					err = 1;
+					err = ENEED_ARG;
 					break;
 				} else if (!is_digits(optarg)) {
-					MSG(0, "\tError: Wrong option -%c %s\n",
-							option, optarg);
-					err = 1;
+					err = EWRONG_OPT;
 					break;
 				}
 				c.dbg_lv = atoi(optarg);
@@ -181,25 +166,27 @@ void f2fs_parse_options(int argc, char *argv[])
 			case 't':
 				c.dbg_lv = -1;
 				break;
+
+
 			case ':':
-				__handle_fsck_args(optopt);
+				if (optopt == 'p') {
+					MSG(0, "Info: Use default preen mode\n");
+					c.preen_mode = PREEN_MODE_0;
+					c.auto_fix = 1;
+				} else {
+					option = optopt;
+					err = ENEED_ARG;
+					break;
+				}
 				break;
 			case '?':
-				MSG(0, "\tError: Unknown option %c\n", optopt);
-				err = 1;
-				break;
+				option = optopt;
 			default:
-				MSG(0, "\tError: Unknown option %c\n", option);
-				err = 1;
+				err = EUNKNOWN_OPT;
 				break;
 			}
-			if (err)
-				fsck_usage();
-		}
-		if (argc > optind) {
-			c.dbg_lv = 0;
-			MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
-			fsck_usage();
+			if (err != NOERROR)
+				break;
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
 		const char *option_string = "d:i:n:s:a:b:";
@@ -220,6 +207,10 @@ void f2fs_parse_options(int argc, char *argv[])
 
 			switch (option) {
 			case 'd':
+				if (!is_digits(optarg)) {
+					err = EWRONG_OPT;
+					break;
+				}
 				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
 							c.dbg_lv);
@@ -256,11 +247,12 @@ void f2fs_parse_options(int argc, char *argv[])
 							&dump_opt.blk_addr);
 				break;
 			default:
-				MSG(0, "\tError: Unknown option %c\n", option);
-				dump_usage();
+				err = EUNKNOWN_OPT;
 				break;
 			}
 			ASSERT(ret >= 0);
+			if (err != NOERROR)
+				break;
 		}
 
 		c.private = &dump_opt;
@@ -273,6 +265,10 @@ void f2fs_parse_options(int argc, char *argv[])
 
 			switch (option) {
 			case 'd':
+				if (!is_digits(optarg)) {
+					err = EWRONG_OPT;
+					break;
+				}
 				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
 							c.dbg_lv);
@@ -305,11 +301,12 @@ void f2fs_parse_options(int argc, char *argv[])
 				c.defrag_shrink = 1;
 				break;
 			default:
-				MSG(0, "\tError: Unknown option %c\n", option);
-				defrag_usage();
+				err = EUNKNOWN_OPT;
 				break;
 			}
 			ASSERT(ret >= 0);
+			if (err != NOERROR)
+				break;
 		}
 	} else if (!strcmp("resize.f2fs", prog)) {
 		const char *option_string = "d:t:";
@@ -320,6 +317,10 @@ void f2fs_parse_options(int argc, char *argv[])
 
 			switch (option) {
 			case 'd':
+				if (!is_digits(optarg)) {
+					err = EWRONG_OPT;
+					break;
+				}
 				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
 							c.dbg_lv);
@@ -333,11 +334,12 @@ void f2fs_parse_options(int argc, char *argv[])
 							&c.target_sectors);
 				break;
 			default:
-				MSG(0, "\tError: Unknown option %c\n", option);
-				resize_usage();
+				err = EUNKNOWN_OPT;
 				break;
 			}
 			ASSERT(ret >= 0);
+			if (err != NOERROR)
+				break;
 		}
 	} else if (!strcmp("sload.f2fs", prog)) {
 		const char *option_string = "d:f:t:";
@@ -346,6 +348,10 @@ void f2fs_parse_options(int argc, char *argv[])
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
 			switch (option) {
 			case 'd':
+				if (!is_digits(optarg)) {
+					err = EWRONG_OPT;
+					break;
+				}
 				c.dbg_lv = atoi(optarg);
 				MSG(0, "Info: Debug level = %d\n",
 						c.dbg_lv);
@@ -357,12 +363,36 @@ void f2fs_parse_options(int argc, char *argv[])
 				c.mount_point = (char *)optarg;
 				break;
 			default:
-				MSG(0, "\tError: Unknown option %c\n", option);
-				sload_usage();
+				err = EUNKNOWN_OPT;
 				break;
 			}
+			if (err != NOERROR)
+				break;
 		}
 	}
+	if (argc > optind) {
+		c.dbg_lv = 0;
+		err = EUNKNOWN_ARG;
+	}
+	if (err == NOERROR)
+		return;
+
+	/* print out error */
+	switch (err) {
+	case EWRONG_OPT:
+		MSG(0, "\tError: Wrong option -%c %s\n", option, optarg);
+		break;
+	case ENEED_ARG:
+		MSG(0, "\tError: Need argument for -%c\n", option);
+		break;
+	case EUNKNOWN_OPT:
+		MSG(0, "\tError: Unknown option %c\n", option);
+		break;
+	case EUNKNOWN_ARG:
+		MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
+		break;
+	}
+	error_out();
 }
 
 static void do_fsck(struct f2fs_sb_info *sbi)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
