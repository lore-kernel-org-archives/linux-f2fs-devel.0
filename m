From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: replace __get_victim by dirty_segments
	in FG_GC
Date: Fri, 17 Feb 2017 17:16:38 +0800
Message-ID: <20170217091639.29433-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ceebI-0001Wx-2v
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 09:13:12 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ceebE-0007IQ-Bw
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 09:13:12 +0000
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

In FG_GC process, it will search victim section twice. This will
cause some dirty section with less valid blocks skip garbage
collection.

section # 26425 : valid blocks # 3
142.037567: get_victim_by_default: victim 26425 : valid blocks # 3
142.037585: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
142.039494: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19022 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
142.070247: new_curseg: Debug: alloc new segment 26746
142.244341: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26054 ofs_unit = 1, pre_victim_secno = 26054, prefree = 0, free = 243
142.254475: do_garbage_collect: Debug: FG_GC, seg_freed = 1
142.293131: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23466 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
142.319001: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23467 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
142.368879: get_victim_by_default: victim 26425 : valid blocks # 3
142.368894: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
142.378127: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19612 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
142.416917: new_curseg: Debug: alloc new segment 26054
142.656794: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 25404 ofs_unit = 1, pre_victim_secno = 25404, prefree = 0, free = 243
142.662139: do_garbage_collect: Debug: FG_GC, seg_freed = 1
142.684159: new_curseg: Debug: alloc new segment 25197
142.685059: get_victim_by_default: victim 26425 : valid blocks # 3
142.685079: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 243
142.701427: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26238 ofs_unit = 1, pre_victim_secno = 26238, prefree = 0, free = 243
142.707105: do_garbage_collect: Debug: FG_GC, seg_freed = 1
142.802444: f2fs_get_victim: dev = (259,30), type = Warm DATA, policy = (Background GC, SSR-mode, Greedy), victim = 23473 ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 244
142.804422: get_victim_by_default: victim 26425 : valid blocks # 3
142.804443: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244
142.851567: f2fs_get_victim: dev = (259,30), type = Hot DATA, policy = (Background GC, SSR-mode, Greedy), victim = 19092 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 24
142.865014: new_curseg: Debug: alloc new segment 26238
143.082245: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26307 ofs_unit = 1, pre_victim_secno = 26307, prefree = 0, free = 244
143.088252: do_garbage_collect: Debug: FG_GC, seg_freed = 1
143.128307: new_curseg: Debug: alloc new segment 25404
143.181846: get_victim_by_default: victim 26425 : valid blocks # 3
143.181872: f2fs_get_victim: dev = (259,30), type = No TYPE, policy = (Foreground GC, LFS-mode, Greedy), victim = 26425 ofs_unit = 1, pre_victim_secno = 26425, prefree = 0, free = 244

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 88e5e7b..74e1553 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -943,12 +943,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		 * enough free sections, we should flush dent/node blocks and do
 		 * garbage collections.
 		 */
-		if (__get_victim(sbi, &segno, gc_type) ||
-						prefree_segments(sbi)) {
+		if (dirty_segments(sbi) || prefree_segments(sbi)) {
 			ret = write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
-			segno = NULL_SEGNO;
 		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
 			ret = write_checkpoint(sbi, &cpc);
 			if (ret)
@@ -959,7 +957,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		goto stop;
 	}
 
-	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
+	if (!__get_victim(sbi, &segno, gc_type))
 		goto stop;
 	ret = 0;
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
