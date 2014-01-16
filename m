From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] fibmap.f2fs: add bdev information
Date: Thu, 16 Jan 2014 12:01:27 +0900
Message-ID: <1389841287-11496-2-git-send-email-cm224.lee@samsung.com>
References: <1389841287-11496-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1W3dF1-0003Fk-SI
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 03:03:35 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W3dEw-0007ai-Tr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 03:03:35 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZH007VC4HJW0A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Jan 2014 12:03:19 +0900 (KST)
In-reply-to: <1389841287-11496-1-git-send-email-cm224.lee@samsung.com>
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

This patch shows devname and start_lba based on zero sector.
fibmap reports related lba, sometimes we want to know absolute lba of
file to compare with blktrace.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 tools/fibmap.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/fibmap.c b/tools/fibmap.c
index 9eb6b90..ed0a08e 100644
--- a/tools/fibmap.c
+++ b/tools/fibmap.c
@@ -7,6 +7,8 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <libgen.h>
+#include <linux/hdreg.h>
 #include <linux/types.h>
 #include <linux/fs.h>
 
@@ -41,6 +43,42 @@ void print_stat(struct stat64 *st)
 	printf("--------------------------------------------\n\n");
 }
 
+void stat_bdev(struct stat64 *st, unsigned int *start_lba)
+{
+	struct stat bdev_stat;
+	struct hd_geometry geom;
+	char devname[32] = { 0, };
+	char linkname[32] = { 0, };
+	int fd;
+
+	sprintf(devname, "/dev/block/%d:%d", major(st->st_dev), minor(st->st_dev));
+
+	fd = open(devname, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	if (fstat(fd, &bdev_stat) < 0)
+		goto out;
+
+	if (S_ISBLK(bdev_stat.st_mode)) {
+		if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
+			*start_lba = 0;
+		else
+			*start_lba = geom.start;
+	}
+
+	if (readlink(devname, linkname, sizeof(linkname)) < 0)
+		goto out;
+
+	printf("----------------bdev info-------------------\n");
+	printf("devname = %s\n", basename(linkname));
+	printf("start_lba = %u\n", *start_lba);
+
+out:
+	close(fd);
+
+}
+
 int main(int argc, char *argv[])
 {
 	int fd;
@@ -50,6 +88,7 @@ int main(int argc, char *argv[])
 	int total_blks;
 	unsigned int i;
 	struct file_ext ext;
+	__u32 start_lba;
 	__u32 blknum;
 
 	if (argc != 2) {
@@ -73,9 +112,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	stat_bdev(&st, &start_lba);
+
 	total_blks = (st.st_size + st.st_blksize - 1) / st.st_blksize;
 
-	printf("\n%s :\n", filename);
+	printf("\n----------------file info-------------------\n");
+	printf("%s :\n", filename);
 	print_stat(&st);
 	printf("file_pos   start_blk     end_blk        blks\n");
 
-- 
1.7.9.5


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
