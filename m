From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: ZBC device support
Date: Wed,  8 Jun 2016 10:24:02 -0700
Message-ID: <20160608172402.60280-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDH-0007hW-TP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDD-0006aY-AD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:19 +0000
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

This patch adds "-m" option to configure ZBC device.

This is to support host-managed SMR device and configure some major features
and on-disk layout in f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h       |  35 +++
 lib/Makefile.am         |   2 +-
 lib/libf2fs.c           |  17 ++
 lib/zbc.c               | 647 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/zbc.h               | 361 +++++++++++++++++++++++++++
 mkfs/f2fs_format.c      |   4 +-
 mkfs/f2fs_format_main.c |   9 +-
 7 files changed, 1069 insertions(+), 6 deletions(-)
 create mode 100644 lib/zbc.c
 create mode 100644 lib/zbc.h

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1cc08fd..1045ede 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -229,6 +229,32 @@ enum f2fs_config_func {
 	SLOAD,
 };
 
+enum zbc_sk {
+	ZBC_E_ILLEGAL_REQUEST         = 0x5,
+	ZBC_E_DATA_PROTECT            = 0x7,
+	ZBC_E_ABORTED_COMMAND         = 0xB,
+};
+
+/**
+ * Additional sense code/Additional sense code qualifier.
+ */
+enum zbc_asc_ascq {
+	ZBC_E_INVALID_FIELD_IN_CDB                  = 0x2400,
+	ZBC_E_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE    = 0x2100,
+	ZBC_E_UNALIGNED_WRITE_COMMAND               = 0x2104,
+	ZBC_E_WRITE_BOUNDARY_VIOLATION              = 0x2105,
+	ZBC_E_ATTEMPT_TO_READ_INVALID_DATA          = 0x2106,
+	ZBC_E_READ_BOUNDARY_VIOLATION               = 0x2107,
+	ZBC_E_ZONE_IS_READ_ONLY                     = 0x2708,
+	ZBC_E_INSUFFICIENT_ZONE_RESOURCES           = 0x550E,
+};
+
+struct zbc_errno {
+	enum zbc_sk		sk;
+	enum zbc_asc_ascq	asc_ascq;
+};
+typedef struct zbc_errno zbc_errno_t;
+
 struct f2fs_configuration {
 	u_int32_t sector_size;
 	u_int32_t reserved_segments;
@@ -273,6 +299,13 @@ struct f2fs_configuration {
 	/* sload parameters */
 	char *from_dir;
 	char *mount_point;
+
+	/* to detect zbc error */
+	int smr_mode;
+	u_int32_t nr_zones;
+	u_int32_t nr_conventional;
+	size_t zone_sectors;
+	zbc_errno_t zbd_errno;
 } __attribute__((packed));
 
 #ifdef CONFIG_64BIT
@@ -939,6 +972,8 @@ extern int dev_read_version(void *, __u64, size_t);
 extern void get_kernel_version(__u8 *);
 f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
+extern int zbc_scsi_report_zones(struct f2fs_configuration *);
+
 extern struct f2fs_configuration config;
 
 #define ALIGN(val, size)	((val) + (size) - 1) / (size)
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 37b8d57..91e4b4c 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -2,7 +2,7 @@
 
 lib_LTLIBRARIES = libf2fs.la
 
-libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c
+libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c zbc.c
 libf2fs_la_CFLAGS = -Wall
 libf2fs_la_CPPFLAGS = -I$(top_srcdir)/include
 libf2fs_la_LDFLAGS = -version-info $(LIBF2FS_CURRENT):$(LIBF2FS_REVISION):$(LIBF2FS_AGE)
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a8ad324..d4580f4 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -645,6 +645,23 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		MSG(0, "\tError: F2FS can support 16TB at most!!!\n");
 		return -1;
 	}
