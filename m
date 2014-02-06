From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fstat: add memory information used by f2fs
Date: Thu, 06 Feb 2014 16:37:53 +0900
Message-ID: <1391672273-22862-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1WBJYq-0000ta-Kc
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Feb 2014 07:39:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WBJYo-0007LY-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Feb 2014 07:39:48 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0K0095SDA27R40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Feb 2014 16:39:38 +0900 (KST)
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

This patch adds memory information used by f2fs.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 tools/f2fstat.c |   69 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index b4f22ae..8ece660 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -16,6 +16,9 @@
  */
 #define F2FS_STATUS	"/sys/kernel/debug/f2fs/status"
 
+#define KEY_NODE	0x00000001
+#define KEY_META	0x00000010
+
 unsigned long util;
 unsigned long used_node_blks;
 unsigned long used_data_blks;
@@ -33,9 +36,9 @@ unsigned long gc_node_blks;
 
 //unsigned long extent_hit_ratio;
 
-unsigned long dirty_node;
+unsigned long dirty_node, node_kb;
 unsigned long dirty_dents;
-unsigned long dirty_meta;
+unsigned long dirty_meta, meta_kb;
 unsigned long nat_caches;
 unsigned long dirty_sit;
 
@@ -43,7 +46,7 @@ unsigned long free_nids;
 
 unsigned long ssr_blks;
 unsigned long lfs_blks;
-
+unsigned long memory_kb;
 
 struct options {
 	int delay;
@@ -54,6 +57,7 @@ struct options {
 struct mm_table {
 	const char *name;
 	unsigned long *val;
+	int flag;
 };
 
 static int compare_mm_table(const void *a, const void *b)
@@ -84,21 +88,22 @@ void f2fstat(struct options *opt)
 	int found_cnt = 0;
 
 	static struct mm_table f2fstat_table[] = {
-		{ "  - Data",		&used_data_blks },
-		{ "  - Dirty",		&dirty_segs },
-		{ "  - Free",		&free_segs },
-		{ "  - NATs",		&nat_caches },
-		{ "  - Node",		&used_node_blks },
-		{ "  - Prefree",	&prefree_segs },
-		{ "  - SITs",		&dirty_sit },
-		{ "  - Valid",		&valid_segs },
-		{ "  - dents",		&dirty_dents },
-		{ "  - meta",		&dirty_meta },
-		{ "  - nodes",		&dirty_node },
-		{ "GC calls",		&gc },
-		{ "LFS",		&lfs_blks },
-		{ "SSR",		&ssr_blks },
-		{ "Utilization",	&util },
+		{ "  - Data",		&used_data_blks,	0 },
+		{ "  - Dirty",		&dirty_segs,		0 },
+		{ "  - Free",		&free_segs,		0 },
+		{ "  - NATs",		&nat_caches,		0 },
+		{ "  - Node",		&used_node_blks,	0 },
+		{ "  - Prefree",	&prefree_segs,		0 },
+		{ "  - SITs",		&dirty_sit,		0 },
+		{ "  - Valid",		&valid_segs,		0 },
+		{ "  - dents",		&dirty_dents,		0 },
+		{ "  - meta",		&dirty_meta,		KEY_META },
+		{ "  - nodes",		&dirty_node,		KEY_NODE },
+		{ "GC calls",		&gc,			0 },
+		{ "LFS",		&lfs_blks,		0 },
+		{ "Memory",		&memory_kb,		0 },
+		{ "SSR",		&ssr_blks,		0 },
+		{ "Utilization",	&util,			0 },
 	};
 
 	f2fstat_table_cnt = sizeof(f2fstat_table)/sizeof(struct mm_table);
@@ -147,6 +152,20 @@ void f2fstat(struct options *opt)
 			goto nextline;
 
 		*(found->val) = strtoul(head, &tail, 10);
+		if (found->flag) {
+			int npages;
+			tail = strstr(head, "in");
+			head = tail + 2;
+			npages = strtoul(head, &tail, 10);
+			switch (found->flag & (KEY_NODE | KEY_META)) {
+			case KEY_NODE:
+				node_kb = npages * 4;
+				break;
+			case KEY_META:
+				meta_kb = npages * 4;
+				break;
+			}
+		}
 		if (++found_cnt == f2fstat_table_cnt)
 			break;
 nextline:
@@ -193,13 +212,13 @@ void parse_option(int argc, char *argv[], struct options *opt)
 
 void print_head(void)
 {
-	printf("---utilization--- -----------main area-------- ---balancing async-- -gc- ---alloc---\n");
-	printf("util  node   data   free  valid  dirty prefree node  dent meta sit   gc    ssr    lfs\n");
+	fprintf(stderr, "---utilization--- -----------main area-------- ---balancing async-- -gc- ---alloc--- -----memory-----\n");
+	fprintf(stderr, "util  node   data   free  valid  dirty prefree node  dent meta sit   gc    ssr    lfs  total  node  meta\n");
 }
 
 int main(int argc, char *argv[])
 {
-	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %5ld %6ld %6ld\n";
+	char format[] = "%3ld %6ld %6ld %6ld %6ld %6ld %6ld %5ld %5ld %3ld %3ld %5ld %6ld %6ld %6ld %6ld %6ld\n";
 	int head_interval;
 	struct options opt = {
 		.delay = 1,
@@ -219,10 +238,10 @@ int main(int argc, char *argv[])
 
 		f2fstat(&opt);
 
-		printf(format, util, used_node_blks, used_data_blks,
-				free_segs, valid_segs, dirty_segs, prefree_segs,
-				dirty_node, dirty_dents, dirty_meta, dirty_sit,
-				gc, ssr_blks, lfs_blks);
+		fprintf(stderr, format, util, used_node_blks, used_data_blks,
+			free_segs, valid_segs, dirty_segs, prefree_segs,
+			dirty_node, dirty_dents, dirty_meta, dirty_sit,
+			gc, ssr_blks, lfs_blks, memory_kb, node_kb, meta_kb);
 
 		sleep(opt.delay);
 	}
-- 
1.7.10.4


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
