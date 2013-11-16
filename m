From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH V2 2/2] f2fs: read contiguous sit entry pages by
 merging for mount performance
Date: Sat, 16 Nov 2013 14:15:26 +0800
Message-ID: <000101cee293$4eae78d0$ec0b6a70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VhZB0-0005Ns-5q
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Nov 2013 06:16:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhZAy-0003dP-CB for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Nov 2013 06:16:14 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MWC003CWEQR2XC0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 Nov 2013 15:16:05 +0900 (KST)
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
To: '???' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously we read sit entries page one by one, this method lost the chance of reading contiguous page together.
So we read pages as contiguous as possible for better mount performance.

v1-->v2:
 o merge judgements/use 'Continue' or 'Break' instead of 'Goto' as Gu Zheng suggested.
 o add mark_page_accessed () before release page to delay VM reclaiming them.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c |  108 ++++++++++++++++++++++++++++++++++++++++-------------
 fs/f2fs/segment.h |    2 +
 2 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fa284d3..656fe40 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/prefetch.h>
 #include <linux/vmalloc.h>
+#include <linux/swap.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -1480,41 +1481,96 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	return restore_curseg_summaries(sbi);
 }
 
+static int ra_sit_pages(struct f2fs_sb_info *sbi, int start,
+					int nrpages, bool *is_order)
+{
+	struct address_space *mapping = sbi->meta_inode->i_mapping;
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct page *page;
+	block_t blk_addr;
+	int blkno = start, readcnt = 0;
+	int sit_blk_cnt = SIT_BLK_CNT(sbi);
+
+	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {
+
+		if ((!f2fs_test_bit(blkno, sit_i->sit_bitmap) ^ !*is_order)) {
+			*is_order = !*is_order;
+			break;
+		}
+
+		blk_addr = sit_i->sit_base_addr + blkno;
+		if (*is_order)
+			blk_addr += sit_i->sit_blocks;
+repeat:
+		page = grab_cache_page(mapping, blk_addr);
+		if (!page) {
+			cond_resched();
+			goto repeat;
+		}
+		if (PageUptodate(page)) {
+			mark_page_accessed(page);
+			f2fs_put_page(page, 1);
+			readcnt++;
+			continue;
+		}
+
+		submit_read_page(sbi, page, blk_addr, READ_SYNC);
+
+		mark_page_accessed(page);
+		f2fs_put_page(page, 0);
+		readcnt++;
+	}
+
+	f2fs_submit_read_bio(sbi, READ_SYNC);
+	return readcnt;
+}
+
 static void build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_summary_block *sum = curseg->sum_blk;
-	unsigned int start;
-
-	for (start = 0; start < TOTAL_SEGS(sbi); start++) {
-		struct seg_entry *se = &sit_i->sentries[start];
-		struct f2fs_sit_block *sit_blk;
-		struct f2fs_sit_entry sit;
-		struct page *page;
-		int i;
+	bool is_order = f2fs_test_bit(0, sit_i->sit_bitmap) ? true : false;
+	int sit_blk_cnt = SIT_BLK_CNT(sbi);
+	unsigned int i, start, end;
+	unsigned int readed, start_blk = 0;
 
-		mutex_lock(&curseg->curseg_mutex);
-		for (i = 0; i < sits_in_cursum(sum); i++) {
-			if (le32_to_cpu(segno_in_journal(sum, i)) == start) {
-				sit = sit_in_journal(sum, i);
-				mutex_unlock(&curseg->curseg_mutex);
-				goto got_it;
+	do {
+		readed = ra_sit_pages(sbi, start_blk, sit_blk_cnt, &is_order);
+
+		start = start_blk * sit_i->sents_per_block;
+		end = (start_blk + readed) * sit_i->sents_per_block;
+
+		for (; start < end && start < TOTAL_SEGS(sbi); start++) {
+			struct seg_entry *se = &sit_i->sentries[start];
+			struct f2fs_sit_block *sit_blk;
+			struct f2fs_sit_entry sit;
+			struct page *page;
+
+			mutex_lock(&curseg->curseg_mutex);
+			for (i = 0; i < sits_in_cursum(sum); i++) {
+				if (le32_to_cpu(segno_in_journal(sum, i)) == start) {
+					sit = sit_in_journal(sum, i);
+					mutex_unlock(&curseg->curseg_mutex);
+					goto got_it;
+				}
 			}
-		}
-		mutex_unlock(&curseg->curseg_mutex);
-		page = get_current_sit_page(sbi, start);
-		sit_blk = (struct f2fs_sit_block *)page_address(page);
-		sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
-		f2fs_put_page(page, 1);
+			mutex_unlock(&curseg->curseg_mutex);
+
+			page = get_current_sit_page(sbi, start);
+			sit_blk = (struct f2fs_sit_block *)page_address(page);
+			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
+			f2fs_put_page(page, 1);
 got_it:
-		check_block_count(sbi, start, &sit);
-		seg_info_from_raw_sit(se, &sit);
-		if (sbi->segs_per_sec > 1) {
-			struct sec_entry *e = get_sec_entry(sbi, start);
-			e->valid_blocks += se->valid_blocks;
+			check_block_count(sbi, start, &sit);
+			seg_info_from_raw_sit(se, &sit);
+			if (sbi->segs_per_sec > 1) {
+				struct sec_entry *e = get_sec_entry(sbi, start);
+				e->valid_blocks += se->valid_blocks;
+			}
 		}
-	}
+		start_blk += readed;
+	} while (start_blk < sit_blk_cnt);
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 269f690..ad5b9f1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -83,6 +83,8 @@
 	(segno / SIT_ENTRY_PER_BLOCK)
 #define	START_SEGNO(sit_i, segno)		\
 	(SIT_BLOCK_OFFSET(sit_i, segno) * SIT_ENTRY_PER_BLOCK)
+#define SIT_BLK_CNT(sbi)			\
+	((TOTAL_SEGS(sbi) + SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOCK)
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
 #define TOTAL_SEGS(sbi)	(SM_I(sbi)->main_segments)
-- 
1.7.9.5



------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
