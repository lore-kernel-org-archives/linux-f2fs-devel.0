From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] fsck.f2fs: fix wrong usage out
Date: Mon, 13 Feb 2017 18:05:19 -0800
Message-ID: <20170214020520.18091-3-jaegeuk@kernel.org>
References: <20170214020520.18091-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cdSUu-0001Cl-SN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:05:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cdSUp-0006zl-JE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:05:40 +0000
In-Reply-To: <20170214020520.18091-1-jaegeuk@kernel.org>
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

This fixes wrong messages for error out.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 6c94a70..8bf5cd9 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -88,18 +88,20 @@ static int is_digits(char *optarg)
 	return i == strlen(optarg);
 }
 
-static void error_out(void)
+static void error_out(char *prog)
 {
-	if (c.func == FSCK)
+	if (!strcmp("fsck.f2fs", prog))
 		fsck_usage();
-	else if (c.func == DUMP)
+	else if (!strcmp("dump.f2fs", prog))
 		dump_usage();
-	else if (c.func == DEFRAG)
+	else if (!strcmp("defrag.f2fs", prog))
 		defrag_usage();
-	else if (c.func == RESIZE)
+	else if (!strcmp("resize.f2fs", prog))
 		resize_usage();
-	else if (c.func == SLOAD)
+	else if (!strcmp("sload.f2fs", prog))
 		sload_usage();
+	else
+		MSG(0, "\nWrong progam.\n");
 }
 
 void f2fs_parse_options(int argc, char *argv[])
@@ -110,7 +112,7 @@ void f2fs_parse_options(int argc, char *argv[])
 
 	if (argc < 2) {
 		MSG(0, "\tError: Device not specified\n");
-		error_out();
+		error_out(prog);
 	}
 	c.devices[0].path = strdup(argv[argc - 1]);
 	argv[argc-- - 1] = 0;
@@ -392,7 +394,7 @@ void f2fs_parse_options(int argc, char *argv[])
 		MSG(0, "\tError: Unknown argument %s\n", argv[optind]);
 		break;
 	}
-	error_out();
+	error_out(prog);
 }
 
 static void do_fsck(struct f2fs_sb_info *sbi)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
