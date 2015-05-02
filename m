From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/19] f2fs: move get_page for gc victims
Date: Fri,  1 May 2015 17:48:38 -0700
Message-ID: <1430527726-68547-11-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcY-0001Cu-Ap
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcX-0004Sy-GQ for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:30 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch moves getting victim page into move_data_page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 72667a5..1bd11f0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -518,14 +518,13 @@ static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	return 1;
 }
 
-static void move_data_page(struct inode *inode, struct page *page, int gc_type)
+static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 {
-	struct f2fs_io_info fio = {
-		.sbi = F2FS_I_SB(inode),
-		.type = DATA,
-		.rw = WRITE_SYNC,
-		.page = page,
-	};
+	struct page *page;
+
+	page = get_lock_data_page(inode, bidx);
+	if (IS_ERR(page))
+		return;
 
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
@@ -533,6 +532,12 @@ static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 		set_page_dirty(page);
 		set_cold_data(page);
 	} else {
+		struct f2fs_io_info fio = {
+			.sbi = F2FS_I_SB(inode),
+			.type = DATA,
+			.rw = WRITE_SYNC,
+			.page = page,
+		};
 		f2fs_wait_on_page_writeback(page, DATA);
 
 		if (clear_page_dirty_for_io(page))
@@ -618,12 +623,9 @@ next_step:
 		/* phase 3 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
-			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
-			data_page = get_lock_data_page(inode,
-						start_bidx + ofs_in_node);
-			if (IS_ERR(data_page))
-				continue;
-			move_data_page(inode, data_page, gc_type);
+			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode))
+								+ ofs_in_node;
+			move_data_page(inode, start_bidx, gc_type);
 			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
