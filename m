From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: introduce __get_node_page to reuse common code
Date: Tue, 05 Jan 2016 16:52:46 +0800
Message-ID: <009f01d14796$93e06c00$bba14400$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

There are duplicated code in between get_node_page and get_node_page_ra,
introduce __get_node_page to includes common parts of these two, and
export get_node_page and get_node_page_ra by reusing __get_node_page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 88 +++++++++++++++++++++++-----------------------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c1ddf3d..5a2d800 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1060,56 +1060,35 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_put_page(apage, err ? 1 : 0);
 }
 
-struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
+/*
+ * readahead MAX_RA_NODE number of node pages.
+ */
+void ra_node_pages(struct page *parent, int start)
 {
-	struct page *page;
-	int err;
+	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
+	struct blk_plug plug;
+	int i, end;
+	nid_t nid;
 
-	if (!nid)
-		return ERR_PTR(-ENOENT);
-	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
-repeat:
-	page = grab_cache_page(NODE_MAPPING(sbi), nid);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	blk_start_plug(&plug);
 
-	err = read_node_page(page, READ_SYNC);
-	if (err < 0) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(err);
-	} else if (err == LOCKED_PAGE) {
-		goto page_hit;
+	/* Then, try readahead for siblings of the desired node */
+	end = start + MAX_RA_NODE;
+	end = min(end, NIDS_PER_BLOCK);
+	for (i = start; i < end; i++) {
+		nid = get_nid(parent, i, false);
+		ra_node_page(sbi, nid);
 	}
 
-	lock_page(page);
-
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_put_page(page, 1);
-		return ERR_PTR(-EIO);
-	}
-	if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-		f2fs_put_page(page, 1);
-		goto repeat;
-	}
-page_hit:
-	f2fs_bug_on(sbi, nid != nid_of_node(page));
-	return page;
+	blk_finish_plug(&plug);
 }
 
-/*
- * Return a locked page for the desired node page.
- * And, readahead MAX_RA_NODE number of node pages.
- */
-struct page *get_node_page_ra(struct page *parent, int start)
+struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
+					struct page *parent, int start)
 {
-	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
-	struct blk_plug plug;
 	struct page *page;
-	int err, i, end;
-	nid_t nid;
+	int err;
 
-	/* First, try getting the desired direct node. */
-	nid = get_nid(parent, start, false);
 	if (!nid)
 		return ERR_PTR(-ENOENT);
 	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
@@ -1126,21 +1105,11 @@ repeat:
 		goto page_hit;
 	}
 
-	blk_start_plug(&plug);
-
-	/* Then, try readahead for siblings of the desired node */
-	end = start + MAX_RA_NODE;
-	end = min(end, NIDS_PER_BLOCK);
-	for (i = start + 1; i < end; i++) {
-		nid_t tnid;
-
-		tnid = get_nid(parent, i, false);
-		ra_node_page(sbi, tnid);
-	}
-
-	blk_finish_plug(&plug);
+	if (parent)
+		ra_node_pages(parent, start + 1);
 
 	lock_page(page);
+
 	if (unlikely(!PageUptodate(page))) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
@@ -1154,6 +1123,19 @@ page_hit:
 	return page;
 }
 
+struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
+{
+	return __get_node_page(sbi, nid, NULL, 0);
+}
+
+struct page *get_node_page_ra(struct page *parent, int start)
+{
+	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
+	nid_t nid = get_nid(parent, start, false);
+
+	return __get_node_page(sbi, nid, parent, start);
+}
+
 void sync_inode_page(struct dnode_of_data *dn)
 {
 	if (IS_INODE(dn->node_page) || dn->inode_page == dn->node_page) {
-- 
2.6.3
