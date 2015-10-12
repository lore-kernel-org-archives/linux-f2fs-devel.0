From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/5] f2fs: don't tag REQ_META for temporary non-meta pages
Date: Mon, 12 Oct 2015 17:04:21 +0800
Message-ID: <021001d104cd$14196370$3c4c2a50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In recovery or checkpoint flow, we grab pages temperarily in meta inode's
mapping for caching temperary data, actually, datas in these pages were
not meta data of f2fs, but still we tag them with REQ_META flag. However,
lower device like eMMC may do some optimization for data of such type.
So in order to avoid wrong optimization, we'd better remove such flag
for temperary non-meta pages.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 20 +++++++++++++++++++-
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/recovery.c   |  4 ++--
 fs/f2fs/segment.c    |  3 +++
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0a9ec42..60a9599 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -47,7 +47,8 @@ repeat:
 /*
  * We guarantee no failure on the returned page.
  */
-struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
+static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
+							bool is_meta)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page;
@@ -58,6 +59,9 @@ struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 		.blk_addr = index,
 		.encrypted_page = NULL,
 	};
+
+	if (unlikely(!is_meta))
+		fio.rw &= ~REQ_META;
 repeat:
 	page = grab_cache_page(mapping, index);
 	if (!page) {
@@ -91,6 +95,17 @@ out:
 	return page;
 }
 
+struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
+{
+	return __get_meta_page(sbi, index, true);
+}
+
+/* for POR only */
+struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
+{
+	return __get_meta_page(sbi, index, false);
+}
+
 bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 {
 	switch (type) {
@@ -137,6 +152,9 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 		.encrypted_page = NULL,
 	};
 
+	if (unlikely(type == META_POR))
+		fio.rw &= ~REQ_META;
+
 	for (; nrpages-- > 0; blkno++) {
 
 		if (!is_valid_blkaddr(sbi, blkno, type))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ba5a59..6c0e83c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1806,6 +1806,7 @@ void destroy_segment_manager_caches(void);
  */
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
+struct page *get_tmp_page(struct f2fs_sb_info *, pgoff_t);
 bool is_valid_blkaddr(struct f2fs_sb_info *, block_t, int);
 int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int);
 void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4d9bedf..c61dfb6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1807,7 +1807,7 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 		ra_meta_pages(sbi, addr, nrpages, META_POR);
 
 		for (idx = addr; idx < addr + nrpages; idx++) {
-			struct page *page = get_meta_page(sbi, idx);
+			struct page *page = get_tmp_page(sbi, idx);
 
 			rn = F2FS_NODE(page);
 			sum_entry->nid = rn->footer.nid;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c5daec5..75dbc07 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -188,7 +188,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
-		page = get_meta_page(sbi, blkaddr);
+		page = get_tmp_page(sbi, blkaddr);
 
 		if (cp_ver != cpver_of_node(page))
 			break;
@@ -480,7 +480,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 
 		ra_meta_pages_cond(sbi, blkaddr);
 
-		page = get_meta_page(sbi, blkaddr);
+		page = get_tmp_page(sbi, blkaddr);
 
 		if (cp_ver != cpver_of_node(page)) {
 			f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 581a9af..13aa7a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1317,6 +1317,9 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.encrypted_page = NULL,
 	};
 
+	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
+		fio.rw &= ~REQ_META;
+
 	set_page_writeback(page);
 	f2fs_submit_page_mbio(&fio);
 }
-- 
2.5.2
