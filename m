From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4] f2fs: fix to avoid data update racing between GC and DIO
Date: Wed, 13 Jul 2016 09:18:29 +0800
Message-ID: <20160713011829.83711-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
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
v4: split rwsem to avoid deadlock between dio reader and dio writer.
 fs/f2fs/data.c  |  6 +++++-
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/gc.c    | 20 ++++++++++++++++++++
 fs/f2fs/super.c |  2 ++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 20b3016..62947c30 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1714,6 +1714,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = mapping->host;
 	size_t count = iov_iter_count(iter);
 	loff_t offset = iocb->ki_pos;
+	int rw = iov_iter_rw(iter);
 	int err;
 
 	err = check_direct_IO(inode, iter, offset);
@@ -1727,8 +1728,11 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
+	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
-	if (iov_iter_rw(iter) == WRITE) {
+	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
+
+	if (rw == WRITE) {
 		if (err > 0)
 			set_inode_flag(inode, FI_UPDATE_WRITE);
 		else if (err < 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1190c04..5973759 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -474,6 +474,7 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
+	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c612137..5c8acf7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -755,12 +755,32 @@ next_step:
 		/* phase 3 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
+			struct f2fs_inode_info *fi = F2FS_I(inode);
+			bool locked = false;
+
+			if (S_ISREG(inode->i_mode)) {
+				if (!down_write_trylock(&fi->dio_rwsem[READ]))
+					continue;
+				if (!down_write_trylock(
+						&fi->dio_rwsem[WRITE])) {
+					up_write(&fi->dio_rwsem[READ]);
+					continue;
+				}
+				locked = true;
+			}
+
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 				move_encrypted_block(inode, start_bidx);
 			else
 				move_data_page(inode, start_bidx, gc_type);
+
+			if (locked) {
+				up_write(&fi->dio_rwsem[WRITE]);
+				up_write(&fi->dio_rwsem[READ]);
+			}
+
 			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 451dfb4..b97c065 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -579,6 +579,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
+	init_rwsem(&fi->dio_rwsem[READ]);
+	init_rwsem(&fi->dio_rwsem[WRITE]);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
2.8.2.311.gee88674
