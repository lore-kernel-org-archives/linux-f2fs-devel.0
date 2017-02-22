From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/2] f2fs fg_gc: node segment is prior to data
	segment selected victim
Date: Wed, 22 Feb 2017 10:28:59 +0000
Message-ID: <20170222102900.152902-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1cgUAn-0004J5-KV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 10:29:25 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgUAl-0006Y8-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Feb 2017 10:29:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

As data segment gc may lead dnode dirty, so the greedy cost for data segment should be
valid blocks * 2, that is data segment is prior to node segment.

Team:OTHERS
Feature or Bugfix:Bugfix
Binary Source:No

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e93aecb..4ee749f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -242,6 +242,13 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	return UINT_MAX - ((100 * (100 - u) * age) / (100 + u));
 }
 
+static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	unsigned int valid_blocks = get_valid_blocks(sbi, segno, sbi->segs_per_sec);
+	return IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
+			valid_blocks * 2 : valid_blocks;
+}
+
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
@@ -250,7 +257,7 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
-		return get_valid_blocks(sbi, segno, sbi->segs_per_sec);
+		return get_greedy_cost(sbi, segno);
 	else
 		return get_cb_cost(sbi, segno);
 }
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
