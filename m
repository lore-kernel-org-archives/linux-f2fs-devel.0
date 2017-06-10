From: =?UTF-8?q?Piotr=20Soko=C5=82owski?= <piotrsok2@gmail.com>
Subject: [PATCH] Bugfix - programm shows proper help communicate
Date: Sat, 10 Jun 2017 11:27:29 +0200
Message-ID: <1497086849-192-1-git-send-email-piotrsok2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <piotrsok2@gmail.com>) id 1dJcgy-0000VT-Qk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Jun 2017 09:28:24 +0000
Received: from mail-lf0-f68.google.com ([209.85.215.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dJcgx-0003jO-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Jun 2017 09:28:24 +0000
Received: by mail-lf0-f68.google.com with SMTP id o28so6515921lfk.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2017 02:28:23 -0700 (PDT)
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
Cc: Jacek Kupiec <jacek.kupiec@o2.pl>

From: Jacek Kupiec <jacek.kupiec@o2.pl>

---
 fsck/main.c | 479 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 252 insertions(+), 227 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 6c94a70..b0881e8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -108,6 +108,18 @@ void f2fs_parse_options(int argc, char *argv[])
 	char *prog = basename(argv[0]);
 	int err = NOERROR;
 
+	if (!strcmp("fsck.f2fs", prog))
+		c.func = FSCK;
+	else if (!strcmp("dump.f2fs", prog))
+		c.func = DUMP;
+	else if (!strcmp("defrag.f2fs", prog))
+		c.func = DEFRAG;
+	else if (!strcmp("resize.f2fs", prog)) 
+		c.func = RESIZE;
+	else if (!strcmp("sload.f2fs", prog))
+		c.func = SLOAD;
+	
+
 	if (argc < 2) {
 		MSG(0, "\tError: Device not specified\n");
 		error_out();
@@ -115,261 +127,274 @@ void f2fs_parse_options(int argc, char *argv[])
 	c.devices[0].path = strdup(argv[argc - 1]);
 	argv[argc-- - 1] = 0;
 
-	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":ad:fp:t";
+	switch (c.func) {
+	case FSCK:
+		{
+			const char *option_string = ":ad:fp:t";
 
-		c.func = FSCK;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
-			switch (option) {
-			case 'a':
-				c.auto_fix = 1;
-				MSG(0, "Info: Fix the reported corruption.\n");
-				break;
-			case 'p':
-				/* preen mode has different levels:
-				 *  0: default level, the same as -a
-				 *  1: check meta
-				 */
-				if (optarg[0] == '-') {
-					c.preen_mode = PREEN_MODE_0;
-					optind--;
-					break;
-				} else if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
-					break;
-				}
-				c.preen_mode = atoi(optarg);
-				if (c.preen_mode < 0)
-					c.preen_mode = PREEN_MODE_0;
-				else if (c.preen_mode >= PREEN_MODE_MAX)
-					c.preen_mode = PREEN_MODE_MAX - 1;
-				if (c.preen_mode == PREEN_MODE_0)
+			while ((option = getopt(argc, argv, option_string)) != EOF) {
+				switch (option) {
+				case 'a':
 					c.auto_fix = 1;
-				MSG(0, "Info: Fix the reported corruption in "
-					"preen mode %d\n", c.preen_mode);
-				break;
-			case 'd':
-				if (optarg[0] == '-') {
-					err = ENEED_ARG;
+					MSG(0, "Info: Fix the reported corruption.\n");
 					break;
-				} else if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
+				case 'p':
+					/* preen mode has different levels:
+					*  0: default level, the same as -a
+					*  1: check meta
+					*/
+					if (optarg[0] == '-') {
+						c.preen_mode = PREEN_MODE_0;
+						optind--;
+						break;
+					} else if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.preen_mode = atoi(optarg);
+					if (c.preen_mode < 0)
+						c.preen_mode = PREEN_MODE_0;
+					else if (c.preen_mode >= PREEN_MODE_MAX)
+						c.preen_mode = PREEN_MODE_MAX - 1;
+					if (c.preen_mode == PREEN_MODE_0)
+						c.auto_fix = 1;
+					MSG(0, "Info: Fix the reported corruption in "
+						"preen mode %d\n", c.preen_mode);
+					break;
+				case 'd':
+					if (optarg[0] == '-') {
+						err = ENEED_ARG;
+						break;
+					} else if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
+					break;
+				case 'f':
+					c.fix_on = 1;
+					MSG(0, "Info: Force to fix corruption\n");
+					break;
+				case 't':
+					c.dbg_lv = -1;
 					break;
-				}
-				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n", c.dbg_lv);
-				break;
-			case 'f':
-				c.fix_on = 1;
-				MSG(0, "Info: Force to fix corruption\n");
-				break;
-			case 't':
-				c.dbg_lv = -1;
-				break;
 
 
-			case ':':
-				if (optopt == 'p') {
-					MSG(0, "Info: Use default preen mode\n");
-					c.preen_mode = PREEN_MODE_0;
-					c.auto_fix = 1;
-				} else {
+				case ':':
+					if (optopt == 'p') {
+						MSG(0, "Info: Use default preen mode\n");
+						c.preen_mode = PREEN_MODE_0;
+						c.auto_fix = 1;
+					} else {
+						option = optopt;
+						err = ENEED_ARG;
+						break;
+					}
+					break;
+				case '?':
 					option = optopt;
-					err = ENEED_ARG;
+				default:
+					err = EUNKNOWN_OPT;
 					break;
 				}
-				break;
-			case '?':
-				option = optopt;
-			default:
-				err = EUNKNOWN_OPT;
-				break;
+				if (err != NOERROR)
+					break;
 			}
-			if (err != NOERROR)
-				break;
 		}
-	} else if (!strcmp("dump.f2fs", prog)) {
-		const char *option_string = "d:i:n:s:a:b:";
-		static struct dump_option dump_opt = {
-			.nid = 0,	/* default root ino */
-			.start_nat = -1,
-			.end_nat = -1,
-			.start_sit = -1,
-			.end_sit = -1,
-			.start_ssa = -1,
-			.end_ssa = -1,
-			.blk_addr = -1,
-		};
-
-		c.func = DUMP;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
-			int ret = 0;
-
-			switch (option) {
-			case 'd':
-				if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
+		
+		break;
+	case DUMP:
+		{
+			const char *option_string = "d:i:n:s:a:b:";
+			static struct dump_option dump_opt = {
+				.nid = 0,	/* default root ino */
+				.start_nat = -1,
+				.end_nat = -1,
+				.start_sit = -1,
+				.end_sit = -1,
+				.start_ssa = -1,
+				.end_ssa = -1,
+				.blk_addr = -1,
+			};
+
+			while ((option = getopt(argc, argv, option_string)) != EOF) {
+				int ret = 0;
+
+				switch (option) {
+				case 'd':
+					if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n",
+								c.dbg_lv);
+					break;
+				case 'i':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%d",
+								&dump_opt.nid);
+					else
+						ret = sscanf(optarg, "%x",
+								&dump_opt.nid);
+					break;
+				case 'n':
+					ret = sscanf(optarg, "%d~%d",
+								&dump_opt.start_nat,
+								&dump_opt.end_nat);
+					break;
+				case 's':
+					ret = sscanf(optarg, "%d~%d",
+								&dump_opt.start_sit,
+								&dump_opt.end_sit);
+					break;
+				case 'a':
+					ret = sscanf(optarg, "%d~%d",
+								&dump_opt.start_ssa,
+								&dump_opt.end_ssa);
+					break;
+				case 'b':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%d",
+								&dump_opt.blk_addr);
+					else
+						ret = sscanf(optarg, "%x",
+								&dump_opt.blk_addr);
+					break;
+				default:
+					err = EUNKNOWN_OPT;
 					break;
 				}
-				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n",
-							c.dbg_lv);
-				break;
-			case 'i':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%d",
-							&dump_opt.nid);
-				else
-					ret = sscanf(optarg, "%x",
-							&dump_opt.nid);
-				break;
-			case 'n':
-				ret = sscanf(optarg, "%d~%d",
-							&dump_opt.start_nat,
-							&dump_opt.end_nat);
-				break;
-			case 's':
-				ret = sscanf(optarg, "%d~%d",
-							&dump_opt.start_sit,
-							&dump_opt.end_sit);
-				break;
-			case 'a':
-				ret = sscanf(optarg, "%d~%d",
-							&dump_opt.start_ssa,
-							&dump_opt.end_ssa);
-				break;
-			case 'b':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%d",
-							&dump_opt.blk_addr);
-				else
-					ret = sscanf(optarg, "%x",
-							&dump_opt.blk_addr);
-				break;
-			default:
-				err = EUNKNOWN_OPT;
-				break;
+				ASSERT(ret >= 0);
+				if (err != NOERROR)
+					break;
 			}
