From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs_io: add read
Date: Wed, 20 Feb 2019 09:07:43 -0800
Message-ID: <20190220170745.7328-2-jaegeuk@kernel.org>
References: <20190220170745.7328-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gwVLh-000291-J2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 17:07:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwVLf-003808-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 17:07:57 +0000
In-Reply-To: <20190220170745.7328-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@google.com>

From: Jaegeuk Kim <jaegeuk@google.com>

f2fs_io read [chunk_size in 4kb] [offset in chunk_size] [count] [IO] [print_nbytes] [file_path]

Read data in file_path and print nbytes
IO can be
  buffered : buffered IO
  dio      : direct IO

Change-Id: I912adc4f443c3656ad067d29a1e2f581b79d28e6
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 tools/f2fs_io/f2fs_io.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 0515108..d09f732 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -214,6 +214,91 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define read_desc "read data from file"
+#define read_help					\
+"f2fs_io read [chunk_size in 4kb] [offset in chunk_size] [count] [IO] [print_nbytes] [file_path]\n\n"	\
+"Read data in file_path and print nbytes\n"		\
+"IO can be\n"						\
+"  buffered : buffered IO\n"				\
+"  dio      : direct IO\n"				\
+
+static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	u64 buf_size = 0, ret = 0, read_cnt = 0;
+	loff_t offset;
+	char *buf = NULL;
+	char *print_buf = NULL;
+	unsigned bs, count, i, print_bytes;
+	int flags = 0;
+	int fd;
+
+	if (argc != 7) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	bs = atoi(argv[1]);
+	if (bs > 1024) {
+		fputs("Too big chunk size - limit: 4MB\n\n", stderr);
+		exit(1);
+	}
+	buf_size = bs * 4096;
+
+	offset = atoi(argv[2]) * buf_size;
+
+	buf = aligned_alloc(4096, buf_size);
+	if (!buf) {
+		fputs("Memory alloc failed\n\n", stderr);
+		exit(1);
+	}
+	count = atoi(argv[3]);
+	if (!strcmp(argv[4], "buffered")) {
+		flags |= O_DIRECT;
+	} else if (strcmp(argv[4], "dio")) {
+		fputs("Wrong IO type\n\n", stderr);
+		exit(1);
+	}
+
+	print_bytes = atoi(argv[5]);
+	if (print_bytes > buf_size) {
+		fputs("Print_nbytes should be less then chunk_size in kb\n\n", stderr);
+		exit(1);
+	}
+	print_buf = malloc(print_bytes);
+	if (!print_buf) {
+		fputs("Memory alloc failed\n\n", stderr);
+		exit(1);
+	}
+
+	fd = open(argv[6], O_RDONLY | flags);
+	if (fd == -1) {
+		fputs("Open failed\n\n", stderr);
+		exit(1);
+	}
+
+	for (i = 0; i < count; i++) {
+		ret = pread(fd, buf, buf_size, offset + buf_size * i);
+		if (ret != buf_size)
+			break;
+
+		read_cnt += ret;
+		if (i == 0)
+			memcpy(print_buf, buf, print_bytes);
+	}
+	printf("Read %lu bytes and print %d bytes:\n", read_cnt, print_bytes);
+	printf("%08lx : ", offset);
+	for (i = 1; i <= print_bytes; i++) {
+		printf("%02x", print_buf[i - 1]);
+		if (i % 16 == 0)
+			printf("\n%08lx : ", offset + 16 * i);
+		else if (i % 2 == 0)
+			printf(" ");
+	}
+	printf("\n");
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -224,6 +309,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(shutdown),
 	CMD(pinfile),
 	CMD(write),
+	CMD(read),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.19.0.605.g01d371f741-goog
