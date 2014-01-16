From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2] f2fs-tools: move fsck/fibmap.f2fs to tools/
Date: Thu, 16 Jan 2014 12:01:26 +0900
Message-ID: <1389841287-11496-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1W3dF1-0005wq-TR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 03:03:35 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W3dEw-0001mV-Kf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 03:03:35 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZH001DU4HFBUB0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 12:03:15 +0900 (KST)
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

Let's move miscellaneous utilities into tools directory.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/Makefile.am  |    4 +-
 fsck/fibmap.c     |  118 -----------------------------------------------------
 tools/Makefile.am |    4 +-
 tools/fibmap.c    |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 123 deletions(-)
 delete mode 100644 fsck/fibmap.c
 create mode 100644 tools/fibmap.c

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index fc54e91..3258e47 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -2,11 +2,9 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = fsck.f2fs fibmap.f2fs
+sbin_PROGRAMS = fsck.f2fs
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c
 fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
-fibmap_f2fs_SOURCES = fibmap.c
-
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
diff --git a/fsck/fibmap.c b/fsck/fibmap.c
deleted file mode 100644
index 9eb6b90..0000000
--- a/fsck/fibmap.c
+++ /dev/null
@@ -1,118 +0,0 @@
-#define _LARGEFILE64_SOURCE
-#include <unistd.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/ioctl.h>
-#include <sys/stat.h>
-#include <linux/types.h>
-#include <linux/fs.h>
-
-struct file_ext {
-	__u32 f_pos;
-	__u32 start_blk;
-	__u32 end_blk;
-	__u32 blk_count;
-};
-
-void print_ext(struct file_ext *ext)
-{
-	if (ext->end_blk == 0)
-		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, 0, 0, ext->blk_count);
-	else
-		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, ext->start_blk,
-					ext->end_blk, ext->blk_count);
-}
-
-void print_stat(struct stat64 *st)
-{
-	printf("--------------------------------------------\n");
-	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
-	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
-	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
-	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
-	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
-	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
-	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
-	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
-	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
-	printf("--------------------------------------------\n\n");
-}
-
-int main(int argc, char *argv[])
-{
-	int fd;
-	int ret = 0;
-	char *filename;
-	struct stat64 st;
-	int total_blks;
-	unsigned int i;
-	struct file_ext ext;
-	__u32 blknum;
-
-	if (argc != 2) {
-		fprintf(stderr, "No filename\n");
-		exit(-1);
-	}
-	filename = argv[1];
-
-	fd = open(filename, O_RDONLY|O_LARGEFILE);
-	if (fd < 0) {
-		ret = errno;
-		perror(filename);
-		exit(-1);
-	}
-
-	fsync(fd);
-
-	if (fstat64(fd, &st) < 0) {
-		ret = errno;
-		perror(filename);
-		goto out;
-	}
-
-	total_blks = (st.st_size + st.st_blksize - 1) / st.st_blksize;
-
-	printf("\n%s :\n", filename);
-	print_stat(&st);
-	printf("file_pos   start_blk     end_blk        blks\n");
-
-	blknum = 0;
-	if (ioctl(fd, FIBMAP, &blknum) < 0) {
-		ret = errno;
-		perror("ioctl(FIBMAP)");
-		goto out;
-	}
-	ext.f_pos = 0;
-	ext.start_blk = blknum;
-	ext.end_blk = blknum;
-	ext.blk_count = 1;
-
-	for (i = 1; i < total_blks; i++) {
-		blknum = i;
-
-		if (ioctl(fd, FIBMAP, &blknum) < 0) {
-			ret = errno;
-			perror("ioctl(FIBMAP)");
-			goto out;
-		}
-
-		if ((blknum == 0 && blknum == ext.end_blk) || (ext.end_blk + 1) == blknum) {
-			ext.end_blk = blknum;
-			ext.blk_count++;
-		} else {
-			print_ext(&ext);
-			ext.f_pos = i * st.st_blksize;
-			ext.start_blk = blknum;
-			ext.end_blk = blknum;
-			ext.blk_count = 1;
-		}
-	}
-
-	print_ext(&ext);
-out:
-	close(fd);
-	return ret;
-}
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 8442387..1ead174 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -2,6 +2,6 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = f2fstat
+sbin_PROGRAMS = f2fstat fibmap.f2fs
 f2fstat_SOURCES = f2fstat.c
-f2fstat_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+fibmap_f2fs_SOURCES = fibmap.c
diff --git a/tools/fibmap.c b/tools/fibmap.c
new file mode 100644
index 0000000..9eb6b90
--- /dev/null
+++ b/tools/fibmap.c
@@ -0,0 +1,118 @@
+#define _LARGEFILE64_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/fs.h>
+
+struct file_ext {
+	__u32 f_pos;
+	__u32 start_blk;
+	__u32 end_blk;
+	__u32 blk_count;
+};
+
+void print_ext(struct file_ext *ext)
+{
+	if (ext->end_blk == 0)
+		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, 0, 0, ext->blk_count);
+	else
+		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, ext->start_blk,
+					ext->end_blk, ext->blk_count);
+}
+
+void print_stat(struct stat64 *st)
+{
+	printf("--------------------------------------------\n");
+	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
+	printf("ino       [0x%8lx : %ld]\n", st->st_ino, st->st_ino);
+	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
+	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
+	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
+	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
+	printf("size      [0x%8lx : %ld]\n", st->st_size, st->st_size);
+	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
+	printf("blocks    [0x%8lx : %ld]\n", st->st_blocks, st->st_blocks);
+	printf("--------------------------------------------\n\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	int ret = 0;
+	char *filename;
+	struct stat64 st;
+	int total_blks;
+	unsigned int i;
+	struct file_ext ext;
+	__u32 blknum;
+
+	if (argc != 2) {
+		fprintf(stderr, "No filename\n");
+		exit(-1);
+	}
+	filename = argv[1];
+
+	fd = open(filename, O_RDONLY|O_LARGEFILE);
+	if (fd < 0) {
+		ret = errno;
+		perror(filename);
+		exit(-1);
+	}
+
+	fsync(fd);
+
+	if (fstat64(fd, &st) < 0) {
+		ret = errno;
+		perror(filename);
+		goto out;
+	}
+
+	total_blks = (st.st_size + st.st_blksize - 1) / st.st_blksize;
+
+	printf("\n%s :\n", filename);
+	print_stat(&st);
+	printf("file_pos   start_blk     end_blk        blks\n");
+
+	blknum = 0;
+	if (ioctl(fd, FIBMAP, &blknum) < 0) {
+		ret = errno;
+		perror("ioctl(FIBMAP)");
+		goto out;
+	}
+	ext.f_pos = 0;
+	ext.start_blk = blknum;
+	ext.end_blk = blknum;
+	ext.blk_count = 1;
+
+	for (i = 1; i < total_blks; i++) {
+		blknum = i;
+
+		if (ioctl(fd, FIBMAP, &blknum) < 0) {
+			ret = errno;
+			perror("ioctl(FIBMAP)");
+			goto out;
+		}
+
+		if ((blknum == 0 && blknum == ext.end_blk) || (ext.end_blk + 1) == blknum) {
+			ext.end_blk = blknum;
+			ext.blk_count++;
+		} else {
+			print_ext(&ext);
+			ext.f_pos = i * st.st_blksize;
+			ext.start_blk = blknum;
+			ext.end_blk = blknum;
+			ext.blk_count = 1;
+		}
+	}
+
+	print_ext(&ext);
+out:
+	close(fd);
+	return ret;
+}
-- 
1.7.9.5


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
