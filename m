From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/7] f2fs-tools: Use zoned block device
	terminology
Date: Fri, 28 Oct 2016 16:56:59 +0900
Message-ID: <1477641424-12367-4-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02VQ-00076V-5k
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:27:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02VO-0002wI-Ri
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:27:16 +0000
In-Reply-To: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-f2fs-devel@lists.sourceforge.net

SMR stands for "Shingled Magnetic Recording" which makes sense
only for hard disk drives (spinning rust). The ZBC/ZAC standards
enable management of SMR disks, but solid state drives may also
support those standards. So replace "SMR" with "zoned block device"
to avoid a HDD centric terminology.

In particular, rename the HMSMR feature to BLKZONED.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fsck/mount.c            | 4 ++--
 include/f2fs_fs.h       | 4 ++--
 lib/libf2fs.c           | 6 +++---
 mkfs/f2fs_format.c      | 2 +-
 mkfs/f2fs_format_main.c | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 3be60bb..dead207 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -268,8 +268,8 @@ void print_sb_state(struct f2fs_super_block *sb)
 	if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
 		MSG(0, "%s", " encrypt");
 	}
-	if (f & cpu_to_le32(F2FS_FEATURE_HMSMR)) {
-		MSG(0, "%s", " host-managed SMR");
+	if (f & cpu_to_le32(F2FS_FEATURE_BLKZONED)) {
+		MSG(0, "%s", " zoned block device");
 	}
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1345e2d..b2b2d8e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -301,7 +301,7 @@ struct f2fs_configuration {
 	char *mount_point;
 
 	/* to detect zbc error */
-	int smr_mode;
+	int zoned_mode;
 	u_int32_t nr_zones;
 	u_int32_t nr_conventional;
 	size_t zone_sectors;
@@ -457,7 +457,7 @@ enum {
 #define MAX_ACTIVE_DATA_LOGS	8
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
-#define F2FS_FEATURE_HMSMR	0x0002
+#define F2FS_FEATURE_BLKZONED	0x0002
 
 #define MAX_VOLUME_NAME		512
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index d4580f4..a73955d 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -646,12 +646,12 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		return -1;
 	}
 
-	if (config.smr_mode) {
+	if (config.zoned_mode) {
 		if (zbc_scsi_report_zones(c)) {
-			MSG(0, "\tError: Not proper SMR drive\n");
+			MSG(0, "\tError: Not proper zoned block device\n");
 			return -1;
 		}
-		MSG(0, "Info: SMR - ZONES = %u, CONV = %u, ZONE_SECTS = %lu\n",
+		MSG(0, "Info: Zoned block device - ZONES = %u, CONV = %u, ZONE_SECTS = %lu\n",
 				c->nr_zones, c->nr_conventional,
 				c->zone_sectors);
 		if (c->segs_per_sec == 1)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 6b1318a..b40cd83 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -703,7 +703,7 @@ static int f2fs_write_super_block(void)
 #ifndef WITH_ANDROID
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
-	if (config.smr_mode)
+	if (config.zoned_mode)
 		return 0;
 	do {
 		if (offset < get_sb(main_blkaddr) ||
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8a7b604..c417829 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -38,7 +38,7 @@ static void mkfs_usage()
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
-	MSG(0, "  -m support SMR device [default:0]\n");
+	MSG(0, "  -m support zoned block device [default:0]\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
@@ -98,7 +98,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 			config.vol_label = optarg;
 			break;
 		case 'm':
-			config.smr_mode = 1;
+			config.zoned_mode = 1;
 			break;
 		case 'o':
 			config.overprovision = atof(optarg);
@@ -131,8 +131,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 	if ((optind + 1) < argc)
 		config.total_sectors = atoll(argv[optind+1]);
 
-	if (config.smr_mode)
-		config.feature |= cpu_to_le32(F2FS_FEATURE_HMSMR);
+	if (config.zoned_mode)
+		config.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
 }
 
 int main(int argc, char *argv[])
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
