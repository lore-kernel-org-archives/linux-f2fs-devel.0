From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs_io: fix build breakage and wrong conditions
Date: Thu, 28 Feb 2019 08:25:36 -0800
Message-ID: <20190228162536.9354-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gzOVE-0007Gf-Vm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 16:25:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gzOVD-004L41-FH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Feb 2019 16:25:44 +0000
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

Fix build breakage in android, and fix wrong conditions.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 tools/f2fs_io/f2fs_io.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index cb28ff8..d0c7cd2 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -25,6 +25,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
+#include <inttypes.h>
 #include <string.h>
 #include <signal.h>
 #include <termios.h>
@@ -155,7 +156,7 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
 static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	u64 buf_size = 0, inc_num = 0, ret = 0, written = 0;
-	loff_t offset;
+	u64 offset;
 	char *buf = NULL;
 	unsigned bs, count, i;
 	int flags = 0;
@@ -193,9 +194,9 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	if (!strcmp(argv[5], "buffered")) {
+	if (!strcmp(argv[5], "dio")) {
 		flags |= O_DIRECT;
-	} else if (strcmp(argv[5], "dio")) {
+	} else if (strcmp(argv[5], "buffered")) {
 		fputs("Wrong IO type\n\n", stderr);
 		exit(1);
 	}
@@ -219,7 +220,7 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		written += ret;
 	}
 
-	printf("Written %lu bytes with pattern=%s\n", written, argv[4]);
+	printf("Written %"PRIu64" bytes with pattern=%s\n", written, argv[4]);
 	exit(0);
 }
 
@@ -234,7 +235,7 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	u64 buf_size = 0, ret = 0, read_cnt = 0;
-	loff_t offset;
+	u64 offset;
 	char *buf = NULL;
 	char *print_buf = NULL;
 	unsigned bs, count, i, print_bytes;
@@ -262,9 +263,9 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 	count = atoi(argv[3]);
-	if (!strcmp(argv[4], "buffered")) {
+	if (!strcmp(argv[4], "dio")) {
 		flags |= O_DIRECT;
-	} else if (strcmp(argv[4], "dio")) {
+	} else if (strcmp(argv[4], "buffered")) {
 		fputs("Wrong IO type\n\n", stderr);
 		exit(1);
 	}
@@ -295,12 +296,12 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 		if (i == 0)
 			memcpy(print_buf, buf, print_bytes);
 	}
-	printf("Read %lu bytes and print %d bytes:\n", read_cnt, print_bytes);
-	printf("%08lx : ", offset);
+	printf("Read %"PRIu64" bytes and print %u bytes:\n", read_cnt, print_bytes);
+	printf("%08"PRIx64" : ", offset);
 	for (i = 1; i <= print_bytes; i++) {
 		printf("%02x", print_buf[i - 1]);
 		if (i % 16 == 0)
-			printf("\n%08lx : ", offset + 16 * i);
+			printf("\n%08"PRIx64" : ", offset + 16 * i);
 		else if (i % 2 == 0)
 			printf(" ");
 	}
@@ -325,7 +326,7 @@ struct file_ext {
 
 static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 {
-	loff_t offset;
+	u64 offset;
 	u32 blknum;
 	unsigned count, i;
 	int fd;
@@ -345,7 +346,7 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	printf("Fiemap: offset = %08lx len = %d\n", offset, count);
+	printf("Fiemap: offset = %08"PRIx64" len = %d\n", offset, count);
 	for (i = 0; i < count; i++) {
 		blknum = offset + i;
 
-- 
2.19.0.605.g01d371f741-goog
