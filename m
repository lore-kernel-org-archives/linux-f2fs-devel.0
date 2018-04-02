From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] mkfs.f2fs: support multiple features with one
 "-O"
Date: Mon, 2 Apr 2018 12:19:15 +0800
Message-ID: <20180402041915.168646-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1f2qwa-0003Jb-AK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Apr 2018 04:19:44 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f2qwW-008gQs-4L
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Apr 2018 04:19:44 +0000
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
---
 mkfs/f2fs_format_main.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 741600e..76ff296 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -80,10 +80,8 @@ static void f2fs_show_info()
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
@@ -108,6 +106,32 @@ static void parse_feature(const char *features)
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
+}
+
 static void f2fs_parse_options(int argc, char *argv[])
 {
 	static const char *option_string = "qa:c:d:e:E:il:mo:O:s:S:z:t:f";
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
