From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: rebuild sit page from sit info in mem
Date: Wed, 24 Jan 2018 10:39:20 +0800
Message-ID: <1516761560-22917-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eeBCJ-0005W7-3Z
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jan 2018 02:53:59 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eeBCH-0003VF-Ni
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jan 2018 02:53:59 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

This patch rebuild sit page from sit info in mem instead
of issue a read io.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 53 ++++++++++++++++++++++++-----------------------------
 fs/f2fs/segment.h | 10 ++++++++++
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e5739ce..9435261 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3109,34 +3109,6 @@ static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
 	return get_meta_page(sbi, current_sit_addr(sbi, segno));
 }
 
-static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
-					unsigned int start)
-{
-	struct sit_info *sit_i = SIT_I(sbi);
-	struct page *src_page, *dst_page;
-	pgoff_t src_off, dst_off;
-	void *src_addr, *dst_addr;
-
-	src_off = current_sit_addr(sbi, start);
-	dst_off = next_sit_addr(sbi, src_off);
-
-	/* get current sit block page without lock */
-	src_page = get_meta_page(sbi, src_off);
-	dst_page = grab_meta_page(sbi, dst_off);
-	f2fs_bug_on(sbi, PageDirty(src_page));
-
-	src_addr = page_address(src_page);
-	dst_addr = page_address(dst_page);
-	memcpy(dst_addr, src_addr, PAGE_SIZE);
-
-	set_page_dirty(dst_page);
-	f2fs_put_page(src_page, 1);
-
-	set_to_next_sit(sit_i, start);
-
-	return dst_page;
-}
-
 static struct sit_entry_set *grab_sit_entry_set(void)
 {
 	struct sit_entry_set *ses =
@@ -3261,6 +3233,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 */
 	list_for_each_entry_safe(ses, tmp, head, set_list) {
 		struct page *page = NULL;
+		struct address_space *mapping = META_MAPPING(sbi);
 		struct f2fs_sit_block *raw_sit = NULL;
 		unsigned int start_segno = ses->start_segno;
 		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
@@ -3274,8 +3247,30 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (to_journal) {
 			down_write(&curseg->journal_rwsem);
 		} else {
-			page = get_next_sit_page(sbi, start_segno);
+			pgoff_t src_off, dst_off;
+			int i;
+
+			src_off = current_sit_addr(sbi, start_segno);
+			dst_off = next_sit_addr(sbi, src_off);
+			set_to_next_sit(sit_i, start_segno);
+repeat:
+			page = f2fs_grab_cache_page(mapping, dst_off, false);
+			if (!page) {
+				cond_resched();
+				goto repeat;
+			}
+
+			f2fs_wait_on_page_writeback(page, META, true);
+			set_page_dirty(page);
 			raw_sit = page_address(page);
+			if (!PageUptodate(page)) {
+				for (i = 0; i < end - start_segno; i++) {
+					se = get_seg_entry(sbi, start_segno + i);
+					seg_info_to_sit_page(se,
+							&raw_sit->entries[i]);
+				}
+				SetPageUptodate(page);
+			}
 		}
 
 		/* flush dirty sit entries in region of current sit set */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 1a807e6..e346d90 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -348,6 +348,16 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 	se->mtime = le64_to_cpu(rs->mtime);
 }
 
+static inline void seg_info_to_sit_page(struct seg_entry *se,
+					struct f2fs_sit_entry *rs)
+{
+	unsigned short raw_vblocks = (se->type << SIT_VBLOCKS_SHIFT) |
+					se->valid_blocks;
+	rs->vblocks = cpu_to_le16(raw_vblocks);
+	memcpy(rs->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+	rs->mtime = cpu_to_le64(se->mtime);
+}
+
 static inline void seg_info_to_raw_sit(struct seg_entry *se,
 					struct f2fs_sit_entry *rs)
 {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
