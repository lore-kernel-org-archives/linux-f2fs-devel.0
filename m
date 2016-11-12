From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: initialize and avoid build warning
	for android
Date: Fri, 11 Nov 2016 18:23:24 -0800
Message-ID: <20161112022324.9060-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c5Nyg-0003ym-U7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 02:23:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c5Nyg-0003q0-1n
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Nov 2016 02:23:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch initialize one variable for android build.
In addition, it avoids there-in build warnings.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c       | 1 +
 lib/libf2fs_zoned.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 74d4d82..93d3da9 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -556,6 +556,7 @@ void f2fs_init_configuration(void)
 
 	for (i = 0; i < MAX_DEVICES; i++) {
 		memset(&c.devices[i], 0, sizeof(struct device_info));
+		c.devices[i].fd = -1;
 		c.devices[i].sector_size = DEFAULT_SECTOR_SIZE;
 		c.devices[i].end_blkaddr = -1;
 		c.devices[i].zoned_model = F2FS_ZONED_NONE;
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 3c2186a..eebf030 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -296,13 +296,13 @@ int f2fs_get_zone_blocks(int i)
 
 int f2fs_check_zones(int i)
 {
-	ERR_MSG("Zoned block devices are not supported\n");
+	ERR_MSG("%d: Zoned block devices are not supported\n", i);
 	return -1;
 }
 
 int f2fs_reset_zones(int i)
 {
-	ERR_MSG("Zoned block devices are not supported\n");
+	ERR_MSG("%d: Zoned block devices are not supported\n", i);
 	return -1;
 }
 
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
