From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 2/2] mkfs.f2fs: tell users if the label is empty
Date: Sun, 18 Mar 2018 00:04:47 +0900
Message-ID: <20180317150447.124186-2-qkrwngud825@gmail.com>
References: <20180317150447.124186-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exDOL-0000E4-V2
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:05:05 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pf0-f194.google.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exDOK-00Bncg-BP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 17 Mar 2018 15:05:05 +0000
Received: by mail-pf0-f194.google.com with SMTP id u5so5328476pfh.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Mar 2018 08:05:04 -0700 (PDT)
In-Reply-To: <20180317150447.124186-1-qkrwngud825@gmail.com>
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

Previous code didn't cover cases where c.vol_label was
actually initialized with an empty string

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 3fffec8..94a2a53 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -76,8 +76,11 @@ static void f2fs_show_info()
 	if (c.extension_list[1])
 		INFO_MSG("Adding new hot file extension list\n");
 
-	if (c.vol_label)
-		INFO_MSG("Label = %s\n", c.vol_label);
+	INFO_MSG("Label = ");
+	if (c.vol_label && c.vol_label[0] != '\0')
+		MSG(0, "%s\n", c.vol_label);
+	else
+		MSG(0, "(empty)\n");
 	INFO_MSG("%s trim\n", c.trim ? "Enabling": "Disabling");
 }
 
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
