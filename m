From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs: fix to search whole dirty segmap when
 get_victim
Date: Mon, 15 Sep 2014 18:05:44 +0800
Message-ID: <003101cfd0cc$c0335890$409a09b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XTTBM-0005BB-OB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:06:52 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XTTBL-0006Yp-9m
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 10:06:52 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NBX00F4QTF8WN00@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 19:06:44 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In ->get_victim we get max_search value from dirty_i->nr_dirty without
protection of seglist_lock, after that, nr_dirty can be increased/decreased
before we hold seglist_lock lock.
Then in main loop we attempt to traverse all dirty section one time to find
victim section, but it's not accurate to use max_search as the total loop count,
because we might lose checking several sections or check sections redundantly
for the case of nr_dirty are increased or decreased previously.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 075ea1e..4481edc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -263,14 +263,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	unsigned int secno, max_cost;
 	int nsearched = 0;
 
+	mutex_lock(&dirty_i->seglist_lock);
+
 	p.alloc_mode = alloc_mode;
 	select_policy(sbi, gc_type, type, &p);
 
 	p.min_segno = NULL_SEGNO;
 	p.min_cost = max_cost = get_max_cost(sbi, &p);
 
-	mutex_lock(&dirty_i->seglist_lock);
-
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
 		if (p.min_segno != NULL_SEGNO)
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
