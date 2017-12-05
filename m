From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: Windows Android SDK support
Date: Mon,  4 Dec 2017 18:46:38 -0800
Message-ID: <20171205024638.52697-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eM3GB-0002Um-58
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Dec 2017 02:47:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eM3G9-00073V-II
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Dec 2017 02:47:03 +0000
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
Cc: Hyojun Kim <hyojun@google.com>

From: Hyojun Kim <hyojun@google.com>

This patch enables cross compilation for Windows Android SDK
by using ANDROID_WINDOWS_HOST.

Signed-off-by: Hyojun Kim <hyojun@google.com>
---
 include/android_config.h |   4 ++
 include/f2fs_fs.h        |  37 +++++++++++++++-
 include/quota.h          |   3 ++
 lib/libf2fs.c            | 112 ++++++++++++++++++++++++++++++++++++++++++++++-
 lib/libf2fs_io.c         |   8 +++-
 lib/libf2fs_zoned.c      |   2 +
 mkfs/f2fs_format.c       |   2 +
 mkfs/f2fs_format_main.c  |   2 +
 mkfs/f2fs_format_utils.c |   5 +++
 9 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/include/android_config.h b/include/android_config.h
index 59ba1ee..6f49f90 100644
--- a/include/android_config.h
+++ b/include/android_config.h
@@ -60,3 +60,7 @@
 #define HAVE_LIBSELINUX 1
 #endif
 #endif
+
+#if defined(_WIN32)
+#define HAVE_LSEEK64
+#endif
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index a18ddc4..d8d199f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -53,6 +53,14 @@
 # define UNUSED(x) x
 #endif
 
+#ifdef ANDROID_WINDOWS_HOST
+#undef HAVE_LINUX_TYPES_H
+typedef uint64_t u_int64_t;
+typedef uint32_t u_int32_t;
+typedef uint16_t u_int16_t;
+typedef uint8_t u_int8_t;
+#endif
+
 typedef u_int64_t	u64;
 typedef u_int32_t	u32;
 typedef u_int16_t	u16;
