From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] libf2fs: avoid overwrite the c.start_sector by
 non-root device
Date: Sat, 18 Mar 2017 16:00:10 +0800
Message-ID: <3fb23e18-0ded-9126-04f0-02568771b0fa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cp9Hj-0008QU-T6
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 08:00:23 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cp9Hj-0004Ns-4x
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Mar 2017 08:00:23 +0000
Received: by mail-it0-f66.google.com with SMTP id u69so8015938ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 18 Mar 2017 01:00:23 -0700 (PDT)
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

For multiple devices, the c.start_sector will be overwrite by the non-root devices.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 lib/libf2fs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 93d3da9..bb32df8 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -730,10 +730,12 @@ int get_device_info(int i)
 #endif
 		dev->total_sectors /= dev->sector_size;
 
-		if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
-			c.start_sector = 0;
-		else
-			c.start_sector = geom.start;
+		if (i == 0) {
+			if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
+				c.start_sector = 0;
+			else
+				c.start_sector = geom.start;
+		}
 
 #ifndef WITH_ANDROID
 		/* Send INQUIRY command */
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
