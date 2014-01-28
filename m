From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/4] f2fs: handle dirty segments inside
	refresh_sit_entry
Date: Tue, 28 Jan 2014 14:54:05 +0900
Message-ID: <1390888447-5258-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1390888447-5258-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W81eE-00040D-Vq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:47 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W81eD-0005f5-3R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:46 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0300AADKGM6790@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 14:55:34 +0900 (KST)
In-reply-to: <1390888447-5258-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch cleans up the refresh_sit_entry to handle locate_dirty_segments.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 42903c3..6e9515d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1132,6 +1132,7 @@ void destroy_node_manager_caches(void);
 void f2fs_balance_fs(struct f2fs_sb_info *);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
+void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *);
 int npages_for_summary_flush(struct f2fs_sb_info *);
 void allocate_new_segments(struct f2fs_sb_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7caac5f..89aa503 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -434,12 +434,14 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
-static void refresh_sit_entry(struct f2fs_sb_info *sbi,
-			block_t old_blkaddr, block_t new_blkaddr)
+void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)
 {
-	update_sit_entry(sbi, new_blkaddr, 1);
-	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
-		update_sit_entry(sbi, old_blkaddr, -1);
+	update_sit_entry(sbi, new, 1);
+	if (GET_SEGNO(sbi, old) != NULL_SEGNO)
+		update_sit_entry(sbi, old, -1);
+
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, old));
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, new));
 }
 
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
@@ -886,12 +888,11 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 * since SSR needs latest valid block information.
 	 */
 	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
+	locate_dirty_segment(sbi, old_cursegno);
 
 	if (!__has_curseg_space(sbi, type))
 		sit_i->s_ops->allocate_segment(sbi, type, false);
 
-	locate_dirty_segment(sbi, old_cursegno);
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	mutex_unlock(&sit_i->sentry_lock);
 
 	if (page && IS_NODESEG(type))
@@ -992,9 +993,7 @@ void recover_data_page(struct f2fs_sb_info *sbi,
 	__add_sum_entry(sbi, type, sum);
 
 	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
-
 	locate_dirty_segment(sbi, old_cursegno);
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 
 	mutex_unlock(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
@@ -1045,9 +1044,7 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 	f2fs_submit_page_mbio(sbi, page, new_blkaddr, &fio);
 	f2fs_submit_merged_bio(sbi, NODE, WRITE);
 	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
-
 	locate_dirty_segment(sbi, old_cursegno);
-	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 
 	mutex_unlock(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
