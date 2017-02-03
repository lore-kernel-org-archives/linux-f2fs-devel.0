From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: move write_node_page above fsync_node_pages
Date: Fri,  3 Feb 2017 15:48:15 -0800
Message-ID: <20170203234816.12723-4-jaegeuk@kernel.org>
References: <20170203234816.12723-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203234816.12723-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch just moves write_node_page and introduces an inner function.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 142 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c573954571dd..f30cf1dec9a8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1318,6 +1318,79 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	return last_page;
 }
 
+static int __write_node_page(struct page *page,
+				struct writeback_control *wbc)
+{
+	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	nid_t nid;
+	struct node_info ni;
+	struct f2fs_io_info fio = {
+		.sbi = sbi,
+		.type = NODE,
+		.op = REQ_OP_WRITE,
+		.op_flags = wbc_to_write_flags(wbc),
+		.page = page,
+		.encrypted_page = NULL,
+	};
+
+	trace_f2fs_writepage(page, NODE);
+
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		goto redirty_out;
+	if (unlikely(f2fs_cp_error(sbi)))
+		goto redirty_out;
+
+	/* get old block addr of this node page */
+	nid = nid_of_node(page);
+	f2fs_bug_on(sbi, page->index != nid);
+
+	if (wbc->for_reclaim) {
+		if (!down_read_trylock(&sbi->node_write))
+			goto redirty_out;
+	} else {
+		down_read(&sbi->node_write);
+	}
+
+	get_node_info(sbi, nid, &ni);
+
+	/* This page is already truncated */
+	if (unlikely(ni.blk_addr == NULL_ADDR)) {
+		ClearPageUptodate(page);
+		dec_page_count(sbi, F2FS_DIRTY_NODES);
+		up_read(&sbi->node_write);
+		unlock_page(page);
+		return 0;
+	}
+
+	set_page_writeback(page);
+	fio.old_blkaddr = ni.blk_addr;
+	write_node_page(nid, &fio);
+	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
+	dec_page_count(sbi, F2FS_DIRTY_NODES);
+	up_read(&sbi->node_write);
+
+	if (wbc->for_reclaim)
+		f2fs_submit_merged_bio_cond(sbi, page->mapping->host, 0,
+						page->index, NODE, WRITE);
+
+	unlock_page(page);
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+
+	return 0;
+
+redirty_out:
+	redirty_page_for_writepage(wbc, page);
+	return AOP_WRITEPAGE_ACTIVATE;
+}
+
+static int f2fs_write_node_page(struct page *page,
+				struct writeback_control *wbc)
+{
+	return __write_node_page(page, wbc);
+}
+
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic)
 {
@@ -1397,7 +1470,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = NODE_MAPPING(sbi)->a_ops->writepage(page, wbc);
+			ret = __write_node_page(page, wbc);
 			if (ret) {
 				unlock_page(page);
 				f2fs_put_page(last_page, 0);
@@ -1579,73 +1652,6 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 	return ret;
 }
 
-static int f2fs_write_node_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
-	nid_t nid;
-	struct node_info ni;
-	struct f2fs_io_info fio = {
-		.sbi = sbi,
-		.type = NODE,
-		.op = REQ_OP_WRITE,
-		.op_flags = wbc_to_write_flags(wbc),
-		.page = page,
-		.encrypted_page = NULL,
-	};
-
-	trace_f2fs_writepage(page, NODE);
-
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto redirty_out;
-	if (unlikely(f2fs_cp_error(sbi)))
-		goto redirty_out;
-
-	/* get old block addr of this node page */
-	nid = nid_of_node(page);
-	f2fs_bug_on(sbi, page->index != nid);
-
-	if (wbc->for_reclaim) {
-		if (!down_read_trylock(&sbi->node_write))
-			goto redirty_out;
-	} else {
-		down_read(&sbi->node_write);
-	}
-
-	get_node_info(sbi, nid, &ni);
-
-	/* This page is already truncated */
-	if (unlikely(ni.blk_addr == NULL_ADDR)) {
-		ClearPageUptodate(page);
-		dec_page_count(sbi, F2FS_DIRTY_NODES);
-		up_read(&sbi->node_write);
-		unlock_page(page);
-		return 0;
-	}
-
-	set_page_writeback(page);
-	fio.old_blkaddr = ni.blk_addr;
-	write_node_page(nid, &fio);
-	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
-	dec_page_count(sbi, F2FS_DIRTY_NODES);
-	up_read(&sbi->node_write);
-
-	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host, 0,
-						page->index, NODE, WRITE);
-
-	unlock_page(page);
-
-	if (unlikely(f2fs_cp_error(sbi)))
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
-
-	return 0;
-
-redirty_out:
-	redirty_page_for_writepage(wbc, page);
-	return AOP_WRITEPAGE_ACTIVATE;
-}
-
 static int f2fs_write_node_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
-- 
2.11.0
