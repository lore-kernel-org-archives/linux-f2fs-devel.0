From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] mkfs.f2fs: check the c.overprovision with zero
 before using it
Date: Mon, 6 Feb 2017 17:58:43 +0800
Message-ID: <46c484c4-4f58-fc15-d57b-80d795307e0a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cag4b-00017A-BM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Feb 2017 09:59:01 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cag4a-0006WG-M6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Feb 2017 09:59:01 +0000
Received: by mail-it0-f67.google.com with SMTP id 203so8087122ith.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 06 Feb 2017 01:59:00 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

The using of c.overprovision when it equal zero as, 

        c.reserved_segments =
                        (2 * (100 / c.overprovision + 1) + 6)
                        * c.segs_per_sec;

may cause problem, although it doesn't happen.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 mkfs/f2fs_format.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 3c13026..2e0a4e5 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -337,10 +337,6 @@ static int f2fs_prepare_super_block(void)
 	if (c.overprovision == 0)
 		c.overprovision = get_best_overprovision(sb);
 
-	c.reserved_segments =
-			(2 * (100 / c.overprovision + 1) + 6)
-			* c.segs_per_sec;
-
 	if (c.overprovision == 0 || c.total_segments < F2FS_MIN_SEGMENTS ||
 		(c.devices[0].total_sectors *
 			c.sector_size < zone_align_start_offset) ||
@@ -349,6 +345,10 @@ static int f2fs_prepare_super_block(void)
 		return -1;
 	}
 
+	c.reserved_segments =
+			(2 * (100 / c.overprovision + 1) + 6)
+			* c.segs_per_sec;
+
 	uuid_generate(sb->uuid);
 
 	utf8_to_utf16(sb->volume_name, (const char *)c.vol_label,
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
