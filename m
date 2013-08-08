From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs-tools: add stat information into fibmap
Date: Thu, 08 Aug 2013 11:12:21 +0900
Message-ID: <1375927941-7988-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V7Fjt-0003rT-F0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 02:14:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7Fjp-0002oi-Oy for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 02:14:09 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR6005ZAWUM8TH0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Aug 2013 11:13:58 +0900 (KST)
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

This patch shows stat information about a file with fragmented state.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/fibmap.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fsck/fibmap.c b/fsck/fibmap.c
index 8726d3d..0ced7ca 100644
--- a/fsck/fibmap.c
+++ b/fsck/fibmap.c
@@ -26,6 +26,21 @@ void print_ext(struct file_ext *ext)
 					ext->end_blk, ext->blk_count);
 }
 
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
 int main(int argc, char *argv[])
 {
 	int fd;
@@ -61,6 +76,7 @@ int main(int argc, char *argv[])
 	total_blks = (st.st_size + st.st_blksize - 1) / st.st_blksize;
 
 	printf("\n%s :\n", filename);
+	print_stat(&st);
 	printf("file_pos   start_blk     end_blk        blks\n");
 
 	blknum = 0;
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
