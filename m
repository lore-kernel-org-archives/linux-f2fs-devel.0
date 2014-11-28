From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: more fast lookup for gc_inode list
Date: Fri, 28 Nov 2014 16:12:50 +0900
Message-ID: <20141128071250.GC2819@lcm>
References: <1417079511-29479-1-git-send-email-cm224.lee@samsung.com>
 <20141128042421.GA59574@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20141128060057.GA2819@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20141128060057.GA2819@lcm>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

I've modified as you mentioned. Review again, please.

Changes from V1
 o introduce gc_inode_list containing ilist and iradix
 o use local variable
 o call radix_tree_delete before iput
 o retry to add inode into radix_tree
 o call list_del explicitly

Thanks,
Changman

-- >8 --
>From eb1a8f4ddee6c5541d5979e4119ca33245d74c30 Mon Sep 17 00:00:00 2001
From: Changman Lee <cm224.lee@samsung.com>
Date: Fri, 28 Nov 2014 15:49:40 +0000
Subject: [PATCH] f2fs: more fast lookup for gc_inode list

If there are many inodes that have data blocks in victim segment,
it takes long time to find a inode in gc_inode list.
Let's use radix_tree to reduce lookup time.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/gc.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 29fc7e5..e10ed7f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -26,6 +26,11 @@
 
 static struct kmem_cache *winode_slab;
 
+struct gc_inode_list {
+	struct list_head ilist;
+	struct radix_tree_root iradix;
+};
+
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
@@ -338,34 +343,41 @@ static const struct victim_selection default_v_ops = {
 	.get_victim = get_victim_by_default,
 };
 
-static struct inode *find_gc_inode(nid_t ino, struct list_head *ilist)
+static struct inode *find_gc_inode(struct gc_inode_list *gc_list, nid_t ino)
 {
 	struct inode_entry *ie;
 
-	list_for_each_entry(ie, ilist, list)
-		if (ie->inode->i_ino == ino)
-			return ie->inode;
+	ie = radix_tree_lookup(&gc_list->iradix, ino);
+	if (ie)
+		return ie->inode;
 	return NULL;
 }
 
-static void add_gc_inode(struct inode *inode, struct list_head *ilist)
+static void add_gc_inode(struct gc_inode_list *gc_list, struct inode *inode)
 {
 	struct inode_entry *new_ie;
+	int ret;
+retry:
+	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
+	new_ie->inode = inode;
 
-	if (inode == find_gc_inode(inode->i_ino, ilist)) {
+	ret = radix_tree_insert(&gc_list->iradix, inode->i_ino, new_ie);
+	if (ret == -EEXIST) {
+		kmem_cache_free(winode_slab, new_ie);
 		iput(inode);
 		return;
+	} else if (ret) {
+		kmem_cache_free(winode_slab, new_ie);
+		goto retry;
 	}
-
-	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
-	new_ie->inode = inode;
-	list_add_tail(&new_ie->list, ilist);
+	list_add_tail(&new_ie->list, &gc_list->ilist);
 }
 
-static void put_gc_inode(struct list_head *ilist)
+static void put_gc_inode(struct gc_inode_list *gc_list)
 {
 	struct inode_entry *ie, *next_ie;
-	list_for_each_entry_safe(ie, next_ie, ilist, list) {
+	list_for_each_entry_safe(ie, next_ie, &gc_list->ilist, list) {
+		radix_tree_delete(&gc_list->iradix, ie->inode->i_ino);
 		iput(ie->inode);
 		list_del(&ie->list);
 		kmem_cache_free(winode_slab, ie);
@@ -551,7 +563,7 @@ out:
  * the victim data block is ignored.
  */
 static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
-		struct list_head *ilist, unsigned int segno, int gc_type)
+		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
 {
 	struct super_block *sb = sbi->sb;
 	struct f2fs_summary *entry;
@@ -609,12 +621,12 @@ next_step:
 			}
 
 			f2fs_put_page(data_page, 0);
-			add_gc_inode(inode, ilist);
+			add_gc_inode(gc_list, inode);
 			continue;
 		}
 
 		/* phase 3 */
-		inode = find_gc_inode(dni.ino, ilist);
+		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
 			start_bidx = start_bidx_of_node(nofs,
 							F2FS_I(inode));
@@ -658,7 +670,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 }
 
 static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
-				struct list_head *ilist, int gc_type)
+				struct gc_inode_list *gc_list, int gc_type)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
@@ -676,7 +688,7 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 		gc_node_segment(sbi, sum->entries, segno, gc_type);
 		break;
 	case SUM_TYPE_DATA:
-		gc_data_segment(sbi, sum->entries, ilist, segno, gc_type);
+		gc_data_segment(sbi, sum->entries, gc_list, segno, gc_type);
 		break;
 	}
 	blk_finish_plug(&plug);
@@ -689,16 +701,18 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 
 int f2fs_gc(struct f2fs_sb_info *sbi)
 {
-	struct list_head ilist;
 	unsigned int segno, i;
 	int gc_type = BG_GC;
 	int nfree = 0;
 	int ret = -1;
 	struct cp_control cpc;
+	struct gc_inode_list gc_list = {
+		.ilist = LIST_HEAD_INIT(gc_list.ilist),
+		.iradix = RADIX_TREE_INIT(GFP_ATOMIC),
+	};
 
 	cpc.reason = test_opt(sbi, FASTBOOT) ? CP_UMOUNT : CP_SYNC;
 
-	INIT_LIST_HEAD(&ilist);
 gc_more:
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
@@ -720,7 +734,7 @@ gc_more:
 								META_SSA);
 
 	for (i = 0; i < sbi->segs_per_sec; i++)
-		do_garbage_collect(sbi, segno + i, &ilist, gc_type);
+		do_garbage_collect(sbi, segno + i, &gc_list, gc_type);
 
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
@@ -736,7 +750,7 @@ gc_more:
 stop:
 	mutex_unlock(&sbi->gc_mutex);
 
-	put_gc_inode(&ilist);
+	put_gc_inode(&gc_list);
 	return ret;
 }
 
-- 
1.9.1

