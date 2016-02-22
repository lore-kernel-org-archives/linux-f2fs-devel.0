From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: check /proc/mounts first to detect
	readonly
Date: Mon, 22 Feb 2016 09:22:52 -0800
Message-ID: <1456161772-14366-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aXuCF-00029a-7I
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 17:22:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aXuCE-0000St-6q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 17:22:55 +0000
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

Once f2fs_stop_checkpoint makes f2fs as readonly, only /proc/mounts shows
RDONLY whereas /etc/mtab does not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index d61eb85..5eb5c33 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -530,17 +530,17 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 	struct stat st_buf;
 	int ret = 0;
 
-	ret = is_mounted(MOUNTED, c->device_name);
+	/*
+	 * try with /proc/mounts fist to detect RDONLY.
+	 * f2fs_stop_checkpoint makes RO in /proc/mounts while RW in /etc/mtab.
+	 */
+	ret = is_mounted("/proc/mounts", c->device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
 	}
 
-	/*
-	 * if failed due to /etc/mtab file not present
-	 * try with /proc/mounts.
-	 */
-	ret = is_mounted("/proc/mounts", c->device_name);
+	ret = is_mounted(MOUNTED, c->device_name);
 	if (ret) {
 		MSG(0, "Info: Mounted device!\n");
 		return -1;
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
