From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: more fast lookup for gc_inode list
Date: Thu, 27 Nov 2014 18:11:51 +0900
Message-ID: <1417079511-29479-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there are many inodes that have data blocks in victim segment,
it takes long time to find a inode in gc_inode list.
Let's use radix_tree to reduce lookup time.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/gc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 29fc7e5..fc765c1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -24,6 +24,7 @@
 #include "gc.h"
 #include <trace/events/f2fs.h>
 
+RADIX_TREE(gc_inode_root, GFP_ATOMIC);
 static struct kmem_cache *winode_slab;
 
 static int gc_thread_func(void *data)
@@ -338,13 +339,13 @@ static const struct victim_selection default_v_ops = {
 	.get_victim = get_victim_by_default,
 };
 
-static struct inode *find_gc_inode(nid_t ino, struct list_head *ilist)
+static struct inode *find_gc_inode(nid_t ino)
 {
 	struct inode_entry *ie;
 
-	list_for_each_entry(ie, ilist, list)
-		if (ie->inode->i_ino == ino)
-			return ie->inode;
+	ie = radix_tree_lookup(&gc_inode_root, ino);
+	if (ie)
+		return ie->inode;
 	return NULL;
 }
 
@@ -352,13 +353,19 @@ static void add_gc_inode(struct inode *inode, struct list_head *ilist)
 {
 	struct inode_entry *new_ie;
 
-	if (inode == find_gc_inode(inode->i_ino, ilist)) {
+	new_ie = radix_tree_lookup(&gc_inode_root, inode->i_ino);
+	if (new_ie) {
 		iput(inode);
 		return;
 	}
 
 	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
 	new_ie->inode = inode;
+
+	if (radix_tree_insert(&gc_inode_root, inode->i_ino, new_ie)) {
+		kmem_cache_free(winode_slab, new_ie);
+		return;
+	}
 	list_add_tail(&new_ie->list, ilist);
 }
 
@@ -367,7 +374,7 @@ static void put_gc_inode(struct list_head *ilist)
 	struct inode_entry *ie, *next_ie;
 	list_for_each_entry_safe(ie, next_ie, ilist, list) {
 		iput(ie->inode);
-		list_del(&ie->list);
+		radix_tree_delete(&gc_inode_root, ie->inode->i_ino);
 		kmem_cache_free(winode_slab, ie);
 	}
 }
@@ -614,7 +621,7 @@ next_step:
 		}
 
 		/* phase 3 */
-		inode = find_gc_inode(dni.ino, ilist);
+		inode = find_gc_inode(dni.ino);
 		if (inode) {
 			start_bidx = start_bidx_of_node(nofs,
 							F2FS_I(inode));
-- 
1.9.1

