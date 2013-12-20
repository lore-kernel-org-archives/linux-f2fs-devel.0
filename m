From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: remove the rw_flag domain from f2fs_io_info
Date: Fri, 20 Dec 2013 18:17:49 +0800
Message-ID: <52B4194D.1010300@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VtxGX-0007Ji-BU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 10:25:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VtxGV-0008Qj-A4 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 10:25:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

When using the f2fs_io_info in the low level, we still need to merge the
rw and rw_flag, so use the rw to hold all the io flags directly,
and remove the rw_flag field.

ps.It is based on the previous patch:
f2fs: move all the bio initialization into __bio_alloc

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/data.c    |    3 +--
 fs/f2fs/f2fs.h    |    5 ++---
 fs/f2fs/gc.c      |    1 -
 fs/f2fs/node.c    |    6 ++----
 fs/f2fs/segment.c |    8 ++------
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 94fa651..439ed6c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -105,7 +105,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
-	rw = fio->rw | fio->rw_flag;
+	rw = fio->rw;
 
 	if (is_read_io(rw)) {
 		trace_f2fs_submit_read_bio(io->sbi->sb, rw,
@@ -755,7 +755,6 @@ static int f2fs_write_data_page(struct page *page,
 	struct f2fs_io_info fio = {
 		.type = DATA,
 		.rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC: WRITE,
-		.rw_flag = 0,
 	};
 
 	if (page->index < end_index)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8cbc5a6..d03d2ab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -368,9 +368,8 @@ enum page_type {
 };
 
 struct f2fs_io_info {
-	enum page_type type;		/* contains DATA/NODE/META/META_FLUSH */
-	int rw;				/* contains R/RS/W/WS */
-	int rw_flag;			/* contains REQ_META/REQ_PRIO */
+	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
+	int rw;			/* contains R/RS/W/WS with REQ_META/REQ_PRIO */
 };
 
 #define is_read_io(rw)	(((rw) & 1) == READ)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69c18e3..599f546 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -523,7 +523,6 @@ static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 	struct f2fs_io_info fio = {
 		.type = DATA,
 		.rw = WRITE_SYNC,
-		.rw_flag = 0,
 	};
 
 	if (gc_type == BG_GC) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3565caf..0af0a71 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -94,8 +94,7 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 	int i;
 	struct f2fs_io_info fio = {
 		.type = META,
-		.rw = READ_SYNC,
-		.rw_flag = REQ_META | REQ_PRIO
+		.rw = READ_SYNC | REQ_META | REQ_PRIO
 	};
 
 
@@ -1581,8 +1580,7 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
 	int page_idx = start;
 	struct f2fs_io_info fio = {
 		.type = META,
-		.rw = READ_SYNC,
-		.rw_flag = REQ_META | REQ_PRIO
+		.rw = READ_SYNC | REQ_META | REQ_PRIO
 	};
 
 	for (; page_idx < start + nrpages; page_idx++) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9f8bdd0..555ae76 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -916,8 +916,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 {
 	struct f2fs_io_info fio = {
 		.type = META,
-		.rw = WRITE_SYNC,
-		.rw_flag = REQ_META | REQ_PRIO
+		.rw = WRITE_SYNC | REQ_META | REQ_PRIO
 	};
 
 	set_page_writeback(page);
@@ -931,7 +930,6 @@ void write_node_page(struct f2fs_sb_info *sbi, struct page *page,
 	struct f2fs_io_info fio = {
 		.type = NODE,
 		.rw = WRITE_SYNC,
-		.rw_flag = 0
 	};
 
 	set_summary(&sum, nid, 0, 0);
@@ -1018,7 +1016,6 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 	struct f2fs_io_info fio = {
 		.type = NODE,
 		.rw = WRITE_SYNC,
-		.rw_flag = 0
 	};
 
 	curseg = CURSEG_I(sbi, type);
@@ -1598,8 +1595,7 @@ static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int nrpages)
 	int blkno = start;
 	struct f2fs_io_info fio = {
 		.type = META,
-		.rw = READ_SYNC,
-		.rw_flag = REQ_META | REQ_PRIO
+		.rw = READ_SYNC | REQ_META | REQ_PRIO
 	};
 
 	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {
-- 
1.7.7


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
