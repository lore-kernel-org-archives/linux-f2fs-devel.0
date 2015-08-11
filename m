From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] mkfs.f2fs: set overprovision size more
	precisely
Date: Mon, 10 Aug 2015 18:23:47 -0700
Message-ID: <1439256228-8982-2-git-send-email-jaegeuk@kernel.org>
References: <1439256228-8982-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZOyIV-0002Vy-KM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOyIR-0003kh-Pd for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:11 +0000
In-Reply-To: <1439256228-8982-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces to set the default overprovision space according to the
partition size in order to provide more space.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c           |  4 ++--
 mkfs/f2fs_format.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 mkfs/f2fs_format_main.c |  5 -----
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 7fd2550..e8f4d47 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -353,8 +353,8 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
 
 	/* calculated by overprovision ratio */
-	c->reserved_segments = 48;
-	c->overprovision = 5;
+	c->reserved_segments = 0;
+	c->overprovision = 0;
 	c->segs_per_sec = 1;
 	c->secs_per_zone = 1;
 	c->segs_per_zone = 1;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f879bca..21e74fe 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -155,6 +155,33 @@ static void configure_extension_list(void)
 	free(config.extension_list);
 }
 
+static u_int32_t get_best_overprovision(void)
+{
+	u_int32_t reserved, ovp, candidate, end, diff, space;
+	u_int32_t max_ovp = 0, max_space = 0;
+
+	if (get_sb(segment_count_main) < 256) {
+		candidate = 10;
+		end = 95;
+		diff = 5;
+	} else {
+		candidate = 1;
+		end = 10;
+		diff = 1;
+	}
+
+	for (; candidate <= end; candidate += diff) {
+		reserved = 2 * (100 / candidate + 1) + 6;
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
 static int f2fs_prepare_super_block(void)
 {
 	u_int32_t blk_size_bytes;
@@ -310,6 +337,14 @@ static int f2fs_prepare_super_block(void)
 
 	set_sb(segment_count_main, get_sb(section_count) * config.segs_per_sec);
 
+	/* Let's determine the best reserved and overprovisioned space */
+	if (config.overprovision == 0)
+		config.overprovision = get_best_overprovision();
+
+	config.reserved_segments =
+			(2 * (100 / config.overprovision + 1) + 6)
+			* config.segs_per_sec;
+
 	if ((get_sb(segment_count_main) - 2) <
 					config.reserved_segments) {
 		MSG(1, "\tError: Device size is not sufficient for F2FS volume,\
@@ -497,6 +532,11 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 			get_cp(rsvd_segment_count));
 
+	MSG(0, "Info: Overprovision ratio = %u%%\n", config.overprovision);
+	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
+					get_cp(overprov_segment_count),
+					config.reserved_segments);
+
 	/* main segments - reserved segments - (node + data segments) */
 	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
 	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 5a9e7e2..fc612d8 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -56,7 +56,6 @@ static void f2fs_show_info()
 
 	if (config.vol_label)
 		MSG(0, "Info: Label = %s\n", config.vol_label);
-	MSG(0, "Info: Overprovision ratio = %u%%\n", config.overprovision);
 	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
 	MSG(0, "Info: Sections per zone = %d\n", config.secs_per_zone);
 	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
@@ -134,10 +133,6 @@ static void f2fs_parse_options(int argc, char *argv[])
 				config.total_sectors,
 				config.total_sectors * 512);
 	}
-
-	config.reserved_segments  =
-			(2 * (100 / config.overprovision + 1) + 6)
-			* config.segs_per_sec;
 	config.segs_per_zone = config.segs_per_sec * config.secs_per_zone;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
