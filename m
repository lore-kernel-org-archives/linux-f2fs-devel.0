From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] mkfs.f2fs: avoid build warning
Date: Wed, 15 Oct 2014 20:59:08 -0700
Message-ID: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XecDi-0003Wo-2X
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:22 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XecDh-000405-0a for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:22 +0000
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

Avoid build warning for printf.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 19c52e4..e1f7c69 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -103,7 +103,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 	if ((optind + 1) < argc) {
 		/* We have a sector count. */
 		config.total_sectors = atoll(argv[optind+1]);
-		MSG(0, "\ttotal_sectors=%lu (%s bytes)\n", config.total_sectors, argv[optind+1]);
+		MSG(0, "\ttotal_sectors=%08"PRIx64" (%s bytes)\n",
+				config.total_sectors, argv[optind+1]);
 	}
 
 	config.reserved_segments  =
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
