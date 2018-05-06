From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] libf2fs: quote non-printables when displaying
 "disk model"
Date: Mon,  7 May 2018 00:50:14 +0200
Message-ID: <20180506225014.28201-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kilobyte@angband.pl>) id 1fFSmM-0003PL-KZ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 06 May 2018 23:09:18 +0000
Received: from tartarus.angband.pl ([89.206.35.136])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFSmK-009Vh9-5H
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 06 May 2018 23:09:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: Adam Borowski <kilobyte@angband.pl>

One offender I own has:
STORAGE DEVICE  1404x05xe3x07QGENEx00%x00x00x00x00x00x00x00x00x00x00x00x00x170x04

I limited it to pure ASCII only, but you might want to allow high-bit bytes,
either validating UTF-8 or assuming that mojibake is not as bad as beep and
zeroes as in the above example.  Or, cutting off at the first control
character might be a good alternative too.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 lib/libf2fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5ef0214..8782afc 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -884,8 +884,9 @@ int get_device_info(int i)
 
 			MSG(0, "Info: [%s] Disk Model: ",
 					dev->path);
-			while (reply_buffer[i] != '`' && i < 80)
-				printf("%c", reply_buffer[i++]);
+			for (; reply_buffer[i] != '`' && i < 80; i++)
+				printf((reply_buffer[i] >= ' ' && reply_buffer[i] < 127) ?
+				       "%c" : "x%02x", reply_buffer[i]);
 			printf("\n");
 		}
 #endif
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
