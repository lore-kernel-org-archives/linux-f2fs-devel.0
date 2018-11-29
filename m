From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] tools: add f2fs_io
Date: Wed, 28 Nov 2018 18:03:41 -0800
Message-ID: <20181129020342.96045-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gSBgN-0007t6-Vh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Nov 2018 02:03:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gSBgD-008Vks-Cq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Nov 2018 02:03:59 +0000
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

This is initial commit to support shutdown ioctl.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 configure.ac              |   1 +
 tools/Makefile.am         |   2 +-
 tools/f2fs_io/Android.bp  |  15 ++++
 tools/f2fs_io/Makefile.am |   8 ++
 tools/f2fs_io/f2fs_io.c   | 171 ++++++++++++++++++++++++++++++++++++++
 tools/f2fs_io/f2fs_io.h   | 109 ++++++++++++++++++++++++
 6 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 tools/f2fs_io/Android.bp
 create mode 100644 tools/f2fs_io/Makefile.am
 create mode 100644 tools/f2fs_io/f2fs_io.c
 create mode 100644 tools/f2fs_io/f2fs_io.h

diff --git a/configure.ac b/configure.ac
index b02a718..a2dff96 100644
--- a/configure.ac
+++ b/configure.ac
@@ -209,6 +209,7 @@ AC_CONFIG_FILES([
 	fsck/Makefile
 	tools/Makefile
 	tools/sg_write_buffer/Makefile
+	tools/f2fs_io/Makefile
 ])
 
 # export library version info for mkfs/libf2fs_format_la
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 25a8c6f..446bb39 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -14,4 +14,4 @@ f2fscrypt_LDFLAGS = -luuid
 dist_man_MANS = f2fscrypt.8
 endif
 
