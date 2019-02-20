From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs_io: add fiemap
Date: Wed, 20 Feb 2019 09:07:44 -0800
Message-ID: <20190220170745.7328-3-jaegeuk@kernel.org>
References: <20190220170745.7328-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gwVLh-0000cj-EE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 17:07:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwVLg-003Swq-0f
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

f2fs_io fiemap [offset in 4kb] [count] [file_path]

Change-Id: Iee9e8b742ada6a12a9f761b3a6de8d82a60e1b59
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 tools/f2fs_io/f2fs_io.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index d09f732..70fde6e 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -9,6 +9,15 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+#ifndef _LARGEFILE_SOURCE
+#define _LARGEFILE_SOURCE
+#endif
+#ifndef _LARGEFILE64_SOURCE
+#define _LARGEFILE64_SOURCE
+#endif
+#ifndef O_LARGEFILE
+#define O_LARGEFILE 0
+#endif
 
 #include <stdio.h>
 #include <fcntl.h>
@@ -299,6 +308,57 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+struct file_ext {
+	__u32 f_pos;
+	__u32 start_blk;
+	__u32 end_blk;
+	__u32 blk_count;
+};
+
+#ifndef FIBMAP
+#define FIBMAP          _IO(0x00, 1)    /* bmap access */
+#endif
+
+#define fiemap_desc "get block address in file"
+#define fiemap_help					\
+"f2fs_io fiemap [offset in 4kb] [count] [file_path]\n\n"\
+
+static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	loff_t offset;
+	u32 blknum;
+	unsigned count, i;
+	int fd;
+
+	if (argc != 4) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	offset = atoi(argv[1]);
+	count = atoi(argv[2]);
+
+	fd = open(argv[3], O_RDONLY | O_LARGEFILE);
+	if (fd == -1) {
+		fputs("Open failed\n\n", stderr);
+		exit(1);
+	}
+
+	printf("Fiemap: offset = %08lx len = %d\n", offset, count);
+	for (i = 0; i < count; i++) {
+		blknum = offset + i;
+
+		if (ioctl(fd, FIBMAP, &blknum) < 0) {
+			fputs("FIBMAP failed\n\n", stderr);
+			exit(1);
+		}
+		printf("%u ", blknum);
+	}
+	printf("\n");
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -310,6 +370,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(pinfile),
 	CMD(write),
 	CMD(read),
+	CMD(fiemap),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.19.0.605.g01d371f741-goog
