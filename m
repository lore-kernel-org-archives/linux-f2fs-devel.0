From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/12] f2fs: set cached_en after checking finally
Date: Mon, 29 Jun 2015 11:39:31 -0700
Message-ID: <1435603176-63219-7-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch relocates cached_en not only to be covered by spin_lock, but also
to set once after checking out completely.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e6609b..676e7b9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -453,14 +453,12 @@ static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
 	while (node) {
 		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (fofs < en->ei.fofs) {
+		if (fofs < en->ei.fofs)
 			node = node->rb_left;
-		} else if (fofs >= en->ei.fofs + en->ei.len) {
+		else if (fofs >= en->ei.fofs + en->ei.len)
 			node = node->rb_right;
-		} else {
-			et->cached_en = en;
+		else
 			return en;
-		}
 	}
 	return NULL;
 }
@@ -625,6 +623,7 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		spin_lock(&sbi->extent_lock);
 		if (!list_empty(&en->list))
 			list_move_tail(&en->list, &sbi->extent_list);
+		et->cached_en = en;
 		spin_unlock(&sbi->extent_lock);
 		stat_inc_read_hit(sbi->sb);
 	}
-- 
2.1.1
