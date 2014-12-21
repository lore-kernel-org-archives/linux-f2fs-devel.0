From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] parse.f2fs: add a tool to parse IO traces
	made by runtime f2fs
Date: Sun, 21 Dec 2014 08:37:14 -0800
Message-ID: <1419179834-3345-2-git-send-email-jaegeuk@kernel.org>
References: <1419179834-3345-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y2jVW-0005df-7I
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:37:26 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2jVU-0001nM-3y for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Dec 2014 16:37:26 +0000
In-Reply-To: <1419179834-3345-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@motorola.com>

From: Jaegeuk Kim <jaegeuk@motorola.com>

This patch adds parse.f2fs to retrieve process information and an amount
of data reads and writes from given IO trace got by f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@motorola.com>
---
 tools/Makefile.am     |   3 +-
 tools/f2fs_io_parse.c | 322 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 tools/f2fs_io_parse.c

diff --git a/tools/Makefile.am b/tools/Makefile.am
index 1ead174..69a0bb1 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -2,6 +2,7 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = f2fstat fibmap.f2fs
+sbin_PROGRAMS = f2fstat fibmap.f2fs parse.f2fs
 f2fstat_SOURCES = f2fstat.c
 fibmap_f2fs_SOURCES = fibmap.c
+parse_f2fs_SOURCES = f2fs_io_parse.c
diff --git a/tools/f2fs_io_parse.c b/tools/f2fs_io_parse.c
new file mode 100644
index 0000000..7f97270
--- /dev/null
+++ b/tools/f2fs_io_parse.c
@@ -0,0 +1,322 @@
+/*
+ * f2fs IO tracer
+ *
+ * Copyright (c) 2014 Motorola Mobility
+ * Copyright (c) 2014 Jaegeuk Kim <jaegeuk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define _LARGEFILE64_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <assert.h>
+#include <locale.h>
+
+#define P_NAMELEN	16
+
+/* For global trace methods */
+enum show_type {
+	SHOW_PID,
+	SHOW_FTYPE,
+	SHOW_ALL,
+};
+
+enum trace_types {
+	TP_PID,
+	TP_IOS,
+	TP_MAX,
+};
+
+struct tps {
+	enum trace_types type;
+	const char *name;
+};
+
+struct tps trace_points[] = {
+	{ TP_PID,	"f2fs_trace_pid" },
+	{ TP_IOS,	"f2fs_trace_ios" },
+};
+
+/* For f2fs_trace_pid and f2fs_trace_ios */
+enum rw_type {
+	READ,
+	WRITE,
+	MAX_RW,
+};
+
+enum file_type {
+	__NORMAL_FILE,
+	__DIR_FILE,
+	__NODE_FILE,
+	__META_FILE,
+	__ATOMIC_FILE,
+	__VOLATILE_FILE,
+	__MISC_FILE,
+	__NR_FILES,
+};
+
+char *file_type_string[] = {
+	"User      ",
+	"Dir       ",
+	"Node      ",
+	"Meta      ",
+	"Atomic    ",
+	"Voltile   ",
+	"Misc      ",
+};
+
+struct pid_ent {
+	int pid;
+	char name[P_NAMELEN];
+	unsigned long long io[__NR_FILES][MAX_RW];
+	unsigned long long total_io[MAX_RW];
+	LIST_ENTRY(pid_ent) ptr;
+};
+
+/* global variables */
+int major = 0, minor = 0;
+int show_option = SHOW_ALL;
+unsigned long long total_io[__NR_FILES][MAX_RW];
+
+LIST_HEAD(plist, pid_ent) pid_info;
+
+/* Functions */
+static inline int atoh(char *str)
+{
+	int val;
+	sscanf(str, "%x", &val);
+	return val;
+}
+
+static void do_init()
+{
+	struct pid_ent *misc;
+
+	misc = calloc(1, sizeof(struct pid_ent));
+	assert(misc);
+
+	LIST_INIT(&pid_info);
+	LIST_INSERT_HEAD(&pid_info, misc, ptr);
+}
+
+void show_usage()
+{
+	printf("\nUsage: parse.f2fs [options] log_file\n");
+	printf("[options]:\n");
+	printf("  -a RW sorted by pid & file types\n");
+	printf("  -f RW sorted by file types\n");
+	printf("  -p RW sorted by pid\n");
+	printf("  -m major number\n");
+	printf("  -n minor number\n");
+	exit(1);
+}
+
+static int parse_options(int argc, char *argv[])
+{
+	const char *option_string = "fm:n:p";
+	int option = 0;
+
+	while ((option = getopt(argc, argv, option_string)) != EOF) {
+		switch (option) {
+		case 'f':
+			show_option = SHOW_FTYPE;
+			break;
+		case 'm':
+			major = atoh(optarg);
+			break;
+		case 'n':
+			minor = atoh(optarg);
+			break;
+		case 'p':
+			show_option = SHOW_PID;
+			break;
+		default:
+			printf("\tError: Unknown option %c\n", option);
+			show_usage();
+			break;
+		}
+	}
+	if ((optind + 1) != argc) {
+		printf("\tError: Log file is not specified.\n");
+		show_usage();
+	}
+	return optind;
+}
+
+struct pid_ent *get_pid_entry(int pid)
+{
+	struct pid_ent *entry;
+
+	LIST_FOREACH(entry, &pid_info, ptr) {
+		if (entry->pid == pid)
+			return entry;
+	}
+	return LIST_FIRST(&pid_info);
+}
+
+static void handle_tp_pid(char *ptr)
+{
+	struct pid_ent *pent;
+
+	pent = calloc(1, sizeof(struct pid_ent));
+	assert(pent);
+
+	ptr = strtok(NULL, " ");
+	pent->pid = atoh(ptr);
+
+	ptr = strtok(NULL, " ");
+	strcpy(pent->name, ptr);
+
+	LIST_INSERT_HEAD(&pid_info, pent, ptr);
+}
+
+static void handle_tp_ios(char *ptr)
+{
+	int pid, type, rw, len;
+	struct pid_ent *p;
+
+	ptr = strtok(NULL, " ");
+	pid = atoh(ptr);
+
+	ptr = strtok(NULL, " ");
+	ptr = strtok(NULL, " ");
+	type = atoh(ptr);
+
+	ptr = strtok(NULL, " ");
+	rw = atoh(ptr);
+
+	ptr = strtok(NULL, " ");
+	/* unsigned long long blkaddr = atoh(ptr); */
+
+	ptr = strtok(NULL, " ");
+	len = atoh(ptr);
+
+	/* update per-pid stat */
+	p = get_pid_entry(pid);
+	p->io[type][rw & 0x1] += len;
+	p->total_io[rw & 0x1] += len;
+
+	/* update total stat */
+	total_io[type][rw & 0x1] += len;
+}
+
+static void do_parse(FILE *file)
+{
+	char line[300];
+	char *ptr;
+	int i;
+
+	while (fgets(line, sizeof(line), file) != NULL) {
+		ptr = strtok(line, ":");
+
+		ptr = strtok(NULL, " :");
+
+		for (i = 0; i < TP_MAX; i++) {
+			if (!strcmp(ptr, trace_points[i].name))
+				break;
+		}
+		if (i == TP_MAX)
+			continue;
+		ptr = strtok(NULL, " :");
+		if (major && major != atoh(ptr))
+			continue;
+		ptr = strtok(NULL, " :");
+		if (minor && minor != atoh(ptr))
+			continue;
+
+		switch (i) {
+		case TP_PID:
+			handle_tp_pid(ptr);
+			break;
+		case TP_IOS:
+			handle_tp_ios(ptr);
+			break;
+		}
+	}
+}
+
+static void __print_pid()
+{
+	struct pid_ent *entry;
+	int i;
+
+	setlocale(LC_ALL, "");
+	printf("%8s %16s %17s ||", "PID", "NAME", "R/W in 4KB");
+	for (i = 0; i < __NR_FILES; i++)
+		printf(" %17s |", file_type_string[i]);
+	printf("\n");
+
+	LIST_FOREACH(entry, &pid_info, ptr) {
+		printf("%8x %16s %'8lld %'8lld ||",
+				entry->pid, entry->name,
+				entry->total_io[READ],
+				entry->total_io[WRITE]);
+		for (i = 0; i < __NR_FILES; i++)
+			printf(" %'8lld %'8lld |",
+				entry->io[i][READ],
+				entry->io[i][WRITE]);
+		printf("\n");
+	}
+}
+
+static void __print_ftype()
+{
+	int i;
+
+	setlocale(LC_ALL, "");
+	printf("\n===== Data R/W in 4KB accoring to File types =====\n");
+	for (i = 0; i < __NR_FILES; i++)
+		printf(" %17s |", file_type_string[i]);
+	printf("\n");
+
+	for (i = 0; i < __NR_FILES; i++)
+		printf(" %'8lld %'8lld |",
+				total_io[i][READ],
+				total_io[i][WRITE]);
+	printf("\n");
+}
+
+static void do_print()
+{
+	switch (show_option) {
+	case SHOW_PID:
+		__print_pid();
+		break;
+	case SHOW_FTYPE:
+		__print_ftype();
+		break;
+	case SHOW_ALL:
+		__print_pid();
+		printf("\n\n");
+		__print_ftype();
+		break;
+	}
+}
+
+int main(int argc, char **argv)
+{
+	FILE *file;
+	int opt;
+
+	opt = parse_options(argc, argv);
+
+	file = fopen(argv[opt], "r");
+	if (!file) {
+		perror("open log file");
+		exit(EXIT_FAILURE);
+	}
+
+	do_init();
+
+	do_parse(file);
+
+	do_print();
+
+	fclose(file);
+	return 0;
+}
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
