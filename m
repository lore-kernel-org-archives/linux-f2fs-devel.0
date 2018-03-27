From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Tue, 27 Mar 2018 10:19:08 -0700
Message-ID: <20180327171908.15092-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f0sFn-0003Mo-FZ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Mar 2018 17:19:23 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f0sFl-00ACgQ-Mh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Mar 2018 17:19:23 +0000
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
Cc: katao <katao@xiaomi.com>, Jaegeuk Kim <jaegeuk@google.com>

From: katao <katao@xiaomi.com>

The args of wanted_total_sectors is calculated based
on the DEFAULT_SECTOR_SIZE(512Bytes).get_device_info(i)
may be reset dev_sector_size, we should reset the number
of wanted_total_sectors.

This bug was reported to Google Issue Tracker.
Link: https://issuetracker.google.com/issues/76407663

Signed-off-by: katao <katao@xiaomi.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 lib/libf2fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 0c684d5..5f11796 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -799,8 +799,15 @@ int get_device_info(int i)
 #ifdef BLKSSZGET
 		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
 			MSG(0, "\tError: Using the default sector size\n");
-		else if (dev->sector_size < sector_size)
+		else if (dev->sector_size < sector_size){
+			/*
+			 * wanted_total_sectors need to be reset by new
+			 * sector_size.
+			 */
+			c.wanted_total_sectors = (c.wanted_total_sectors *
+						dev->sector_size) / sector_size;
 			dev->sector_size = sector_size;
+		}
 #endif
 #ifdef BLKGETSIZE64
 		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
