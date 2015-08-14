From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid garbage collecting already moved node blocks
Date: Fri, 14 Aug 2015 16:09:11 -0700
Message-ID: <1439593751-21879-2-git-send-email-jaegeuk@kernel.org>
References: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If node blocks were already moved, we don't need to move them again.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 81de28d8..0a5d573 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -396,14 +396,18 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 {
 	bool initial = true;
 	struct f2fs_summary *entry;
+	block_t start_addr;
 	int off;
 
+	start_addr = START_BLOCK(sbi, segno);
+
 next_step:
 	entry = sum;
 
 	for (off = 0; off < sbi->blocks_per_seg; off++, entry++) {
 		nid_t nid = le32_to_cpu(entry->nid);
 		struct page *node_page;
+		struct node_info ni;
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
@@ -426,6 +430,12 @@ next_step:
 			continue;
 		}
 
+		get_node_info(sbi, nid, &ni);
+		if (ni.blk_addr != start_addr + off) {
+			f2fs_put_page(node_page, 1);
+			continue;
+		}
+
 		/* set page dirty and write it */
 		if (gc_type == FG_GC) {
 			f2fs_wait_on_page_writeback(node_page, NODE);
-- 
2.1.1