-			ASSERT(ret >= 0);
-			if (err != NOERROR)
-				break;
-		}
-
-		c.private = &dump_opt;
-	} else if (!strcmp("defrag.f2fs", prog)) {
-		const char *option_string = "d:s:l:t:i";
 
-		c.func = DEFRAG;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
-			int ret = 0;
-
-			switch (option) {
-			case 'd':
-				if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
+			c.private = &dump_opt;
+		}
+		break;
+	case DEFRAG:
+		{
+			const char *option_string = "d:s:l:t:i";
+
+			while ((option = getopt(argc, argv, option_string)) != EOF) {
+				int ret = 0;
+
+				switch (option) {
+				case 'd':
+					if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n",
+								c.dbg_lv);
+					break;
+				case 's':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%"PRIu64"",
+								&c.defrag_start);
+					else
+						ret = sscanf(optarg, "%"PRIx64"",
+								&c.defrag_start);
+					break;
+				case 'l':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%"PRIu64"",
+								&c.defrag_len);
+					else
+						ret = sscanf(optarg, "%"PRIx64"",
+								&c.defrag_len);
+					break;
+				case 't':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%"PRIu64"",
+								&c.defrag_target);
+					else
+						ret = sscanf(optarg, "%"PRIx64"",
+								&c.defrag_target);
+					break;
+				case 'i':
+					c.defrag_shrink = 1;
+					break;
+				default:
+					err = EUNKNOWN_OPT;
 					break;
 				}
