From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2] f2fstat: show cp count calling f2fs
Date: Thu, 13 Feb 2014 15:13:22 +0900
Message-ID: <1392272003-12324-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WDpZp-0000MD-9V
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 06:15:13 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WDpZn-0007rQ-Ee
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 06:15:13 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0X00AP0813M310@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 15:15:04 +0900 (KST)
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

This patch is to inform how many checkpoint is called.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 tools/f2fstat.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index 8ece660..73ad457 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -29,8 +29,8 @@ unsigned long valid_segs;
 unsigned long dirty_segs;
 unsigned long prefree_segs;
 
-unsigned long gc;
-unsigned long bg_gc;
+unsigned long gc, bg_gc;
+unsigned long cp;
 unsigned long gc_data_blks;
 unsigned long gc_node_blks;
 
@@ -99,6 +99,7 @@ void f2fstat(struct options *opt)
 		{ "  - dents",		&dirty_dents,		0 },
 		{ "  - meta",		&dirty_meta,		KEY_META },
 		{ "  - nodes",		&dirty_node,		KEY_NODE },
+		{ "CP calls",		&cp,			0 },
 		{ "GC calls",		&gc,			0 },
 		{ "LFS",		&lfs_blks,		0 },
 		{ "Memory",		&memory_kb,		0 },
@@ -213,12 +214,12 @@ void parse_option(int argc, char *argv[], struct options *opt)
 void print_head(void)
 {
 	fprintf(stderr, "---utilization--- -----------main area-------- ---balancing async-- -gc- ---alloc--- -----memory-----\n");
-	fprintf(stderr, "util  node   data   free  valid  dirty prefree node  dent meta sit   gc    ssr    lfs  total  node  meta\n");
+	fprintf(stderr, "util  node   data   free  valid  dirty prefree node  dent meta sit  cp   gc    ssr    lfs  total  node  meta\n");
 }
 
 int main(int argc, char *argv[])
 {
-	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %5ld %6ld %6ld %6ld %6ld %6ld\n";
+	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %3ld %5ld %6ld %6ld %6ld %6ld %6ld\n";
 	int head_interval;
 	struct options opt = {
 		.delay = 1,
@@ -241,7 +242,7 @@ int main(int argc, char *argv[])
 		fprintf(stderr, format, util, used_node_blks, used_data_blks,
 			free_segs, valid_segs, dirty_segs, prefree_segs,
 			dirty_node, dirty_dents, dirty_meta, dirty_sit,
-			gc, ssr_blks, lfs_blks, memory_kb, node_kb, meta_kb);
+			cp, gc, ssr_blks, lfs_blks, memory_kb, node_kb, meta_kb);
 
 		sleep(opt.delay);
 	}
-- 
1.7.10.4


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
