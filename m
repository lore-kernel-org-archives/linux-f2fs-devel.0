From: JP Abgrall <jpa@google.com>
Subject: [PATCH] mkfs: support passing in the number of sectors
	to use
Date: Wed, 11 Jun 2014 21:55:38 -0700
Message-ID: <1402548938-3141-1-git-send-email-jpa@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1WuxUa-0006qR-EA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:24:04 +0000
Received: from mail-pb0-f73.google.com ([209.85.160.73])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WuxUY-0005dn-OQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jun 2014 05:24:04 +0000
Received: by mail-pb0-f73.google.com with SMTP id ma3so41583pbc.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 11 Jun 2014 22:23:57 -0700 (PDT)
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

Adds the optional sectors count:
  mkfs.f2fs [options] device [sectors]

Change-Id: I3ac83121576574bda074140ffa60195a2bc9947b
---
 lib/libf2fs.c           |  7 +++++++
 mkfs/f2fs_format_main.c | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index c1e0b0e..7df275c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -354,6 +354,7 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
  */
 void f2fs_init_configuration(struct f2fs_configuration *c)
 {
+	c->total_sectors = 0;
 	c->sector_size = DEFAULT_SECTOR_SIZE;
 	c->sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
 	c->blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
@@ -430,6 +431,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	uint32_t sector_size;
 	struct stat stat_buf;
 	struct hd_geometry geom;
+	u_int64_t wanted_total_sectors = c->total_sectors;
 
 	fd = open(c->device_name, O_RDWR);
 	if (fd < 0) {
@@ -472,7 +474,12 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		MSG(0, "\tError: Volume type is not supported!!!\n");
 		return -1;
 	}
+	if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
+		MSG(0, "Info: total device sectors = %"PRIu64" (in 512bytes)\n",
+					c->total_sectors);
+		c->total_sectors = wanted_total_sectors;
 
+	}
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",
 					c->total_sectors);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index cee640a..2b6c195 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -26,7 +26,7 @@ extern struct f2fs_configuration config;
 
 static void mkfs_usage()
 {
-	MSG(0, "\nUsage: mkfs.f2fs [options] device\n");
+	MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -a heap-based allocation [default:1]\n");
 	MSG(0, "  -d debug level [default:0]\n");
@@ -36,6 +36,7 @@ static void mkfs_usage()
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
+	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
 
@@ -93,15 +94,21 @@ static void f2fs_parse_options(int argc, char *argv[])
 		}
 	}
 
-	if ((optind + 1) != argc) {
+	if (optind >= argc) {
 		MSG(0, "\tError: Device not specified\n");
 		mkfs_usage();
 	}
+	config.device_name = argv[optind];
+
+	if ((optind + 1) < argc) {
+		/* We have a sector count. */
+		config.total_sectors = atoll(argv[optind+1]);
+		MSG(0, "\ttotal_sectors=%lu (%s bytes)\n", config.total_sectors, argv[optind+1]);
+	}
 
 	config.reserved_segments  =
 			(2 * (100 / config.overprovision + 1) + 6)
 			* config.segs_per_sec;
-	config.device_name = argv[optind];
 }
 
 int main(int argc, char *argv[])
-- 
2.0.0.526.g5318336


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
