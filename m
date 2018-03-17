From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 1/4] mkfs.f2fs: update extension lists
Date: Sun, 18 Mar 2018 00:02:54 +0900
Message-ID: <20180317150257.123927-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exDNj-00061e-5k
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:27 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pf0-f195.google.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exDNX-00BvTe-LN
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:27 +0000
Received: by mail-pf0-f195.google.com with SMTP id 68so5330630pfx.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Mar 2018 08:04:15 -0700 (PDT)
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

Those formats are large in size and rarely updated.

Formats such as tar and zip were intentionally excluded as
those are capable of random updates.

(Added from vlc, p7zip and running
'find . -type f -size +1M |
    while read FILE; do echo ${FILE##*.}; done |
    sort | uniq -c | sort -nr'
manually)

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 86 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 65692bb..3c7ce16 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -37,34 +37,76 @@ struct f2fs_checkpoint *cp;
 
 static unsigned int quotatype_bits = 0;
 
-const char *media_ext_lists[] = {
-	"jpg",
-	"gif",
-	"png",
+const char *cold_ext_lists[] = {
+	/* video */
 	"avi",
 	"divx",
-	"mp4",
-	"mp3",
-	"3gp",
-	"wmv",
-	"wma",
-	"mpeg",
+	"flv",
+	"m2ts",
+	"m4p",
+	"m4v",
 	"mkv",
 	"mov",
-	"asx",
-	"asf",
-	"wmx",
-	"svi",
-	"wvx",
-	"wm",
+	"mp4",
+	"mpeg",
+	"mpeg4",
 	"mpg",
-	"mpe",
-	"rm",
 	"ogg",
+	"ogm",
+	"ogv",
+	"ts",
+	"vob",
+	"wmb",
+	"wmv",
+	"webm",
+
+	/* audio */
+	"aac",
+	"ac3",
+	"dts",
+	"flac",
+	"m4a",
+	"mka",
+	"mp3",
+	"oga",
+	"wav",
+	"wma",
+
+	/* image */
+	"bmp",
+	"gif",
+	"jpg",
 	"jpeg",
-	"video",
-	"apk",	/* for android system */
-	"so",	/* for android system */
+	"png",
+	"svg",
+	"webp",
+
+	/* archive */
+	"7z",
+	"a",
+	"deb",
+	"gz",
+	"gzip",
+	"iso",
+	"jar",
+	"lzma",
+	"rar",
+	"tgz",
+	"txz",
+	"udf",
+	"xz",
+
+	/* other */
+	"pdf",
+	"ttf",
+	"ttc",
+
+	/* android */
+	"apk",
+	"exo", // YouTube
+	"odex", // Android RunTime
+	"vdex", // Android RunTime
+	"so",
 	NULL
 };
 
@@ -74,7 +116,7 @@ const char *hot_ext_lists[] = {
 };
 
 const char **default_ext_list[] = {
-	media_ext_lists,
+	cold_ext_lists,
 	hot_ext_lists
 };
 
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
