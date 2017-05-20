From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/5] f2fs: reconstruct sit flushing code
Date: Sat, 20 May 2017 12:24:32 +0000
Message-ID: <20170520122435.17574-3-houpengyang@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dC3RJ-0006ku-IW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:24:57 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dC3RH-00034X-K6
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:24:57 +0000
In-Reply-To: <20170520122435.17574-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org, miaoxie@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch recontructs sit flushing code for the afterward patch, with logic unchanged.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/segment.c | 119 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 55 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2d87aff..2c99fec 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2724,6 +2724,69 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 	up_write(&curseg->journal_rwsem);
 }
 
+static void __flush_sit_entry_set(struct f2fs_sb_info *sbi,
+							struct sit_entry_set *ses, struct cp_control *cpc,
+							bool to_journal)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	struct f2fs_journal *journal = curseg->journal;
+	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
+	struct page *page = NULL;
+	struct f2fs_sit_block *raw_sit = NULL;
+	unsigned int start_segno = ses->start_segno;
+	unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
+			(unsigned long)MAIN_SEGS(sbi));
+	unsigned int segno = start_segno;
+	struct seg_entry *se;
+
+	if (to_journal) {
+		down_write(&curseg->journal_rwsem);
+	} else {
+		page = get_next_sit_page(sbi, start_segno);
+		raw_sit = page_address(page);
+	}
+
+	/* flush dirty sit entries in region of current sit set */
+	for_each_set_bit_from(segno, bitmap, end) {
+		int offset, sit_offset;
+
+		se = get_seg_entry(sbi, segno);
+
+		/* add discard candidates */
+		if (!(cpc->reason & CP_DISCARD)) {
+			cpc->trim_start = segno;
+	        add_discard_addrs(sbi, cpc, false);
+	    }
+
+		if (to_journal) {
+			offset = lookup_journal_in_cursum(journal,
+				SIT_JOURNAL, segno, 1);
+			f2fs_bug_on(sbi, offset < 0);
+			segno_in_journal(journal, offset) =
+				cpu_to_le32(segno);
+			seg_info_to_raw_sit(se,
+				&sit_in_journal(journal, offset));
+	    } else {
+			sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
+			seg_info_to_raw_sit(se,
+				&raw_sit->entries[sit_offset]);
+	    }
+
+		__clear_bit(segno, bitmap);
+		sit_i->dirty_sentries--;
+		ses->entry_cnt--;
+	}
+	if (to_journal)
+		up_write(&curseg->journal_rwsem);
+	else
+		f2fs_put_page(page, 1);
+
+	f2fs_bug_on(sbi, ses->entry_cnt);
+	release_sit_entry_set(ses);
+
+}
+
 /*
  * CP calls this function, which flushes SIT entries including sit_journal,
  * and moves prefree segs to free segs.
@@ -2731,13 +2794,11 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	struct sit_entry_set *ses, *tmp;
 	struct list_head *head = &SM_I(sbi)->sit_entry_set;
 	bool to_journal = true;
-	struct seg_entry *se;
 
 	mutex_lock(&sit_i->sentry_lock);
 
@@ -2764,62 +2825,10 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * #2, flush sit entries to sit page.
 	 */
 	list_for_each_entry_safe(ses, tmp, head, set_list) {
-		struct page *page = NULL;
-		struct f2fs_sit_block *raw_sit = NULL;
-		unsigned int start_segno = ses->start_segno;
-		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
-						(unsigned long)MAIN_SEGS(sbi));
-		unsigned int segno = start_segno;
-
 		if (to_journal &&
 			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
 			to_journal = false;
-
-		if (to_journal) {
-			down_write(&curseg->journal_rwsem);
-		} else {
-			page = get_next_sit_page(sbi, start_segno);
-			raw_sit = page_address(page);
-		}
-
-		/* flush dirty sit entries in region of current sit set */
-		for_each_set_bit_from(segno, bitmap, end) {
-			int offset, sit_offset;
-
-			se = get_seg_entry(sbi, segno);
-
-			/* add discard candidates */
-			if (!(cpc->reason & CP_DISCARD)) {
-				cpc->trim_start = segno;
-				add_discard_addrs(sbi, cpc, false);
-			}
-
-			if (to_journal) {
-				offset = lookup_journal_in_cursum(journal,
-							SIT_JOURNAL, segno, 1);
-				f2fs_bug_on(sbi, offset < 0);
-				segno_in_journal(journal, offset) =
-							cpu_to_le32(segno);
-				seg_info_to_raw_sit(se,
-					&sit_in_journal(journal, offset));
-			} else {
-				sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
-				seg_info_to_raw_sit(se,
-						&raw_sit->entries[sit_offset]);
-			}
-
-			__clear_bit(segno, bitmap);
-			sit_i->dirty_sentries--;
-			ses->entry_cnt--;
-		}
-
-		if (to_journal)
-			up_write(&curseg->journal_rwsem);
-		else
-			f2fs_put_page(page, 1);
-
-		f2fs_bug_on(sbi, ses->entry_cnt);
-		release_sit_entry_set(ses);
+		__flush_sit_entry_set(sbi, ses, cpc, to_journal);
 	}
 
 	f2fs_bug_on(sbi, !list_empty(head));
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
