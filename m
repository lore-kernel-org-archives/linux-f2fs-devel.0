From: Yang Jin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCHv3 1/1] add sparse support for f2fs
Date: Fri, 16 Jun 2017 11:32:58 -0700
Message-ID: <20170616183258.189722-1-yajin@google.com>
Reply-To: Yang Jin <yajin@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yajin@google.com>) id 1dLw47-0007jk-L4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Jun 2017 18:33:51 +0000
Received: from mail-pf0-f179.google.com ([209.85.192.179])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dLw46-00074K-B6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Jun 2017 18:33:51 +0000
Received: by mail-pf0-f179.google.com with SMTP id 83so25990165pfr.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 16 Jun 2017 11:33:50 -0700 (PDT)
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
Cc: jaegeuk@kernel.org

Description:
modify I/O operations to support writing in sparse format
build host executable for making sparse image

Signed-off-by: Yang Jin <yajin@google.com>
---
 include/f2fs_fs.h       |  2 ++
 lib/libf2fs.c           | 14 ++++++++--
 lib/libf2fs_io.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 mkfs/f2fs_format_main.c | 27 +++++++++++++++++-
 4 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2316869..dd2635b 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -256,6 +256,7 @@ struct device_info {
 struct f2fs_configuration {
 	u_int32_t reserved_segments;
 	u_int32_t new_reserved_segments;
+	int sparse_mode;
 	int zoned_mode;
 	int zoned_model;
 	size_t zone_blocks;
@@ -268,6 +269,7 @@ struct f2fs_configuration {
 	u_int32_t start_sector;
 	u_int32_t total_segments;
 	u_int32_t sector_size;
+	u_int64_t device_size;
 	u_int64_t total_sectors;
 	u_int64_t wanted_total_sectors;
 	u_int64_t target_sectors;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index c96506a..31836db 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -32,6 +32,10 @@
 #define MODELINQUIRY	0x12,0x00,0x00,0x00,0x4A,0x00
 #endif
 
+#ifndef _WIN32 /* O_BINARY is windows-specific flag */
+#define O_BINARY 0
+#endif
+
 /*
  * UTF conversion codes are Copied from exfat tools.
  */
@@ -689,7 +693,11 @@ int get_device_info(int i)
 #endif
 	struct device_info *dev = c.devices + i;
 
-	fd = open((char *)dev->path, O_RDWR);
+	if (c.sparse_mode) {
+		fd = open((char *)dev->path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
+	} else {
+		fd = open((char *)dev->path, O_RDWR);
+	}
 	if (fd < 0) {
 		MSG(0, "\tError: Failed to open the device!\n");
 		return -1;
@@ -710,7 +718,9 @@ int get_device_info(int i)
 		return -1;
 	}
 
-	if (S_ISREG(stat_buf.st_mode)) {
+	if (c.sparse_mode) {
+		dev->total_sectors = c.device_size / dev->sector_size;
+	} else if (S_ISREG(stat_buf.st_mode)) {
 		dev->total_sectors = stat_buf.st_size / dev->sector_size;
 	} else if (S_ISBLK(stat_buf.st_mode)) {
 		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index c09db36..aa99068 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -25,6 +25,19 @@
 
 struct f2fs_configuration c;
 
+#ifdef WITH_ANDROID
+#include <sparse/sparse.h>
+struct sparse_file *f2fs_sparse_file;
+
+struct buf_item {
+	void *buf;
+	size_t len;
+	struct buf_item *next;
+};
+
+struct buf_item *buf_list;
+#endif
+
 static int __get_device_fd(__u64 *offset)
 {
 	__u64 blk_addr = *offset >> F2FS_BLKSIZE_BITS;
@@ -46,6 +59,8 @@ static int __get_device_fd(__u64 *offset)
  */
 int dev_read_version(void *buf, __u64 offset, size_t len)
 {
+	if (c.sparse_mode)
+		return 0;
 	if (lseek64(c.kd, (off64_t)offset, SEEK_SET) < 0)
 		return -1;
 	if (read(c.kd, buf, len) < 0)
@@ -55,8 +70,12 @@ int dev_read_version(void *buf, __u64 offset, size_t len)
 
 int dev_read(void *buf, __u64 offset, size_t len)
 {
-	int fd = __get_device_fd(&offset);
+	int fd;
+
+	if (c.sparse_mode)
+		return 0;
 
+	fd = __get_device_fd(&offset);
 	if (fd < 0)
 		return fd;
 
@@ -80,10 +99,40 @@ int dev_readahead(__u64 offset, size_t len)
 #endif
 }
 
+#ifdef WITH_ANDROID
+static int dev_write_sparse(void *buf, __u64 byte_offset, size_t byte_len)
+{
+	struct buf_item *bi = calloc(1, sizeof(struct buf_item));
+
+	if (bi == NULL) {
+		return -1;
+	}
+	bi->buf = malloc(byte_len);
+	if (bi->buf == NULL) {
+		free(bi);
+		return -1;
+	}
+
+	bi->len = byte_len;
+	memcpy(bi->buf, buf, byte_len);
+	bi->next = buf_list;
+	buf_list = bi;
+
+	sparse_file_add_data(f2fs_sparse_file, bi->buf, byte_len, byte_offset/F2FS_BLKSIZE);
+	return 0;
+}
+#else
+static int dev_write_sparse(void *buf, __u64 byte_offset, size_t byte_len) { return 0; }
+#endif
+
 int dev_write(void *buf, __u64 offset, size_t len)
 {
-	int fd = __get_device_fd(&offset);
+	int fd;
+
+	if (c.sparse_mode)
+		return dev_write_sparse(buf, offset, len);
 
+	fd = __get_device_fd(&offset);
 	if (fd < 0)
 		return fd;
 
@@ -110,8 +159,12 @@ int dev_write_dump(void *buf, __u64 offset, size_t len)
 
 int dev_fill(void *buf, __u64 offset, size_t len)
 {
-	int fd = __get_device_fd(&offset);
+	int fd;
+
+	if (c.sparse_mode)
+		return 0;
 
+	fd = __get_device_fd(&offset);
 	if (fd < 0)
 		return fd;
 
@@ -144,6 +197,20 @@ void f2fs_finalize_device(void)
 {
 	int i;
 
+#ifdef WITH_ANDROID
+	if (c.sparse_mode) {
+		sparse_file_write(f2fs_sparse_file, c.devices[0].fd, /*gzip*/0, /*sparse*/1, /*crc*/0);
+		sparse_file_destroy(f2fs_sparse_file);
+		while (buf_list) {
+			struct buf_item *bi = buf_list;
+			buf_list = buf_list->next;
+			free(bi->buf);
+			free(bi);
+		}
+		f2fs_sparse_file = NULL;
+	}
+#endif
+
 	/*
 	 * We should call fsync() to flush out all the dirty pages
 	 * in the block device page cache.
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index a3652a9..5525d1c 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -27,6 +27,11 @@
 #include "f2fs_fs.h"
 #include "f2fs_format_utils.h"
 
+#ifdef WITH_ANDROID
+#include <sparse/sparse.h>
+extern struct sparse_file *f2fs_sparse_file;
+#endif
+
 extern struct f2fs_configuration c;
 static int force_overwrite = 0;
 
@@ -45,6 +50,7 @@ static void mkfs_usage()
 	MSG(0, "  -O [feature list] e.g. \"encrypt\"\n");
 	MSG(0, "  -q quiet mode\n");
 	MSG(0, "  -s # of segments per section [default:1]\n");
+	MSG(0, "  -S sparse mode\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
@@ -82,7 +88,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:z:t:f";
+	static const char *option_string = "qa:c:d:e:l:mo:O:s:S:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -132,6 +138,11 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 's':
 			c.segs_per_sec = atoi(optarg);
 			break;
+		case 'S':
+			c.device_size = atoll(optarg);
+			c.device_size &= (~((u_int64_t)(F2FS_BLKSIZE - 1)));
+			c.sparse_mode = 1;
+			break;
 		case 'z':
 			c.secs_per_zone = atoi(optarg);
 			break;
@@ -164,6 +175,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		c.wanted_total_sectors = atoll(argv[optind+1]);
 	}
 
+	if (c.sparse_mode)
+		c.trim = 0;
+
 	if (c.zoned_mode)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
 }
@@ -277,6 +291,17 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
+	if (c.sparse_mode) {
+#ifndef WITH_ANDROID
+		MSG(0, "\tError: Sparse mode is only supported for android\n");
+		return -1;
+#else
+		if (f2fs_sparse_file)
+			sparse_file_destroy(f2fs_sparse_file);
+		f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE, c.device_size);
+#endif
+	}
+
 	if (f2fs_format_device() < 0)
 		return -1;
 
-- 
2.13.1.518.g3df882009-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
