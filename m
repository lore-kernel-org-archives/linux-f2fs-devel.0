From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: send discard commands in larger extent
Date: Thu, 30 Oct 2014 23:16:13 -0700
Message-ID: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there is a chance to make a huge sized discard command, we don't need
to split it out, since each blkdev_issue_discard should wait one at a
time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 06dda73..2fb3d7f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -469,10 +469,33 @@ void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 	}
 }
 
-static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+static void __add_discard_entry(struct f2fs_sb_info *sbi,
+		struct cp_control *cpc, unsigned int start, unsigned int end)
 {
 	struct list_head *head = &SM_I(sbi)->discard_list;
-	struct discard_entry *new;
+	struct discard_entry *new, *last;
+
+	if (!list_empty(head)) {
+		last = list_last_entry(head, struct discard_entry, list);
+		if (START_BLOCK(sbi, cpc->trim_start) + start ==
+						last->blkaddr + last->len) {
+			last->len += end - start;
+			goto done;
+		}
+	}
+
+	new = f2fs_kmem_cache_alloc(discard_entry_slab, GFP_NOFS);
+	INIT_LIST_HEAD(&new->list);
+	new->blkaddr = START_BLOCK(sbi, cpc->trim_start) + start;
+	new->len = end - start;
+	list_add_tail(&new->list, head);
+done:
+	SM_I(sbi)->nr_discards += end - start;
+	cpc->trimmed += end - start;
+}
+
+static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+{
 	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
 	int max_blocks = sbi->blocks_per_seg;
 	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
@@ -501,13 +524,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		}
 		mutex_unlock(&dirty_i->seglist_lock);
 
-		new = f2fs_kmem_cache_alloc(discard_entry_slab, GFP_NOFS);
-		INIT_LIST_HEAD(&new->list);
-		new->blkaddr = START_BLOCK(sbi, cpc->trim_start);
-		new->len = sbi->blocks_per_seg;
-		list_add_tail(&new->list, head);
-		SM_I(sbi)->nr_discards += sbi->blocks_per_seg;
-		cpc->trimmed += sbi->blocks_per_seg;
+		__add_discard_entry(sbi, cpc, 0, sbi->blocks_per_seg);
 		return;
 	}
 
@@ -529,14 +546,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (end - start < cpc->trim_minlen)
 			continue;
 
-		new = f2fs_kmem_cache_alloc(discard_entry_slab, GFP_NOFS);
-		INIT_LIST_HEAD(&new->list);
-		new->blkaddr = START_BLOCK(sbi, cpc->trim_start) + start;
-		new->len = end - start;
-		cpc->trimmed += end - start;
-
-		list_add_tail(&new->list, head);
-		SM_I(sbi)->nr_discards += end - start;
+		__add_discard_entry(sbi, cpc, start, end);
 	}
 }
 
-- 
2.1.1
