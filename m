From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] f2fs-tools: enable sparse_file opeartions
Date: Thu, 30 Nov 2017 21:51:57 -0800
Message-ID: <20171201055157.72846-6-jaegeuk@kernel.org>
References: <20171201055157.72846-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKeFN-0003Ib-4C
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKeFL-0004BB-LP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 05:52:25 +0000
In-Reply-To: <20171201055157.72846-1-jaegeuk@kernel.org>
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

This adds reading data from sparse_file.

Change-Id: Icd8ec8f401a5ba87d6d9a26dd07062cc003de1e4
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c             |  30 +++++++-
 fsck/mount.c            |   6 +-
 include/f2fs_fs.h       |   2 +
 lib/libf2fs.c           |   7 +-
 lib/libf2fs_io.c        | 191 +++++++++++++++++++++++++++++++++++++-----------
 mkfs/f2fs_format_main.c |  12 +--
 6 files changed, 190 insertions(+), 58 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index a09ca76..db5c413 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -23,6 +23,11 @@
 
 struct f2fs_fsck gfsck;
 
+#ifdef WITH_ANDROID
+#include <sparse/sparse.h>
+extern struct sparse_file *f2fs_sparse_file;
+#endif
+
 static char *absolute_path(const char *file)
 {
 	char *ret;
@@ -49,6 +54,7 @@ void fsck_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
 	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
+	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -t show directory tree\n");
 	MSG(0, "  -q preserve quota limits\n");
 	MSG(0, "  --dry-run do not really fix corruptions\n");
@@ -63,6 +69,7 @@ void dump_usage()
 	MSG(0, "  -i inode no (hex)\n");
 	MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
+	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
 	MSG(0, "  -b blk_addr (in 4KB)\n");
 
@@ -75,6 +82,7 @@ void defrag_usage()
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -s start block address [default: main_blkaddr]\n");
+	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -l length [default:512 (2MB)]\n");
 	MSG(0, "  -t target block address [default: main_blkaddr + 2MB]\n");
 	MSG(0, "  -i set direction as shrink [default: expand]\n");
@@ -98,6 +106,7 @@ void sload_usage()
 	MSG(0, "  -f source directory [path of the source directory]\n");
 	MSG(0, "  -p product out directory\n");
 	MSG(0, "  -s file_contexts\n");
+	MSG(0, "  -S sparse_mode\n");
 	MSG(0, "  -t mount point [prefix of target fs path, default:/]\n");
 	MSG(0, "  -T timestamp\n");
 	MSG(0, "  -d debug level [default:0]\n");
@@ -150,7 +159,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":ad:fp:q:t";
+		const char *option_string = ":ad:fp:q:St";
 		int opt = 0;
 		struct option long_opt[] = {
 			{"dry-run", no_argument, 0, 1},
@@ -212,6 +221,9 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Preserve quota limits = %d\n",
 					c.preserve_limits);
 				break;
+			case 'S':
+				c.sparse_mode = 1;
+				break;
 			case 't':
 				c.show_dentry = 1;
 				break;
@@ -236,7 +248,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("dump.f2fs", prog)) {
-		const char *option_string = "d:i:n:s:a:b:";
+		const char *option_string = "d:i:n:s:Sa:b:";
 		static struct dump_option dump_opt = {
 			.nid = 0,	/* default root ino */
 			.start_nat = -1,
@@ -280,6 +292,9 @@ void f2fs_parse_options(int argc, char *argv[])
 							&dump_opt.start_sit,
 							&dump_opt.end_sit);
 				break;
+			case 'S':
+				c.sparse_mode = 1;
+				break;
 			case 'a':
 				ret = sscanf(optarg, "%d~%d",
 							&dump_opt.start_ssa,
@@ -304,7 +319,7 @@ void f2fs_parse_options(int argc, char *argv[])
 
 		c.private = &dump_opt;
 	} else if (!strcmp("defrag.f2fs", prog)) {
-		const char *option_string = "d:s:l:t:i";
+		const char *option_string = "d:s:Sl:t:i";
 
 		c.func = DEFRAG;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -328,6 +343,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%"PRIx64"",
 							&c.defrag_start);
 				break;
+			case 'S':
+				c.sparse_mode = 1;
+				break;
 			case 'l':
 				if (strncmp(optarg, "0x", 2))
 					ret = sscanf(optarg, "%"PRIu64"",
@@ -389,7 +407,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("sload.f2fs", prog)) {
-		const char *option_string = "C:d:f:p:s:t:T:";
+		const char *option_string = "C:d:f:p:s:St:T:";
 #ifdef HAVE_LIBSELINUX
 		int max_nr_opt = (int)sizeof(c.seopt_file) /
 			sizeof(c.seopt_file[0]);
@@ -438,6 +456,9 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Not support selinux opts\n");
 #endif
 				break;
+			case 'S':
+				c.sparse_mode = 1;
+				break;
 			case 't':
 				c.mount_point = (char *)optarg;
 				break;
@@ -683,6 +704,7 @@ int main(int argc, char **argv)
 	/* Get device */
 	if (f2fs_get_device_info() < 0)
 		return -1;
+
 fsck_again:
 	memset(&gfsck, 0, sizeof(gfsck));
 	gfsck.sbi.fsck = &gfsck;
diff --git a/fsck/mount.c b/fsck/mount.c
index f16f046..678eeae 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -590,6 +590,7 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
 int validate_super_block(struct f2fs_sb_info *sbi, int block)
 {
 	u64 offset;
+	char buf[F2FS_BLKSIZE];
 
 	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
 
@@ -598,9 +599,12 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 	else
 		offset = F2FS_BLKSIZE + F2FS_SUPER_OFFSET;
 
-	if (dev_read(sbi->raw_super, offset, sizeof(struct f2fs_super_block)))
+	if (dev_read_block(buf, block))
 		return -1;
 
+	memcpy(sbi->raw_super, buf + F2FS_SUPER_OFFSET,
+					sizeof(struct f2fs_super_block));
+
 	if (!sanity_check_raw_super(sbi->raw_super, offset)) {
 		/* get kernel version */
 		if (c.kd >= 0) {
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3084cce..a18ddc4 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -284,6 +284,7 @@ static inline uint64_t bswap_64(uint64_t val)
 #define VERSION_LEN	256
 
 enum f2fs_config_func {
+	MKFS,
 	FSCK,
 	DUMP,
 	DEFRAG,
@@ -1077,6 +1078,7 @@ extern int f2fs_devs_are_umounted(void);
 extern int f2fs_dev_is_umounted(char *);
 extern int f2fs_get_device_info(void);
 extern int get_device_info(int);
+extern int f2fs_init_sparse_file(void);
 extern int f2fs_finalize_device(void);
 extern int f2fs_fsync_device(void);
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index bbe3a8b..9e1c9a6 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -761,7 +761,7 @@ int get_device_info(int i)
 	struct device_info *dev = c.devices + i;
 
 	if (c.sparse_mode) {
-		fd = open((char *)dev->path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
+		fd = open((char *)dev->path, O_RDWR | O_CREAT | O_BINARY, 0644);
 	} else {
 		fd = open((char *)dev->path, O_RDWR);
 	}
@@ -772,6 +772,11 @@ int get_device_info(int i)
 
 	dev->fd = fd;
 
+	if (c.sparse_mode) {
+		if (f2fs_init_sparse_file())
+			return -1;
+	}
+
 	if (c.kd == -1) {
 		c.kd = open("/proc/version", O_RDONLY);
 		if (c.kd < 0) {
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index f39133a..e64cdad 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -32,14 +32,8 @@ struct f2fs_configuration c;
 #ifdef WITH_ANDROID
 #include <sparse/sparse.h>
 struct sparse_file *f2fs_sparse_file;
-
-struct buf_item {
-	void *buf;
-	size_t len;
-	struct buf_item *next;
-};
-
-struct buf_item *buf_list;
+static char **blocks;
+u_int64_t blocks_count;
 #endif
 
 static int __get_device_fd(__u64 *offset)
@@ -81,12 +75,89 @@ int dev_read_version(void *buf, __u64 offset, size_t len)
 	return 0;
 }
 
+#ifdef WITH_ANDROID
+static int sparse_read_blk(__u64 block, int count, void *buf)
+{
+	int i;
+	char *out = buf;
+	__u64 cur_block;
+
+	for (i = 0; i < count; ++i) {
+		cur_block = block + i;
+		if (blocks[cur_block])
+			memcpy(out + (i * F2FS_BLKSIZE),
+					blocks[cur_block], F2FS_BLKSIZE);
+		else if (blocks)
+			memset(out + (i * F2FS_BLKSIZE), 0, F2FS_BLKSIZE);
+	}
+	return 0;
+}
+
+static int sparse_write_blk(__u64 block, int count, const void *buf)
+{
+	int i;
+	__u64 cur_block;
+	const char *in = buf;
+
+	for (i = 0; i < count; ++i) {
+		cur_block = block + i;
+		if (!blocks[cur_block]) {
+			blocks[cur_block] = calloc(1, F2FS_BLKSIZE);
+			if (!blocks[cur_block])
+				return -ENOMEM;
+		}
+		memcpy(blocks[cur_block], in + (i * F2FS_BLKSIZE),
+				F2FS_BLKSIZE);
+	}
+	return 0;
+}
+
+static int sparse_import_segment(void *UNUSED(priv), const void *data, int len,
+		unsigned int block, unsigned int nr_blocks)
+{
+	/* Ignore chunk headers, only write the data */
+	if (!nr_blocks || len % F2FS_BLKSIZE)
+		return 0;
+
+	return sparse_write_blk(block, nr_blocks, data);
+}
+
+static int sparse_merge_blocks(uint64_t start, uint64_t num)
+{
+	char *buf;
+	uint64_t i;
+
+	buf = calloc(num, F2FS_BLKSIZE);
+	if (!buf) {
+		fprintf(stderr, "failed to alloc %llu\n",
+			(unsigned long long)num * F2FS_BLKSIZE);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num; i++) {
+		memcpy(buf + i * F2FS_BLKSIZE, blocks[start + i], F2FS_BLKSIZE);
+		free(blocks[start + i]);
+		blocks[start + i] = NULL;
+	}
+
+	/* free_sparse_blocks will release this buf. */
+	blocks[start] = buf;
+
+	return sparse_file_add_data(f2fs_sparse_file, blocks[start],
+					F2FS_BLKSIZE * num, start);
+}
+#else
+static int sparse_read_blk(__u64 block, int count, void *buf) { return 0; }
+static int sparse_write_blk(__u64 block, int count, const void *buf) { return 0; }
+#endif
+
 int dev_read(void *buf, __u64 offset, size_t len)
 {
 	int fd;
 
 	if (c.sparse_mode)
-		return 0;
+		return sparse_read_blk(offset / F2FS_BLKSIZE,
+					len / F2FS_BLKSIZE, buf);
 
 	fd = __get_device_fd(&offset);
 	if (fd < 0)
@@ -116,32 +187,6 @@ int dev_readahead(__u64 offset, size_t UNUSED(len))
 #endif
 }
 
-#ifdef WITH_ANDROID
-static int dev_write_sparse(void *buf, __u64 byte_offset, size_t byte_len)
-{
-	struct buf_item *bi = calloc(1, sizeof(struct buf_item));
-
-	if (bi == NULL) {
-		return -1;
-	}
-	bi->buf = malloc(byte_len);
-	if (bi->buf == NULL) {
-		free(bi);
-		return -1;
-	}
-
-	bi->len = byte_len;
-	memcpy(bi->buf, buf, byte_len);
-	bi->next = buf_list;
-	buf_list = bi;
-
-	sparse_file_add_data(f2fs_sparse_file, bi->buf, byte_len, byte_offset/F2FS_BLKSIZE);
-	return 0;
-}
-#else
-static int dev_write_sparse(void *buf, __u64 byte_offset, size_t byte_len) { return 0; }
-#endif
-
 int dev_write(void *buf, __u64 offset, size_t len)
 {
 	int fd;
@@ -150,7 +195,8 @@ int dev_write(void *buf, __u64 offset, size_t len)
 		return 0;
 
 	if (c.sparse_mode)
-		return dev_write_sparse(buf, offset, len);
+		return sparse_write_blk(offset / F2FS_BLKSIZE,
+					len / F2FS_BLKSIZE, buf);
 
 	fd = __get_device_fd(&offset);
 	if (fd < 0)
@@ -227,6 +273,36 @@ int f2fs_fsync_device(void)
 	return 0;
 }
 
+int f2fs_init_sparse_file(void)
+{
+#ifdef WITH_ANDROID
+	if (c.func == MKFS) {
+		f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE, c.device_size);
+	} else {
+		f2fs_sparse_file = sparse_file_import(c.devices[0].fd,
+							true, false);
+		if (!f2fs_sparse_file)
+			return -1;
+
+		c.device_size = sparse_file_len(f2fs_sparse_file, 0, 0);
+		c.device_size &= (~((u_int64_t)(F2FS_BLKSIZE - 1)));
+	}
+
+	if (sparse_file_block_size(f2fs_sparse_file) != F2FS_BLKSIZE) {
+		MSG(0, "\tError: Corrupted sparse file\n");
+		return -1;
+	}
+	blocks_count = c.device_size / F2FS_BLKSIZE;
+	blocks = calloc(blocks_count, sizeof(char *));
+
+	return sparse_file_foreach_chunk(f2fs_sparse_file, true, false,
+				sparse_import_segment, NULL);
+#else
+	MSG(0, "\tError: Sparse mode is only supported for android\n");
+	return -1;
+#endif
+}
+
 int f2fs_finalize_device(void)
 {
 	int i;
@@ -234,18 +310,45 @@ int f2fs_finalize_device(void)
 
 #ifdef WITH_ANDROID
 	if (c.sparse_mode) {
-		sparse_file_write(f2fs_sparse_file, c.devices[0].fd, /*gzip*/0, /*sparse*/1, /*crc*/0);
-		sparse_file_destroy(f2fs_sparse_file);
-		while (buf_list) {
-			struct buf_item *bi = buf_list;
-			buf_list = buf_list->next;
-			free(bi->buf);
-			free(bi);
+		int64_t chunk_start = (blocks[0] == NULL) ? -1 : 0;
+		uint64_t j;
+
+		if (c.func != MKFS) {
+			sparse_file_destroy(f2fs_sparse_file);
+			ret = ftruncate(c.devices[0].fd, 0);
+			ASSERT(!ret);
+			lseek(c.devices[0].fd, 0, SEEK_SET);
+			f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE,
+							c.device_size);
+		}
+
+		for (j = 0; j < blocks_count; ++j) {
+			if (!blocks[j] && chunk_start != -1) {
+				ret = sparse_merge_blocks(chunk_start,
+							j - chunk_start);
+				chunk_start = -1;
+			} else if (blocks[j] && chunk_start == -1) {
+				chunk_start = j;
+			}
+			ASSERT(!ret);
+		}
+		if (chunk_start != -1) {
+			ret = sparse_merge_blocks(chunk_start,
+						blocks_count - chunk_start);
+			ASSERT(!ret);
 		}
+
+		sparse_file_write(f2fs_sparse_file, c.devices[0].fd,
+				/*gzip*/0, /*sparse*/1, /*crc*/0);
+
+		sparse_file_destroy(f2fs_sparse_file);
+		for (j = 0; j < blocks_count; j++)
+			free(blocks[j]);
+		free(blocks);
+		blocks = NULL;
 		f2fs_sparse_file = NULL;
 	}
 #endif
-
 	/*
 	 * We should call fsync() to flush out all the dirty pages
 	 * in the block device page cache.
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 21caff8..973266c 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -291,6 +291,8 @@ int main(int argc, char *argv[])
 
 	f2fs_show_info();
 
+	c.func = MKFS;
+
 	if (!force_overwrite && f2fs_check_overwrite()) {
 		MSG(0, "\tUse the -f option to force overwrite.\n");
 		return -1;
@@ -320,14 +322,8 @@ int main(int argc, char *argv[])
 	}
 
 	if (c.sparse_mode) {
-#ifndef WITH_ANDROID
-		MSG(0, "\tError: Sparse mode is only supported for android\n");
-		return -1;
-#else
-		if (f2fs_sparse_file)
-			sparse_file_destroy(f2fs_sparse_file);
-		f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE, c.device_size);
-#endif
+		if (f2fs_init_sparse_file())
+			return -1;
 	}
 
 	if (f2fs_format_device() < 0)
-- 
2.15.0.403.gc27cc4dac6-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