+
+	if (config.smr_mode) {
+		if (zbc_scsi_report_zones(c)) {
+			MSG(0, "\tError: Not proper SMR drive\n");
+			return -1;
+		}
+		MSG(0, "Info: SMR - ZONES = %u, CONV = %u, ZONE_SECTS = %lu\n",
+				c->nr_zones, c->nr_conventional,
+				c->zone_sectors);
+		if (c->segs_per_sec == 1)
+			c->segs_per_sec = c->zone_sectors /
+				c->sectors_per_blk / DEFAULT_BLOCKS_PER_SEGMENT;
+	}
+	c->segs_per_zone = c->segs_per_sec * c->secs_per_zone;
+
+	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
+	MSG(0, "Info: Sections per zone = %d\n", config.secs_per_zone);
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
 				c->total_sectors, (c->total_sectors *
diff --git a/lib/zbc.c b/lib/zbc.c
new file mode 100644
index 0000000..6ec2fc7
--- /dev/null
+++ b/lib/zbc.c
@@ -0,0 +1,647 @@
+/*
+ * This file is mostly copied from libzbc.
+ *
+ * Copyright (C) 2009-2014, HGST, Inc.  All rights reserved.
+ *
+ * This software is distributed under the terms of the BSD 2-clause license,
+ * "as is," without technical support, and WITHOUT ANY WARRANTY, without
+ * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE. You should have received a copy of the BSD 2-clause license along
+ * with libzbc. If not, see  <http://opensource.org/licenses/BSD-2-Clause>.
+ *
+ * Authors: Damien Le Moal (damien.lemoal@hgst.com)
+ *          Christophe Louargant (christophe.louargant@hgst.com)
+ *
+ * Integrated into f2fs-tools by:
+ *          Jaegeuk Kim (jaegeuk@kernel.org)
+ */
+
+#include <f2fs_fs.h>
+
+#include "zbc.h"
+
+static struct zbc_sg_cmd_s
+{
+
+    char                *cdb_cmd_name;
+    int                 cdb_opcode;
+    int                 cdb_sa;
+    size_t              cdb_length;
+    int			dir;
+
+} zbc_sg_cmd_list[ZBC_SG_CMD_NUM] = {
+
+    /* ZBC_SG_TEST_UNIT_READY */
+    {
+        "TEST UNIT READY",
+        ZBC_SG_TEST_UNIT_READY_CDB_OPCODE,
+        0,
+        ZBC_SG_TEST_UNIT_READY_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_INQUIRY */
+    {
+        "INQUIRY",
+        ZBC_SG_INQUIRY_CDB_OPCODE,
+        0,
+        ZBC_SG_INQUIRY_CDB_LENGTH,
+	SG_DXFER_FROM_DEV
+    },
+
+    /* ZBC_SG_READ_CAPACITY */
+    {
+        "READ CAPACITY 16",
+        ZBC_SG_READ_CAPACITY_CDB_OPCODE,
+        ZBC_SG_READ_CAPACITY_CDB_SA,
+        ZBC_SG_READ_CAPACITY_CDB_LENGTH,
+	SG_DXFER_FROM_DEV
+    },
+
+    /* ZBC_SG_READ */
+    {
+        "READ 16",
+        ZBC_SG_READ_CDB_OPCODE,
+        0,
+        ZBC_SG_READ_CDB_LENGTH,
+	SG_DXFER_FROM_DEV
+    },
+
+    /* ZBC_SG_WRITE */
+    {
+        "WRITE 16",
+        ZBC_SG_WRITE_CDB_OPCODE,
+        0,
+        ZBC_SG_WRITE_CDB_LENGTH,
+	SG_DXFER_TO_DEV
+    },
+
+    /* ZBC_SG_SYNC_CACHE */
+    {
+        "SYNCHRONIZE CACHE 16",
+        ZBC_SG_SYNC_CACHE_CDB_OPCODE,
+        0,
+        ZBC_SG_SYNC_CACHE_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_REPORT_ZONES */
+    {
+        "REPORT ZONES",
+        ZBC_SG_REPORT_ZONES_CDB_OPCODE,
+        ZBC_SG_REPORT_ZONES_CDB_SA,
+        ZBC_SG_REPORT_ZONES_CDB_LENGTH,
+	SG_DXFER_FROM_DEV
+    },
+
+    /* ZBC_SG_OPEN_ZONE */
+    {
+        "OPEN ZONE",
+        ZBC_SG_OPEN_ZONE_CDB_OPCODE,
+        ZBC_SG_OPEN_ZONE_CDB_SA,
+        ZBC_SG_OPEN_ZONE_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_CLOSE_ZONE */
+    {
+        "CLOSE ZONE",
+        ZBC_SG_CLOSE_ZONE_CDB_OPCODE,
+        ZBC_SG_CLOSE_ZONE_CDB_SA,
+        ZBC_SG_CLOSE_ZONE_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_FINISH_ZONE */
+    {
+        "FINISH ZONE",
+        ZBC_SG_FINISH_ZONE_CDB_OPCODE,
+        ZBC_SG_FINISH_ZONE_CDB_SA,
+        ZBC_SG_FINISH_ZONE_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_RESET_WRITE_POINTER */
+    {
+        "RESET WRITE POINTER",
+        ZBC_SG_RESET_WRITE_POINTER_CDB_OPCODE,
+        ZBC_SG_RESET_WRITE_POINTER_CDB_SA,
+        ZBC_SG_RESET_WRITE_POINTER_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_SET_ZONES */
+    {
+        "SET ZONES",
+        ZBC_SG_SET_ZONES_CDB_OPCODE,
+        ZBC_SG_SET_ZONES_CDB_SA,
+        ZBC_SG_SET_ZONES_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_SET_WRITE_POINTER */
+    {
+        "SET WRITE POINTER",
+        ZBC_SG_SET_WRITE_POINTER_CDB_OPCODE,
+        ZBC_SG_SET_WRITE_POINTER_CDB_SA,
+        ZBC_SG_SET_WRITE_POINTER_CDB_LENGTH,
+	SG_DXFER_NONE
+    },
+
+    /* ZBC_SG_ATA12 */
+    {
+	"ATA 12",
+	ZBC_SG_ATA12_CDB_OPCODE,
+	0,
+        ZBC_SG_ATA12_CDB_LENGTH,
+	0
+    },
+
+    /* ZBC_SG_ATA16 */
+    {
+	"ATA 16",
+	ZBC_SG_ATA16_CDB_OPCODE,
+	0,
+        ZBC_SG_ATA16_CDB_LENGTH,
+	0
+    }
+};
+
+static void zbc_sg_cmd_set_bytes(uint8_t *cmd, void *buf, int bytes)
+{
+	uint8_t *v = (uint8_t *) buf;
+	int i;
+
+	for (i = 0; i < bytes; i++) {
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		/* The least significant byte is stored last */
+		cmd[bytes - i - 1] = v[i];
+#else
+		/* The most significant byte is stored first */
+		cmd[i] = v[i];
+#endif
+	}
+	return;
+}
+
+static void zbc_sg_cmd_get_bytes(uint8_t *val, union converter *conv, int bytes)
+{
+	uint8_t *v = (uint8_t *) val;
+	int i;
+
+	memset(conv, 0, sizeof(union converter));
+
+	for(i = 0; i < bytes; i++) {
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		conv->val_buf[bytes - i - 1] = v[i];
+#else
+		conv->val_buf[i] = v[i];
+#endif
+	}
+	return;
+}
+
+static inline void zbc_sg_cmd_set_int64(uint8_t *buf, uint64_t val)
+{
+	zbc_sg_cmd_set_bytes(buf, &val, 8);
+	return;
+}
+
+static inline void zbc_sg_cmd_set_int32(uint8_t *buf, uint32_t val)
+{
+	zbc_sg_cmd_set_bytes(buf, &val, 4);
+	return;
+}
+
+static inline uint32_t zbc_sg_cmd_get_int32(uint8_t *buf)
+{
+	union converter conv;
+
+	zbc_sg_cmd_get_bytes(buf, &conv, 4);
+	return conv.val32;
+}
+
+static inline uint64_t zbc_sg_cmd_get_int64(uint8_t *buf)
+{
+	union converter conv;
+
+	zbc_sg_cmd_get_bytes(buf, &conv, 8);
+	return( conv.val64 );
+
+}
+
+static void zbc_sg_cmd_destroy(zbc_sg_cmd_t *cmd)
+{
+	/* Free the command */
+	if (!cmd)
+		return;
+
+	if (cmd->out_buf && cmd->out_buf_needfree) {
+		free(cmd->out_buf);
+		cmd->out_buf = NULL;
+		cmd->out_bufsz = 0;
+	}
+	memset(cmd, 0, sizeof(*cmd));
+	return;
+}
+
+static int zbc_sg_cmd_init(zbc_sg_cmd_t *cmd, int cmd_code,
+				uint8_t *out_buf, size_t out_bufsz)
+{
+	int ret = 0;
+
+	if ((!cmd) || (cmd_code < 0) || (cmd_code >= ZBC_SG_CMD_NUM) ) {
+		ERR_MSG("Invalid command specified\n");
+		return -EINVAL;
+	}
+
+	/* Set command */
+	memset(cmd, 0, sizeof(zbc_sg_cmd_t));
+	cmd->code = cmd_code;
+	cmd->cdb_sz = zbc_sg_cmd_list[cmd_code].cdb_length;
+	cmd->cdb_opcode = zbc_sg_cmd_list[cmd_code].cdb_opcode;
+	cmd->cdb_sa = zbc_sg_cmd_list[cmd_code].cdb_sa;
+
+	/* Set output buffer */
+	if (out_buf) {
+		/* Set specified buffer */
+		if (!out_bufsz) {
+			ERR_MSG("Invalid 0 output buffer size\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		cmd->out_buf = out_buf;
+		cmd->out_bufsz = out_bufsz;
+	} else if (out_bufsz) {
+		/* Allocate a buffer */
+		ret = posix_memalign((void **)&cmd->out_buf,
+				sysconf(_SC_PAGESIZE), out_bufsz);
+		if ( ret != 0 ) {
+			ERR_MSG("No memory for output buffer (%zu B)\n",
+					out_bufsz);
+			ret = -ENOMEM;
+			goto out;
+		}
+		memset(cmd->out_buf, 0, out_bufsz);
+		cmd->out_bufsz = out_bufsz;
+		cmd->out_buf_needfree = 1;
+	}
+
+	/* OK: setup SGIO header */
+	memset(&cmd->io_hdr, 0, sizeof(sg_io_hdr_t));
+
+	cmd->io_hdr.interface_id    = 'S';
+	cmd->io_hdr.timeout         = 20000;
+	cmd->io_hdr.flags           = 0; //SG_FLAG_DIRECT_IO;
+
+	cmd->io_hdr.cmd_len         = cmd->cdb_sz;
+	cmd->io_hdr.cmdp            = &cmd->cdb[0];
+
+	cmd->io_hdr.dxfer_direction = zbc_sg_cmd_list[cmd_code].dir;
+	cmd->io_hdr.dxfer_len       = cmd->out_bufsz;
+	cmd->io_hdr.dxferp          = cmd->out_buf;
+
+	cmd->io_hdr.mx_sb_len       = ZBC_SG_SENSE_MAX_LENGTH;
+	cmd->io_hdr.sbp             = cmd->sense_buf;
+out:
+	if (ret != 0)
+		zbc_sg_cmd_destroy(cmd);
+
+	return ret;
+}
+
+static char *zbc_sg_cmd_name(zbc_sg_cmd_t *cmd)
+{
+	char *name;
+
+	if ((cmd->code >= 0)
+			&& (cmd->code < ZBC_SG_CMD_NUM)) {
+		name = zbc_sg_cmd_list[cmd->code].cdb_cmd_name;
+	} else {
+		name = "(UNKNOWN COMMAND)";
+	}
+
+	return name;
+}
+
+static void zbc_sg_set_sense(struct f2fs_configuration *c, uint8_t *sense_buf)
+{
+	if (sense_buf == NULL) {
+		c->zbd_errno.sk       = 0x00;
+		c->zbd_errno.asc_ascq = 0x0000;
+	} else {
+		if ((sense_buf[0] & 0x7F) == 0x72
+				|| (sense_buf[0] & 0x7F) == 0x73) {
+			/* store sense key, ASC/ASCQ */
+			c->zbd_errno.sk       = sense_buf[1] & 0x0F;
+			c->zbd_errno.asc_ascq = ((int)sense_buf[2] << 8) |
+							(int)sense_buf[3];
+		} else if ((sense_buf[0] & 0x7F) == 0x70
+				|| (sense_buf[0] & 0x7F) == 0x71) {
+			/* store sense key, ASC/ASCQ */
+			c->zbd_errno.sk       = sense_buf[2] & 0x0F;
+			c->zbd_errno.asc_ascq = ((int)sense_buf[12] << 8) |
+							(int)sense_buf[13];
+		}
+	}
+	return;
+}
+
+static int zbc_sg_cmd_exec(struct f2fs_configuration *c, zbc_sg_cmd_t *cmd)
+{
+	int ret;
+
+	/* Send the SG_IO command */
+	ret = ioctl(c->fd, SG_IO, &cmd->io_hdr);
+	if (ret) {
+		ERR_MSG("SG_IO ioctl failed (%s)\n", strerror(errno));
+		goto out;
+	}
+
+	/* Reset errno */
+	zbc_sg_set_sense(c, NULL);
+
+	DBG(1, "Command %s done: status 0x%02x (0x%02x), host status 0x%04x, driver status 0x%04x (flags 0x%04x)\n",
+			zbc_sg_cmd_name(cmd),
+			(unsigned int)cmd->io_hdr.status,
+			(unsigned int)cmd->io_hdr.masked_status,
+			(unsigned int)cmd->io_hdr.host_status,
+			(unsigned int)zbc_sg_cmd_driver_status(cmd),
+			(unsigned int)zbc_sg_cmd_driver_flags(cmd));
+
+	/* Check status */
+	if (((cmd->code == ZBC_SG_ATA12) || (cmd->code == ZBC_SG_ATA16))
+			&& (cmd->cdb[2] & (1 << 5)) ) {
+
+		/* ATA command status */
+		if (cmd->io_hdr.status != ZBC_SG_CHECK_CONDITION) {
+			zbc_sg_set_sense(c, cmd->sense_buf);
+			ret = -EIO;
+			goto out;
+		}
+
+		if ((zbc_sg_cmd_driver_status(cmd) == ZBC_SG_DRIVER_SENSE)
+				&& (cmd->io_hdr.sb_len_wr > 21)
+				&& (cmd->sense_buf[21] != 0x50) ) {
+			zbc_sg_set_sense(c, cmd->sense_buf);
+			ret = -EIO;
+			goto out;
+		}
+		cmd->io_hdr.status = 0;
+	}
+
+	if (cmd->io_hdr.status
+			|| (cmd->io_hdr.host_status != ZBC_SG_DID_OK)
+			|| (zbc_sg_cmd_driver_status(cmd) &&
+			(zbc_sg_cmd_driver_status(cmd) != ZBC_SG_DRIVER_SENSE)) ) {
+
+		ERR_MSG("Command %s failed with status 0x%02x (0x%02x), host status 0x%04x, driver status 0x%04x (flags 0x%04x)\n",
+				zbc_sg_cmd_name(cmd),
+				(unsigned int)cmd->io_hdr.status,
+				(unsigned int)cmd->io_hdr.masked_status,
+				(unsigned int)cmd->io_hdr.host_status,
+				(unsigned int)zbc_sg_cmd_driver_status(cmd),
+				(unsigned int)zbc_sg_cmd_driver_flags(cmd));
+		zbc_sg_set_sense(c, cmd->sense_buf);
+		ret = -EIO;
+		goto out;
+	}
+
+	if (cmd->io_hdr.resid) {
+		ERR_MSG("Transfer missing %d B of data\n",
+				cmd->io_hdr.resid);
+		cmd->out_bufsz -= cmd->io_hdr.resid;
+	}
+out:
+	return ret;
+}
+
+#define ZBC_SCSI_REPORT_ZONES_BUFSZ     524288
+
+int zbc_scsi_report_zones(struct f2fs_configuration *c)
+{
+	zbc_sg_cmd_t cmd;
+	uint8_t *buf;
+	zbc_zone_t *z, *zones = NULL;
+	int i, buf_nz, ret;
+	size_t bufsz;
+	uint32_t idx = 0, nr_zones = 0;
+	uint64_t next_lba = 0;
+	int phase = 0;
+next:
+	bufsz = ZBC_ZONE_DESCRIPTOR_OFFSET;
+	if (phase) {
+		if (c->nr_zones - idx == 0)
+			return 0;
+
+		bufsz += (size_t)(c->nr_zones - idx) *
+					ZBC_ZONE_DESCRIPTOR_LENGTH;
+		if (bufsz > ZBC_SCSI_REPORT_ZONES_BUFSZ)
+			bufsz = ZBC_SCSI_REPORT_ZONES_BUFSZ;
+	}
+
+	/* For in kernel ATA translation: align to 512 B */
+	bufsz = (bufsz + 511) & ~511;
+
+	/* Allocate and intialize report zones command */
+	ret = zbc_sg_cmd_init(&cmd, ZBC_SG_REPORT_ZONES, NULL, bufsz);
+	if (ret) {
+		ERR_MSG("zbc_sg_cmd_init failed\n");
+		return ret;
+	}
+
+	/* Fill command CDB:
+	 * +=============================================================================+
+	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
+	 * |Byte |        |        |        |        |        |        |        |        |
+	 * |=====+==========================+============================================|
+	 * | 0   |                           Operation Code (95h)                        |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 1   |      Reserved            |       Service Action (00h)                 |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 2   | (MSB)                                                                 |
+	 * |- - -+---                        Zone Start LBA                           ---|
+	 * | 9   |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 10  | (MSB)                                                                 |
+	 * |- - -+---                        Allocation Length                        ---|
+	 * | 13  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 14  |Partial |Reserved|                 Reporting Options                   |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 15  |                           Control                                     |
+	 * +=============================================================================+
+	 */
+	cmd.cdb[0] = ZBC_SG_REPORT_ZONES_CDB_OPCODE;
+	cmd.cdb[1] = ZBC_SG_REPORT_ZONES_CDB_SA;
+	zbc_sg_cmd_set_int64(&cmd.cdb[2], next_lba);
+	zbc_sg_cmd_set_int32(&cmd.cdb[10], (unsigned int) bufsz);
+	cmd.cdb[14] = 0;
+
+	/* Send the SG_IO command */
+	ret = zbc_sg_cmd_exec(c, &cmd);
+	if (ret != 0)
+		goto out;
+
+	if (cmd.out_bufsz < ZBC_ZONE_DESCRIPTOR_OFFSET) {
+		ERR_MSG("Not enough data received (need at least %d B, got %zu B)\n",
+				ZBC_ZONE_DESCRIPTOR_OFFSET,
+				cmd.out_bufsz);
+		ret = -EIO;
+		goto out;
+	}
+
+	/* Process output:
+	 * +=============================================================================+
+	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
+	 * |Byte |        |        |        |        |        |        |        |        |
+	 * |=====+=======================================================================|
+	 * |  0  | (MSB)                                                                 |
+	 * |- - -+---               Zone List Length (n - 64)                         ---|
+	 * |  3  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  4  |              Reserved             |               Same                |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  5  |                                                                       |
+	 * |- - -+---                        Reserved                                 ---|
+	 * |  7  |                                                                       |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  8  | (MSB)                                                                 |
+	 * |- - -+---                      Maximum LBA                                ---|
+	 * | 15  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 16  | (MSB)                                                                 |
+	 * |- - -+---                        Reserved                                 ---|
+	 * | 63  |                                                                 (LSB) |
+	 * |=====+=======================================================================|
+	 * |     |                       Vendor-Specific Parameters                      |
+	 * |=====+=======================================================================|
+	 * | 64  | (MSB)                                                                 |
+	 * |- - -+---                  Zone Descriptor [first]                        ---|
+	 * | 127 |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |                                    .                                        |
+	 * |                                    .                                        |
+	 * |                                    .                                        |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |n-63 |                                                                       |
+	 * |- - -+---                   Zone Descriptor [last]                        ---|
+	 * | n   |                                                                       |
+	 * +=============================================================================+
+	 */
+
+	/* Get number of zones in result */
+	buf = (uint8_t *)cmd.out_buf;
+	nr_zones = zbc_sg_cmd_get_int32(buf) / ZBC_ZONE_DESCRIPTOR_LENGTH;
+
+	/* read # of zones and then get all the zone info */
+	if (phase == 0) {
+		c->nr_zones = nr_zones;
+		c->nr_conventional = 0;
+		zbc_sg_cmd_destroy(&cmd);
+		phase++;
+		goto next;
+	}
+
+	if (nr_zones > c->nr_zones - idx)
+		nr_zones = c->nr_zones - idx;
+
+	buf_nz = (cmd.out_bufsz - ZBC_ZONE_DESCRIPTOR_OFFSET) /
+						ZBC_ZONE_DESCRIPTOR_LENGTH;
+	if (nr_zones > buf_nz)
+		nr_zones = buf_nz;
+
+	if (!nr_zones) {
+		ERR_MSG("No more zones\n");
+		goto out;
+	}
+
+	/* Allocate zone array */
+	zones = (zbc_zone_t *)malloc(sizeof(zbc_zone_t) * nr_zones);
+	if (!zones) {
+		ERR_MSG("No memory\n");
+		goto out;
+	}
+	memset(zones, 0, sizeof(zbc_zone_t) * nr_zones);
+
+	/* Get zone descriptors:
+	 * +=============================================================================+
+	 * |  Bit|   7    |   6    |   5    |   4    |   3    |   2    |   1    |   0    |
+	 * |Byte |        |        |        |        |        |        |        |        |
+	 * |=====+=======================================================================|
+	 * |  0  |             Reserved              |            Zone type              |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  1  |          Zone condition           |    Reserved     |non-seq |  Reset |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  2  |                                                                       |
+	 * |- - -+---                             Reserved                            ---|
+	 * |  7  |                                                                       |
+	 * |-----+-----------------------------------------------------------------------|
+	 * |  8  | (MSB)                                                                 |
+	 * |- - -+---                           Zone Length                           ---|
+	 * | 15  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 16  | (MSB)                                                                 |
+	 * |- - -+---                          Zone Start LBA                         ---|
+	 * | 23  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 24  | (MSB)                                                                 |
+	 * |- - -+---                         Write Pointer LBA                       ---|
+	 * | 31  |                                                                 (LSB) |
+	 * |-----+-----------------------------------------------------------------------|
+	 * | 32  |                                                                       |
+	 * |- - -+---                             Reserved                            ---|
+	 * | 63  |                                                                       |
+	 * +=============================================================================+
+	 */
+	buf += ZBC_ZONE_DESCRIPTOR_OFFSET;
+
+	for(i = 0; i < nr_zones; i++) {
+		zones[i].zbz_type = buf[0] & 0x0f;
+		zones[i].zbz_condition = (buf[1] >> 4) & 0x0f;
+		zones[i].zbz_length = zbc_sg_cmd_get_int64(&buf[8]);
+		zones[i].zbz_start = zbc_sg_cmd_get_int64(&buf[16]);
+		zones[i].zbz_write_pointer = zbc_sg_cmd_get_int64(&buf[24]);
+		zones[i].zbz_flags = buf[1] & 0x03;
+
+		buf += ZBC_ZONE_DESCRIPTOR_LENGTH;
+	}
+
+	for (i = 0; i < nr_zones; i++) {
+		z = &zones[i];
+		if ( zbc_zone_conventional(z) ) {
+			c->nr_conventional++;
+			DBG(1, "Zone %05d: type 0x%x (%s), cond 0x%x (%s), LBA %llu, %llu sectors, wp N/A\n",
+				i + idx,
+				zbc_zone_type(z),
+				zbc_zone_type_str(zbc_zone_type(z)),
+				zbc_zone_condition(z),
+				zbc_zone_condition_str(zbc_zone_condition(z)),
+				zbc_zone_start_lba(z),
+				zbc_zone_length(z));
+		} else {
+			DBG(1, "Zone %05d: type 0x%x (%s), cond 0x%x (%s), need_reset %d, non_seq %d, LBA %llu, %llu sectors, wp %llu\n",
+				i + idx,
+				zbc_zone_type(z),
+				zbc_zone_type_str(zbc_zone_type(z)),
+				zbc_zone_condition(z),
+				zbc_zone_condition_str(zbc_zone_condition(z)),
+				zbc_zone_need_reset(z),
+				zbc_zone_non_seq(z),
+				zbc_zone_start_lba(z),
+				zbc_zone_length(z),
+				zbc_zone_wp_lba(z));
+		}
+	}
+
+	idx += nr_zones;
+	next_lba = zones[nr_zones - 1].zbz_start + zones[nr_zones - 1].zbz_length;
+	c->zone_sectors = zones[nr_zones - 1].zbz_length;
+	phase++;
+	zbc_sg_cmd_destroy(&cmd);
+	free(zones);
+	goto next;
+out:
+	zbc_sg_cmd_destroy(&cmd);
+	return ret;
+}
diff --git a/lib/zbc.h b/lib/zbc.h
new file mode 100644
index 0000000..15692c1
--- /dev/null
+++ b/lib/zbc.h
@@ -0,0 +1,361 @@
+/*
+ * This file is copied from libzbc.
+ *
+ * Copyright (C) 2009-2014, HGST, Inc.  All rights reserved.
+ *
+ * This software is distributed under the terms of the BSD 2-clause license,
+ * "as is," without technical support, and WITHOUT ANY WARRANTY, without
+ * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ * PURPOSE. You should have received a copy of the BSD 2-clause license along
+ * with libzbc. If not, see  <http://opensource.org/licenses/BSD-2-Clause>.
+ *
+ * Author: Damien Le Moal (damien.lemoal@hgst.com)
+ *         Christophe Louargant (christophe.louargant@hgst.com)
+ */
+
+#ifndef __LIBZBC_SG_H__
+#define __LIBZBC_SG_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <linux/types.h>
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <scsi/scsi.h>
+#include <scsi/sg.h>
+
+#define zbc_error(format, args...)			\
+	fprintf(stderr, "[ERROR] " format, ##args)
+
+/**
+ * SG SCSI command names.
+ */
+enum {
+
+	ZBC_SG_TEST_UNIT_READY = 0,
+	ZBC_SG_INQUIRY,
+	ZBC_SG_READ_CAPACITY,
+	ZBC_SG_READ,
+	ZBC_SG_WRITE,
+	ZBC_SG_SYNC_CACHE,
+	ZBC_SG_REPORT_ZONES,
+	ZBC_SG_OPEN_ZONE,
+	ZBC_SG_CLOSE_ZONE,
+	ZBC_SG_FINISH_ZONE,
+	ZBC_SG_RESET_WRITE_POINTER,
+	ZBC_SG_SET_ZONES,
+	ZBC_SG_SET_WRITE_POINTER,
+	ZBC_SG_ATA12,
+	ZBC_SG_ATA16,
+
+	ZBC_SG_CMD_NUM,
+};
+
+/**
+ * Test unit ready command definition.
+ */
+#define ZBC_SG_TEST_UNIT_READY_CDB_OPCODE       0x00
+#define ZBC_SG_TEST_UNIT_READY_CDB_LENGTH       6
+#define ZBC_ZONE_DESCRIPTOR_LENGTH		64
+
+/**
+ * Number of bytes in the buffer before the first Zone Descriptor.
+ */
+#define ZBC_ZONE_DESCRIPTOR_OFFSET		64
+
+/**
+ * Inquiry command definition.
+ */
+#define ZBC_SG_INQUIRY_CDB_OPCODE               0x12
+#define ZBC_SG_INQUIRY_CDB_LENGTH               6
+#define ZBC_SG_INQUIRY_REPLY_LEN                96
+#define ZBC_SG_INQUIRY_REPLY_LEN_VPD_PAGE_B1    64
+#define ZBC_SG_INQUIRY_REPLY_LEN_VPD_PAGE_B6    64
+
+/**
+ * Read capacity command definition.
+ */
+#define ZBC_SG_READ_CAPACITY_CDB_OPCODE         0x9E
+#define ZBC_SG_READ_CAPACITY_CDB_SA             0x10
+#define ZBC_SG_READ_CAPACITY_CDB_LENGTH         16
+#define ZBC_SG_READ_CAPACITY_REPLY_LEN          32
+
+/**
+ * Read command definition.
+ */
+#define ZBC_SG_READ_CDB_OPCODE                  0x88
+#define ZBC_SG_READ_CDB_LENGTH                  16
+
+/**
+ * Write command definition.
+ */
+#define ZBC_SG_WRITE_CDB_OPCODE                 0x8A
+#define ZBC_SG_WRITE_CDB_LENGTH                 16
+
+/**
+ * Sync cache command definition.
+ */
+#define ZBC_SG_SYNC_CACHE_CDB_OPCODE            0x91
+#define ZBC_SG_SYNC_CACHE_CDB_LENGTH            16
+
+/**
+ * Report zones command definition.
+ */
+#define ZBC_SG_REPORT_ZONES_CDB_OPCODE          0x95
+#define ZBC_SG_REPORT_ZONES_CDB_SA              0x00
+#define ZBC_SG_REPORT_ZONES_CDB_LENGTH          16
+
+/**
+ * Open zone command definition.
+ */
+#define ZBC_SG_OPEN_ZONE_CDB_OPCODE             0x94
+#define ZBC_SG_OPEN_ZONE_CDB_SA                 0x03
+#define ZBC_SG_OPEN_ZONE_CDB_LENGTH             16
+
+/**
+ * Close zone command definition.
+ */
+#define ZBC_SG_CLOSE_ZONE_CDB_OPCODE            0x94
+#define ZBC_SG_CLOSE_ZONE_CDB_SA                0x01
+#define ZBC_SG_CLOSE_ZONE_CDB_LENGTH            16
+
+/**
+ * Finish zone command definition.
+ */
+#define ZBC_SG_FINISH_ZONE_CDB_OPCODE           0x94
+#define ZBC_SG_FINISH_ZONE_CDB_SA               0x02
+#define ZBC_SG_FINISH_ZONE_CDB_LENGTH           16
+
+/**
+ * Reset write pointer command definition.
+ */
+#define ZBC_SG_RESET_WRITE_POINTER_CDB_OPCODE   0x94
+#define ZBC_SG_RESET_WRITE_POINTER_CDB_SA       0x04
+#define ZBC_SG_RESET_WRITE_POINTER_CDB_LENGTH   16
+
+/**
+ * Set zones command definition.
+ */
+#define ZBC_SG_SET_ZONES_CDB_OPCODE             0x9F
+#define ZBC_SG_SET_ZONES_CDB_SA                 0x15
+#define ZBC_SG_SET_ZONES_CDB_LENGTH             16
+
+/**
+ * Set write pointer command definition.
+ */
+#define ZBC_SG_SET_WRITE_POINTER_CDB_OPCODE     0x9F
+#define ZBC_SG_SET_WRITE_POINTER_CDB_SA         0x16
+#define ZBC_SG_SET_WRITE_POINTER_CDB_LENGTH     16
+
+/**
+ * ATA pass through 12.
+ */
+#define ZBC_SG_ATA12_CDB_OPCODE			0xA1
+#define ZBC_SG_ATA12_CDB_LENGTH			12
+
+/**
+ * ATA pass through 16.
+ */
+#define ZBC_SG_ATA16_CDB_OPCODE			0x85
+#define ZBC_SG_ATA16_CDB_LENGTH			16
+
+/**
+ * Command sense buffer maximum length.
+ */
+#define ZBC_SG_SENSE_MAX_LENGTH                 64
+
+/**
+ * Maximum command CDB length.
+ */
+#define ZBC_SG_CDB_MAX_LENGTH                   16
+
+/**
+ * Status codes.
+ */
+#define ZBC_SG_CHECK_CONDITION      		0x02
+
+/**
+ * Host status codes.
+ */
+#define ZBC_SG_DID_OK 				0x00 /* No error */
+#define ZBC_SG_DID_NO_CONNECT 			0x01 /* Couldn't connect before timeout period */
+#define ZBC_SG_DID_BUS_BUSY 			0x02 /* BUS stayed busy through time out period */
+#define ZBC_SG_DID_TIME_OUT 			0x03 /* Timed out for other reason */
+#define ZBC_SG_DID_BAD_TARGET 			0x04 /* Bad target, device not responding? */
+#define ZBC_SG_DID_ABORT 			0x05 /* Told to abort for some other reason. */
+#define ZBC_SG_DID_PARITY 			0x06 /* Parity error. */
+#define ZBC_SG_DID_ERROR 			0x07 /* Internal error detected in the host adapter. */
+#define ZBC_SG_DID_RESET 			0x08 /* The SCSI bus (or this device) has been reset. */
+#define ZBC_SG_DID_BAD_INTR 			0x09 /* Got an unexpected interrupt */
+#define ZBC_SG_DID_PASSTHROUGH 			0x0a /* Forced command past mid-layer. */
+#define ZBC_SG_DID_SOFT_ERROR 			0x0b /* The low level driver wants a retry. */
+
+/**
+ * Driver status codes.
+ */
+#define ZBC_SG_DRIVER_OK 			0x00
+#define ZBC_SG_DRIVER_BUSY 			0x01
+#define ZBC_SG_DRIVER_SOFT 			0x02
+#define ZBC_SG_DRIVER_MEDIA 			0x03
+#define ZBC_SG_DRIVER_ERROR 			0x04
+#define ZBC_SG_DRIVER_INVALID 			0x05
+#define ZBC_SG_DRIVER_TIMEOUT 			0x06
+#define ZBC_SG_DRIVER_HARD 			0x07
+#define ZBC_SG_DRIVER_SENSE         		0x08
+#define ZBC_SG_DRIVER_STATUS_MASK   		0x0f
+
+/**
+ * Driver status code flags ('or'ed with code)
+ */
+#define ZBC_SG_DRIVER_SUGGEST_RETRY 		0x10
+#define ZBC_SG_DRIVER_SUGGEST_ABORT 		0x20
+#define ZBC_SG_DRIVER_SUGGEST_REMAP 		0x30
+#define ZBC_SG_DRIVER_SUGGEST_DIE 		0x40
+#define ZBC_SG_DRIVER_SUGGEST_SENSE 		0x80
+#define ZBC_SG_DRIVER_FLAGS_MASK   		0xf0
+
+/***** Type definitions *****/
+
+/**
+ * SG command descriptor. Used to process SCSI commands.
+ */
+typedef struct zbc_sg_cmd {
+
+	int                 code;
+
+	int                 cdb_opcode;
+	int                 cdb_sa;
+	size_t              cdb_sz;
+	uint8_t             cdb[ZBC_SG_CDB_MAX_LENGTH];
+
+	size_t              sense_bufsz;
+	uint8_t             sense_buf[ZBC_SG_SENSE_MAX_LENGTH];
+
+	int                 out_buf_needfree;
+	size_t              out_bufsz;
+	uint8_t             *out_buf;
+
+	sg_io_hdr_t         io_hdr;
+
+} zbc_sg_cmd_t;
+
+/**
+ * Zone descriptor.
+ */
+struct zbc_zone {
+
+	uint64_t                    zbz_length;
+	uint64_t                    zbz_start;
+	uint64_t                    zbz_write_pointer;
+
+	uint8_t                     zbz_type;
+	uint8_t                     zbz_condition;
+	uint8_t                     zbz_flags;
+
+	uint8_t                     __pad[5];
+
+};
+typedef struct zbc_zone zbc_zone_t;
+
+#define ZBC_FORCE_ATA_RW       	0x40000000
+#define zbc_open_flags(f)           ((f) & ~ZBC_FORCE_ATA_RW)
+
+/**
+ * Zone type.
+ */
+enum zbc_zone_type {
+	ZBC_ZT_CONVENTIONAL         = 0x01,
+	ZBC_ZT_SEQUENTIAL_REQ       = 0x02,
+	ZBC_ZT_SEQUENTIAL_PREF      = 0x03,
+};
+#define zbc_zone_type(z)                ((int)(z)->zbz_type)
+
+#define zbc_zone_conventional(z)        ((z)->zbz_type == ZBC_ZT_CONVENTIONAL)
+static inline const char *zbc_zone_type_str(enum zbc_zone_type type)
+{
+	switch( type ) {
+	case ZBC_ZT_CONVENTIONAL:
+		return( "Conventional" );
+	case ZBC_ZT_SEQUENTIAL_REQ:
+		return( "Sequential-write-required" );
+	case ZBC_ZT_SEQUENTIAL_PREF:
+		return( "Sequential-write-preferred" );
+	}
+	return( "Unknown-type" );
+}
+
+/**
+ * Zone condition.
+ */
+enum zbc_zone_condition {
+	ZBC_ZC_NOT_WP               = 0x00,
+	ZBC_ZC_EMPTY                = 0x01,
+	ZBC_ZC_IMP_OPEN             = 0x02,
+	ZBC_ZC_EXP_OPEN             = 0x03,
+	ZBC_ZC_CLOSED               = 0x04,
+	ZBC_ZC_RDONLY               = 0x0d,
+	ZBC_ZC_FULL                 = 0x0e,
+	ZBC_ZC_OFFLINE              = 0x0f,
+};
+
+/**
+ * zbc_zone_cond_str - returns a string describing a zone condition.
+ * @zone: (IN)  ZBC_ZC_NOT_WP, ZBC_ZC_EMPTY, ZBC_ZC_IMP_OPEN, ZBC_ZC_EXP_OPEN,
+ *              ZBC_ZC_CLOSED, ZBC_ZC_RDONLY, ZBC_ZC_FULL or ZBC_ZC_OFFLINE
+ *
+ * Returns a string describing a zone condition.
+ */
+static inline const char *zbc_zone_condition_str(enum zbc_zone_condition cond)
+{
+	switch( cond ) {
+	case ZBC_ZC_NOT_WP:
+		return "Not-write-pointer";
+	case ZBC_ZC_EMPTY:
+		return "Empty";
+	case ZBC_ZC_IMP_OPEN:
+		return "Implicit-open";
+	case ZBC_ZC_EXP_OPEN:
+		return "Explicit-open";
+	case ZBC_ZC_CLOSED:
+		return "Closed";
+	case ZBC_ZC_RDONLY:
+		return "Read-only";
+	case ZBC_ZC_FULL:
+		return "Full";
+	case ZBC_ZC_OFFLINE:
+		return "Offline";
+	}
+	return "Unknown-cond";
+}
+
+#define zbc_zone_condition(z)           ((int)(z)->zbz_condition)
+#define zbc_zone_start_lba(z)           ((unsigned long long)((z)->zbz_start))
+#define zbc_zone_length(z)              ((unsigned long long)((z)->zbz_length))
+#define zbc_zone_wp_lba(z)              ((unsigned long long)((z)->zbz_write_pointer))
+
+/**
+ * Zone flags: need reset, and non-seq write.
+ */
+enum zbc_zone_flags {
+	ZBC_ZF_NEED_RESET           = 0x0001,
+	ZBC_ZF_NON_SEQ              = 0x0002,
+};
+#define zbc_zone_need_reset(z)          (((z)->zbz_flags & ZBC_ZF_NEED_RESET) != 0)
+#define zbc_zone_non_seq(z)          	(((z)->zbz_flags & ZBC_ZF_NON_SEQ) != 0)
+
+#define zbc_sg_cmd_driver_status(cmd)		((cmd)->io_hdr.driver_status & ZBC_SG_DRIVER_STATUS_MASK)
+#define zbc_sg_cmd_driver_flags(cmd)		((cmd)->io_hdr.driver_status & ZBC_SG_DRIVER_FLAGS_MASK)
+
+union converter {
+	uint8_t         val_buf[8];
+	uint16_t        val16;
+	uint32_t        val32;
+	uint64_t        val64;
+};
+
+#endif /* __LIBZBC_SG_H__ */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 960031e..3173c30 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -703,6 +703,8 @@ static int f2fs_write_super_block(void)
 #ifndef WITH_ANDROID
 static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 {
+	if (config.smr_mode)
+		return 0;
 	do {
 		if (offset < get_sb(main_blkaddr) ||
 			offset >= get_sb(main_blkaddr) + get_sb(block_count))
@@ -781,7 +783,7 @@ static int f2fs_write_root_inode(void)
 					config.blks_per_seg;
         main_area_node_seg_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting root inode (hot node), at offset 0x%08"PRIx64"\n", main_area_node_seg_blk_offset);
+	DBG(1, "\tWriting root inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n", get_sb(main_blkaddr), config.cur_seg[CURSEG_HOT_NODE], config.blks_per_seg, main_area_node_seg_blk_offset/512);
 	if (dev_write(raw_node, main_area_node_seg_blk_offset, F2FS_BLKSIZE)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
 		free(raw_node);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 243f0e9..8bd938c 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -38,6 +38,7 @@ static void mkfs_usage()
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
+	MSG(0, "  -m support SMR device [default:0]\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
 }
@@ -56,8 +57,6 @@ static void f2fs_show_info()
 
 	if (config.vol_label)
 		MSG(0, "Info: Label = %s\n", config.vol_label);
-	MSG(0, "Info: Segments per section = %d\n", config.segs_per_sec);
-	MSG(0, "Info: Sections per zone = %d\n", config.secs_per_zone);
 	MSG(0, "Info: Trim is %s\n", config.trim ? "enabled": "disabled");
 }
 
@@ -73,7 +72,7 @@ static void parse_feature(char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:d:e:l:o:O:s:z:t:";
+	static const char *option_string = "qa:d:e:l:mo:O:s:z:t:";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -98,6 +97,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 			}
 			config.vol_label = optarg;
 			break;
+		case 'm':
+			config.smr_mode = 1;
+			break;
 		case 'o':
 			config.overprovision = atof(optarg);
 			break;
@@ -128,7 +130,6 @@ static void f2fs_parse_options(int argc, char *argv[])
 
 	if ((optind + 1) < argc)
 		config.total_sectors = atoll(argv[optind+1]);
-	config.segs_per_zone = config.segs_per_sec * config.secs_per_zone;
 }
 
 int main(int argc, char *argv[])
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
