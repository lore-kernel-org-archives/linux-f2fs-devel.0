From: Changman Lee <cm224.lee@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools: add fibmap
Date: Thu, 18 Jul 2013 18:08:01 +0900
Message-ID: <1374138481-12867-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1UzkDb-0005kb-V7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 09:09:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UzkDZ-0003GR-T1 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 09:09:47 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQ400IC0K4185X0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Jul 2013 18:09:37 +0900 (KST)
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

This is to get physical location of file data.
We can check the percentage of fragmentation on a file.

Note that it uses fsync to get exact blkaddr.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/Makefile.am |    4 ++-
 fsck/fibmap.c    |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 fsck/fibmap.c

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 3258e47..c7be063 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -2,9 +2,11 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = fsck.f2fs
+sbin_PROGRAMS = fsck.f2fs fibmap
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c
 fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
 
+fibmap_SOURCES = fibmap.c
+
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
diff --git a/fsck/fibmap.c b/fsck/fibmap.c
new file mode 100644
index 0000000..8726d3d
--- /dev/null
+++ b/fsck/fibmap.c
@@ -0,0 +1,103 @@
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
+			ext.blk_count++;
+			print_ext(&ext);
+			ext.f_pos = i * st.st_blksize;
+			ext.start_blk = blknum;
+			ext.end_blk = blknum;
+			ext.blk_count = 0;
+		}
+	}
+
+	print_ext(&ext);
+out:
+	close(fd);
+	return ret;
+}
-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
