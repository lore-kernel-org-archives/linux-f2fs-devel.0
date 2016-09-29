From: Sheng Yong <shengyong1@huawei.com>
Subject: [trivial PATCH] f2fs: remove dead variable
Date: Thu, 29 Sep 2016 18:37:31 +0800
Message-ID: <20160929103731.15161-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bpYqh-0000KP-44
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:45:55 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYqe-0000W3-Lj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:45:55 +0000
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

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c9b8a67..93985c6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -275,7 +275,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct victim_sel_policy p;
-	unsigned int secno, max_cost, last_victim;
+	unsigned int secno, last_victim;
 	unsigned int last_segment = MAIN_SEGS(sbi);
 	unsigned int nsearched = 0;
 
@@ -285,7 +285,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	select_policy(sbi, gc_type, type, &p);
 
 	p.min_segno = NULL_SEGNO;
-	p.min_cost = max_cost = get_max_cost(sbi, &p);
+	p.min_cost = get_max_cost(sbi, &p);
 
 	if (p.max_search == 0)
 		goto out;
-- 
2.9.2


------------------------------------------------------------------------------
