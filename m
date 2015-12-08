From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: show correct partition size
Date: Tue,  8 Dec 2015 13:15:48 -0800
Message-ID: <1449609348-10782-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a6Pc5-0001Fn-JG
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:15:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a6Pc4-00066v-Kl for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:15:57 +0000
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

It needs to consider different sector size when showing the total
size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c           | 3 ++-
 mkfs/f2fs_format_main.c | 7 +------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 32e0651..0ac9994 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -503,7 +503,8 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	}
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
-				c->total_sectors, c->total_sectors >> 11);
+				c->total_sectors, (c->total_sectors *
+					(c->sector_size >> 9)) >> 11);
 	return 0;
 }
 
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 0eee81a..243f0e9 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -126,13 +126,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 	}
 	config.device_name = argv[optind];
 
-	if ((optind + 1) < argc) {
-		/* We have a sector count. */
+	if ((optind + 1) < argc)
 		config.total_sectors = atoll(argv[optind+1]);
-		MSG(1, "\ttotal_sectors=%"PRIx64" (%"PRIx64" bytes)\n",
-				config.total_sectors,
-				config.total_sectors * 512);
-	}
 	config.segs_per_zone = config.segs_per_sec * config.secs_per_zone;
 }
 
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
