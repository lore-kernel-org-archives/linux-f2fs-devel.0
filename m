From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] mkfs.f2fs: Add several media formats + exe
Date: Sat, 14 Jul 2018 11:08:05 -0700
Message-ID: <20180714180805.11633-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rosenp@gmail.com>) id 1feOxr-0004fv-V3
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Jul 2018 18:08:16 +0000
Received: from mail-pl0-f67.google.com ([209.85.160.67])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1feOxo-003QQA-R1
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Jul 2018 18:08:14 +0000
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so3153443plk.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 14 Jul 2018 11:08:12 -0700 (PDT)
Received: from clevo-mangix.lan (astound-69-42-1-138.ca.astound.net.
 [69.42.1.138])
 by smtp.gmail.com with ESMTPSA id f19-v6sm35026509pfd.147.2018.07.14.11.08.06
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Jul 2018 11:08:06 -0700 (PDT)
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

These media formats are currently in use.

exe is useful if storing various Windows utilities on the drive.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 mkfs/f2fs_format.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 1a2deae..5245d68 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -43,6 +43,9 @@ const char *media_ext_lists[] = {
 	"png",
 	"avi",
 	"divx",
+	"m4a",
+	"m4v",
+	"m4p",
 	"mp4",
 	"mp3",
 	"3gp",
@@ -56,15 +59,19 @@ const char *media_ext_lists[] = {
 	"wmx",
 	"svi",
 	"wvx",
+	"wv",
 	"wm",
 	"mpg",
 	"mpe",
 	"rm",
 	"ogg",
+	"opus",
+	"flac",
 	"jpeg",
 	"video",
 	"apk",	/* for android system */
 	"so",	/* for android system */
+	"exe",
 	NULL
 };
 
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
