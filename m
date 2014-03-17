From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: print type for each segment in
 segment_info's show
Date: Mon, 17 Mar 2014 10:31:06 +0800
Message-ID: <000001cf4189$14d1c310$3e754930$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WPNLb-0006dw-EE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 02:32:15 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WPNLZ-0004Nz-Ci
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 02:32:15 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N2K0074G71F5CB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 11:32:03 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The original segment_info's show looks out-of-format:
cat /proc/fs/f2fs/loop0/segment_info
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 512
512 512 512 512 512 512 512 0 0 512
348 0 263 0 0 512 0 0 512 512
512 512 0 512 512 512 512 512 512 512
512 512 511 328 512 512 512 512 512 512
512 512 512 512 512 512 512 0 0 175

Let's fix this and show type for each segment.
cat /proc/fs/f2fs/loop0/segment_info
format: segment_type|valid_blocks
segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)
0    2|0   1|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0
10   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0
20   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0
30   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0
40   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0   0|0
50   3|0   3|0   3|0   3|0   3|0   3|0   3|0   0|0   3|0   3|0
60   3|0   3|0   3|0   3|0   3|0   3|0   3|0   3|0   3|0   3|512
70   3|512 3|512 3|512 3|512 3|512 3|512 3|512 3|0   3|0   3|512
80   3|0   3|0   3|0   3|0   3|0   3|512 3|0   3|0   3|512 3|512
90   3|512 0|512 3|274 0|512 0|512 0|512 0|512 0|512 0|512 3|512
100  3|512 0|512 3|511 0|328 3|512 0|512 0|512 3|512 0|512 0|512
110  0|512 0|512 0|512 0|512 0|512 0|512 0|512 5|0   4|0   3|512

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3a51d7a..057a3ef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -544,8 +544,16 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 			le32_to_cpu(sbi->raw_super->segment_count_main);
 	int i;
 
+	seq_puts(seq, "format: segment_type|valid_blocks\n"
+		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
+
 	for (i = 0; i < total_segs; i++) {
-		seq_printf(seq, "%u", get_valid_blocks(sbi, i, 1));
+		struct seg_entry *se = get_seg_entry(sbi, i);
+
+		if ((i % 10) == 0)
+			seq_printf(seq, "%-5d", i);
+		seq_printf(seq, "%d|%-3u", se->type,
+					get_valid_blocks(sbi, i, 1));
 		if ((i % 10) == 9 || i == (total_segs - 1))
 			seq_putc(seq, '\n');
 		else
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