@@ -460,6 +468,7 @@ struct f2fs_configuration {
  */
 #define __round_mask(x, y)	((__typeof__(x))((y)-1))
 #define round_down(x, y)	((x) & ~__round_mask(x, y))
+
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
 	typeof(y) _min2 = (y);			\
@@ -547,11 +556,13 @@ enum {
 /*
  * For superblock
  */
+#pragma pack(1)
 struct f2fs_device {
 	__u8 path[MAX_PATH_LEN];
 	__le32 total_segments;
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_super_block {
 	__le32 magic;			/* Magic Number */
 	__le16 major_ver;		/* Major Version */
@@ -608,6 +619,7 @@ struct f2fs_super_block {
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
 #define CP_UMOUNT_FLAG		0x00000001
 
+#pragma pack(1)
 struct f2fs_checkpoint {
 	__le64 checkpoint_ver;		/* checkpoint block version number */
 	__le64 user_block_count;	/* # of user blocks */
@@ -644,6 +656,7 @@ struct f2fs_checkpoint {
  */
 #define F2FS_ORPHANS_PER_BLOCK	1020
 
+#pragma pack(1)
 struct f2fs_orphan_block {
 	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */
 	__le32 reserved;	/* reserved */
@@ -656,6 +669,7 @@ struct f2fs_orphan_block {
 /*
  * For NODE structure
  */
+#pragma pack(1)
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
 	__le32 blk_addr;	/* start block address of the extent */
@@ -722,6 +736,7 @@ struct f2fs_extent {
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
 
+#pragma pack(1)
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
 	__u8 i_advise;			/* file hints */
@@ -762,10 +777,13 @@ struct f2fs_inode {
 						double_indirect(1) node id */
 } __attribute__((packed));
 
+
+#pragma pack(1)
 struct direct_node {
 	__le32 addr[ADDRS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
 
+#pragma pack(1)
 struct indirect_node {
 	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
 } __attribute__((packed));
@@ -779,7 +797,7 @@ enum {
 
 #define XATTR_NODE_OFFSET	((((unsigned int)-1) << OFFSET_BIT_SHIFT) \
 				>> OFFSET_BIT_SHIFT)
-
+#pragma pack(1)
 struct node_footer {
 	__le32 nid;		/* node id */
 	__le32 ino;		/* inode nunmber */
@@ -788,6 +806,7 @@ struct node_footer {
 	__le32 next_blkaddr;	/* next node page block address */
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
 	union {
@@ -804,12 +823,14 @@ struct f2fs_node {
 #define NAT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_nat_entry))
 #define NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
+#pragma pack(1)
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
 	__le32 ino;		/* inode number */
 	__le32 block_addr;	/* block address */
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_nat_block {
 	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -846,12 +867,14 @@ struct f2fs_nat_block {
 	((le16_to_cpu((raw_sit)->vblocks) & ~SIT_VBLOCKS_MASK)	\
 	 >> SIT_VBLOCKS_SHIFT)
 
+#pragma pack(1)
 struct f2fs_sit_entry {
 	__le16 vblocks;				/* reference above */
 	__u8 valid_map[SIT_VBLOCK_MAP_SIZE];	/* bitmap for valid blocks */
 	__le64 mtime;				/* segment age for cleaning */
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_sit_block {
 	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
 } __attribute__((packed));
@@ -877,10 +900,12 @@ struct f2fs_sit_block {
 #define SUM_ENTRIES_SIZE	(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
 /* a summary entry for a 4KB-sized block in a segment */
+#pragma pack(1)
 struct f2fs_summary {
 	__le32 nid;		/* parent node id */
 	union {
 		__u8 reserved[3];
+#pragma pack(1)
 		struct {
 			__u8 version;		/* node version number */
 			__le16 ofs_in_node;	/* block index in parent node */
@@ -892,6 +917,7 @@ struct f2fs_summary {
 #define SUM_TYPE_NODE		(1)
 #define SUM_TYPE_DATA		(0)
 
+#pragma pack(1)
 struct summary_footer {
 	unsigned char entry_type;	/* SUM_TYPE_XXX */
 	__le32 check_sum;		/* summary checksum */
@@ -923,31 +949,37 @@ enum {
 	SIT_JOURNAL
 };
 
+#pragma pack(1)
 struct nat_journal_entry {
 	__le32 nid;
 	struct f2fs_nat_entry ne;
 } __attribute__((packed));
 
+#pragma pack(1)
 struct nat_journal {
 	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
 	__u8 reserved[NAT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
+#pragma pack(1)
 struct sit_journal_entry {
 	__le32 segno;
 	struct f2fs_sit_entry se;
 } __attribute__((packed));
 
+#pragma pack(1)
 struct sit_journal {
 	struct sit_journal_entry entries[SIT_JOURNAL_ENTRIES];
 	__u8 reserved[SIT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_extra_info {
 	__le64 kbytes_written;
 	__u8 reserved[EXTRA_INFO_RESERVED];
 } __attribute__((packed));
 
+#pragma pack(1)
 struct f2fs_journal {
 	union {
 		__le16 n_nats;
@@ -962,6 +994,7 @@ struct f2fs_journal {
 } __attribute__((packed));
 
 /* 4KB-sized summary block structure */
+#pragma pack(1)
 struct f2fs_summary_block {
 	struct f2fs_summary entries[ENTRIES_IN_SUM];
 	struct f2fs_journal journal;
@@ -1001,6 +1034,7 @@ typedef __le32	f2fs_hash_t;
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
 
 /* One directory entry slot representing F2FS_SLOT_LEN-sized file name */
+#pragma pack(1)
 struct f2fs_dir_entry {
 	__le32 hash_code;	/* hash code of file name */
 	__le32 ino;		/* inode number */
@@ -1009,6 +1043,7 @@ struct f2fs_dir_entry {
 } __attribute__((packed));
 
 /* 4KB-sized directory entry block */
+#pragma pack(1)
 struct f2fs_dentry_block {
 	/* validity bitmap for directory entries in each block */
 	__u8 dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
diff --git a/include/quota.h b/include/quota.h
index 4c9f5f4..80dbdc6 100644
--- a/include/quota.h
+++ b/include/quota.h
@@ -44,12 +44,14 @@ enum quota_type {
 
 #define QT_TREEOFF	1	/* Offset of tree in file in blocks */
 
+#pragma pack(1)
 struct v2_disk_dqheader {
 	u_int32_t dqh_magic;	/* Magic number identifying file */
 	u_int32_t dqh_version;	/* File version */
 } __attribute__ ((packed));
 
 /* Header with type and version specific information */
+#pragma pack(1)
 struct v2_disk_dqinfo {
 	u_int32_t dqi_bgrace;	/* Time before block soft limit becomes hard limit */
 	u_int32_t dqi_igrace;	/* Time before inode soft limit becomes hard limit */
@@ -59,6 +61,7 @@ struct v2_disk_dqinfo {
 	u_int32_t dqi_free_entry;	/* Number of block with at least one free entry */
 } __attribute__ ((packed));
 
+#pragma pack(1)
 struct v2r1_disk_dqblk {
 	__le32 dqb_id;  	/* id this quota applies to */
 	__le32 dqb_pad;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 9e1c9a6..ffdbccb 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -20,8 +20,10 @@
 #endif
 #include <time.h>
 #include <sys/stat.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/mount.h>
 #include <sys/ioctl.h>
+#endif
 #ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>
 #endif
@@ -42,8 +44,11 @@
 #define MODELINQUIRY	0x12,0x00,0x00,0x00,0x4A,0x00
 #endif
 
-#ifndef _WIN32 /* O_BINARY is windows-specific flag */
+#ifndef ANDROID_WINDOWS_HOST /* O_BINARY is windows-specific flag */
 #define O_BINARY 0
+#else
+/* On Windows, wchar_t is 8 bit sized and it causes compilation errors. */
+#define wchar_t	int
 #endif
 
 /*
@@ -528,6 +533,9 @@ __u32 f2fs_inode_chksum(struct f2fs_node *node)
  */
 const char *get_rootdev()
 {
+#ifdef ANDROID_WINDOWS_HOST
+	return NULL;
+#else
 	struct stat sb;
 	int fd, ret;
 	char buf[32];
@@ -568,6 +576,7 @@ const char *get_rootdev()
 	snprintf(rootdev, PATH_MAX + 1, "/dev/%s", buf);
 
 	return rootdev;
+#endif
 }
 
 /*
@@ -643,6 +652,9 @@ static int is_mounted(const char *mpt, const char *device)
 
 int f2fs_dev_is_umounted(char *path)
 {
+#ifdef ANDROID_WINDOWS_HOST
+	return 0;
+#else
 	struct stat st_buf;
 	int is_rootdev = 0;
 	int ret = 0;
@@ -701,6 +713,7 @@ int f2fs_dev_is_umounted(char *path)
 		}
 	}
 	return ret;
+#endif
 }
 
 int f2fs_devs_are_umounted(void)
@@ -742,6 +755,7 @@ void get_kernel_version(__u8 *version)
 #define BLKSSZGET	DKIOCGETBLOCKCOUNT
 #endif /* APPLE_DARWIN */
 
+#ifndef ANDROID_WINDOWS_HOST
 int get_device_info(int i)
 {
 	int32_t fd = 0;
@@ -890,6 +904,102 @@ int get_device_info(int i)
 	return 0;
 }
 
+#else
+
+#include "windows.h"
+#include "winioctl.h"
+
+#if (_WIN32_WINNT >= 0x0500)
+#define HAVE_GET_FILE_SIZE_EX 1
+#endif
+
+static int win_get_device_size(const char *file, uint64_t *device_size)
+{
+	HANDLE dev;
+	PARTITION_INFORMATION pi;
+	DISK_GEOMETRY gi;
+	DWORD retbytes;
+#ifdef HAVE_GET_FILE_SIZE_EX
+	LARGE_INTEGER filesize;
+#else
+	DWORD filesize;
+#endif /* HAVE_GET_FILE_SIZE_EX */
+
+	dev = CreateFile(file, GENERIC_READ,
+			FILE_SHARE_READ | FILE_SHARE_WRITE ,
+			NULL,  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,  NULL);
+
+	if (dev == INVALID_HANDLE_VALUE)
+		return EBADF;
+	if (DeviceIoControl(dev, IOCTL_DISK_GET_PARTITION_INFO,
+				&pi, sizeof(PARTITION_INFORMATION),
+				&pi, sizeof(PARTITION_INFORMATION),
+				&retbytes, NULL)) {
+
+		*device_size = 	pi.PartitionLength.QuadPart;
+
+	} else if (DeviceIoControl(dev, IOCTL_DISK_GET_DRIVE_GEOMETRY,
+				&gi, sizeof(DISK_GEOMETRY),
+				&gi, sizeof(DISK_GEOMETRY),
+				&retbytes, NULL)) {
+
+		*device_size = gi.BytesPerSector *
+			gi.SectorsPerTrack *
+			gi.TracksPerCylinder *
+			gi.Cylinders.QuadPart;
+
+#ifdef HAVE_GET_FILE_SIZE_EX
+	} else if (GetFileSizeEx(dev, &filesize)) {
+		*device_size = filesize.QuadPart;
+	}
+#else
+	} else {
+		filesize = GetFileSize(dev, NULL);
+		if (INVALID_FILE_SIZE != filesize)
+			return -1;
+		*device_size = filesize;
+	}
+#endif /* HAVE_GET_FILE_SIZE_EX */
+
+	CloseHandle(dev);
+	return 0;
+}
+
+int get_device_info(int i)
+{
+	struct device_info *dev = c.devices + i;
+	uint64_t device_size = 0;
+	int32_t fd = 0;
+
+	/* Block device target is not supported on Windows. */
+	if (!c.sparse_mode) {
+		if (win_get_device_size(dev->path, &device_size)) {
+			MSG(0, "\tError: Failed to get device size!\n");
+			return -1;
+		}
+	} else {
+		device_size = c.device_size;
+	}
+	if (c.sparse_mode) {
+		fd = open((char *)dev->path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
+	} else {
+		fd = open((char *)dev->path, O_RDWR | O_BINARY);
+	}
+	if (fd < 0) {
+		MSG(0, "\tError: Failed to open the device!\n");
+		return -1;
+	}
+	dev->fd = fd;
+	dev->total_sectors = device_size / dev->sector_size;
+	c.start_sector = 0;
+	c.sector_size = dev->sector_size;
+	c.sectors_per_blk = F2FS_BLKSIZE / c.sector_size;
+	c.total_sectors += dev->total_sectors;
+
+	return 0;
+}
+#endif
+
 int f2fs_get_device_info(void)
 {
 	int i;
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index e64cdad..4781517 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -18,9 +18,11 @@
 #include <mntent.h>
 #endif
 #include <time.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include <sys/ioctl.h>
+#endif
 #ifdef HAVE_LINUX_HDREG_H
 #include <linux/hdreg.h>
 #endif
@@ -261,6 +263,7 @@ int dev_reada_block(__u64 blk_addr)
 
 int f2fs_fsync_device(void)
 {
+#ifndef ANDROID_WINDOWS_HOST
 	int i;
 
 	for (i = 0; i < c.ndevs; i++) {
@@ -269,7 +272,7 @@ int f2fs_fsync_device(void)
 			return -1;
 		}
 	}
-
+#endif
 	return 0;
 }
 
@@ -354,12 +357,13 @@ int f2fs_finalize_device(void)
 	 * in the block device page cache.
 	 */
 	for (i = 0; i < c.ndevs; i++) {
+#ifndef ANDROID_WINDOWS_HOST
 		ret = fsync(c.devices[i].fd);
 		if (ret < 0) {
 			MSG(0, "\tError: Could not conduct fsync!!!\n");
 			break;
 		}
-
+#endif
 		ret = close(c.devices[i].fd);
 		if (ret < 0) {
 			MSG(0, "\tError: Failed to close device file!!!\n");
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index eebf030..6e32f32 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -15,7 +15,9 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/stat.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/ioctl.h>
+#endif
 #include <libgen.h>
 
 #include <f2fs_fs.h>
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index ddd0809..583b17f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -13,8 +13,10 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/stat.h>
 #include <sys/mount.h>
+#endif
 #include <time.h>
 #include <uuid/uuid.h>
 
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 973266c..e41bcb1 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -14,7 +14,9 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/mount.h>
+#endif
 #include <time.h>
 #include <uuid/uuid.h>
 #include <errno.h>
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index a474764..e481a8f 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -20,7 +20,9 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#ifndef ANDROID_WINDOWS_HOST
 #include <sys/ioctl.h>
+#endif
 #include <sys/stat.h>
 #include <fcntl.h>
 
@@ -40,6 +42,7 @@
 
 static int trim_device(int i)
 {
+#ifndef ANDROID_WINDOWS_HOST
 	unsigned long long range[2];
 	struct stat stat_buf;
 	struct device_info *dev = c.devices + i;
@@ -83,6 +86,8 @@ static int trim_device(int i)
 		}
 	} else
 		return -1;
+#endif
+
 #endif
 	return 0;
 }
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
