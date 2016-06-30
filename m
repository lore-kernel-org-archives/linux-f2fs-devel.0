From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to avoid data update racing between GC and DIO
Date: Thu, 30 Jun 2016 16:42:48 +0800
Message-ID: <20160630084248.57469-2-yuchao0@huawei.com>
References: <20160630084248.57469-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160630084248.57469-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Datas in file can be operated by GC and DIO simultaneously, so we will
face race case as below:

For write case:
Thread A				Thread B
- generic_file_direct_write
 - invalidate_inode_pages2_range
 - f2fs_direct_IO
  - do_blockdev_direct_IO
   - do_direct_IO
    - get_more_blocks
					- f2fs_gc
					 - do_garbage_collect
					  - gc_data_segment
					   - move_data_page
					    - do_write_data_page
					    migrate data block to new block address
   - dio_bio_submit
   update user data to old block address

For read case:
Thread A                                Thread B
- generic_file_direct_write
 - invalidate_inode_pages2_range
 - f2fs_direct_IO
  - do_blockdev_direct_IO
   - do_direct_IO
    - get_more_blocks
					- f2fs_balance_fs
					 - f2fs_gc
					  - do_garbage_collect
					   - gc_data_segment
					    - move_data_page
					     - do_write_data_page
					     migrate data block to new block address
					  - write_checkpoint
					   - do_checkpoint
					    - clear_prefree_segments
					     - f2fs_issue_discard
                                             discard old block adress
   - dio_bio_submit
   update user buffer from obsolete block address

In order to fix this, for one file, we should let DIO and GC getting exclusion
against with each other.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  |  2 ++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/gc.c    | 14 +++++++++++++-
 fs/f2fs/super.c |  1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba4963f..08dc060 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1716,7 +1716,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
+	mutex_lock(&F2FS_I(inode)->dio_mutex);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
+	mutex_unlock(&F2FS_I(inode)->dio_mutex);
 	if (iov_iter_rw(iter) == WRITE) {
 		if (err > 0)
 			set_inode_flag(inode, FI_UPDATE_WRITE);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd82b6d..a241576 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -474,6 +474,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
+	struct mutex dio_mutex;		/* avoid racing between dio and gc */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c2c4ac3..98e3763 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -744,12 +744,24 @@ next_step:
 		/* phase 3 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
+			bool locked = false;
+
+			if (S_ISREG(inode->i_mode)) {
+				if (!mutex_trylock(&F2FS_I(inode)->dio_mutex))
+					continue;
+				locked = true;
+			}
+
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
-			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+			if (f2fs_encrypted_inode(inode) &&
+							S_ISREG(inode->i_mode))
 				move_encrypted_block(inode, start_bidx);
 			else
 				move_data_page(inode, start_bidx, gc_type);
+			if (locked)
+				mutex_unlock(&F2FS_I(inode)->dio_mutex);
+
 			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8c698e1..24aab3f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -575,6 +575,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
+	mutex_init(&fi->dio_mutex);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
2.8.2.311.gee88674
