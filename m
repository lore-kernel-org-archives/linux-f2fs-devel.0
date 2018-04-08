From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH v3] mkfs.f2fs: support multiple features with one
 "-O"
Date: Sun, 8 Apr 2018 12:09:13 +0800
Message-ID: <20180408040913.37635-1-zhengjunling@huawei.com>
References: <20180403093845.68535-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1f51e2-0008JN-LD
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 04:09:34 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f51dy-00F0hA-JD
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 04:09:34 +0000
In-Reply-To: <20180403093845.68535-1-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Now one "-O" option can support multiple features separated
by a comma or blank, such as:
feature1,feature2,... or "feature1 feature2 ..."

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
Changes from v1:
 - free buf to fix memory leak.
Changes from v2:
 - modify usage and man page to show this feature.
 man/mkfs.f2fs.8         |  3 ++-
 mkfs/f2fs_format_main.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 442c0ea..29dd68f 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -112,7 +112,8 @@ is hidden to users, and utilized by F2FS cleaner. If not specified, the best
 number will be assigned automatically accoring to the partition size.
 .TP
 .BI \-O " feature-list"
-Specify a feature list in order f2fs filesystem will supports.
+Specify a feature list like feature1[feature2,feature3,...] in order f2fs
+filesystem will supports.
 e.g "encrypt" and so on.
 .TP
 .BI \-q
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 449a0ed..a6e4474 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -51,7 +51,7 @@ static void mkfs_usage()
 	MSG(0, "  -l label\n");
 	MSG(0, "  -m support zoned block device [default:0]\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
-	MSG(0, "  -O [feature list] e.g. \"encrypt\"\n");
+	MSG(0, "  -O feature1[feature2,feature3,...] e.g. \"encrypt\"\n");
 	MSG(0, "  -q quiet mode\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -S sparse mode\n");
@@ -81,10 +81,8 @@ static void f2fs_show_info()
 	MSG(0, "Info: Trim is %s\n", c.trim ? "enabled": "disabled");
 }
 
-static void parse_feature(const char *features)
+static void set_feature_bits(char *features)
 {
-	while (*features == ' ')
-		features++;
 	if (!strcmp(features, "encrypt")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
 	} else if (!strcmp(features, "verity")) {
@@ -109,6 +107,33 @@ static void parse_feature(const char *features)
 	}
 }
 
+static void parse_feature(const char *features)
+{
+	char *buf, *sub, *next;
+
+	buf = calloc(strlen(features) + 1, sizeof(char));
+	ASSERT(buf);
+	strncpy(buf, features, strlen(features) + 1);
+
+	for (sub = buf; sub && *sub; sub = next ? next + 1 : NULL) {
+		/* Skip the beginning blanks */
+		while (*sub && *sub == ' ')
+			sub++;
+		next = sub;
+		/* Skip a feature word */
+		while (*next && *next != ' ' && *next != ',')
+			next++;
+
+		if (*next == 0)
+			next = NULL;
+		else
+			*next = 0;
+
+		set_feature_bits(sub);
+	}
+	free(buf);
+}
+
 static void f2fs_parse_options(int argc, char *argv[])
 {
 	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:fw:";
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
