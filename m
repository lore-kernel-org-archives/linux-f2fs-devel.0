From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs-tools: add f2fstat to print f2fs's status
	in sec
Date: Fri, 10 Jan 2014 17:44:59 +0900
Message-ID: <1389343499-17078-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1W1XgA-0002HL-NO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 08:42:58 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W1Xg6-0001IN-OU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 08:42:58 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZ600HWSG7BBO40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 17:42:47 +0900 (KST)
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

This tool prints /sys/kernel/debug/f2fs/status in sec so that we
can monitor variation of f2fs status.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 Makefile.am       |    2 +-
 configure.ac      |    1 +
 tools/Makefile.am |    7 ++
 tools/f2fstat.c   |  216 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 tools/Makefile.am
 create mode 100644 tools/f2fstat.c

diff --git a/Makefile.am b/Makefile.am
index ca376b4..d2921d6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,4 +2,4 @@
 
 ACLOCAL_AMFLAGS = -I m4
 
-SUBDIRS = man lib mkfs fsck
+SUBDIRS = man lib mkfs fsck tools
diff --git a/configure.ac b/configure.ac
index c5ca858..c2dafb0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,6 +83,7 @@ AC_CONFIG_FILES([
 	lib/Makefile
 	mkfs/Makefile
 	fsck/Makefile
+	tools/Makefile
 ])
 
 AC_OUTPUT
