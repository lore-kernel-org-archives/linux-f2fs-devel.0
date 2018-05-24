From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: not allow to format too small sized
 partition
Date: Wed, 23 May 2018 18:17:40 -0700
Message-ID: <20180524011740.86838-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fLet5-0002Dn-Qv
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 May 2018 01:17:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fLet4-001F5n-J9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 May 2018 01:17:51 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

For example, if we want to format 40MB image, it'll give 12 segments for main
area. And, it assigns 6 for current segments, 11 for ovp segments, and 10 for
reserved segments. So, we have 5 free segments, which we can't handle:
 # of free segments < # of reserved segments.

Reported-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 0a99a77..3ab5236 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -408,18 +408,19 @@ static int f2fs_prepare_super_block(void)
 	if (c.overprovision == 0)
 		c.overprovision = get_best_overprovision(sb);
 
+	c.reserved_segments =
+			(2 * (100 / c.overprovision + 1) + NR_CURSEG_TYPE)
+			* c.segs_per_sec;
+
 	if (c.overprovision == 0 || c.total_segments < F2FS_MIN_SEGMENTS ||
 		(c.devices[0].total_sectors *
 			c.sector_size < zone_align_start_offset) ||
-		(get_sb(segment_count_main) - 2) < c.reserved_segments) {
+		(get_sb(segment_count_main) - NR_CURSEG_TYPE) <
+						c.reserved_segments) {
 		MSG(0, "\tError: Device size is not sufficient for F2FS volume\n");
 		return -1;
 	}
 
-	c.reserved_segments =
-			(2 * (100 / c.overprovision + 1) + 6)
-			* c.segs_per_sec;
-
 	uuid_generate(sb->uuid);
 
 	/* precompute checksum seed for metadata */
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
