From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix out-of free segments
Date: Thu, 20 Apr 2017 17:49:57 -0700
Message-ID: <20170421004957.23760-2-jaegeuk@kernel.org>
References: <20170421004957.23760-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d1Mm0-0006Br-Eg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 00:50:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d1Mlz-0007oN-FO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 00:50:08 +0000
In-Reply-To: <20170421004957.23760-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org

This patch also reverts d0db7703ac1 ("f2fs: do SSR in higher priority").

This patch fixes out of free segments caused by many small file creation by
1) mkfs -s 1 2G
2) mount
3) untar
 - preoduce 60000 small files burstly
4) sync
 - flush node pages
 - flush imeta

Here, when we do f2fs_balance_fs, we missed # of imeta blocks, resulting in
skipping to check has_not_enough_free_secs.

Another test is done by
1) mkfs -s 12 2G
2) mount
3) untar
 - preoduce 60000 small files burstly
4) sync
 - flush node pages
 - flush imeta

In this case, this patch also fixes wrong block allocation under large section
size.

Reported-by: William Brana <wbrana@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    |  3 ++-
 fs/f2fs/inode.c   |  3 ++-
 fs/f2fs/segment.c | 26 +++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7d46a8e6d350..b8dcd1e224e8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1472,7 +1472,8 @@ static int __write_data_page(struct page *page, bool *submitted,
 	}
 
 	unlock_page(page);
-	f2fs_balance_fs(sbi, need_balance_fs);
+	if (!S_ISDIR(inode->i_mode))
+		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0900814485c7..518f49643092 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -338,7 +338,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
-	if (update_inode_page(inode) && wbc && wbc->nr_to_write)
+	update_inode_page(inode);
+	if (wbc && wbc->nr_to_write)
 		f2fs_balance_fs(sbi, true);
 	return 0;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d4bda1e54475..2a95535794ca 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -388,11 +388,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	}
 #endif
 
-	if (!need)
-		return;
-
 	/* balance_fs_bg is able to be pending */
-	if (excess_cached_nats(sbi))
+	if (need && excess_cached_nats(sbi))
 		f2fs_balance_fs_bg(sbi);
 
 	/*
@@ -1639,6 +1636,17 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
 	f2fs_put_page(page, 1);
 }
 
+static int is_next_segment_free(struct f2fs_sb_info *sbi, int type)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	unsigned int segno = curseg->segno + 1;
+	struct free_segmap_info *free_i = FREE_I(sbi);
+
+	if (segno < MAIN_SEGS(sbi) && segno % sbi->segs_per_sec)
+		return !test_bit(segno, free_i->free_segmap);
+	return 0;
+}
+
 /*
  * Find a new segment from the free segments bitmap to right order
  * This function should be returned with success, otherwise BUG
@@ -1752,6 +1760,10 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 
 static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 {
+	/* if segs_per_sec is large than 1, we need to keep original policy. */
+	if (sbi->segs_per_sec != 1)
+		return CURSEG_I(sbi, type)->segno;
+
 	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		return 0;
 
@@ -1901,17 +1913,21 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 						int type, bool force)
 {
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+
 	if (force)
 		new_curseg(sbi, type, true);
 	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
 					type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
+	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
+		new_curseg(sbi, type, false);
 	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type, true);
 	else
 		new_curseg(sbi, type, false);
 
-	stat_inc_seg_type(sbi, CURSEG_I(sbi, type));
+	stat_inc_seg_type(sbi, curseg);
 }
 
 void allocate_new_segments(struct f2fs_sb_info *sbi)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
