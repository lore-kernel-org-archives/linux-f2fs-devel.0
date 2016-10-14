From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: avoid AOSP build failure
Date: Thu, 13 Oct 2016 17:02:26 -0700
Message-ID: <20161014000230.59232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bupxd-0005CW-Iv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bupxc-0001fK-Jt
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:53 +0000
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

SCSI-related operations are not permitted to AOSP biuld.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c   |  2 ++
 lib/libf2fs.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index f1b065f..75f8c1e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -510,6 +510,7 @@ fsck_again:
 	case DUMP:
 		do_dump(sbi);
 		break;
+#ifndef WITH_ANDROID
 	case DEFRAG:
 		ret = do_defrag(sbi);
 		if (ret)
@@ -522,6 +523,7 @@ fsck_again:
 	case SLOAD:
 		do_sload(sbi);
 		break;
+#endif
 	}
 
 	f2fs_do_umount(sbi);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 6140452..d3311ca 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -19,14 +19,18 @@
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <sys/ioctl.h>
+#ifndef WITH_ANDROID
 #include <scsi/sg.h>
+#endif
 #include <linux/hdreg.h>
 #include <linux/limits.h>
 
 #include <f2fs_fs.h>
 
+#ifndef WITH_ANDROID
 /* SCSI command for standard inquiry*/
 #define MODELINQUIRY	0x12,0x00,0x00,0x00,0x4A,0x00
+#endif
 
 /*
  * UTF conversion codes are Copied from exfat tools.
@@ -652,9 +656,11 @@ int f2fs_get_device_info(void)
 #endif
 	struct stat stat_buf;
 	struct hd_geometry geom;
+#ifndef WITH_ANDROID
 	sg_io_hdr_t io_hdr;
 	unsigned char reply_buffer[96];
 	unsigned char model_inq[6] = {MODELINQUIRY};
+#endif
 	u_int64_t wanted_total_sectors = c.total_sectors;
 
 	fd = open(c.device_name, O_RDWR);
@@ -704,6 +710,7 @@ int f2fs_get_device_info(void)
 		else
 			c.start_sector = geom.start;
 
+#ifndef WITH_ANDROID
 		/* Send INQUIRY command */
 		memset(&io_hdr, 0, sizeof(sg_io_hdr_t));
 		io_hdr.interface_id = 'S';
@@ -722,6 +729,7 @@ int f2fs_get_device_info(void)
 				printf("%c", reply_buffer[i++]);
 			printf("\n");
 		}
+#endif
 	} else {
 		MSG(0, "\tError: Volume type is not supported!!!\n");
 		return -1;
@@ -737,6 +745,7 @@ int f2fs_get_device_info(void)
 		return -1;
 	}
 
+#ifndef WITH_ANDROID
 	if (c.smr_mode) {
 		if (zbc_scsi_report_zones()) {
 			MSG(0, "\tError: Not proper SMR drive\n");
@@ -749,6 +758,7 @@ int f2fs_get_device_info(void)
 			c.segs_per_sec = c.zone_sectors /
 				c.sectors_per_blk / DEFAULT_BLOCKS_PER_SEGMENT;
 	}
+#endif
 	c.segs_per_zone = c.segs_per_sec * c.secs_per_zone;
 
 	MSG(0, "Info: Segments per section = %d\n", c.segs_per_sec);
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
