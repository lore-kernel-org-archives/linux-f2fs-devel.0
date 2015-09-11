From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 7/7] f2fs: fix overflow of size calculation
Date: Fri, 11 Sep 2015 14:43:52 +0800
Message-ID: <000201d0ec5d$5079d620$f16d8260$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZaI4e-0001oG-T7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:44:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZaI4c-0006vi-PX
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 06:44:40 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUI034K72Q5J640@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 15:44:32 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We have potential overflow issue when calculating size of object, when
we left shift index with PAGE_CACHE_SHIFT bits, if type of index has only
32-bits space in 32-bit architecture, left shifting will incur overflow,
i.e:

pgoff_t index =  0xFFFFFFFF;
loff_t size = index << PAGE_CACHE_SHIFT;
size: 0xFFFFF000

So we should cast index with 64-bits type to avoid this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c     | 11 ++++++-----
 fs/f2fs/debug.c    | 12 ++++++------
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/file.c     | 18 ++++++++++--------
 fs/f2fs/recovery.c |  2 +-
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a0a5849..5b0513d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -447,9 +447,9 @@ repeat:
 		lock_page(page);
 	}
 got_it:
-	if (new_i_size &&
-		i_size_read(inode) < ((index + 1) << PAGE_CACHE_SHIFT)) {
-		i_size_write(inode, ((index + 1) << PAGE_CACHE_SHIFT));
+	if (new_i_size && i_size_read(inode) <
+				((loff_t)(index + 1) << PAGE_CACHE_SHIFT)) {
+		i_size_write(inode, ((loff_t)(index + 1) << PAGE_CACHE_SHIFT));
 		/* Only the directory inode sets new_i_size */
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_DIR);
 	}
@@ -489,8 +489,9 @@ alloc:
 	/* update i_size */
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
-	if (i_size_read(dn->inode) < ((fofs + 1) << PAGE_CACHE_SHIFT))
-		i_size_write(dn->inode, ((fofs + 1) << PAGE_CACHE_SHIFT));
+	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_CACHE_SHIFT))
+		i_size_write(dn->inode,
+				((loff_t)(fofs + 1) << PAGE_CACHE_SHIFT));
 
 	/* direct IO doesn't use extent cache to maximize the performance */
 	f2fs_drop_largest_extent(dn->inode, fofs);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d013d84..ebfcc40 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -198,9 +198,9 @@ get_cache:
 
 	si->page_mem = 0;
 	npages = NODE_MAPPING(sbi)->nrpages;
-	si->page_mem += npages << PAGE_CACHE_SHIFT;
+	si->page_mem += (unsigned long long)npages << PAGE_CACHE_SHIFT;
 	npages = META_MAPPING(sbi)->nrpages;
-	si->page_mem += npages << PAGE_CACHE_SHIFT;
+	si->page_mem += (unsigned long long)npages << PAGE_CACHE_SHIFT;
 }
 
 static int stat_show(struct seq_file *s, void *v)
@@ -333,13 +333,13 @@ static int stat_show(struct seq_file *s, void *v)
 
 		/* memory footprint */
 		update_mem_info(si->sbi);
-		seq_printf(s, "\nMemory: %u KB\n",
+		seq_printf(s, "\nMemory: %llu KB\n",
 			(si->base_mem + si->cache_mem + si->page_mem) >> 10);
-		seq_printf(s, "  - static: %u KB\n",
+		seq_printf(s, "  - static: %llu KB\n",
 				si->base_mem >> 10);
-		seq_printf(s, "  - cached: %u KB\n",
+		seq_printf(s, "  - cached: %llu KB\n",
 				si->cache_mem >> 10);
-		seq_printf(s, "  - paged : %u KB\n",
+		seq_printf(s, "  - paged : %llu KB\n",
 				si->page_mem >> 10);
 	}
 	mutex_unlock(&f2fs_stat_mutex);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1a90ff..79c38ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1844,7 +1844,7 @@ struct f2fs_stat_info {
 	unsigned int segment_count[2];
 	unsigned int block_count[2];
 	unsigned int inplace_count;
-	unsigned base_mem, cache_mem, page_mem;
+	unsigned long long base_mem, cache_mem, page_mem;
 };
 
 static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e03622..180b838 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -74,7 +74,8 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 		goto mapped;
 
 	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_CACHE_SHIFT) > i_size_read(inode)) {
+	if (((loff_t)(page->index + 1) << PAGE_CACHE_SHIFT) >
+						i_size_read(inode)) {
 		unsigned offset;
 		offset = i_size_read(inode) & ~PAGE_CACHE_MASK;
 		zero_user_segment(page, offset, PAGE_CACHE_SIZE);
@@ -343,7 +344,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	dirty = __get_first_dirty_index(inode->i_mapping, pgofs, whence);
 
-	for (; data_ofs < isize; data_ofs = pgofs << PAGE_CACHE_SHIFT) {
+	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_CACHE_SHIFT) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE_RA);
 		if (err && err != -ENOENT) {
@@ -812,8 +813,8 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 			f2fs_balance_fs(sbi);
 
-			blk_start = pg_start << PAGE_CACHE_SHIFT;
-			blk_end = pg_end << PAGE_CACHE_SHIFT;
+			blk_start = (loff_t)pg_start << PAGE_CACHE_SHIFT;
+			blk_end = (loff_t)pg_end << PAGE_CACHE_SHIFT;
 			truncate_inode_pages_range(mapping, blk_start,
 					blk_end - 1);
 
@@ -1004,7 +1005,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 				return ret;
 
 			new_size = max_t(loff_t, new_size,
-						pg_start << PAGE_CACHE_SHIFT);
+					(loff_t)pg_start << PAGE_CACHE_SHIFT);
 		}
 
 		for (index = pg_start; index < pg_end; index++) {
@@ -1040,7 +1041,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_unlock_op(sbi);
 
 			new_size = max_t(loff_t, new_size,
-					(index + 1) << PAGE_CACHE_SHIFT);
+				(loff_t)(index + 1) << PAGE_CACHE_SHIFT);
 		}
 
 		if (off_end) {
@@ -1202,9 +1203,10 @@ noalloc:
 		if (pg_start == pg_end)
 			new_size = offset + len;
 		else if (index == pg_start && off_start)
-			new_size = (index + 1) << PAGE_CACHE_SHIFT;
+			new_size = (loff_t)(index + 1) << PAGE_CACHE_SHIFT;
 		else if (index == pg_end)
-			new_size = (index << PAGE_CACHE_SHIFT) + off_end;
+			new_size = ((loff_t)index << PAGE_CACHE_SHIFT) +
+								off_end;
 		else
 			new_size += PAGE_CACHE_SIZE;
 	}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index faec2ca..acc21f2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -570,7 +570,7 @@ out:
 
 	/* truncate meta pages to be used by the recovery */
 	truncate_inode_pages_range(META_MAPPING(sbi),
-			MAIN_BLKADDR(sbi) << PAGE_CACHE_SHIFT, -1);
+			(loff_t)MAIN_BLKADDR(sbi) << PAGE_CACHE_SHIFT, -1);
 
 	if (err) {
 		truncate_inode_pages_final(NODE_MAPPING(sbi));
-- 
2.4.2



------------------------------------------------------------------------------
