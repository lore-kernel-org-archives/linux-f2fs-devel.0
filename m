From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: support fast lookup in extent cache
Date: Thu, 05 Feb 2015 18:01:39 +0800
Message-ID: <000801d0412a$d5da9bd0$818fd370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a fast lookup path for rb-tree extent cache.

In this patch we add a recently accessed extent node pointer 'cached_en' in
extent tree. In lookup path of extent cache, we will firstly lookup the last
accessed extent node which cached_en points, if we do not hit in this node,
we will try to lookup extent node in rb-tree.

By this way we can avoid unnecessary slow lookup in rb-tree sometimes.

Note that, side-effect of this patch is that we will increase memory cost,
because we will store a pointer variable in each struct extent tree
additionally.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 19 ++++++++++++++++---
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ba1605..112db9c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -395,6 +395,9 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 	rb_erase(&en->rb_node, &et->root);
 	et->count--;
 	atomic_dec(&sbi->total_ext_node);
+
+	if (et->cached_en == en)
+		et->cached_en = NULL;
 }
 
 static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
@@ -403,15 +406,24 @@ static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
 	struct rb_node *node = et->root.rb_node;
 	struct extent_node *en;
 
+	if (et->cached_en) {
+		struct extent_info *cei = &et->cached_en->ei;
+
+		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
+			return et->cached_en;
+	}
+
 	while (node) {
 		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (fofs < en->ei.fofs)
+		if (fofs < en->ei.fofs) {
 			node = node->rb_left;
-		else if (fofs >= en->ei.fofs + en->ei.len)
+		} else if (fofs >= en->ei.fofs + en->ei.len) {
 			node = node->rb_right;
-		else
+		} else {
+			et->cached_en = en;
 			return en;
+		}
 	}
 	return NULL;
 }
@@ -587,6 +599,7 @@ static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 		memset(et, 0, sizeof(struct extent_tree));
 		et->ino = ino;
 		et->root = RB_ROOT;
+		et->cached_en = NULL;
 		rwlock_init(&et->lock);
 		atomic_set(&et->refcount, 0);
 		et->count = 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9572f7c..47b30de 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -296,6 +296,7 @@ struct extent_node {
 struct extent_tree {
 	nid_t ino;			/* inode number */
 	struct rb_root root;		/* root of extent info rb-tree */
+	struct extent_node *cached_en;	/* recently accessed extent node */
 	rwlock_t lock;			/* protect extent info rb-tree */
 	atomic_t refcount;		/* reference count of rb-tree */
 	unsigned int count;		/* # of extent node in rb-tree*/
-- 
2.2.1
