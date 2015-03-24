From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] mkfs.f2fs: add quite mode, -q
Date: Tue, 24 Mar 2015 00:37:03 -0700
Message-ID: <1427182624-40539-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YaJOk-0000CP-7B
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 07:37:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YaJOi-0003kB-DP for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 07:37:14 +0000
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

This patch add a quite mode as -q.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_main.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index aefe9fc..9a96798 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -33,6 +33,7 @@ static void mkfs_usage()
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -l label\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
+	MSG(0, "  -q quiet mode\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
@@ -40,25 +41,44 @@ static void mkfs_usage()
 	exit(1);
 }
 
+static void f2fs_show_info()
+{
+	MSG(0, "\n\tF2FS-tools: mkfs.f2fs Ver: %s (%s)\n\n",
+				F2FS_TOOLS_VERSION,
+				F2FS_TOOLS_DATE);
+	if (config.heap == 0)
+		MSG(0, "Info: Disable heap-based policy\n");
+
+	MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
+	if (config.extension_list)
+		MSG(0, "Info: Add new extension list\n");
+
+	if (config.vol_label)
+		MSG(0, "Info: Label = %s\n", config.vol_label);
+	MSG(0, "Info: Overprovision ratio = %u%%\n", config.overprovision);
+	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
+	MSG(0, "Info: Sections per zone = %d\n", config.secs_per_zone);
+	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
+}
+
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "a:d:e:l:o:s:z:t:";
+	static const char *option_string = "qa:d:e:l:o:s:z:t:";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
 		switch (option) {
+		case 'q':
+			config.dbg_lv = -1;
+			break;
 		case 'a':
 			config.heap = atoi(optarg);
-			if (config.heap == 0)
-				MSG(0, "Info: Disable heap-based policy\n");
 			break;
 		case 'd':
 			config.dbg_lv = atoi(optarg);
-			MSG(0, "Info: Debug level = %d\n", config.dbg_lv);
 			break;
 		case 'e':
 			config.extension_list = strdup(optarg);
-			MSG(0, "Info: Add new extension list\n");
 			break;
 		case 'l':		/*v: volume label */
 			if (strlen(optarg) > 512) {
@@ -67,25 +87,18 @@ static void f2fs_parse_options(int argc, char *argv[])
 				mkfs_usage();
 			}
 			config.vol_label = optarg;
-			MSG(0, "Info: Label = %s\n", config.vol_label);
 			break;
 		case 'o':
 			config.overprovision = atoi(optarg);
-			MSG(0, "Info: Overprovision ratio = %u%%\n",
-								atoi(optarg));
 			break;
 		case 's':
 			config.segs_per_sec = atoi(optarg);
-			MSG(0, "Info: Segments per section = %d\n",
-								atoi(optarg));
 			break;
 		case 'z':
 			config.secs_per_zone = atoi(optarg);
-			MSG(0, "Info: Sections per zone = %d\n", atoi(optarg));
 			break;
 		case 't':
 			config.trim = atoi(optarg);
-			MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
 			break;
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
@@ -116,13 +129,12 @@ static void f2fs_parse_options(int argc, char *argv[])
 
 int main(int argc, char *argv[])
 {
-	MSG(0, "\n\tF2FS-tools: mkfs.f2fs Ver: %s (%s)\n\n",
-				F2FS_TOOLS_VERSION,
-				F2FS_TOOLS_DATE);
 	f2fs_init_configuration(&config);
 
 	f2fs_parse_options(argc, argv);
 
+	f2fs_show_info();
+
 	if (f2fs_dev_is_umounted(&config) < 0)
 		return -1;
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
