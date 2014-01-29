From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fstat: add option to select partition to see
	status
Date: Wed, 29 Jan 2014 13:36:54 +0900
Message-ID: <1390970214-20404-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1W8MrH-0006Yd-Df
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jan 2014 04:34:39 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W8MrF-0005h6-4M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jan 2014 04:34:39 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0500C8YBDDA780@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jan 2014 13:34:25 +0900 (KST)
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

If there are some partitions, this may select a partition to see its
status. If no selection, you will see first section of status.

e.g.) f2fstat -p /dev/sda3

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 tools/f2fstat.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index e26e174..b4f22ae 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
+#include <libgen.h>
 
 #ifdef DEBUG
 #define dbg(fmt, args...)	printf(fmt, __VA_ARGS__);
@@ -47,6 +48,7 @@ unsigned long lfs_blks;
 struct options {
 	int delay;
 	int interval;
+	char partname[32];
 };
 
 struct mm_table {
@@ -69,7 +71,7 @@ again:
 	}
 }
 
-void f2fstat(void)
+void f2fstat(struct options *opt)
 {
 	int fd;
 	int ret;
@@ -79,6 +81,7 @@ void f2fstat(void)
 	struct mm_table *found;
 	int f2fstat_table_cnt;
 	char *head, *tail;
+	int found_cnt = 0;
 
 	static struct mm_table f2fstat_table[] = {
 		{ "  - Data",		&used_data_blks },
@@ -114,6 +117,13 @@ void f2fstat(void)
 	buf[ret] = '\0';
 
 	head = buf;
+
+	if (opt->partname[0] != '\0') {
+		head = strstr(buf, opt->partname);
+		if (head == NULL)
+			exit(EXIT_FAILURE);
+	}
+
 	for (;;) {
 		remove_newline(&head);
 		tail = strchr(head, ':');
@@ -137,6 +147,8 @@ void f2fstat(void)
 			goto nextline;
 
 		*(found->val) = strtoul(head, &tail, 10);
+		if (++found_cnt == f2fstat_table_cnt)
+			break;
 nextline:
 		tail = strchr(head, '\n');
 		if (!tail)
@@ -151,14 +163,15 @@ void usage(void)
 {
 	printf("Usage: f2fstat [option]\n"
 			"    -d    delay (secs)\n"
-			"    -i    interval of head info\n");
+			"    -i    interval of head info\n"
+			"    -p    partition name (e.g. /dev/sda3)\n");
 	exit(EXIT_FAILURE);
 }
 
 void parse_option(int argc, char *argv[], struct options *opt)
 {
 	char option;
-	const char *option_string = "d:i:h";
+	const char *option_string = "d:i:p:h";
 
 	while ((option = getopt(argc, argv, option_string)) != EOF) {
 		switch (option) {
@@ -168,6 +181,9 @@ void parse_option(int argc, char *argv[], struct options *opt)
 		case 'i':
 			opt->interval = atoi(optarg);
 			break;
+		case 'p':
+			strcpy(opt->partname, basename(optarg));
+			break;
 		default:
 			usage();
 			break;
@@ -188,6 +204,7 @@ int main(int argc, char *argv[])
 	struct options opt = {
 		.delay = 1,
 		.interval = 20,
+		.partname = { 0, },
 	};
 
 	parse_option(argc, argv, &opt);
@@ -200,7 +217,7 @@ int main(int argc, char *argv[])
 			head_interval = opt.interval;
 		}
 
-		f2fstat();
+		f2fstat(&opt);
 
 		printf(format, util, used_node_blks, used_data_blks,
 				free_segs, valid_segs, dirty_segs, prefree_segs,
-- 
1.7.10.4


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
