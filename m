From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: select target segment with closer
	temperature in SSR mode
Date: Fri, 24 Feb 2017 18:46:00 +0800
Message-ID: <20170224104600.60557-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chDON-0003vA-Bv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 10:46:27 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chDOL-0005Wz-Ls
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 10:46:27 +0000
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

In SSR mode, we can allocate target segment which has different
temperature type from the type of current block, in order to avoid
mixing coldest and hottest data/node as much as possible, change
SSR allocation policy to select closer temperature for current
block prior.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9eb6d89bf9e2..3a8a4d9888f1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1539,7 +1539,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
-	int i, n;
+	int i, cnt;
+	bool reversed = false;
 
 	/* need_SSR() already forces to do this */
 	if (v_ops->get_victim(sbi, &(curseg)->next_segno, BG_GC, type, SSR))
@@ -1547,14 +1548,24 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 
 	/* For node segments, let's do SSR more intensively */
 	if (IS_NODESEG(type)) {
-		i = CURSEG_HOT_NODE;
-		n = CURSEG_COLD_NODE;
+		if (type >= CURSEG_WARM_NODE) {
+			reversed = true;
+			i = CURSEG_COLD_NODE;
+		} else {
+			i = CURSEG_HOT_NODE;
+		}
+		cnt = NR_CURSEG_NODE_TYPE;
 	} else {
-		i = CURSEG_HOT_DATA;
-		n = CURSEG_COLD_DATA;
+		if (type >= CURSEG_WARM_DATA) {
+			reversed = true;
+			i = CURSEG_COLD_DATA;
+		} else {
+			i = CURSEG_HOT_DATA;
+		}
+		cnt = NR_CURSEG_DATA_TYPE;
 	}
 
-	for (; i <= n; i++) {
+	for (; cnt-- > 0; reversed ? i-- : i++) {
 		if (i == type)
 			continue;
 		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
