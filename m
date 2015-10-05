From: Chao Yu <yuchaochina@hotmail.com>
Subject: [PATCH 1/4] f2fs: fix to avoid redundant searching in
	dirty map during gc
Date: Mon, 5 Oct 2015 22:19:24 +0800
Message-ID: <COL402-EAS70ED5C3974FFD7920351AFAB480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1Zj6cV-00046W-11
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:20:03 +0000
Received: from col004-omc1s3.hotmail.com ([65.55.34.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zj6cT-00062X-5G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:20:03 +0000
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

When doing gc, we search a victim in dirty map, starting from position of
last victim, we will reset the current searching position until we touch
the end of dirty map, and then search the whole diryt map. So sometimes we
will search the range [victim, last] twice, it's redundant, this patch
avoids this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 343b096..e5c255b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -257,6 +257,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct victim_sel_policy p;
 	unsigned int secno, max_cost;
+	unsigned int last_segment = MAIN_SEGS(sbi);
 	int nsearched = 0;
 
 	mutex_lock(&dirty_i->seglist_lock);
@@ -277,9 +278,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		unsigned long cost;
 		unsigned int segno;
 
-		segno = find_next_bit(p.dirty_segmap, MAIN_SEGS(sbi), p.offset);
-		if (segno >= MAIN_SEGS(sbi)) {
+		segno = find_next_bit(p.dirty_segmap, last_segment, p.offset);
+		if (segno >= last_segment) {
 			if (sbi->last_victim[p.gc_mode]) {
+				last_segment = sbi->last_victim[p.gc_mode];
 				sbi->last_victim[p.gc_mode] = 0;
 				p.offset = 0;
 				continue;
-- 
2.5.3


------------------------------------------------------------------------------
