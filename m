From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] Revert "f2fs: node segment is prior to data
 segment selected victim"
Date: Sat, 23 Sep 2017 17:02:18 +0800
Message-ID: <1506157338-20441-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1dvgKm-0004Pf-Ol
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Sep 2017 09:02:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dvgKk-0006dW-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Sep 2017 09:02:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This reverts commit b9cd20619e359d199b755543474c3d853c8e3415.

That patch causes much fewer node segments (which can be used for SSR)
than before, and in the corner case (e.g. create and delete *.txt files in
one same directory, there will be very few node segments but many data
segments), if the reserved free segments are all used up during gc, then
the write_checkpoint can still flush dentry pages to data ssr segments,
but will probably fail to flush node pages to node ssr segments, since
there are not enough node ssr segments left (the left ones are all
full).

So revert this patch to give a fair chance to let node segments remain
for SSR, which provides more robustness for corner cases.

Conflicts:
	fs/f2fs/gc.c
---
 fs/f2fs/gc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bfe6a8c..f777e07 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -267,16 +267,6 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	return UINT_MAX - ((100 * (100 - u) * age) / (100 + u));
 }
 
-static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
-						unsigned int segno)
-{
-	unsigned int valid_blocks =
-			get_valid_blocks(sbi, segno, true);
-
-	return IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
-				valid_blocks * 2 : valid_blocks;
-}
-
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
@@ -285,7 +275,7 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
-		return get_greedy_cost(sbi, segno);
+		return get_valid_blocks(sbi, segno, true);
 	else
 		return get_cb_cost(sbi, segno);
 }
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
