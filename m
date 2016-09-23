From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: adjust display format of segment bit
Date: Fri, 23 Sep 2016 13:24:56 +0800
Message-ID: <20160923052458.83849-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bnIzI-0000ZP-Qc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:28 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bnIzF-0003Zg-5A
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Just adjust segment bit info printed in procfs.

Before:
1008      5|0  |0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1009      3|183|0 0 61 20 20 0 0 21 80 c0 2 e4 e 54 0 21 21 17 a 44 d0 28 e4 50 40 30 8 0 2d 32 0 5 b0 80 1 43 2 8e f8 7b 2 25 93 bf e0 73 8e 9a 19 44 60 ff e4 cc e6 8e bf f9 ff 5 3d 31 3d 13
1010      3|1  |0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 40 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

After:
1008      5|0  | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1009      4|434| ff 7d ff bf d9 3f ff e7 ff bf d7 bf ff bb be ff fb df f7 fb fa bf fb fe bb df dd ff fe ef ff fe ef e2 27 bf ab bf fb df fd bd bf fb db fc ff ff 3f ff ff bf ff 5f db 3f fb fb bf fb bf 4f ff ef
1010      4|422| ff bb fe ff ef d7 ee ff ff fc bf ef 7d eb ec fd fb 3f 97 7f ef ff af ff db ff ff 69 bf ff f6 e7 ff fb f7 7b fb df be ff ff ef f3 fe ff ff df fe f7 fa ff b7 77 be fe fb a9 7f 87 a2 ac c7 ff 75

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e7bb153..6426855 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -954,7 +954,7 @@ static int segment_bits_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "%d|%-3u|", se->type,
 					get_valid_blocks(sbi, i, 1));
 		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
-			seq_printf(seq, "%x ", se->cur_valid_map[j]);
+			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
 		seq_putc(seq, '\n');
 	}
 	return 0;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
