From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/7] f2fs-tools: Introduce support for zoned
	block devices
Date: Fri, 28 Oct 2016 16:57:00 +0900
Message-ID: <1477641424-12367-5-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02HD-0003EX-AD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02H8-0000bd-Pa
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:35 +0000
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

With the availability of the BLKREPORTZONE and BLKRESETZONE
ioctls, there is no need for using SG_IO to discover zoned
block devices characteristics. This simplifies the code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 configure.ac        |   2 +-
 include/f2fs_fs.h   | 107 ++++++---
 lib/Makefile.am     |   2 +-
 lib/libf2fs.c       |  40 +++-
 lib/libf2fs_zoned.c | 296 ++++++++++++++++++++++++
 lib/zbc.c           | 647 ----------------------------------------------------
 lib/zbc.h           | 361 -----------------------------
 7 files changed, 404 insertions(+), 1051 deletions(-)
 create mode 100644 lib/libf2fs_zoned.c
 delete mode 100644 lib/zbc.c
 delete mode 100644 lib/zbc.h

diff --git a/configure.ac b/configure.ac
index f519790..5655612 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,7 +57,7 @@ PKG_CHECK_MODULES([libuuid], [uuid])
 PKG_CHECK_MODULES([libselinux], [libselinux])
 
 # Checks for header files.
