From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 3/5] f2fs: format segment_info's show for better
	legibility
Date: Fri, 07 Mar 2014 18:43:33 +0800
Message-ID: <5319A2D5.6060201@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WLsO7-00030U-Sf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLsO6-0006r5-Qb for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Mar 2014 10:52:23 +0000
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

The original segment_info's show is a bit out-of-format:

[root@guz Demoes]# cat /proc/fs/f2fs/loop0/segment_info
0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
......
0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 1 [root@guz Demoes]#

so we fix it here for better legibility.
[root@guz Demoes]# cat /proc/fs/f2fs/loop0/segment_info
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
......
0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 1
[root@guz Demoes]#

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/super.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 72df734..6e4851c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -546,11 +546,12 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 
 	for (i = 0; i < total_segs; i++) {
 		seq_printf(seq, "%u", get_valid_blocks(sbi, i, 1));
-		if (i != 0 && (i % 10) == 0)
-			seq_puts(seq, "\n");
+		if ((i % 10) == 9 || i == (total_segs - 1))
+			seq_putc(seq, '\n');
 		else
-			seq_puts(seq, " ");
+			seq_putc(seq, ' ');
 	}
+
 	return 0;
 }
 
-- 
1.7.7


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
