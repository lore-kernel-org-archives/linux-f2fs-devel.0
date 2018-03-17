From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 4/4] mkfs.f2fs: print the default list if no
 argument is given to -e and -E
Date: Sun, 18 Mar 2018 00:02:57 +0900
Message-ID: <20180317150257.123927-4-qkrwngud825@gmail.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exDNj-0001IT-Vc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:27 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pl0-f65.google.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exDNc-00BvTz-7Y
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:27 +0000
Received: by mail-pl0-f65.google.com with SMTP id b7-v6so3500727plr.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Mar 2018 08:04:20 -0700 (PDT)
In-Reply-To: <20180317150257.123927-1-qkrwngud825@gmail.com>
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

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c       | 29 +++++++++++++++++++++++++++++
 mkfs/f2fs_format_main.c  |  7 ++++++-
 mkfs/f2fs_format_utils.h |  1 +
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 10ccca0..aa372ca 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -111,6 +111,35 @@ const char **default_ext_list[] = {
 	hot_ext_lists
 };
 
+void f2fs_list_extensions(void)
+{
+	int i;
+	const char **extlist;
+
+	MSG(0, "Listing default extensions for storing in cold mode\n\n");
+
+	extlist = cold_ext_lists;
+	for (i = 0; *(extlist + i); i++) {
+		printf("%4s, ", *(extlist + i));
+		if ((i + 1) % 8 == 0)
+			printf("\n");
+	}
+
+	printf("\n\n");
+	MSG(0, "Listing default extensions for storing in hot mode\n\n");
+
+	extlist = hot_ext_lists;
+	for (i = 0; *(extlist + i); i++) {
+		printf("%4s, ", *(extlist + i));
+		if ((i + 1) % 8 == 0)
+			printf("\n");
+	}
+
+	printf("\n\n");
+
+	exit(0);
+}
+
 static bool is_extension_exist(const char *name)
 {
 	int i;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index f23fd84..56ca741 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -46,6 +46,7 @@ static void mkfs_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
+	MSG(0, "     If no list is given, the default list will be printed\n");
 	MSG(0, "  -f force overwrite the exist filesystem\n");
 	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -l label\n");
@@ -108,7 +109,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:f";
+	static const char *option_string = "qa:c:d:eEil:mo:O:s:S:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -136,9 +137,13 @@ static void f2fs_parse_options(int argc, char *argv[])
 			c.dbg_lv = atoi(optarg);
 			break;
 		case 'e':
+			if (!optarg)
+				f2fs_list_extensions();
 			c.extension_list[0] = strdup(optarg);
 			break;
 		case 'E':
+			if (!optarg)
+				f2fs_list_extensions();
 			c.extension_list[1] = strdup(optarg);
 			break;
 		case 'i':
diff --git a/mkfs/f2fs_format_utils.h b/mkfs/f2fs_format_utils.h
index 274db7b..4246c3f 100644
--- a/mkfs/f2fs_format_utils.h
+++ b/mkfs/f2fs_format_utils.h
@@ -12,6 +12,7 @@
 
 extern struct f2fs_configuration c;
 
+void f2fs_list_extensions(void);
 int f2fs_trim_device(int, u_int64_t);
 int f2fs_trim_devices(void);
 int f2fs_format_device(void);
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
