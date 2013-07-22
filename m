From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [f2fs-dev] [PATCH] f2fs/debug.c : use seq_puts()/seq_putc() rather
 than seq_printf() where possible
Date: Mon, 22 Jul 2013 16:33:32 +0800
Message-ID: <51ECEE5C.3060407@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1V1BcN-0004vh-Rh
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Jul 2013 08:37:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V1BcJ-00080K-OF for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Jul 2013 08:37:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

For string without format specifiers, using seq_puts()/seq_putc()
instead of seq_printf().

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/debug.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index fd12b7f..a84b0a8 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -253,21 +253,21 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->nats, NM_WOUT_THRESHOLD);
 		seq_printf(s, "  - SITs: %5d\n  - free_nids: %5d\n",
 			   si->sits, si->fnids);
-		seq_printf(s, "\nDistribution of User Blocks:");
-		seq_printf(s, " [ valid | invalid | free ]\n");
-		seq_printf(s, "  [");
+		seq_puts(s, "\nDistribution of User Blocks:");
+		seq_puts(s, " [ valid | invalid | free ]\n");
+		seq_puts(s, "  [");
 
 		for (j = 0; j < si->util_valid; j++)
-			seq_printf(s, "-");
-		seq_printf(s, "|");
+			seq_putc(s, '-');
+		seq_putc(s, '|');
 
 		for (j = 0; j < si->util_invalid; j++)
-			seq_printf(s, "-");
-		seq_printf(s, "|");
+			seq_putc(s, '-');
+		seq_putc(s, '|');
 
 		for (j = 0; j < si->util_free; j++)
-			seq_printf(s, "-");
-		seq_printf(s, "]\n\n");
+			seq_putc(s, '-');
+		seq_puts(s, "]\n\n");
 		seq_printf(s, "SSR: %u blocks in %u segments\n",
 			   si->block_count[SSR], si->segment_count[SSR]);
 		seq_printf(s, "LFS: %u blocks in %u segments\n",
-- 
1.7.7


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
