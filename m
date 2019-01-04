From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs_io: add pin_file control command
Date: Thu,  3 Jan 2019 20:37:39 -0800
Message-ID: <20190104043739.33715-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gfHEy-00049A-9I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 04:37:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gfHEw-00EMr2-SN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jan 2019 04:37:48 +0000
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

This requires a kernel patch "f2fs: export pin_file flag to user".

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 53 +++++++++++++++++++++++++++++++++++++++++
 tools/f2fs_io/f2fs_io.h | 11 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 9c3863d..35ee76a 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -75,6 +75,58 @@ static void do_shutdown(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define pinfile_desc "pin file control"
+#define pinfile_help						\
+"f2fs_io pinfile [get|set] [file]\n\n"			\
+"get/set pinning given the file\n"				\
+
+static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	u32 pin;
+	int ret, fd;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	fd = open(argv[2], O_RDWR);
+	if (fd == -1) {
+		fputs("Open failed\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	ret = -1;
+	if (!strcmp(argv[1], "set")) {
+		pin = 1;
+		ret = ioctl(fd, F2FS_IOC_SET_PIN_FILE, &pin);
+		if (ret != 0) {
+			perror("set_pin_file failed");
+			exit(1);
+		}
+		printf("set_pin_file: %u blocks moved in %s\n", ret, argv[2]);
+	} else if (!strcmp(argv[1], "get")) {
+		unsigned int flags;
+
+		ret = ioctl(fd, F2FS_IOC_GET_PIN_FILE, &pin);
+		if (ret < 0) {
+			perror("pin_file failed");
+			exit(1);
+		}
+		ret = ioctl(fd, F2FS_IOC_GETFLAGS, &flags);
+		if (ret < 0) {
+			perror("get flags failed");
+			exit(1);
+		}
+		printf("get_pin_file: %s with %u blocks moved in %s\n",
+				(flags & F2FS_PIN_FILE_FL) ? "pinned" : "un-pinned",
+				pin, argv[2]);
+	}
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -83,6 +135,7 @@ static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
 const struct cmd_desc cmd_list[] = {
 	_CMD(help),
 	CMD(shutdown),
+	CMD(pinfile),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index a02ff2d..882707c 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -36,7 +36,13 @@ typedef u16	__be16;
 typedef u32	__be32;
 #endif
 
+#ifndef FS_IOC_GETFLAGS
+#define FS_IOC_GETFLAGS			_IOR('f', 1, long)
+#endif
+
 #define F2FS_IOCTL_MAGIC		0xf5
+#define F2FS_IOC_GETFLAGS		FS_IOC_GETFLAGS
+
 #define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
 #define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
 #define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
@@ -61,6 +67,11 @@ typedef u32	__be32;
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
 
+/*
+ * Inode flags
+ */
+#define F2FS_PIN_FILE_FL		0x40000000 /* pin_file status */
+
 /*
  * should be same as XFS_IOC_GOINGDOWN.
  * Flags for going down operation used by FS_IOC_GOINGDOWN
-- 
2.19.0.605.g01d371f741-goog
