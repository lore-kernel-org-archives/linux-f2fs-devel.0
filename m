From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] mkfs.f2fs: export get_best_overprovision
Date: Fri, 11 Dec 2015 16:00:11 -0800
Message-ID: <1449878414-41254-3-git-send-email-jaegeuk@kernel.org>
References: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xbw-0001VS-3R
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xbv-000744-Bi for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:28 +0000
In-Reply-To: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
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

This patch exports get_best_overprovision() function.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h  | 28 ++++++++++++++++++++++++++++
 mkfs/f2fs_format.c | 30 +-----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6fd4c80..bbdeb51 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -886,4 +886,32 @@ extern struct f2fs_configuration config;
 #define ZONE_ALIGN(blks)	ALIGN(blks, config.blks_per_seg * \
 					config.segs_per_zone)
 
+static inline double get_best_overprovision(struct f2fs_super_block *sb)
+{
+	double reserved, ovp, candidate, end, diff, space;
+	double max_ovp = 0, max_space = 0;
+
+	if (get_sb(segment_count_main) < 256) {
+		candidate = 10;
+		end = 95;
+		diff = 5;
+	} else {
+		candidate = 0.01;
+		end = 10;
+		diff = 0.01;
+	}
+
+	for (; candidate <= end; candidate += diff) {
+		reserved = (2 * (100 / candidate + 1) + 6) *
+						get_sb(segs_per_sec);
+		ovp = (get_sb(segment_count_main) - reserved) * candidate / 100;
+		space = get_sb(segment_count_main) - reserved - ovp;
+		if (max_space < space) {
+			max_space = space;
+			max_ovp = candidate;
+		}
+	}
+	return max_ovp;
+}
+
 #endif	/*__F2FS_FS_H */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b0c12f2..c4b17de 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -117,34 +117,6 @@ next:
 	free(config.extension_list);
 }
 
-static double get_best_overprovision(void)
-{
-	double reserved, ovp, candidate, end, diff, space;
-	double max_ovp = 0, max_space = 0;
-
-	if (get_sb(segment_count_main) < 256) {
-		candidate = 10;
-		end = 95;
-		diff = 5;
-	} else {
-		candidate = 0.01;
-		end = 10;
-		diff = 0.01;
-	}
-
-	for (; candidate <= end; candidate += diff) {
-		reserved = (2 * (100 / candidate + 1) + 6) *
-						get_sb(segs_per_sec);
-		ovp = (get_sb(segment_count_main) - reserved) * candidate / 100;
-		space = get_sb(segment_count_main) - reserved - ovp;
-		if (max_space < space) {
-			max_space = space;
-			max_ovp = candidate;
-		}
-	}
-	return max_ovp;
-}
-
 static int f2fs_prepare_super_block(void)
 {
 	u_int32_t blk_size_bytes;
@@ -302,7 +274,7 @@ static int f2fs_prepare_super_block(void)
 
 	/* Let's determine the best reserved and overprovisioned space */
 	if (config.overprovision == 0)
-		config.overprovision = get_best_overprovision();
+		config.overprovision = get_best_overprovision(sb);
 
 	config.reserved_segments =
 			(2 * (100 / config.overprovision + 1) + 6)
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
