From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: use for_each_set_bit to simplify the
	code
Date: Mon, 04 Aug 2014 10:10:07 +0800
Message-ID: <001e01cfaf89$54164640$fc42d2c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XE7jw-0004wg-3g
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 02:11:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XE7jt-0000c4-Bs
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 02:11:07 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9R008UZFE95590@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 11:10:57 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch uses for_each_set_bit to simplify some codes in f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c      |  7 ++-----
 fs/f2fs/segment.c | 13 ++++---------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b90dbe5..d7947d9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -186,7 +186,6 @@ static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
 static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned int hint = 0;
 	unsigned int secno;
 
 	/*
@@ -194,11 +193,9 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 	 * selected by background GC before.
 	 * Those segments guarantee they have small valid blocks.
 	 */
-next:
-	secno = find_next_bit(dirty_i->victim_secmap, TOTAL_SECS(sbi), hint++);
-	if (secno < TOTAL_SECS(sbi)) {
+	for_each_set_bit(secno, dirty_i->victim_secmap, TOTAL_SECS(sbi)) {
 		if (sec_usage_check(sbi, secno))
-			goto next;
+			continue;
 		clear_bit(secno, dirty_i->victim_secmap);
 		return secno * sbi->segs_per_sec;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c3b76d0..0dfeeba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -439,17 +439,12 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi,
 static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned int segno = -1;
+	unsigned int segno;
 	unsigned int total_segs = TOTAL_SEGS(sbi);
 
 	mutex_lock(&dirty_i->seglist_lock);
-	while (1) {
-		segno = find_next_bit(dirty_i->dirty_segmap[PRE], total_segs,
-				segno + 1);
-		if (segno >= total_segs)
-			break;
+	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], total_segs)
 		__set_test_and_free(sbi, segno);
-	}
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
@@ -1531,7 +1526,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 	struct page *page = NULL;
 	struct f2fs_sit_block *raw_sit = NULL;
 	unsigned int start = 0, end = 0;
-	unsigned int segno = -1;
+	unsigned int segno;
 	bool flushed;
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -1543,7 +1538,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 	 */
 	flushed = flush_sits_in_journal(sbi);
 
-	while ((segno = find_next_bit(bitmap, nsegs, segno + 1)) < nsegs) {
+	for_each_set_bit(segno, bitmap, nsegs) {
 		struct seg_entry *se = get_seg_entry(sbi, segno);
 		int sit_offset, offset;
 
-- 
2.0.0.421.g786a89d



------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
