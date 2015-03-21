From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] mkfs.f2fs: show bytes for total_sectors
Date: Fri, 20 Mar 2015 23:06:29 -0700
Message-ID: <1426917991-25128-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YZCYY-0005yx-Fs
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YZCYX-0001Nv-FA for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Mar 2015 06:06:46 +0000
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

This patch shows correct information about total_sectors.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c           | 4 ++--
 mkfs/f2fs_format_main.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 9e19e9b..7fd2550 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -497,8 +497,8 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 
 	}
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
-	MSG(0, "Info: total sectors = %"PRIu64" (in %u bytes)\n",
-					c->total_sectors, c->sector_size);
+	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
+				c->total_sectors, c->total_sectors >> 11);
 	if (c->total_sectors <
 			(F2FS_MIN_VOLUME_SIZE / c->sector_size)) {
 		MSG(0, "Error: Min volume size supported is %d\n",
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index bba2085..aefe9fc 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -103,8 +103,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 	if ((optind + 1) < argc) {
 		/* We have a sector count. */
 		config.total_sectors = atoll(argv[optind+1]);
-		MSG(0, "\ttotal_sectors=%08"PRIx64" (%s bytes)\n",
-				config.total_sectors, argv[optind+1]);
+		MSG(1, "\ttotal_sectors=%"PRIx64" (%"PRIx64" bytes)\n",
+				config.total_sectors,
+				config.total_sectors * 512);
 	}
 
 	config.reserved_segments  =
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
