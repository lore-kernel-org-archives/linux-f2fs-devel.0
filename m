From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 2/4] mkfs.f2fs: commonize extensions by prefix
Date: Sun, 18 Mar 2018 00:02:55 +0900
Message-ID: <20180317150257.123927-2-qkrwngud825@gmail.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exDNk-0000CK-Lg
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:28 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pf0-f196.google.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exDNZ-00BvTo-4v
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:04:28 +0000
Received: by mail-pf0-f196.google.com with SMTP id u5so5328046pfh.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Mar 2018 08:04:17 -0700 (PDT)
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

.m4* and .mk* were left untouched as
other file types are commonly used by GNU Make.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3c7ce16..47834a6 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -47,17 +47,8 @@ const char *cold_ext_lists[] = {
 	"m4v",
 	"mkv",
 	"mov",
-	"mp4",
-	"mpeg",
-	"mpeg4",
-	"mpg",
-	"ogg",
-	"ogm",
-	"ogv",
 	"ts",
 	"vob",
-	"wmb",
-	"wmv",
 	"webm",
 
 	/* audio */
@@ -67,16 +58,11 @@ const char *cold_ext_lists[] = {
 	"flac",
 	"m4a",
 	"mka",
-	"mp3",
-	"oga",
 	"wav",
-	"wma",
 
 	/* image */
 	"bmp",
 	"gif",
-	"jpg",
-	"jpeg",
 	"png",
 	"svg",
 	"webp",
@@ -86,7 +72,6 @@ const char *cold_ext_lists[] = {
 	"a",
 	"deb",
 	"gz",
-	"gzip",
 	"iso",
 	"jar",
 	"lzma",
@@ -101,6 +86,12 @@ const char *cold_ext_lists[] = {
 	"ttf",
 	"ttc",
 
+	/* common prefix */
+	"jp", // Covers jpg, jpeg, jp2
+	"mp", // Covers mp3, mp4, mpeg, mpg
+	"og", // Covers oga, ogg, ogm, ogv
+	"wm", // Covers wma, wmb, wmv
+
 	/* android */
 	"apk",
 	"exo", // YouTube
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
