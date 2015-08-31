From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: upset segment_info repair
Date: Mon, 31 Aug 2015 17:15:10 +0800
Message-ID: <1441012510-28607-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ZWLSn-0006BF-RI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 31 Aug 2015 09:33:17 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZWLSj-000192-FQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 31 Aug 2015 09:33:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

upset segment_info like this:

276000|161 0|0   4|70  3|0   3|0   0|0   0|91  4|0   4|232 4|39
276104|0   4|0   4|1   4|0   4|0   4|280 4|0   4|42  4|262 4|38
276204|179 4|89  4|39  4|24  4|0   4|96  4|3   4|428 4|0   4|118
276304|112 4|97  4|0   4|0   4|0   4|68  4|0   4|0   4|86  4|138
276404|0   4|0   0|166 5|39  4|101 0|111

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cfe3f95..f794781 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -693,7 +693,7 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 		struct seg_entry *se = get_seg_entry(sbi, i);
 
 		if ((i % 10) == 0)
-			seq_printf(seq, "%-5d", i);
+			seq_printf(seq, "%-10d", i);
 		seq_printf(seq, "%d|%-3u", se->type,
 					get_valid_blocks(sbi, i, 1));
 		if ((i % 10) == 9 || i == (total_segs - 1))
-- 
1.9.1


------------------------------------------------------------------------------