-AC_CHECK_HEADERS([linux/fs.h fcntl.h mntent.h stdlib.h string.h \
+AC_CHECK_HEADERS([linux/fs.h linux/blkzoned.h fcntl.h mntent.h stdlib.h string.h \
 		sys/ioctl.h sys/mount.h unistd.h linux/falloc.h byteswap.h])
 
 # Checks for typedefs, structures, and compiler characteristics.
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index b2b2d8e..363f47e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -20,6 +20,10 @@
 #include <config.h>
 #endif
 
+#ifdef HAVE_LINUX_BLKZONED_H
+#include <linux/blkzoned.h>
+#endif
+
 typedef u_int64_t	u64;
 typedef u_int32_t	u32;
 typedef u_int16_t	u16;
@@ -229,32 +233,6 @@ enum f2fs_config_func {
 	SLOAD,
 };
 
-enum zbc_sk {
-	ZBC_E_ILLEGAL_REQUEST         = 0x5,
-	ZBC_E_DATA_PROTECT            = 0x7,
-	ZBC_E_ABORTED_COMMAND         = 0xB,
-};
-
-/**
- * Additional sense code/Additional sense code qualifier.
- */
-enum zbc_asc_ascq {
-	ZBC_E_INVALID_FIELD_IN_CDB                  = 0x2400,
-	ZBC_E_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE    = 0x2100,
-	ZBC_E_UNALIGNED_WRITE_COMMAND               = 0x2104,
-	ZBC_E_WRITE_BOUNDARY_VIOLATION              = 0x2105,
-	ZBC_E_ATTEMPT_TO_READ_INVALID_DATA          = 0x2106,
-	ZBC_E_READ_BOUNDARY_VIOLATION               = 0x2107,
-	ZBC_E_ZONE_IS_READ_ONLY                     = 0x2708,
-	ZBC_E_INSUFFICIENT_ZONE_RESOURCES           = 0x550E,
-};
-
-struct zbc_errno {
-	enum zbc_sk		sk;
-	enum zbc_asc_ascq	asc_ascq;
-};
-typedef struct zbc_errno zbc_errno_t;
-
 struct f2fs_configuration {
 	u_int32_t sector_size;
 	u_int32_t reserved_segments;
@@ -300,12 +278,12 @@ struct f2fs_configuration {
 	char *from_dir;
 	char *mount_point;
 
-	/* to detect zbc error */
+	/* to handle zone block devices */
 	int zoned_mode;
+	int zoned_model;
 	u_int32_t nr_zones;
-	u_int32_t nr_conventional;
-	size_t zone_sectors;
-	zbc_errno_t zbd_errno;
+	u_int32_t nr_rnd_zones;
+	size_t zone_blocks;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -910,7 +888,7 @@ struct f2fs_inline_dentry {
 	__u8 reserved[INLINE_RESERVED_SIZE];
 	struct f2fs_dir_entry dentry[NR_INLINE_DENTRY];
 	__u8 filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
-} __packed;
+} __attribute__((packed));
 
 /* file types used in inode_info->flags */
 enum FILE_TYPE {
@@ -973,7 +951,72 @@ extern int dev_read_version(void *, __u64, size_t);
 extern void get_kernel_version(__u8 *);
 f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
-extern int zbc_scsi_report_zones(struct f2fs_configuration *);
+#define F2FS_ZONED_NONE		0
+#define F2FS_ZONED_HA		1
+#define F2FS_ZONED_HM		2
+
+#ifdef HAVE_LINUX_BLKZONED_H
+
+#define blk_zone_type(z)        (z)->type
+#define blk_zone_conv(z)	((z)->type == BLK_ZONE_TYPE_CONVENTIONAL)
+#define blk_zone_seq_req(z)	((z)->type == BLK_ZONE_TYPE_SEQWRITE_REQ)
+#define blk_zone_seq_pref(z)	((z)->type == BLK_ZONE_TYPE_SEQWRITE_PREF)
+#define blk_zone_seq(z)		(blk_zone_seq_req(z) || blk_zone_seq_pref(z))
+
+static inline const char *
+blk_zone_type_str(struct blk_zone *blkz)
+{
+	switch (blk_zone_type(blkz)) {
+	case BLK_ZONE_TYPE_CONVENTIONAL:
+		return( "Conventional" );
+	case BLK_ZONE_TYPE_SEQWRITE_REQ:
+		return( "Sequential-write-required" );
+	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		return( "Sequential-write-preferred" );
+	}
+	return( "Unknown-type" );
+}
+
+#define blk_zone_cond(z)	(z)->cond
+
+static inline const char *
+blk_zone_cond_str(struct blk_zone *blkz)
+{
+	switch (blk_zone_cond(blkz)) {
+	case BLK_ZONE_COND_NOT_WP:
+		return "Not-write-pointer";
+	case BLK_ZONE_COND_EMPTY:
+		return "Empty";
+	case BLK_ZONE_COND_IMP_OPEN:
+		return "Implicit-open";
+	case BLK_ZONE_COND_EXP_OPEN:
+		return "Explicit-open";
+	case BLK_ZONE_COND_CLOSED:
+		return "Closed";
+	case BLK_ZONE_COND_READONLY:
+		return "Read-only";
+	case BLK_ZONE_COND_FULL:
+		return "Full";
+	case BLK_ZONE_COND_OFFLINE:
+		return "Offline";
+	}
+	return "Unknown-cond";
+}
+
+#define blk_zone_empty(z)	(blk_zone_cond(z) == BLK_ZONE_COND_EMPTY)
+
+#define blk_zone_sector(z)	(z)->start
+#define blk_zone_length(z)	(z)->len
+#define blk_zone_wp_sector(z)	(z)->wp
+#define blk_zone_need_reset(z)	(int)(z)->reset
+#define blk_zone_non_seq(z)	(int)(z)->non_seq
+
+#endif
+
+extern void f2fs_get_zoned_model(struct f2fs_configuration *c);
+extern int f2fs_get_zone_blocks(struct f2fs_configuration *c);
+extern int f2fs_check_zones(struct f2fs_configuration *c);
+extern int f2fs_reset_zones(struct f2fs_configuration *c);
 
 extern struct f2fs_configuration config;
 
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 91e4b4c..b26b404 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,7 @@
 
 lib_LTLIBRARIES = libf2fs.la
 
-libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c zbc.c
+libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c libf2fs_zoned.c
 libf2fs_la_CFLAGS = -Wall
 libf2fs_la_CPPFLAGS = -I$(top_srcdir)/include
 libf2fs_la_LDFLAGS = -version-info $(LIBF2FS_CURRENT):$(LIBF2FS_REVISION):$(LIBF2FS_AGE)
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a73955d..48aea4b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -489,6 +489,8 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->sector_size = DEFAULT_SECTOR_SIZE;
 	c->sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
 	c->blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
+	c->zoned_mode = 0;
+	c->zoned_model = F2FS_ZONED_NONE;
 
 	/* calculated by overprovision ratio */
 	c->reserved_segments = 0;
@@ -646,18 +648,38 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		return -1;
 	}
 
-	if (config.zoned_mode) {
-		if (zbc_scsi_report_zones(c)) {
-			MSG(0, "\tError: Not proper zoned block device\n");
+	if (S_ISBLK(stat_buf.st_mode))
+		f2fs_get_zoned_model(c);
+	if (c->zoned_model == F2FS_ZONED_NONE) {
+		config.zoned_mode = 0;
+	} else {
+
+		if (f2fs_get_zone_blocks(c)) {
+			MSG(0, "\tError: Failed to get number of blocks per zone\n");
+ 			return -1;
+ 		}
+
+		if (f2fs_check_zones(c)) {
+			MSG(0, "\tError: Failed to check zone configuration\n");
 			return -1;
 		}
-		MSG(0, "Info: Zoned block device - ZONES = %u, CONV = %u, ZONE_SECTS = %lu\n",
-				c->nr_zones, c->nr_conventional,
-				c->zone_sectors);
-		if (c->segs_per_sec == 1)
-			c->segs_per_sec = c->zone_sectors /
-				c->sectors_per_blk / DEFAULT_BLOCKS_PER_SEGMENT;
+
+		MSG(0, "Info: Host-%s zoned block device:\n",
+		    (c->zoned_model == F2FS_ZONED_HA) ? "aware" : "managed");
+		MSG(0, "      %u zones, %u randomly writeable zones\n",
+		    c->nr_zones, c->nr_rnd_zones);
+		MSG(0, "      %lu blocks per zone\n",
+		    c->zone_blocks);
+
+		/*
+		 * Align sections to the device zone size
+		 * and align F2FS zones to the device zones.
+		 */
+		c->segs_per_sec = c->zone_blocks / DEFAULT_BLOCKS_PER_SEGMENT;
+		c->secs_per_zone = 1;
+
 	}
+
 	c->segs_per_zone = c->segs_per_sec * c->secs_per_zone;
 
 	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
new file mode 100644
index 0000000..76cb3bd
--- /dev/null
+++ b/lib/libf2fs_zoned.c
@@ -0,0 +1,296 @@
+/**
+ * libf2fs_zoned.c
+ *
+ * Copyright (c) 2016 Western Digital Corporation.
+ * Written by: Damien Le Moal <damien.lemoal@wdc.com>
+ *
+ * Dual licensed under the GPL or LGPL version 2 licenses.
+ */
+#define _LARGEFILE64_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <libgen.h>
+
+#include <f2fs_fs.h>
+
+#ifdef HAVE_LINUX_BLKZONED_H
+
+void f2fs_get_zoned_model(struct f2fs_configuration *c)
+{
+	char str[128];
+	FILE *file;
+
+	/* Check that this is a zoned block device */
+	snprintf(str, sizeof(str),
+		 "/sys/block/%s/queue/zoned",
+		 basename(c->device_name));
+	file = fopen(str, "r");
+	if (!file)
+		goto not_zoned;
+
+	memset(str, 0, sizeof(str));
+	fscanf(file, "%s", str);
+	fclose(file);
+
+	if (strcmp(str, "host-aware") == 0) {
+		c->zoned_model = F2FS_ZONED_HA;
+		return;
+	}
+	if (strcmp(str, "host-managed") == 0) {
+		c->zoned_model = F2FS_ZONED_HM;
+		return;
+	}
+
+not_zoned:
+	c->zoned_model = F2FS_ZONED_NONE;
+}
+
+int f2fs_get_zone_blocks(struct f2fs_configuration *c)
+{
+	uint64_t sectors;
+	char str[128];
+	FILE *file;
+
+	/* Get zone size */
+	c->zone_blocks = 0;
+
+	snprintf(str, sizeof(str),
+		 "/sys/block/%s/queue/chunk_sectors",
+		 basename(c->device_name));
+	file = fopen(str, "r");
+	if (!file)
+		return -1;
+
+	memset(str, 0, sizeof(str));
+	fscanf(file, "%s", str);
+	fclose(file);
+
+	sectors = atol(str);
+	if (!sectors)
+		return -1;
+
+	c->zone_blocks = sectors >> (F2FS_BLKSIZE_BITS - 9);
+	sectors = (sectors << 9) / c->sector_size;
+
+	/*
+	 * Total number of zones: there may
+	 * be a last smaller runt zone.
+	 */
+	c->nr_zones = c->total_sectors / sectors;
+	if (c->total_sectors % sectors)
+		c->nr_zones++;
+
+	return 0;
+}
+
+#define F2FS_REPORT_ZONES_BUFSZ	524288
+
+int f2fs_check_zones(struct f2fs_configuration *c)
+{
+	struct blk_zone_report *rep;
+	struct blk_zone *blkz;
+	unsigned int i, n = 0;
+	u_int64_t total_sectors;
+	u_int64_t sector;
+	int last_is_conv = 1;
+	int ret = -1;
+
+	rep = malloc(F2FS_REPORT_ZONES_BUFSZ);
+	if (!rep) {
+		ERR_MSG("No memory for report zones\n");
+		return -ENOMEM;
+	}
+
+	c->nr_rnd_zones = 0;
+	sector = 0;
+	total_sectors = (c->total_sectors * c->sector_size) >> 9;
+
+	while (sector < total_sectors) {
+
+		/* Get zone info */
+		memset(rep, 0, F2FS_REPORT_ZONES_BUFSZ);
+		rep->sector = sector;
+		rep->nr_zones = (F2FS_REPORT_ZONES_BUFSZ - sizeof(struct blk_zone_report))
+			/ sizeof(struct blk_zone);
+
+		ret = ioctl(c->fd, BLKREPORTZONE, rep);
+		if (ret != 0) {
+			ret = -errno;
+			ERR_MSG("ioctl BLKREPORTZONE failed\n");
+			goto out;
+		}
+
+		if (!rep->nr_zones)
+			break;
+
+		blkz = (struct blk_zone *)(rep + 1);
+		for (i = 0; i < rep->nr_zones && sector < total_sectors; i++) {
+
+			if (blk_zone_cond(blkz) == BLK_ZONE_COND_READONLY ||
+			    blk_zone_cond(blkz) == BLK_ZONE_COND_OFFLINE)
+				last_is_conv = 0;
+			if (blk_zone_conv(blkz) ||
+			    blk_zone_seq_pref(blkz)) {
+				if (last_is_conv)
+					c->nr_rnd_zones++;
+			} else {
+				last_is_conv = 0;
+			}
+
+			if (blk_zone_conv(blkz)) {
+				DBG(2,
+				    "Zone %05u: Conventional, cond 0x%x (%s), sector %llu, %llu sectors\n",
+				    n,
+				    blk_zone_cond(blkz),
+				    blk_zone_cond_str(blkz),
+				    blk_zone_sector(blkz),
+				    blk_zone_length(blkz));
+			} else {
+				DBG(2,
+				    "Zone %05u: type 0x%x (%s), cond 0x%x (%s), need_reset %d, "
+				    "non_seq %d, sector %llu, %llu sectors, wp sector %llu\n",
+				    n,
+				    blk_zone_type(blkz),
+				    blk_zone_type_str(blkz),
+				    blk_zone_cond(blkz),
+				    blk_zone_cond_str(blkz),
+				    blk_zone_need_reset(blkz),
+				    blk_zone_non_seq(blkz),
+				    blk_zone_sector(blkz),
+				    blk_zone_length(blkz),
+				    blk_zone_wp_sector(blkz));
+			}
+
+			sector = blk_zone_sector(blkz) + blk_zone_length(blkz);
+			n++;
+			blkz++;
+		}
+
+	}
+
+	if (sector != total_sectors) {
+		ERR_MSG("Invalid zones: last sector reported is %llu, expected %llu\n",
+			(unsigned long long)(sector << 9) / c->sector_size,
+			(unsigned long long)c->total_sectors);
+		ret = -1;
+		goto out;
+	}
+
+	if (n != c->nr_zones) {
+		ERR_MSG("Inconsistent number of zones: expected %u zones, got %u\n",
+			c->nr_zones,
+			n);
+		ret = -1;
+		goto out;
+	}
+
+	if (c->zoned_model == F2FS_ZONED_HM &&
+	    !c->nr_rnd_zones) {
+		ERR_MSG("No conventional zone for super block\n");
+		ret = -1;
+	}
+
+out:
+	free(rep);
+	return ret;
+}
+
+int f2fs_reset_zones(struct f2fs_configuration *c)
+{
+	struct blk_zone_report *rep;
+	struct blk_zone *blkz;
+	struct blk_zone_range range;
+	u_int64_t total_sectors;
+	u_int64_t sector;
+	unsigned int i;
+	int ret = -1;
+
+	rep = malloc(F2FS_REPORT_ZONES_BUFSZ);
+	if (!rep) {
+		ERR_MSG("No memory for report zones\n");
+		return -1;
+	}
+
+	sector = 0;
+	total_sectors = (c->total_sectors * c->sector_size) >> 9;
+	while (sector < total_sectors) {
+
+		/* Get zone info */
+		memset(rep, 0, F2FS_REPORT_ZONES_BUFSZ);
+		rep->sector = sector;
+		rep->nr_zones = (F2FS_REPORT_ZONES_BUFSZ - sizeof(struct blk_zone_report))
+			/ sizeof(struct blk_zone);
+
+		ret = ioctl(c->fd, BLKREPORTZONE, rep);
+		if (ret != 0) {
+			ret = -errno;
+			ERR_MSG("ioctl BLKREPORTZONES failed\n");
+			goto out;
+		}
+
+		if (!rep->nr_zones)
+			break;
+
+		blkz = (struct blk_zone *)(rep + 1);
+		for (i = 0; i < rep->nr_zones && sector < total_sectors; i++) {
+			if (blk_zone_seq(blkz) &&
+			    !blk_zone_empty(blkz)) {
+				/* Non empty sequential zone: reset */
+				range.sector = blk_zone_sector(blkz);
+				range.nr_sectors = blk_zone_length(blkz);
+				ret = ioctl(c->fd, BLKRESETZONE, &range);
+				if (ret != 0) {
+					ERR_MSG("ioctl BLKRESETZONE failed\n");
+					goto out;
+				}
+			}
+			sector = blk_zone_sector(blkz) + blk_zone_length(blkz);
+			blkz++;
+		}
+
+	}
+
+out:
+	free(rep);
+	return 0;
+}
+
+#else
+
+void f2fs_get_zoned_model(struct f2fs_configuration *c)
+{
+	c->zone_mode = 0;
+	c->zoned_model = F2FS_ZONED_NONE;
+}
+
+int f2fs_get_zone_blocks(struct f2fs_configuration *c)
+{
+	c->zone_mode = 0;
+	c->nr_zones = 0;
+	c->zone_blocks = 0;
+	c->zoned_model = F2FS_ZONED_NONE;
+
+	return 0;
+}
+
+int f2fs_check_zones(struct f2fs_configuration *c)
+{
+	ERR_MSG("Zoned block devices are not supported\n");
+	return -1;
+}
+
+int f2fs_reset_zones(struct f2fs_configuration *c)
+{
+	ERR_MSG("Zoned block devices are not supported\n");
+	return -1;
+}
+
+#endif
+
diff --git a/lib/zbc.c b/lib/zbc.c
deleted file mode 100644
index 6ec2fc7..0000000
--- a/lib/zbc.c
+++ /dev/null
@@ -1,647 +0,0 @@
-/*
- * This file is mostly copied from libzbc.
- *
- * Copyright (C) 2009-2014, HGST, Inc.  All rights reserved.
- *
- * This software is distributed under the terms of the BSD 2-clause license,
- * "as is," without technical support, and WITHOUT ANY WARRANTY, without
- * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- * PURPOSE. You should have received a copy of the BSD 2-clause license along
- * with libzbc. If not, see  <http://opensource.org/licenses/BSD-2-Clause>.
- *
- * Authors: Damien Le Moal (damien.lemoal@hgst.com)
- *          Christophe Louargant (christophe.louargant@hgst.com)
- *
- * Integrated into f2fs-tools by:
- *          Jaegeuk Kim (jaegeuk@kernel.org)
- */
-
-#include <f2fs_fs.h>
-
-#include "zbc.h"
-
-static struct zbc_sg_cmd_s
-{
-
-    char                *cdb_cmd_name;
-    int                 cdb_opcode;
-    int                 cdb_sa;
-    size_t              cdb_length;
-    int			dir;
-
-} zbc_sg_cmd_list[ZBC_SG_CMD_NUM] = {
-
-    /* ZBC_SG_TEST_UNIT_READY */
-    {
-        "TEST UNIT READY",
-        ZBC_SG_TEST_UNIT_READY_CDB_OPCODE,
-        0,
-        ZBC_SG_TEST_UNIT_READY_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_INQUIRY */
-    {
-        "INQUIRY",
-        ZBC_SG_INQUIRY_CDB_OPCODE,
-        0,
-        ZBC_SG_INQUIRY_CDB_LENGTH,
-	SG_DXFER_FROM_DEV
-    },
-
-    /* ZBC_SG_READ_CAPACITY */
-    {
-        "READ CAPACITY 16",
-        ZBC_SG_READ_CAPACITY_CDB_OPCODE,
-        ZBC_SG_READ_CAPACITY_CDB_SA,
-        ZBC_SG_READ_CAPACITY_CDB_LENGTH,
-	SG_DXFER_FROM_DEV
-    },
-
-    /* ZBC_SG_READ */
-    {
-        "READ 16",
-        ZBC_SG_READ_CDB_OPCODE,
-        0,
-        ZBC_SG_READ_CDB_LENGTH,
-	SG_DXFER_FROM_DEV
-    },
-
-    /* ZBC_SG_WRITE */
-    {
-        "WRITE 16",
-        ZBC_SG_WRITE_CDB_OPCODE,
-        0,
-        ZBC_SG_WRITE_CDB_LENGTH,
-	SG_DXFER_TO_DEV
-    },
-
-    /* ZBC_SG_SYNC_CACHE */
-    {
-        "SYNCHRONIZE CACHE 16",
-        ZBC_SG_SYNC_CACHE_CDB_OPCODE,
-        0,
-        ZBC_SG_SYNC_CACHE_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_REPORT_ZONES */
-    {
-        "REPORT ZONES",
-        ZBC_SG_REPORT_ZONES_CDB_OPCODE,
-        ZBC_SG_REPORT_ZONES_CDB_SA,
-        ZBC_SG_REPORT_ZONES_CDB_LENGTH,
-	SG_DXFER_FROM_DEV
-    },
-
-    /* ZBC_SG_OPEN_ZONE */
-    {
-        "OPEN ZONE",
-        ZBC_SG_OPEN_ZONE_CDB_OPCODE,
-        ZBC_SG_OPEN_ZONE_CDB_SA,
-        ZBC_SG_OPEN_ZONE_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_CLOSE_ZONE */
-    {
-        "CLOSE ZONE",
-        ZBC_SG_CLOSE_ZONE_CDB_OPCODE,
-        ZBC_SG_CLOSE_ZONE_CDB_SA,
-        ZBC_SG_CLOSE_ZONE_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_FINISH_ZONE */
-    {
-        "FINISH ZONE",
-        ZBC_SG_FINISH_ZONE_CDB_OPCODE,
-        ZBC_SG_FINISH_ZONE_CDB_SA,
-        ZBC_SG_FINISH_ZONE_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_RESET_WRITE_POINTER */
-    {
-        "RESET WRITE POINTER",
-        ZBC_SG_RESET_WRITE_POINTER_CDB_OPCODE,
-        ZBC_SG_RESET_WRITE_POINTER_CDB_SA,
-        ZBC_SG_RESET_WRITE_POINTER_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_SET_ZONES */
-    {
-        "SET ZONES",
-        ZBC_SG_SET_ZONES_CDB_OPCODE,
-        ZBC_SG_SET_ZONES_CDB_SA,
-        ZBC_SG_SET_ZONES_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_SET_WRITE_POINTER */
-    {
-        "SET WRITE POINTER",
-        ZBC_SG_SET_WRITE_POINTER_CDB_OPCODE,
-        ZBC_SG_SET_WRITE_POINTER_CDB_SA,
-        ZBC_SG_SET_WRITE_POINTER_CDB_LENGTH,
-	SG_DXFER_NONE
-    },
-
-    /* ZBC_SG_ATA12 */
-    {
-	"ATA 12",
-	ZBC_SG_ATA12_CDB_OPCODE,
-	0,
-        ZBC_SG_ATA12_CDB_LENGTH,
-	0
-    },
-
-    /* ZBC_SG_ATA16 */
-    {
-	"ATA 16",
-	ZBC_SG_ATA16_CDB_OPCODE,
-	0,
-        ZBC_SG_ATA16_CDB_LENGTH,
-	0
-    }
-};
-
-static void zbc_sg_cmd_set_bytes(uint8_t *cmd, void *buf, int bytes)
-{
-	uint8_t *v = (uint8_t *) buf;
-	int i;
-
-	for (i = 0; i < bytes; i++) {
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-		/* The least significant byte is stored last */
-		cmd[bytes - i - 1] = v[i];
-#else
-		/* The most significant byte is stored first */
-		cmd[i] = v[i];
-#endif
-	}
-	return;
-}
-
-static void zbc_sg_cmd_get_bytes(uint8_t *val, union converter *conv, int bytes)
-{
-	uint8_t *v = (uint8_t *) val;
-	int i;
-
-	memset(conv, 0, sizeof(union converter));
-
-	for(i = 0; i < bytes; i++) {
-#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-		conv->val_buf[bytes - i - 1] = v[i];
-#else
-		conv->val_buf[i] = v[i];
-#endif
-	}
-	return;
-}
-
-static inline void zbc_sg_cmd_set_int64(uint8_t *buf, uint64_t val)
-{
-	zbc_sg_cmd_set_bytes(buf, &val, 8);
-	return;
-}
-
-static inline void zbc_sg_cmd_set_int32(uint8_t *buf, uint32_t val)
-{
-	zbc_sg_cmd_set_bytes(buf, &val, 4);
-	return;
-}
-
-static inline uint32_t zbc_sg_cmd_get_int32(uint8_t *buf)
-{
-	union converter conv;
-
-	zbc_sg_cmd_get_bytes(buf, &conv, 4);
-	return conv.val32;
-}
-
-static inline uint64_t zbc_sg_cmd_get_int64(uint8_t *buf)
-{
-	union converter conv;
-
-	zbc_sg_cmd_get_bytes(buf, &conv, 8);
-	return( conv.val64 );
-
-}
-
-static void zbc_sg_cmd_destroy(zbc_sg_cmd_t *cmd)
-{
-	/* Free the command */
-	if (!cmd)
-		return;
-
-	if (cmd->out_buf && cmd->out_buf_needfree) {
-		free(cmd->out_buf);
-		cmd->out_buf = NULL;
-		cmd->out_bufsz = 0;
-	}
-	memset(cmd, 0, sizeof(*cmd));
-	return;
-}
-
-static int zbc_sg_cmd_init(zbc_sg_cmd_t *cmd, int cmd_code,
-				uint8_t *out_buf, size_t out_bufsz)
-{
-	int ret = 0;
-
-	if ((!cmd) || (cmd_code < 0) || (cmd_code >= ZBC_SG_CMD_NUM) ) {
-		ERR_MSG("Invalid command specified\n");
-		return -EINVAL;
-	}
-
-	/* Set command */
-	memset(cmd, 0, sizeof(zbc_sg_cmd_t));
-	cmd->code = cmd_code;
-	cmd->cdb_sz = zbc_sg_cmd_list[cmd_code].cdb_length;
-	cmd->cdb_opcode = zbc_sg_cmd_list[cmd_code].cdb_opcode;
-	cmd->cdb_sa = zbc_sg_cmd_list[cmd_code].cdb_sa;
-
-	/* Set output buffer */
-	if (out_buf) {
-		/* Set specified buffer */
-		if (!out_bufsz) {
-			ERR_MSG("Invalid 0 output buffer size\n");
-			ret = -EINVAL;
-			goto out;
-		}
-		cmd->out_buf = out_buf;
-		cmd->out_bufsz = out_bufsz;
-	} else if (out_bufsz) {
-		/* Allocate a buffer */
-		ret = posix_memalign((void **)&cmd->out_buf,
-				sysconf(_SC_PAGESIZE), out_bufsz);
-		if ( ret != 0 ) {
-			ERR_MSG("No memory for output buffer (%zu B)\n",
-					out_bufsz);
-			ret = -ENOMEM;
-			goto out;
-		}
-		memset(cmd->out_buf, 0, out_bufsz);
-		cmd->out_bufsz = out_bufsz;
-		cmd->out_buf_needfree = 1;
-	}
-
-	/* OK: setup SGIO header */
-	memset(&cmd->io_hdr, 0, sizeof(sg_io_hdr_t));
-
-	cmd->io_hdr.interface_id    = 'S';
-	cmd->io_hdr.timeout         = 20000;
-	cmd->io_hdr.flags           = 0; //SG_FLAG_DIRECT_IO;
-
-	cmd->io_hdr.cmd_len         = cmd->cdb_sz;
-	cmd->io_hdr.cmdp            = &cmd->cdb[0];
-
-	cmd->io_hdr.dxfer_direction = zbc_sg_cmd_list[cmd_code].dir;
-	cmd->io_hdr.dxfer_len       = cmd->out_bufsz;
-	cmd->io_hdr.dxferp          = cmd->out_buf;
-
-	cmd->io_hdr.mx_sb_len       = ZBC_SG_SENSE_MAX_LENGTH;
-	cmd->io_hdr.sbp             = cmd->sense_buf;
-out:
-	if (ret != 0)
-		zbc_sg_cmd_destroy(cmd);
-
-	return ret;
-}
-
-static char *zbc_sg_cmd_name(zbc_sg_cmd_t *cmd)
-{
-	char *name;
-
-	if ((cmd->code >= 0)
-			&& (cmd->code < ZBC_SG_CMD_NUM)) {
-		name = zbc_sg_cmd_list[cmd->code].cdb_cmd_name;
-	} else {
-		name = "(UNKNOWN COMMAND)";
-	}
-
-	return name;
-}
-
-static void zbc_sg_set_sense(struct f2fs_configuration *c, uint8_t *sense_buf)
-{
-	if (sense_buf == NULL) {
-		c->zbd_errno.sk       = 0x00;
-		c->zbd_errno.asc_ascq = 0x0000;
-	} else {
-		if ((sense_buf[0] & 0x7F) == 0x72
-				|| (sense_buf[0] & 0x7F) == 0x73) {
-			/* store sense key, ASC/ASCQ */
-			c->zbd_errno.sk       = sense_buf[1] & 0x0F;
-			c->zbd_errno.asc_ascq = ((int)sense_buf[2] << 8) |
-							(int)sense_buf[3];
-		} else if ((sense_buf[0] & 0x7F) == 0x70
-				|| (sense_buf[0] & 0x7F) == 0x71) {
-			/* store sense key, ASC/ASCQ */
-			c->zbd_errno.sk       = sense_buf[2] & 0x0F;
-			c->zbd_errno.asc_ascq = ((int)sense_buf[12] << 8) |
-							(int)sense_buf[13];
-		}
-	}
-	return;
-}
-
-static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
-{
-	int ret;
-
-	/* Send the SG_IO command */
-	ret = ioctl(c->fd, SG_IO, &cmd->io_hdr);
-	if (ret) {
-		ERR_MSG("SG_IO ioctl failed (%s)\n", strerror(errno));
-		goto out;
-	}
-
-	/* Reset errno */
-	zbc_sg_set_sense(c, NULL);
-
-	DBG(1, "Command %s done: status 0x%02x (0x%02x), host status 0x%04x, driver status 0x%04x (flags 0x%04x)\n",
-			zbc_sg_cmd_name(cmd),
-			(unsigned int)cmd->io_hdr.status,
-			(unsigned int)cmd->io_hdr.masked_status,
-			(unsigned int)cmd->io_hdr.host_status,
-			(unsigned int)zbc_sg_cmd_driver_status(cmd),
-			(unsigned int)zbc_sg_cmd_driver_flags(cmd));
-
-	/* Check status */
-	if (((cmd->code == ZBC_SG_ATA12) || (cmd->code == ZBC_SG_ATA16))
-			&& (cmd->cdb[2] & (1 << 5)) ) {
-
-		/* ATA command status */
-		if (cmd->io_hdr.status != ZBC_SG_CHECK_CONDITION) {
-			zbc_sg_set_sense(c, cmd->sense_buf);
-			ret = -EIO;
-			goto out;
-		}
-
-		if ((zbc_sg_cmd_driver_status(cmd) == ZBC_SG_DRIVER_SENSE)
-				&& (cmd->io_hdr.sb_len_wr > 21)
-				&& (cmd->sense_buf[21] != 0x50) ) {
-			zbc_sg_set_sense(c, cmd->sense_buf);
-			ret = -EIO;
-			goto out;
-		}
-		cmd->io_hdr.status = 0;
-	}
-
-	if (cmd->io_hdr.status
-			|| (cmd->io_hdr.host_status != ZBC_SG_DID_OK)
-			|| (zbc_sg_cmd_driver_status(cmd) &&
-			(zbc_sg_cmd_driver_status(cmd) != ZBC_SG_DRIVER_SENSE)) ) {
-
-		ERR_MSG("Command %s failed with status 0x%02x (0x%02x), host status 0x%04x, driver status 0x%04x (flags 0x%04x)\n",
-				zbc_sg_cmd_name(cmd),
-				(unsigned int)cmd->io_hdr.status,
-				(unsigned int)cmd->io_hdr.masked_status,
-				(unsigned int)cmd->io_hdr.host_status,
-				(unsigned int)zbc_sg_cmd_driver_status(cmd),
-				(unsigned int)zbc_sg_cmd_driver_flags(cmd));
-		zbc_sg_set_sense(c, cmd->sense_buf);
-		ret = -EIO;
-		goto out;
-	}
-
-	if (cmd->io_hdr.resid) {
-		ERR_MSG("Transfer missing %d B of data\n",
-				cmd->io_hdr.resid);
-		cmd->out_bufsz -= cmd->io_hdr.resid;
-	}
-out:
-	return ret;
-}
-
-#define ZBC_SCSI_REPORT_ZONES_BUFSZ     524288
-
-int zbc_scsi_report_zones(struct f2fs_configuration *c)
-{
-	zbc_sg_cmd_t cmd;
-	uint8_t *buf;
-	zbc_zone_t *z, *zones = NULL;
-	int i, buf_nz, ret;
-	size_t bufsz;
-	uint32_t idx = 0, nr_zones = 0;
-	uint64_t next_lba = 0;
-	int phase = 0;
-next:
-	bufsz = ZBC_ZONE_DESCRIPTOR_OFFSET;
-	if (phase) {
-		if (c->nr_zones - idx == 0)
-			return 0;
-
-		bufsz += (size_t)(c->nr_zones - idx) *
-					ZBC_ZONE_DESCRIPTOR_LENGTH;
-		if (bufsz > ZBC_SCSI_REPORT_ZONES_BUFSZ)
-			bufsz = ZBC_SCSI_REPORT_ZONES_BUFSZ;
-	}
-
-	/* For in kernel ATA translation: align to 512 B */
-	bufsz = (bufsz + 511) & ~511;
-
-	/* Allocate and intialize report zones command */
-	ret = zbc_sg_cmd_init(&cmd, ZBC_SG_REPORT_ZONES, NULL, bufsz);
-	if (ret) {
-		ERR_MSG("zbc_sg_cmd_init failed\n");
-		return ret;
-	}
-
-	/* Fill command CDB:
-	 * +=============================================================================+
-	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
-	 * |Byte |        |        |        |        |        |        |        |        |
-	 * |=====+==========================+============================================|
-	 * | 0   |                           Operation Code (95h)                        |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 1   |      Reserved            |       Service Action (00h)                 |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 2   | (MSB)                                                                 |
-	 * |- - -+---                        Zone Start LBA                           ---|
-	 * | 9   |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 10  | (MSB)                                                                 |
-	 * |- - -+---                        Allocation Length                        ---|
-	 * | 13  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 14  |Partial |Reserved|                 Reporting Options                   |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 15  |                           Control                                     |
-	 * +=============================================================================+
-	 */
-	cmd.cdb[0] = ZBC_SG_REPORT_ZONES_CDB_OPCODE;
-	cmd.cdb[1] = ZBC_SG_REPORT_ZONES_CDB_SA;
-	zbc_sg_cmd_set_int64(&cmd.cdb[2], next_lba);
-	zbc_sg_cmd_set_int32(&cmd.cdb[10], (unsigned int) bufsz);
-	cmd.cdb[14] = 0;
-
-	/* Send the SG_IO command */
-	ret = zbc_sg_cmd_exec(c, &cmd);
-	if (ret != 0)
-		goto out;
-
-	if (cmd.out_bufsz < ZBC_ZONE_DESCRIPTOR_OFFSET) {
-		ERR_MSG("Not enough data received (need at least %d B, got %zu B)\n",
-				ZBC_ZONE_DESCRIPTOR_OFFSET,
-				cmd.out_bufsz);
-		ret = -EIO;
-		goto out;
-	}
-
-	/* Process output:
-	 * +=============================================================================+
-	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
-	 * |Byte |        |        |        |        |        |        |        |        |
-	 * |=====+=======================================================================|
-	 * |  0  | (MSB)                                                                 |
-	 * |- - -+---               Zone List Length (n - 64)                         ---|
-	 * |  3  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  4  |              Reserved             |               Same                |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  5  |                                                                       |
-	 * |- - -+---                        Reserved                                 ---|
-	 * |  7  |                                                                       |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  8  | (MSB)                                                                 |
-	 * |- - -+---                      Maximum LBA                                ---|
-	 * | 15  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 16  | (MSB)                                                                 |
-	 * |- - -+---                        Reserved                                 ---|
-	 * | 63  |                                                                 (LSB) |
-	 * |=====+=======================================================================|
-	 * |     |                       Vendor-Specific Parameters                      |
-	 * |=====+=======================================================================|
-	 * | 64  | (MSB)                                                                 |
-	 * |- - -+---                  Zone Descriptor [first]                        ---|
-	 * | 127 |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |                                    .                                        |
-	 * |                                    .                                        |
-	 * |                                    .                                        |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |n-63 |                                                                       |
-	 * |- - -+---                   Zone Descriptor [last]                        ---|
-	 * | n   |                                                                       |
-	 * +=============================================================================+
-	 */
-
-	/* Get number of zones in result */
-	buf = (uint8_t *)cmd.out_buf;
-	nr_zones = zbc_sg_cmd_get_int32(buf) / ZBC_ZONE_DESCRIPTOR_LENGTH;
-
-	/* read # of zones and then get all the zone info */
-	if (phase == 0) {
-		c->nr_zones = nr_zones;
-		c->nr_conventional = 0;
-		zbc_sg_cmd_destroy(&cmd);
-		phase++;
-		goto next;
-	}
-
-	if (nr_zones > c->nr_zones - idx)
-		nr_zones = c->nr_zones - idx;
-
-	buf_nz = (cmd.out_bufsz - ZBC_ZONE_DESCRIPTOR_OFFSET) /
-						ZBC_ZONE_DESCRIPTOR_LENGTH;
-	if (nr_zones > buf_nz)
-		nr_zones = buf_nz;
-
-	if (!nr_zones) {
-		ERR_MSG("No more zones\n");
-		goto out;
-	}
-
-	/* Allocate zone array */
-	zones = (zbc_zone_t *)malloc(sizeof(zbc_zone_t) * nr_zones);
-	if (!zones) {
-		ERR_MSG("No memory\n");
-		goto out;
-	}
-	memset(zones, 0, sizeof(zbc_zone_t) * nr_zones);
-
-	/* Get zone descriptors:
-	 * +=============================================================================+
-	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
-	 * |Byte |        |        |        |        |        |        |        |        |
-	 * |=====+=======================================================================|
-	 * |  0  |             Reserved              |            Zone type              |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  1  |          Zone condition           |    Reserved     |non-seq |  Reset |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  2  |                                                                       |
-	 * |- - -+---                             Reserved                            ---|
-	 * |  7  |                                                                       |
-	 * |-----+-----------------------------------------------------------------------|
-	 * |  8  | (MSB)                                                                 |
-	 * |- - -+---                           Zone Length                           ---|
-	 * | 15  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 16  | (MSB)                                                                 |
-	 * |- - -+---                          Zone Start LBA                         ---|
-	 * | 23  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 24  | (MSB)                                                                 |
-	 * |- - -+---                         Write Pointer LBA                       ---|
-	 * | 31  |                                                                 (LSB) |
-	 * |-----+-----------------------------------------------------------------------|
-	 * | 32  |                                                                       |
-	 * |- - -+---                             Reserved                            ---|
-	 * | 63  |                                                                       |
-	 * +=============================================================================+
-	 */
-	buf += ZBC_ZONE_DESCRIPTOR_OFFSET;
-
-	for(i = 0; i < nr_zones; i++) {
-		zones[i].zbz_type = buf[0] & 0x0f;
-		zones[i].zbz_condition = (buf[1] >> 4) & 0x0f;
-		zones[i].zbz_length = zbc_sg_cmd_get_int64(&buf[8]);
-		zones[i].zbz_start = zbc_sg_cmd_get_int64(&buf[16]);
-		zones[i].zbz_write_pointer = zbc_sg_cmd_get_int64(&buf[24]);
-		zones[i].zbz_flags = buf[1] & 0x03;
-
-		buf += ZBC_ZONE_DESCRIPTOR_LENGTH;
-	}
-
-	for (i = 0; i < nr_zones; i++) {
-		z = &zones[i];
-		if ( zbc_zone_conventional(z) ) {
-			c->nr_conventional++;
-			DBG(1, "Zone %05d: type 0x%x (%s), cond 0x%x (%s), LBA %llu, %llu sectors, wp N/A\n",
-				i + idx,
-				zbc_zone_type(z),
-				zbc_zone_type_str(zbc_zone_type(z)),
-				zbc_zone_condition(z),
-				zbc_zone_condition_str(zbc_zone_condition(z)),
-				zbc_zone_start_lba(z),
-				zbc_zone_length(z));
-		} else {
-			DBG(1, "Zone %05d: type 0x%x (%s), cond 0x%x (%s), need_reset %d, non_seq %d, LBA %llu, %llu sectors, wp %llu\n",
-				i + idx,
-				zbc_zone_type(z),
-				zbc_zone_type_str(zbc_zone_type(z)),
-				zbc_zone_condition(z),
-				zbc_zone_condition_str(zbc_zone_condition(z)),
-				zbc_zone_need_reset(z),
-				zbc_zone_non_seq(z),
-				zbc_zone_start_lba(z),
-				zbc_zone_length(z),
-				zbc_zone_wp_lba(z));
-		}
-	}
-
-	idx += nr_zones;
-	next_lba = zones[nr_zones - 1].zbz_start + zones[nr_zones - 1].zbz_length;
-	c->zone_sectors = zones[nr_zones - 1].zbz_length;
-	phase++;
-	zbc_sg_cmd_destroy(&cmd);
-	free(zones);
-	goto next;
-out:
-	zbc_sg_cmd_destroy(&cmd);
-	return ret;
-}
diff --git a/lib/zbc.h b/lib/zbc.h
deleted file mode 100644
index 15692c1..0000000
--- a/lib/zbc.h
+++ /dev/null
@@ -1,361 +0,0 @@
-/*
- * This file is copied from libzbc.
- *
- * Copyright (C) 2009-2014, HGST, Inc.  All rights reserved.
- *
- * This software is distributed under the terms of the BSD 2-clause license,
- * "as is," without technical support, and WITHOUT ANY WARRANTY, without
- * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- * PURPOSE. You should have received a copy of the BSD 2-clause license along
- * with libzbc. If not, see  <http://opensource.org/licenses/BSD-2-Clause>.
- *
- * Author: Damien Le Moal (damien.lemoal@hgst.com)
- *         Christophe Louargant (christophe.louargant@hgst.com)
- */
-
-#ifndef __LIBZBC_SG_H__
-#define __LIBZBC_SG_H__
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <linux/types.h>
-#include <sys/types.h>
-#include <sys/ioctl.h>
-#include <scsi/scsi.h>
-#include <scsi/sg.h>
-
-#define zbc_error(format, args...)			\
-	fprintf(stderr, "[ERROR] " format, ##args)
-
-/**
- * SG SCSI command names.
- */
-enum {
-
-	ZBC_SG_TEST_UNIT_READY = 0,
-	ZBC_SG_INQUIRY,
-	ZBC_SG_READ_CAPACITY,
-	ZBC_SG_READ,
-	ZBC_SG_WRITE,
-	ZBC_SG_SYNC_CACHE,
-	ZBC_SG_REPORT_ZONES,
-	ZBC_SG_OPEN_ZONE,
-	ZBC_SG_CLOSE_ZONE,
-	ZBC_SG_FINISH_ZONE,
-	ZBC_SG_RESET_WRITE_POINTER,
-	ZBC_SG_SET_ZONES,
-	ZBC_SG_SET_WRITE_POINTER,
-	ZBC_SG_ATA12,
-	ZBC_SG_ATA16,
-
-	ZBC_SG_CMD_NUM,
-};
-
-/**
- * Test unit ready command definition.
- */
-#define ZBC_SG_TEST_UNIT_READY_CDB_OPCODE       0x00
-#define ZBC_SG_TEST_UNIT_READY_CDB_LENGTH       6
-#define ZBC_ZONE_DESCRIPTOR_LENGTH		64
-
-/**
- * Number of bytes in the buffer before the first Zone Descriptor.
- */
-#define ZBC_ZONE_DESCRIPTOR_OFFSET		64
-
-/**
- * Inquiry command definition.
- */
-#define ZBC_SG_INQUIRY_CDB_OPCODE               0x12
-#define ZBC_SG_INQUIRY_CDB_LENGTH               6
-#define ZBC_SG_INQUIRY_REPLY_LEN                96
-#define ZBC_SG_INQUIRY_REPLY_LEN_VPD_PAGE_B1    64
-#define ZBC_SG_INQUIRY_REPLY_LEN_VPD_PAGE_B6    64
-
-/**
- * Read capacity command definition.
- */
-#define ZBC_SG_READ_CAPACITY_CDB_OPCODE         0x9E
-#define ZBC_SG_READ_CAPACITY_CDB_SA             0x10
-#define ZBC_SG_READ_CAPACITY_CDB_LENGTH         16
-#define ZBC_SG_READ_CAPACITY_REPLY_LEN          32
-
-/**
- * Read command definition.
- */
-#define ZBC_SG_READ_CDB_OPCODE                  0x88
-#define ZBC_SG_READ_CDB_LENGTH                  16
-
-/**
- * Write command definition.
- */
-#define ZBC_SG_WRITE_CDB_OPCODE                 0x8A
-#define ZBC_SG_WRITE_CDB_LENGTH                 16
-
-/**
- * Sync cache command definition.
- */
-#define ZBC_SG_SYNC_CACHE_CDB_OPCODE            0x91
-#define ZBC_SG_SYNC_CACHE_CDB_LENGTH            16
-
-/**
- * Report zones command definition.
- */
-#define ZBC_SG_REPORT_ZONES_CDB_OPCODE          0x95
-#define ZBC_SG_REPORT_ZONES_CDB_SA              0x00
-#define ZBC_SG_REPORT_ZONES_CDB_LENGTH          16
-
-/**
- * Open zone command definition.
- */
-#define ZBC_SG_OPEN_ZONE_CDB_OPCODE             0x94
-#define ZBC_SG_OPEN_ZONE_CDB_SA                 0x03
-#define ZBC_SG_OPEN_ZONE_CDB_LENGTH             16
-
-/**
- * Close zone command definition.
- */
-#define ZBC_SG_CLOSE_ZONE_CDB_OPCODE            0x94
-#define ZBC_SG_CLOSE_ZONE_CDB_SA                0x01
-#define ZBC_SG_CLOSE_ZONE_CDB_LENGTH            16
-
-/**
- * Finish zone command definition.
- */
-#define ZBC_SG_FINISH_ZONE_CDB_OPCODE           0x94
-#define ZBC_SG_FINISH_ZONE_CDB_SA               0x02
-#define ZBC_SG_FINISH_ZONE_CDB_LENGTH           16
-
-/**
- * Reset write pointer command definition.
- */
-#define ZBC_SG_RESET_WRITE_POINTER_CDB_OPCODE   0x94
-#define ZBC_SG_RESET_WRITE_POINTER_CDB_SA       0x04
-#define ZBC_SG_RESET_WRITE_POINTER_CDB_LENGTH   16
-
-/**
- * Set zones command definition.
- */
-#define ZBC_SG_SET_ZONES_CDB_OPCODE             0x9F
-#define ZBC_SG_SET_ZONES_CDB_SA                 0x15
-#define ZBC_SG_SET_ZONES_CDB_LENGTH             16
-
-/**
- * Set write pointer command definition.
- */
-#define ZBC_SG_SET_WRITE_POINTER_CDB_OPCODE     0x9F
-#define ZBC_SG_SET_WRITE_POINTER_CDB_SA         0x16
-#define ZBC_SG_SET_WRITE_POINTER_CDB_LENGTH     16
-
-/**
- * ATA pass through 12.
- */
-#define ZBC_SG_ATA12_CDB_OPCODE			0xA1
-#define ZBC_SG_ATA12_CDB_LENGTH			12
-
-/**
- * ATA pass through 16.
- */
-#define ZBC_SG_ATA16_CDB_OPCODE			0x85
-#define ZBC_SG_ATA16_CDB_LENGTH			16
-
-/**
- * Command sense buffer maximum length.
- */
-#define ZBC_SG_SENSE_MAX_LENGTH                 64
-
-/**
- * Maximum command CDB length.
- */
-#define ZBC_SG_CDB_MAX_LENGTH                   16
-
-/**
- * Status codes.
- */
-#define ZBC_SG_CHECK_CONDITION      		0x02
-
-/**
- * Host status codes.
- */
-#define ZBC_SG_DID_OK 				0x00 /* No error */
-#define ZBC_SG_DID_NO_CONNECT 			0x01 /* Couldn't connect before timeout period */
-#define ZBC_SG_DID_BUS_BUSY 			0x02 /* BUS stayed busy through time out period */
-#define ZBC_SG_DID_TIME_OUT 			0x03 /* Timed out for other reason */
-#define ZBC_SG_DID_BAD_TARGET 			0x04 /* Bad target, device not responding? */
-#define ZBC_SG_DID_ABORT 			0x05 /* Told to abort for some other reason. */
-#define ZBC_SG_DID_PARITY 			0x06 /* Parity error. */
-#define ZBC_SG_DID_ERROR 			0x07 /* Internal error detected in the host adapter. */
-#define ZBC_SG_DID_RESET 			0x08 /* The SCSI bus (or this device) has been reset. */
-#define ZBC_SG_DID_BAD_INTR 			0x09 /* Got an unexpected interrupt */
-#define ZBC_SG_DID_PASSTHROUGH 			0x0a /* Forced command past mid-layer. */
-#define ZBC_SG_DID_SOFT_ERROR 			0x0b /* The low level driver wants a retry. */
-
-/**
- * Driver status codes.
- */
-#define ZBC_SG_DRIVER_OK 			0x00
-#define ZBC_SG_DRIVER_BUSY 			0x01
-#define ZBC_SG_DRIVER_SOFT 			0x02
-#define ZBC_SG_DRIVER_MEDIA 			0x03
-#define ZBC_SG_DRIVER_ERROR 			0x04
-#define ZBC_SG_DRIVER_INVALID 			0x05
-#define ZBC_SG_DRIVER_TIMEOUT 			0x06
-#define ZBC_SG_DRIVER_HARD 			0x07
-#define ZBC_SG_DRIVER_SENSE         		0x08
-#define ZBC_SG_DRIVER_STATUS_MASK   		0x0f
-
-/**
- * Driver status code flags ('or'ed with code)
- */
-#define ZBC_SG_DRIVER_SUGGEST_RETRY 		0x10
-#define ZBC_SG_DRIVER_SUGGEST_ABORT 		0x20
-#define ZBC_SG_DRIVER_SUGGEST_REMAP 		0x30
-#define ZBC_SG_DRIVER_SUGGEST_DIE 		0x40
-#define ZBC_SG_DRIVER_SUGGEST_SENSE 		0x80
-#define ZBC_SG_DRIVER_FLAGS_MASK   		0xf0
-
-/***** Type definitions *****/
-
-/**
- * SG command descriptor. Used to process SCSI commands.
- */
-typedef struct zbc_sg_cmd {
-
-	int                 code;
-
-	int                 cdb_opcode;
-	int                 cdb_sa;
-	size_t              cdb_sz;
-	uint8_t             cdb[ZBC_SG_CDB_MAX_LENGTH];
-
-	size_t              sense_bufsz;
-	uint8_t             sense_buf[ZBC_SG_SENSE_MAX_LENGTH];
-
-	int                 out_buf_needfree;
-	size_t              out_bufsz;
-	uint8_t             *out_buf;
-
-	sg_io_hdr_t         io_hdr;
-
-} zbc_sg_cmd_t;
-
-/**
- * Zone descriptor.
- */
-struct zbc_zone {
-
-	uint64_t                    zbz_length;
-	uint64_t                    zbz_start;
-	uint64_t                    zbz_write_pointer;
-
-	uint8_t                     zbz_type;
-	uint8_t                     zbz_condition;
-	uint8_t                     zbz_flags;
-
-	uint8_t                     __pad[5];
-
-};
-typedef struct zbc_zone zbc_zone_t;
-
-#define ZBC_FORCE_ATA_RW       	0x40000000
-#define zbc_open_flags(f)           ((f) & ~ZBC_FORCE_ATA_RW)
-
-/**
- * Zone type.
- */
-enum zbc_zone_type {
-	ZBC_ZT_CONVENTIONAL         = 0x01,
-	ZBC_ZT_SEQUENTIAL_REQ       = 0x02,
-	ZBC_ZT_SEQUENTIAL_PREF      = 0x03,
-};
-#define zbc_zone_type(z)                ((int)(z)->zbz_type)
-
-#define zbc_zone_conventional(z)        ((z)->zbz_type == ZBC_ZT_CONVENTIONAL)
-static inline const char *zbc_zone_type_str(enum zbc_zone_type type)
-{
-	switch( type ) {
-	case ZBC_ZT_CONVENTIONAL:
-		return( "Conventional" );
-	case ZBC_ZT_SEQUENTIAL_REQ:
-		return( "Sequential-write-required" );
-	case ZBC_ZT_SEQUENTIAL_PREF:
-		return( "Sequential-write-preferred" );
-	}
-	return( "Unknown-type" );
-}
-
-/**
- * Zone condition.
- */
-enum zbc_zone_condition {
-	ZBC_ZC_NOT_WP               = 0x00,
-	ZBC_ZC_EMPTY                = 0x01,
-	ZBC_ZC_IMP_OPEN             = 0x02,
-	ZBC_ZC_EXP_OPEN             = 0x03,
-	ZBC_ZC_CLOSED               = 0x04,
-	ZBC_ZC_RDONLY               = 0x0d,
-	ZBC_ZC_FULL                 = 0x0e,
-	ZBC_ZC_OFFLINE              = 0x0f,
-};
-
-/**
- * zbc_zone_cond_str - returns a string describing a zone condition.
- * @zone: (IN)  ZBC_ZC_NOT_WP, ZBC_ZC_EMPTY, ZBC_ZC_IMP_OPEN, ZBC_ZC_EXP_OPEN,
- *              ZBC_ZC_CLOSED, ZBC_ZC_RDONLY, ZBC_ZC_FULL or ZBC_ZC_OFFLINE
- *
- * Returns a string describing a zone condition.
- */
-static inline const char *zbc_zone_condition_str(enum zbc_zone_condition cond)
-{
-	switch( cond ) {
-	case ZBC_ZC_NOT_WP:
-		return "Not-write-pointer";
-	case ZBC_ZC_EMPTY:
-		return "Empty";
-	case ZBC_ZC_IMP_OPEN:
-		return "Implicit-open";
-	case ZBC_ZC_EXP_OPEN:
-		return "Explicit-open";
-	case ZBC_ZC_CLOSED:
-		return "Closed";
-	case ZBC_ZC_RDONLY:
-		return "Read-only";
-	case ZBC_ZC_FULL:
-		return "Full";
-	case ZBC_ZC_OFFLINE:
-		return "Offline";
-	}
-	return "Unknown-cond";
-}
-
-#define zbc_zone_condition(z)           ((int)(z)->zbz_condition)
-#define zbc_zone_start_lba(z)           ((unsigned long long)((z)->zbz_start))
-#define zbc_zone_length(z)              ((unsigned long long)((z)->zbz_length))
-#define zbc_zone_wp_lba(z)              ((unsigned long long)((z)->zbz_write_pointer))
-
-/**
- * Zone flags: need reset, and non-seq write.
- */
-enum zbc_zone_flags {
-	ZBC_ZF_NEED_RESET           = 0x0001,
-	ZBC_ZF_NON_SEQ              = 0x0002,
-};
-#define zbc_zone_need_reset(z)          (((z)->zbz_flags & ZBC_ZF_NEED_RESET) != 0)
-#define zbc_zone_non_seq(z)          	(((z)->zbz_flags & ZBC_ZF_NON_SEQ) != 0)
-
-#define zbc_sg_cmd_driver_status(cmd)		((cmd)->io_hdr.driver_status & ZBC_SG_DRIVER_STATUS_MASK)
-#define zbc_sg_cmd_driver_flags(cmd)		((cmd)->io_hdr.driver_status & ZBC_SG_DRIVER_FLAGS_MASK)
-
-union converter {
-	uint8_t         val_buf[8];
-	uint16_t        val16;
-	uint32_t        val32;
-	uint64_t        val64;
-};
-
-#endif /* __LIBZBC_SG_H__ */
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
