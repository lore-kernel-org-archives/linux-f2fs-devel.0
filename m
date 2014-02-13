From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] f2fstat: add nat caches and free nids
Date: Thu, 13 Feb 2014 15:13:23 +0900
Message-ID: <1392272003-12324-2-git-send-email-cm224.lee@samsung.com>
References: <1392272003-12324-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WDpZt-0000Mf-DH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 06:15:17 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WDpZq-0002Il-GX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 06:15:17 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0X002K5817QTC0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Feb 2014 15:15:07 +0900 (KST)
In-reply-to: <1392272003-12324-1-git-send-email-cm224.lee@samsung.com>
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

This patch shows nat caches and free nids using f2fs.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 tools/f2fstat.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index 73ad457..c9c1d30 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -97,6 +97,7 @@ void f2fstat(struct options *opt)
 		{ "  - SITs",		&dirty_sit,		0 },
 		{ "  - Valid",		&valid_segs,		0 },
 		{ "  - dents",		&dirty_dents,		0 },
+		{ "  - free_nids",	&free_nids,		0 },
 		{ "  - meta",		&dirty_meta,		KEY_META },
 		{ "  - nodes",		&dirty_node,		KEY_NODE },
 		{ "CP calls",		&cp,			0 },
@@ -213,13 +214,13 @@ void parse_option(int argc, char *argv[], struct options *opt)
 
 void print_head(void)
 {
-	fprintf(stderr, "---utilization--- -----------main area-------- ---balancing async-- -gc- ---alloc--- -----memory-----\n");
-	fprintf(stderr, "util  node   data   free  valid  dirty prefree node  dent meta sit  cp   gc    ssr    lfs  total  node  meta\n");
+	fprintf(stderr, "---utilization--- -----------main area-------- ---------balancing async------- ---gc--- ---alloc--- -----memory-----\n");
+	fprintf(stderr, "util  node   data   free  valid  dirty prefree node  dent meta  sit   nat fnid  cp   gc    ssr    lfs  total  node  meta\n");
 }
 
 int main(int argc, char *argv[])
 {
-	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %3ld %5ld %6ld %6ld %6ld %6ld %6ld\n";
+	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %5ld %5ld %3ld %3ld %3ld %6ld %6ld %6ld %6ld %6ld\n";
 	int head_interval;
 	struct options opt = {
 		.delay = 1,
@@ -241,7 +242,7 @@ int main(int argc, char *argv[])
 
 		fprintf(stderr, format, util, used_node_blks, used_data_blks,
 			free_segs, valid_segs, dirty_segs, prefree_segs,
-			dirty_node, dirty_dents, dirty_meta, dirty_sit,
+			dirty_node, dirty_dents, dirty_meta, dirty_sit, nat_caches, free_nids,
 			cp, gc, ssr_blks, lfs_blks, memory_kb, node_kb, meta_kb);
 
 		sleep(opt.delay);
-- 
1.7.10.4


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