diff --git a/tools/Makefile.am b/tools/Makefile.am
new file mode 100644
index 0000000..8442387
--- /dev/null
+++ b/tools/Makefile.am
@@ -0,0 +1,7 @@
+## Makefile.am
+
+AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
+AM_CFLAGS = -Wall
+sbin_PROGRAMS = f2fstat
+f2fstat_SOURCES = f2fstat.c
+f2fstat_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
diff --git a/tools/f2fstat.c b/tools/f2fstat.c
new file mode 100644
index 0000000..75027a8
--- /dev/null
+++ b/tools/f2fstat.c
@@ -0,0 +1,216 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+
+#ifdef DEBUG
+#define dbg(fmt, args...)	printf(fmt, __VA_ARGS__);
+#else
+#define dbg(fmt, args...)
+#endif
+
+/*
+ * f2fs status
+ */
+#define F2FS_STATUS	"/sys/kernel/debug/f2fs/status"
+
+unsigned long util;
+unsigned long used_node_blks;
+unsigned long used_data_blks;
+//unsigned long inline_inode;
+
+unsigned long free_segs;
+unsigned long valid_segs;
+unsigned long dirty_segs;
+unsigned long prefree_segs;
+
+unsigned long gc;
+unsigned long bg_gc;
+unsigned long gc_data_blks;
+unsigned long gc_node_blks;
+
+//unsigned long extent_hit_ratio;
+
+unsigned long dirty_node;
+unsigned long dirty_dents;
+unsigned long dirty_meta;
+unsigned long nat_caches;
+unsigned long dirty_sit;
+
+unsigned long free_nids;
+
+unsigned long ssr_blks;
+unsigned long lfs_blks;
+
+
+struct options {
+	int delay;
+	int interval;
+};
+
+struct mm_table {
+	const char *name;
+	unsigned long *val;
+};
+
+static int compare_mm_table(const void *a, const void *b)
+{
+	dbg("[COMPARE] %s, %s\n", ((struct mm_table *)a)->name, ((struct mm_table *)b)->name);
+	return strcmp(((struct mm_table *)a)->name, ((struct mm_table *)b)->name);
+}
+
+static inline void remove_newline(char **head)
+{
+again:
+	if (**head == '\n') {
+		*head = *head + 1;
+		goto again;
+	}
+}
+
+void f2fstat(void)
+{
+	int fd;
+	int ret;
+	char keyname[32];
+	char buf[4096];
+	struct mm_table key = { keyname, NULL };
+	struct mm_table *found;
+	int f2fstat_table_cnt;
+	char *head, *tail;
+
+	static struct mm_table f2fstat_table[] = {
+		{ "  - Data",		&used_data_blks },
+		{ "  - Dirty",		&dirty_segs },
+		{ "  - Free",		&free_segs },
+		{ "  - NATs",		&nat_caches },
+		{ "  - Node",		&used_node_blks },
+		{ "  - Prefree",	&prefree_segs },
+		{ "  - SITs",		&dirty_sit },
+		{ "  - Valid",		&valid_segs },
+		{ "  - dents",		&dirty_dents },
+		{ "  - meta",		&dirty_meta },
+		{ "  - nodes",		&dirty_node },
+		{ "GC calls",		&gc },
+		{ "LFS",		&lfs_blks },
+		{ "SSR",		&ssr_blks },
+		{ "Utilization",	&util },
+	};
+
+	f2fstat_table_cnt = sizeof(f2fstat_table)/sizeof(struct mm_table);
+
+	fd = open(F2FS_STATUS, O_RDONLY);
+	if (fd < 0) {
+		perror("open " F2FS_STATUS);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = read(fd, buf, 4096);
+	if (ret < 0) {
+		perror("read " F2FS_STATUS);
+		exit(EXIT_FAILURE);
+	}
+	buf[ret] = '\0';
+
+	head = buf;
+	for (;;) {
+		remove_newline(&head);
+		tail = strchr(head, ':');
+		if (!tail)
+			break;
+		*tail = '\0';
+		if (strlen(head) >= sizeof(keyname)) {
+			dbg("[OVER] %s\n", head);
+			*tail = ':';
+			tail = strchr(head, '\n');
+			head = tail + 1;
+			continue;
+		}
+
+		strcpy(keyname, head);
+
+		found = bsearch(&key, f2fstat_table, f2fstat_table_cnt, sizeof(struct mm_table), compare_mm_table);
+		dbg("[RESULT] %s (%s)\n", head, (found) ? "O" : "X");
+		head = tail + 1;
+		if (!found)
+			goto nextline;
+
+		*(found->val) = strtoul(head, &tail, 10);
+nextline:
+		tail = strchr(head, '\n');
+		if (!tail)
+			break;
+		head =  tail + 1;
+	}
+
+	close(fd);
+}
+
+void usage(void)
+{
+	printf("Usage: f2fstat [option]\n"
+			"    -d    delay (secs)\n"
+			"    -i    interval of head info\n");
+	exit(EXIT_FAILURE);
+}
+
+void parse_option(int argc, char *argv[], struct options *opt)
+{
+	char option;
+	const char *option_string = "d:i:h";
+
+	while ((option = getopt(argc, argv, option_string)) != EOF) {
+		switch (option) {
+		case 'd':
+			opt->delay = atoi(optarg);
+			break;
+		case 'i':
+			opt->interval = atoi(optarg);
+			break;
+		default:
+			usage();
+			break;
+		}
+	}
+}
+
+void print_head(void)
+{
+	printf("---utilization--- -----------main area-------- ---balancing async-- -gc- ---alloc---\n");
+	printf("util  node   data   free  valid  dirty prefree node  dent meta sit   gc    ssr    lfs\n");
+}
+
+int main(int argc, char *argv[])
+{
+	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %5ld %6ld %6ld\n";
+	int head_interval;
+	struct options opt = {
+		.delay = 1,
+		.interval = 20,
+	};
+
+	parse_option(argc, argv, &opt);
+	head_interval = opt.interval;
+
+	print_head();
+	while (1) {
+		if (head_interval-- == 0) {
+			print_head();
+			head_interval = opt.interval;
+		}
+
+		f2fstat();
+
+		printf(format, util, used_node_blks, used_data_blks,
+				free_segs, valid_segs, dirty_segs, prefree_segs,
+				dirty_node, dirty_dents, dirty_meta, dirty_sit,
+				gc, ssr_blks, lfs_blks);
+
+		sleep(opt.delay);
+	}
+
+	return 0;
+}
+
+
-- 
1.7.10.4


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
