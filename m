From: Chao Yu <chao@kernel.org>
Subject: [patch v2 2/2] f2fs: fix to avoid data update racing
	between GC and DIO
Date: Sun,  3 Jul 2016 22:00:32 +0800
Message-ID: <1467554432-4499-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bJhz2-0007f3-Jp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:02:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bJhyy-0000wd-TB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:02:52 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

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
 fs/f2fs/data.c  | 11 +++++++++++
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/gc.c    | 19 +++++++++++++++++++
 fs/f2fs/super.c |  2 ++
 4 files changed, 34 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba4963f..3a03285 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1701,8 +1701,10 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t offset = iocb->ki_pos;
+	bool is_write = (iov_iter_rw(iter) == WRITE);
 	int err;
 
 	err = check_direct_IO(inode, iter, offset);
@@ -1716,7 +1718,16 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
+	if (is_write)
+		mutex_lock(&fi->dio_mutex);
+	else
+		down_read(&fi->dio_rwsem);
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
+	if (is_write)
+		mutex_unlock(&fi->dio_mutex);
+	else
+		up_read(&fi->dio_rwsem);
+
 	if (iov_iter_rw(iter) == WRITE) {
 		if (err > 0)
 			set_inode_flag(inode, FI_UPDATE_WRITE);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd82b6d..ac3410a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -474,6 +474,8 @@ struct f2fs_inode_info {
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
+	struct mutex dio_mutex;		/* avoid racing between write dio and gc */
+	struct rw_semaphore dio_rwsem;	/* avoid racing between read dio and gc */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c2c4ac3..a15ae8a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -744,12 +744,31 @@ next_step:
 		/* phase 3 */
 		inode = find_gc_inode(gc_list, dni.ino);
 		if (inode) {
+			struct f2fs_inode_info *fi = F2FS_I(inode);
+			bool locked = false;
+
+			if (S_ISREG(inode->i_mode)) {
+				if (!mutex_trylock(&fi->dio_mutex))
+					continue;
+				if (!down_write_trylock(&fi->dio_rwsem)) {
+					mutex_unlock(&fi->dio_mutex);
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
+				mutex_unlock(&fi->dio_mutex);
+				up_write(&fi->dio_rwsem);
+			}
+
 			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8c698e1..512bbb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -575,6 +575,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
+	mutex_init(&fi->dio_mutex);
+	init_rwsem(&fi->dio_rwsem);
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-- 
2.7.2


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