-				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n",
-							c.dbg_lv);
-				break;
-			case 's':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%"PRIu64"",
-							&c.defrag_start);
-				else
-					ret = sscanf(optarg, "%"PRIx64"",
-							&c.defrag_start);
-				break;
-			case 'l':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%"PRIu64"",
-							&c.defrag_len);
-				else
-					ret = sscanf(optarg, "%"PRIx64"",
-							&c.defrag_len);
-				break;
-			case 't':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%"PRIu64"",
-							&c.defrag_target);
-				else
-					ret = sscanf(optarg, "%"PRIx64"",
-							&c.defrag_target);
-				break;
-			case 'i':
-				c.defrag_shrink = 1;
-				break;
-			default:
-				err = EUNKNOWN_OPT;
-				break;
+				ASSERT(ret >= 0);
+				if (err != NOERROR)
+					break;
 			}
-			ASSERT(ret >= 0);
-			if (err != NOERROR)
-				break;
 		}
-	} else if (!strcmp("resize.f2fs", prog)) {
-		const char *option_string = "d:t:";
-
-		c.func = RESIZE;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
-			int ret = 0;
-
-			switch (option) {
-			case 'd':
-				if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
+		break;
+	case RESIZE:
+		{
+			const char *option_string = "d:t:";
+
+			while ((option = getopt(argc, argv, option_string)) != EOF) {
+				int ret = 0;
+
+				switch (option) {
+				case 'd':
+					if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n",
+								c.dbg_lv);
+					break;
+				case 't':
+					if (strncmp(optarg, "0x", 2))
+						ret = sscanf(optarg, "%"PRIu64"",
+								&c.target_sectors);
+					else
+						ret = sscanf(optarg, "%"PRIx64"",
+								&c.target_sectors);
+					break;
+				default:
+					err = EUNKNOWN_OPT;
 					break;
 				}
-				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n",
-							c.dbg_lv);
-				break;
-			case 't':
-				if (strncmp(optarg, "0x", 2))
-					ret = sscanf(optarg, "%"PRIu64"",
-							&c.target_sectors);
-				else
-					ret = sscanf(optarg, "%"PRIx64"",
-							&c.target_sectors);
-				break;
-			default:
-				err = EUNKNOWN_OPT;
-				break;
+				ASSERT(ret >= 0);
+				if (err != NOERROR)
+					break;
 			}
-			ASSERT(ret >= 0);
-			if (err != NOERROR)
-				break;
 		}
-	} else if (!strcmp("sload.f2fs", prog)) {
-		const char *option_string = "d:f:t:";
-
-		c.func = SLOAD;
-		while ((option = getopt(argc, argv, option_string)) != EOF) {
-			switch (option) {
-			case 'd':
-				if (!is_digits(optarg)) {
-					err = EWRONG_OPT;
+		break;
+	case SLOAD:
+		{
+			const char *option_string = "d:f:t:";
+
+			while ((option = getopt(argc, argv, option_string)) != EOF) {
+				switch (option) {
+				case 'd':
+					if (!is_digits(optarg)) {
+						err = EWRONG_OPT;
+						break;
+					}
+					c.dbg_lv = atoi(optarg);
+					MSG(0, "Info: Debug level = %d\n",
+							c.dbg_lv);
+					break;
+				case 'f':
+					c.from_dir = (char *)optarg;
+					break;
+				case 't':
+					c.mount_point = (char *)optarg;
+					break;
+				default:
+					err = EUNKNOWN_OPT;
 					break;
 				}
-				c.dbg_lv = atoi(optarg);
-				MSG(0, "Info: Debug level = %d\n",
-						c.dbg_lv);
-				break;
-			case 'f':
-				c.from_dir = (char *)optarg;
-				break;
-			case 't':
-				c.mount_point = (char *)optarg;
-				break;
-			default:
-				err = EUNKNOWN_OPT;
-				break;
+				if (err != NOERROR)
+					break;
 			}
-			if (err != NOERROR)
-				break;
 		}
+		break;
 	}
+
 	if (argc > optind) {
 		c.dbg_lv = 0;
 		err = EUNKNOWN_ARG;
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
