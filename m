From: Chao Yu <yuchaochina@hotmail.com>
Subject: [PATCH 2/4] f2fs: skip searching dirty map if dirty
	segment is not exist
Date: Mon, 5 Oct 2015 22:20:40 +0800
Message-ID: <COL402-EAS395FAA55C6306F48D4626A9AB480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1Zj6dM-0007ky-1s
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:20:56 +0000
Received: from col004-omc1s14.hotmail.com ([65.55.34.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zj6dG-0005vB-KV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:20:56 +0000
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When searching victim during gc, if there are no dirty segments in
filesystem, we will still take the time to search the whole dirty segment
map, it's not needed, it's better to skip in this condition.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e5c255b..d844a80 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -268,6 +268,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_segno = NULL_SEGNO;
 	p.min_cost = max_cost = get_max_cost(sbi, &p);
 
+	if (p.max_search == 0)
+		goto out;
+
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
 		if (p.min_segno != NULL_SEGNO)
@@ -329,6 +332,7 @@ got_it:
 				sbi->cur_victim_sec,
 				prefree_segments(sbi), free_segments(sbi));
 	}
+out:
 	mutex_unlock(&dirty_i->seglist_lock);
 
 	return (p.min_segno == NULL_SEGNO) ? 0 : 1;
-- 
2.5.3


------------------------------------------------------------------------------
