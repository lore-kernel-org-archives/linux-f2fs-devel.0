From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add a new function get_ssr_cost
Date: Wed, 17 May 2017 17:22:51 +0800
Message-ID: <1495012971-27893-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dAvLb-0003W7-Ax
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 May 2017 09:34:23 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dAvLX-0003Yd-6J
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 May 2017 09:34:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch add a new method get_ssr_cost to select
SSR segment more accurately.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 14c71ac..8139297 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -258,11 +258,20 @@ static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
 				valid_blocks * 2 : valid_blocks;
 }
 
+static unsigned int get_ssr_cost(struct f2fs_sb_info *sbi,
+						unsigned int segno)
+{
+	struct seg_entry *se = get_seg_entry(sbi, segno);
+
+	return se->ckpt_valid_blocks > se->valid_blocks ?
+				se->ckpt_valid_blocks : se->valid_blocks;
+}
+
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
 	if (p->alloc_mode == SSR)
-		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		return get_ssr_cost(sbi, segno);
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