-SUBDIRS = sg_write_buffer
+SUBDIRS = sg_write_buffer f2fs_io
diff --git a/tools/f2fs_io/Android.bp b/tools/f2fs_io/Android.bp
new file mode 100644
index 0000000..2cc81eb
--- /dev/null
+++ b/tools/f2fs_io/Android.bp
@@ -0,0 +1,15 @@
+cc_defaults {
+    name: "f2fs-io-defaults",
+    cflags: [
+        "-Wno-unused-function"
+    ],
+}
+
+cc_binary {
+    name: "f2fs_io",
+    defaults: [ "f2fs-io-defaults" ],
+    srcs: [
+        "f2fs_io.c",
+    ],
+    product_specific: true,
+}
diff --git a/tools/f2fs_io/Makefile.am b/tools/f2fs_io/Makefile.am
new file mode 100644
index 0000000..73ce525
--- /dev/null
+++ b/tools/f2fs_io/Makefile.am
@@ -0,0 +1,8 @@
+## Makefile.am
+
+if LINUX
+AM_CPPFLAGS = -I./include
+AM_CFLAGS = -Wall
+sbin_PROGRAMS = f2fs_io
+f2fs_io_SOURCES = f2fs_io.c
+endif
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
new file mode 100644
index 0000000..9c3863d
--- /dev/null
+++ b/tools/f2fs_io/f2fs_io.c
@@ -0,0 +1,171 @@
+/*
+ * f2fs_io.c - f2fs ioctl utility
+ *
+ * Author: Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * Copied portion of the code from ../f2fscrypt.c
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+#include <termios.h>
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+#include "f2fs_io.h"
+
+struct cmd_desc {
+	const char *cmd_name;
+	void (*cmd_func)(int, char **, const struct cmd_desc *);
+	const char *cmd_desc;
+	const char *cmd_help;
+	int cmd_flags;
+};
+
+#define shutdown_desc "shutdown filesystem"
+#define shutdown_help					\
+"f2fs_io shutdown [level] [dir]\n\n"			\
+"Freeze and stop all IOs given mount point\n"		\
+"level can be\n"					\
+"  0 : going down with full sync\n"			\
+"  1 : going down with checkpoint only\n"		\
+"  2 : going down with no sync\n"			\
+"  3 : going down with metadata flush\n"		\
+"  4 : going down with fsck mark\n"
+
+static void do_shutdown(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	u32 flag;
+	int ret, fd;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	flag = atoi(argv[1]);
+	if (flag >= F2FS_GOING_DOWN_MAX) {
+		fputs("Wrong level\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+	fd = open(argv[2], O_RDONLY);
+	if (fd == -1) {
+		fputs("Open failed\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	ret = ioctl(fd, F2FS_IOC_SHUTDOWN, &flag);
+	if (ret < 0) {
+		perror("F2FS_IOC_SHUTDOWN");
+		exit(1);
+	}
+	printf("Shutdown %s with level=%d\n", argv[2], flag);
+	exit(0);
+}
+
+#define CMD_HIDDEN 	0x0001
+#define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
+#define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
+
+static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
+const struct cmd_desc cmd_list[] = {
+	_CMD(help),
+	CMD(shutdown),
+	{ NULL, NULL, NULL, NULL, 0 }
+};
+
+static void do_help(int argc, char **argv, const struct cmd_desc *UNUSED(cmd))
+{
+	const struct cmd_desc *p;
+
+	if (argc > 1) {
+		for (p = cmd_list; p->cmd_name; p++) {
+			if (p->cmd_flags & CMD_HIDDEN)
+				continue;
+			if (strcmp(p->cmd_name, argv[1]) == 0) {
+				putc('\n', stdout);
+				fputs("USAGE:\n  ", stdout);
+				fputs(p->cmd_help, stdout);
+				exit(0);
+			}
+		}
+		printf("Unknown command: %s\n\n", argv[1]);
+	}
+
+	fputs("Available commands:\n", stdout);
+	for (p = cmd_list; p->cmd_name; p++) {
+		if (p->cmd_flags & CMD_HIDDEN)
+			continue;
+		printf("  %-20s %s\n", p->cmd_name, p->cmd_desc);
+	}
+	printf("\nTo get more information on a command, "
+	       "type 'f2fs_io help cmd'\n");
+	exit(0);
+}
+
+static void die_signal_handler(int UNUSED(signum), siginfo_t *UNUSED(siginfo),
+				void *UNUSED(context))
+{
+	exit(-1);
+}
+
+static void sigcatcher_setup(void)
+{
+	struct sigaction	sa;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_sigaction = die_signal_handler;
+	sa.sa_flags = SA_SIGINFO;
+
+	sigaction(SIGHUP, &sa, 0);
+	sigaction(SIGINT, &sa, 0);
+	sigaction(SIGQUIT, &sa, 0);
+	sigaction(SIGFPE, &sa, 0);
+	sigaction(SIGILL, &sa, 0);
+	sigaction(SIGBUS, &sa, 0);
+	sigaction(SIGSEGV, &sa, 0);
+	sigaction(SIGABRT, &sa, 0);
+	sigaction(SIGPIPE, &sa, 0);
+	sigaction(SIGALRM, &sa, 0);
+	sigaction(SIGTERM, &sa, 0);
+	sigaction(SIGUSR1, &sa, 0);
+	sigaction(SIGUSR2, &sa, 0);
+	sigaction(SIGPOLL, &sa, 0);
+	sigaction(SIGPROF, &sa, 0);
+	sigaction(SIGSYS, &sa, 0);
+	sigaction(SIGTRAP, &sa, 0);
+	sigaction(SIGVTALRM, &sa, 0);
+	sigaction(SIGXCPU, &sa, 0);
+	sigaction(SIGXFSZ, &sa, 0);
+}
+
+int main(int argc, char **argv)
+{
+	const struct cmd_desc *cmd;
+
+	if (argc < 2)
+		do_help(argc, argv, cmd_list);
+
+	sigcatcher_setup();
+	for (cmd = cmd_list; cmd->cmd_name; cmd++) {
+		if (strcmp(cmd->cmd_name, argv[1]) == 0) {
+			cmd->cmd_func(argc - 1, argv + 1, cmd);
+			exit(0);
+		}
+	}
+	printf("Unknown command: %s\n\n", argv[1]);
+	do_help(1, argv, cmd_list);
+	return 0;
+}
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
new file mode 100644
index 0000000..a02ff2d
--- /dev/null
+++ b/tools/f2fs_io/f2fs_io.h
@@ -0,0 +1,109 @@
+/*
+ * ioctl.h - f2fs ioctl header
+ *
+ * Authors: Jaegeuk Kim <jaegeuk@kernel.org>
+ */
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+
+#ifdef HAVE_LINUX_TYPES_H
+#include <linux/types.h>
+#endif
+#include <sys/types.h>
+
+#ifdef UNUSED
+#elif defined(__GNUC__)
+# define UNUSED(x) UNUSED_ ## x __attribute__((unused))
+#elif defined(__LCLINT__)
+# define UNUSED(x) x
+#else
+# define UNUSED(x) x
+#endif
+
+typedef u_int64_t	u64;
+typedef u_int32_t	u32;
+typedef u_int16_t	u16;
+typedef u_int8_t	u8;
+
+#ifndef HAVE_LINUX_TYPES_H
+typedef u8	__u8;
+typedef u16	__u16;
+typedef u32	__u32;
+typedef u16	__le16;
+typedef u32	__le32;
+typedef u16	__be16;
+typedef u32	__be32;
+#endif
+
+#define F2FS_IOCTL_MAGIC		0xf5
+#define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
+#define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
+#define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
+#define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
+#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
+#define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
+#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
+#define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
+						struct f2fs_defragment)
+#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
+						struct f2fs_move_range)
+#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
+						struct f2fs_flush_device)
+#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
+						struct f2fs_gc_range)
+#define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
+#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
+#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
+#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
+
+#define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
+#define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
+#define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
+
+/*
+ * should be same as XFS_IOC_GOINGDOWN.
+ * Flags for going down operation used by FS_IOC_GOINGDOWN
+ */
+#define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
+#define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
+#define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
+#define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
+#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
+#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
+#define F2FS_GOING_DOWN_MAX		0x5
+
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+/*
+ * ioctl commands in 32 bit emulation
+ */
+#define F2FS_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
+#define F2FS_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
+#define F2FS_IOC32_GETVERSION		FS_IOC32_GETVERSION
+#endif
+
+#define F2FS_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
+#define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
+
+struct f2fs_gc_range {
+	u32 sync;
+	u64 start;
+	u64 len;
+};
+
+struct f2fs_defragment {
+	u64 start;
+	u64 len;
+};
+
+struct f2fs_move_range {
+	u32 dst_fd;		/* destination fd */
+	u64 pos_in;		/* start position in src_fd */
+	u64 pos_out;		/* start position in dst_fd */
+	u64 len;		/* size to move */
+};
+
+struct f2fs_flush_device {
+	u32 dev_num;		/* device number to flush */
+	u32 segments;		/* # of segments to flush */
+};
-- 
2.19.0.605.g01d371f741-goog
