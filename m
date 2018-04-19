From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: add -g to give default options
Date: Thu, 19 Apr 2018 11:34:54 -0700
Message-ID: <20180419183454.94690-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f9EOh-0005kv-KO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 18:35:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9EOf-002ZP0-G1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 18:35:07 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds -g option to set default options for specific environment.
I added it for android as a example.

 # mkfs.f2fs -g android $dev
  : gives "-d1 -f -O encrypt -O quota -w 4096"

 # fsck.f2fs -g android $dev
  : gives "-a"

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c             | 31 ++++++++++++++++++++++++++++++-
 include/f2fs_fs.h       |  6 ++++++
 mkfs/f2fs_format_main.c | 26 +++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ca3b789..9256d21 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -53,6 +53,7 @@ void fsck_usage()
 	MSG(0, "  -a check/fix potential corruption, reported by f2fs\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
+	MSG(0, "  -g add default options\n");
 	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
 	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -t show directory tree\n");
@@ -145,6 +146,20 @@ static void error_out(char *prog)
 		MSG(0, "\nWrong program.\n");
 }
 
+static void __add_fsck_options(void)
+{
+	/* -a */
+	c.auto_fix = 1;
+}
+
+static void add_default_options(void)
+{
+	switch (c.defset) {
+	case CONF_ANDROID:
+		__add_fsck_options();
+	}
+}
+
 void f2fs_parse_options(int argc, char *argv[])
 {
 	int option = 0;
@@ -165,7 +180,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":ad:fp:q:StyV";
+		const char *option_string = ":ad:fg:p:q:StyV";
 		int opt = 0;
 		struct option long_opt[] = {
 			{"dry-run", no_argument, 0, 1},
@@ -184,6 +199,10 @@ void f2fs_parse_options(int argc, char *argv[])
 				c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption.\n");
 				break;
+			case 'g':
+				if (!strcmp(optarg, "android"))
+					c.defset = CONF_ANDROID;
+				break;
 			case 'p':
 				/* preen mode has different levels:
 				 *  0: default level, the same as -a
@@ -284,6 +303,14 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Debug level = %d\n",
 							c.dbg_lv);
 				break;
+			case 'g':
+				if (!strcmp(optarg, "android")) {
+					c.defset = CONF_ANDROID;
+					MSG(0, "Info: Set conf for android\n");
+					break;
+				}
+				err = EWRONG_OPT;
+				break;
 			case 'i':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%d",
@@ -496,6 +523,8 @@ void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
+	add_default_options();
+
 	if (optind >= argc) {
 		MSG(0, "\tError: Device not specified\n");
 		error_out(prog);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index cbfdab5..54ac1c8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -303,6 +303,11 @@ enum f2fs_config_func {
 	SLOAD,
 };
 
+enum default_set {
+	CONF_NONE = 0,
+	CONF_ANDROID,
+};
+
 struct device_info {
 	char *path;
 	int32_t fd;
@@ -361,6 +366,7 @@ struct f2fs_configuration {
 	void *private;
 	int dry_run;
 	int fix_on;
+	int defset;
 	int bug_on;
 	int auto_fix;
 	int preen_mode;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 7dd4054..4e39fbd 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -65,6 +65,7 @@ static void mkfs_usage()
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
 	MSG(0, "  -f force overwrite the exist filesystem\n");
+	MSG(0, "  -g add default options\n");
 	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -l label\n");
 	MSG(0, "  -m support zoned block device [default:0]\n");
@@ -98,6 +99,9 @@ static void f2fs_show_info()
 	if (c.vol_label)
 		MSG(0, "Info: Label = %s\n", c.vol_label);
 	MSG(0, "Info: Trim is %s\n", c.trim ? "enabled": "disabled");
+
+	if (c.defset == CONF_ANDROID)
+		MSG(0, "Info: Set conf for android\n");
 }
 
 static inline u32 feature_map(char *feature)
@@ -146,9 +150,23 @@ static void parse_feature(const char *features)
 	free(buf);
 }
 
+static void add_default_options(void)
+{
+	switch (c.defset) {
+	case CONF_ANDROID:
+		/* -d1 -f -O encrypt -O quota -w 4096 */
+		c.dbg_lv = 1;
+		force_overwrite = 1;
+		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
+		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
+		c.wanted_sector_size = 4096;
+		break;
+	}
+}
+
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:V";
+	static const char *option_string = "qa:c:d:e:E:g:il:mo:O:s:S:z:t:fw:V";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -181,6 +199,10 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'E':
 			c.extension_list[1] = strdup(optarg);
 			break;
+		case 'g':
+			if (!strcmp(optarg, "android"))
+				c.defset = CONF_ANDROID;
+			break;
 		case 'i':
 			c.large_nat_bitmap = 1;
 			break;
@@ -231,6 +253,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
+	add_default_options();
+
 	if (!(c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR))) {
 		if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
 			MSG(0, "\tInfo: project quota feature should always been"
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
