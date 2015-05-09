From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] mkfs.f2fs: set encryption feature
Date: Fri,  8 May 2015 21:24:37 -0700
Message-ID: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwK0-0007nw-Uw
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwK0-0003wy-0H for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:04 +0000
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

This patch add to support encryption feature.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h       |  7 +++++++
 mkfs/f2fs_format.c      |  2 ++
 mkfs/f2fs_format_main.c | 16 +++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d23ae1b..6aefa5d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -251,6 +251,7 @@ struct f2fs_configuration {
 	int fix_on;
 	int bug_on;
 	int auto_fix;
+	__le32 feature;			/* defined features */
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -315,6 +316,8 @@ enum {
 #define MAX_ACTIVE_NODE_LOGS	8
 #define MAX_ACTIVE_DATA_LOGS	8
 
+#define F2FS_FEATURE_ENCRYPT	0x0001
+
 /*
  * For superblock
  */
@@ -353,6 +356,10 @@ struct f2fs_super_block {
 	__le32 cp_payload;
 	__u8 version[VERSION_LEN];	/* the kernel version */
 	__u8 init_version[VERSION_LEN];	/* the initial kernel version */
+	__le32 feature;			/* defined features */
+	__u8 encryption_level;		/* versioning level for encryption */
+	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
+	__u8 reserved[871];		/* valid reserved region */
 } __attribute__((packed));
 
 /*
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 094afa3..f879bca 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -364,6 +364,8 @@ static int f2fs_prepare_super_block(void)
 	memcpy(sb.version, config.version, VERSION_LEN);
 	memcpy(sb.init_version, config.version, VERSION_LEN);
 
+	sb.feature = config.feature;
+
 	return 0;
 }
 
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 9a96798..5a9e7e2 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -33,6 +33,7 @@ static void mkfs_usage()
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -l label\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
+	MSG(0, "  -O set feature\n");
 	MSG(0, "  -q quiet mode\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
@@ -61,9 +62,19 @@ static void f2fs_show_info()
 	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
 }
 
+static void parse_feature(char *features)
+{
+	if (!strcmp(features, "encrypt")) {
+		config.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
+	} else {
+		MSG(0, "Error: Wrong features\n");
+		mkfs_usage();
+	}
+}
+
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:d:e:l:o:s:z:t:";
+	static const char *option_string = "qa:d:e:l:o:O:s:z:t:";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -91,6 +102,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'o':
 			config.overprovision = atoi(optarg);
 			break;
+		case 'O':
+			parse_feature(strdup(optarg));
+			break;
 		case 's':
 			config.segs_per_sec = atoi(optarg);
 			break;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
