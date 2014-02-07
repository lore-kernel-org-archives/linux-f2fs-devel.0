From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH V2] f2fs: introduce ra_meta_pages to readahead
 CP/NAT/SIT pages
Date: Fri, 07 Feb 2014 16:11:53 +0800
Message-ID: <002201cf23dc$5e118ee0$1a34aca0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch help us to cleanup the readahead code by merging ra_{sit,nat}_pages
function into ra_meta_pages.
Additionally the new function is used to readahead cp block in
recover_orphan_inodes.

Change log from v1:
 o fix a deadloop bug pointed by Jaegeuk Kim.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       |   10 +++++++
 fs/f2fs/node.c       |   38 +-----------------------
 fs/f2fs/segment.c    |   43 +---------------------------
 4 files changed, 90 insertions(+), 79 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8f5dff1..5f7f905 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -75,6 +75,82 @@ out:
 	return page;
 }
 
+inline int get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
+{
+	switch (type) {
+	case META_NAT:
+		return NM_I(sbi)->max_nid / NAT_ENTRY_PER_BLOCK;
+	case META_SIT:
+		return SIT_BLK_CNT(sbi);
+	case META_CP:
+		return 0;
+	default:
+		BUG();
+	}
+}
+
+/*
+ * Readahead CP/NAT/SIT pages
+ */
+int ra_meta_pages(struct f2fs_sb_info *sbi, int start, int nrpages, int type)
+{
+	block_t prev_blk_addr = 0;
+	struct page *page;
+	int blkno = start;
+	int max_blks = get_max_meta_blks(sbi, type);
+
+	struct f2fs_io_info fio = {
+		.type = META,
+		.rw = READ_SYNC | REQ_META | REQ_PRIO
+	};
+
+	for (; nrpages-- > 0; blkno++) {
+		block_t blk_addr;
+
+		switch (type) {
+		case META_NAT:
+			/* get nat block addr */
+			if (unlikely(blkno >= max_blks))
+				blkno = 0;
+			blk_addr = current_nat_addr(sbi,
+					blkno * NAT_ENTRY_PER_BLOCK);
+			break;
+		case META_SIT:
+			/* get sit block addr */
+			if (unlikely(blkno >= max_blks))
+				goto out;
+			blk_addr = current_sit_addr(sbi,
+					blkno * SIT_ENTRY_PER_BLOCK);
+			if (blkno != start && prev_blk_addr + 1 != blk_addr)
+				goto out;
+			prev_blk_addr = blk_addr;
+			break;
+		case META_CP:
+			/* get cp block addr */
+			blk_addr = blkno;
+			break;
+		default:
+			BUG();
+		}
+
+		page = grab_cache_page(META_MAPPING(sbi), blk_addr);
+		if (!page)
+			continue;
+		if (PageUptodate(page)) {
+			mark_page_accessed(page);
+			f2fs_put_page(page, 1);
+			continue;
+		}
+
+		f2fs_submit_page_mbio(sbi, page, blk_addr, &fio);
+		mark_page_accessed(page);
+		f2fs_put_page(page, 0);
+	}
+out:
+	f2fs_submit_merged_bio(sbi, META, READ);
+	return blkno - start;
+}
+
 static int f2fs_write_meta_page(struct page *page,
 				struct writeback_control *wbc)
 {
@@ -298,6 +374,8 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	start_blk = __start_cp_addr(sbi) + 1;
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
+	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
+
 	for (i = 0; i < orphan_blkaddr; i++) {
 		struct page *page = get_meta_page(sbi, start_blk + i);
 		struct f2fs_orphan_block *orphan_blk;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aeff132..15109f5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -88,6 +88,15 @@ enum {
 	SIT_BITMAP
 };
 
+/*
+ * For CP/NAT/SIT readahead
+ */
+enum {
+	META_CP,
+	META_NAT,
+	META_SIT
+};
+
 /* for the list of orphan inodes */
 struct orphan_inode_entry {
 	struct list_head list;	/* list head */
@@ -1171,6 +1180,7 @@ void destroy_segment_manager_caches(void);
  */
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
+int ra_meta_pages(struct f2fs_sb_info *, int, int, int);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
 int acquire_orphan_inode(struct f2fs_sb_info *);
 void release_orphan_inode(struct f2fs_sb_info *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 82f4753..7689f91 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -82,42 +82,6 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 	return dst_page;
 }
 
-/*
- * Readahead NAT pages
- */
-static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
-{
-	struct address_space *mapping = META_MAPPING(sbi);
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct page *page;
-	pgoff_t index;
-	int i;
-	struct f2fs_io_info fio = {
-		.type = META,
-		.rw = READ_SYNC | REQ_META | REQ_PRIO
-	};
-
-
-	for (i = 0; i < FREE_NID_PAGES; i++, nid += NAT_ENTRY_PER_BLOCK) {
-		if (unlikely(nid >= nm_i->max_nid))
-			nid = 0;
-		index = current_nat_addr(sbi, nid);
-
-		page = grab_cache_page(mapping, index);
-		if (!page)
-			continue;
-		if (PageUptodate(page)) {
-			mark_page_accessed(page);
-			f2fs_put_page(page, 1);
-			continue;
-		}
-		f2fs_submit_page_mbio(sbi, page, index, &fio);
-		mark_page_accessed(page);
-		f2fs_put_page(page, 0);
-	}
-	f2fs_submit_merged_bio(sbi, META, READ);
-}
-
 static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
 {
 	return radix_tree_lookup(&nm_i->nat_root, n);
@@ -1413,7 +1377,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 		return;
 
 	/* readahead nat pages to be scanned */
-	ra_nat_pages(sbi, nid);
+	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES, META_NAT);
 
 	while (1) {
 		struct page *page = get_current_nat_page(sbi, nid);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e87946a..fbb41ba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1576,47 +1576,6 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	return restore_curseg_summaries(sbi);
 }
 
-static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int nrpages)
-{
-	struct address_space *mapping = META_MAPPING(sbi);
-	struct page *page;
-	block_t blk_addr, prev_blk_addr = 0;
-	int sit_blk_cnt = SIT_BLK_CNT(sbi);
-	int blkno = start;
-	struct f2fs_io_info fio = {
-		.type = META,
-		.rw = READ_SYNC | REQ_META | REQ_PRIO
-	};
-
-	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {
-
-		blk_addr = current_sit_addr(sbi, blkno * SIT_ENTRY_PER_BLOCK);
-
-		if (blkno != start && prev_blk_addr + 1 != blk_addr)
-			break;
-		prev_blk_addr = blk_addr;
-repeat:
-		page = grab_cache_page(mapping, blk_addr);
-		if (!page) {
-			cond_resched();
-			goto repeat;
-		}
-		if (PageUptodate(page)) {
-			mark_page_accessed(page);
-			f2fs_put_page(page, 1);
-			continue;
-		}
-
-		f2fs_submit_page_mbio(sbi, page, blk_addr, &fio);
-
-		mark_page_accessed(page);
-		f2fs_put_page(page, 0);
-	}
-
-	f2fs_submit_merged_bio(sbi, META, READ);
-	return blkno - start;
-}
-
 static void build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -1628,7 +1587,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 	int nrpages = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
 
 	do {
-		readed = ra_sit_pages(sbi, start_blk, nrpages);
+		readed = ra_meta_pages(sbi, start_blk, nrpages, META_SIT);
 
 		start = start_blk * sit_i->sents_per_block;
 		end = (start_blk + readed) * sit_i->sents_per_block;
-- 
1.7.9.5
