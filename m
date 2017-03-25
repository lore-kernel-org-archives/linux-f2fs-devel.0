From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: use noheap by default
Date: Sat, 25 Mar 2017 00:59:58 -0700
Message-ID: <20170325075958.21140-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1crgcL-0008AW-84
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 08:00:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1crgcK-0001Nc-A1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 08:00:09 +0000
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

Let's set noheap by default.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c           | 2 +-
 mkfs/f2fs_format.c      | 8 ++++++--
 mkfs/f2fs_format_main.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index bb32df8..7352837 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -568,7 +568,7 @@ void f2fs_init_configuration(void)
 	c.segs_per_sec = 1;
 	c.secs_per_zone = 1;
 	c.segs_per_zone = 1;
-	c.heap = 1;
+	c.heap = 0;
 	c.vol_label = "";
 	c.trim = 1;
 	c.ro = 0;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f6279b5..01f3488 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -376,8 +376,12 @@ static int f2fs_prepare_super_block(void)
 		c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
 		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
 		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
-		c.cur_seg[CURSEG_COLD_DATA] = next_zone(CURSEG_HOT_DATA);
-		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
+		c.cur_seg[CURSEG_COLD_DATA] =
+				max(last_section(last_zone(total_zones)) >> 2,
+					next_zone(CURSEG_COLD_NODE));
+		c.cur_seg[CURSEG_WARM_DATA] =
+				max(last_section(last_zone(total_zones)) >> 1,
+					next_zone(CURSEG_COLD_DATA));
 	}
 
 	cure_extension_list();
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 482506a..21ceeeb 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -33,7 +33,7 @@ static void mkfs_usage()
 {
 	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
-	MSG(0, "  -a heap-based allocation [default:1]\n");
+	MSG(0, "  -a heap-based allocation [default:0]\n");
 	MSG(0, "  -c [device path] up to 7 devices excepts meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
