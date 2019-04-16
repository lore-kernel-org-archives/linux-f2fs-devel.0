From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 1/2] mkfs.f2fs: make extensions list easier to
 read
Date: Tue, 16 Apr 2019 15:43:54 +0900
Message-ID: <20190416064355.29712-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGHpJ-0003WY-0H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 06:44:17 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGHpH-008Elz-PG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 06:44:16 +0000
Received: by mail-pf1-f195.google.com with SMTP id z5so9890984pfn.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 23:44:15 -0700 (PDT)
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

Reorder the list and categorize.
No functional change introduced.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a2685cb..0ae0df3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -38,19 +38,13 @@ struct f2fs_checkpoint *cp;
 static unsigned int quotatype_bits = 0;
 
 const char *media_ext_lists[] = {
-	"jpg",
-	"gif",
-	"png",
+	/* video */
 	"avi",
 	"divx",
-	"m4a",
 	"m4v",
 	"m4p",
 	"mp4",
-	"mp3",
-	"3gp",
 	"wmv",
-	"wma",
 	"mpeg",
 	"mkv",
 	"mov",
@@ -59,19 +53,35 @@ const char *media_ext_lists[] = {
 	"wmx",
 	"svi",
 	"wvx",
-	"wv",
 	"wm",
 	"mpg",
 	"mpe",
 	"rm",
+	"video",
+
+	/* audio */
+	"m4a",
+	"mp3",
+	"3gp",
+	"wma",
+	"wv",
 	"ogg",
 	"opus",
 	"flac",
+
+	/* image */
 	"jpeg",
-	"video",
-	"apk",	/* for android system */
-	"so",	/* for android system */
+	"jpg",
+	"gif",
+	"png",
+
+	/* other */
 	"exe",
+
+	/* android */
+	"apk",
+	"so",
+
 	NULL
 };
 
-- 
2.21.0
