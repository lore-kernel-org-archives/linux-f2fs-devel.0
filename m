From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: allow write page cache when
 writting cp
Date: Wed, 15 Mar 2017 03:24:53 +0800
Message-ID: <20170314192453.GB8729@jaegeuk.local>
References: <20170313122218.26532-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cns4E-0006xO-IZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 19:25:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cns4D-0000rQ-Aq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Mar 2017 19:25:10 +0000
Content-Disposition: inline
In-Reply-To: <20170313122218.26532-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

When testing the original patch, I've got some panics from checkpoint.
I've fixed them, and revised your patch like below.
Please take a look at below.

>From a0e4f7bfdd5665643c5323c480b95a852d141a2b Mon Sep 17 00:00:00 2001
From: Yunlei He <heyunlei@huawei.com>
Date: Mon, 13 Mar 2017 20:22:18 +0800
Subject: [PATCH] f2fs: allow write page cache when writting cp

This patch allow write data to normal file when writting
new checkpoint.

We relax three limitations for write_begin path:
1. data allocation
2. node allocation
3. variables in checkpoint

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 31 +++++++++++++++++++++++--------
 fs/f2fs/data.c       | 28 ++++++++++++++++++++++------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/node.c       | 12 ++++++------
 fs/f2fs/super.c      |  1 +
 5 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 22348c7df67d..bd755468915b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -942,6 +942,19 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static void __prepare_cp_block(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	nid_t last_nid = nm_i->next_scan_nid;
+
+	next_free_nid(sbi, &last_nid);
+	ckpt->valid_block_count = cpu_to_le64(valid_user_blocks(sbi));
+	ckpt->valid_node_count = cpu_to_le32(valid_node_count(sbi));
+	ckpt->valid_inode_count = cpu_to_le32(valid_inode_count(sbi));
+	ckpt->next_free_nid = cpu_to_le32(last_nid);
+}
+
 /*
  * Freeze all the FS-operations for checkpoint.
  */
@@ -980,6 +993,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 * POR: we should ensure that there are no dirty node pages
 	 * until finishing nat/sit flush.
 	 */
+	down_write(&sbi->node_change);
+
 retry_flush_nodes:
 	down_write(&sbi->node_write);
 
@@ -987,11 +1002,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		up_write(&sbi->node_write);
 		err = sync_node_pages(sbi, &wbc);
 		if (err) {
+			up_write(&sbi->node_change);
 			f2fs_unlock_all(sbi);
 			goto out;
 		}
 		goto retry_flush_nodes;
 	}
+
+	/*
+	 * sbi->node_change is used only for AIO write_begin path which produces
+	 * dirty node blocks and some checkpoint values by block allocation.
+	 */
+	__prepare_cp_block(sbi);
+	up_write(&sbi->node_change);
 out:
 	blk_finish_plug(&plug);
 	return err;
@@ -1059,7 +1082,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
-	nid_t last_nid = nm_i->next_scan_nid;
 	block_t start_blk;
 	unsigned int data_sum_blocks, orphan_blocks;
 	__u32 crc32 = 0;
@@ -1076,14 +1098,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			return -EIO;
 	}
 
-	next_free_nid(sbi, &last_nid);
-
 	/*
 	 * modify checkpoint
 	 * version number is already updated
 	 */
 	ckpt->elapsed_time = cpu_to_le64(get_mtime(sbi));
-	ckpt->valid_block_count = cpu_to_le64(valid_user_blocks(sbi));
 	ckpt->free_segment_count = cpu_to_le32(free_segments(sbi));
 	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
 		ckpt->cur_node_segno[i] =
@@ -1102,10 +1121,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 				curseg_alloc_type(sbi, i + CURSEG_HOT_DATA);
 	}
 
-	ckpt->valid_node_count = cpu_to_le32(valid_node_count(sbi));
-	ckpt->valid_inode_count = cpu_to_le32(valid_inode_count(sbi));
-	ckpt->next_free_nid = cpu_to_le32(last_nid);
-
 	/* 2 cp  + n data seg summary + orphan inode blocks */
 	data_sum_blocks = npages_for_summary_flush(sbi, false);
 	spin_lock(&sbi->cp_lock);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2ab5ca06c334..e07c60fb1033 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -786,6 +786,21 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	return err;
 }
 
+static inline void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
+{
+	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
+		if (lock)
+			down_read(&sbi->node_change);
+		else
+			up_read(&sbi->node_change);
+	} else {
+		if (lock)
+			f2fs_lock_op(sbi);
+		else
+			f2fs_unlock_op(sbi);
+	}
+}
+
 /*
  * f2fs_map_blocks() now supported readahead/bmap/rw direct_IO with
  * f2fs_map_blocks structure.
@@ -828,7 +843,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 next_dnode:
 	if (create)
-		f2fs_lock_op(sbi);
+		__do_map_lock(sbi, flag, true);
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -938,7 +953,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	f2fs_put_dnode(&dn);
 
 	if (create) {
-		f2fs_unlock_op(sbi);
+		__do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 	goto next_dnode;
@@ -947,7 +962,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (create) {
-		f2fs_unlock_op(sbi);
+		__do_map_lock(sbi, flag, false);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
@@ -1687,7 +1702,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		f2fs_lock_op(sbi);
+		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 		locked = true;
 	}
 restart:
@@ -1723,7 +1738,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
 			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
-				f2fs_lock_op(sbi);
+				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
+								true);
 				locked = true;
 				goto restart;
 			}
@@ -1737,7 +1753,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		f2fs_unlock_op(sbi);
+		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2ad3ab98c8f..84161b2160b9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -829,6 +829,7 @@ struct f2fs_sb_info {
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
+	struct rw_semaphore node_change;	/* locking node change */
 	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3bfffd744f87..cc7ef45b3f8d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2420,10 +2420,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		f2fs_put_page(page, 1);
 	}
 
-	f2fs_bug_on(sbi, set->entry_cnt);
-
-	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
-	kmem_cache_free(nat_entry_set_slab, set);
+	/* Allow dirty nats by node block allocation in write_begin */
+	if (!set->entry_cnt) {
+		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
+		kmem_cache_free(nat_entry_set_slab, set);
+	}
 }
 
 /*
@@ -2468,8 +2469,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		__flush_nat_entry_set(sbi, set, cpc);
 
 	up_write(&nm_i->nat_tree_lock);
-
-	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
+	/* Allow dirty nats by node block allocation in write_begin */
 }
 
 static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 778b6c449d47..f86a2021c2d1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1920,6 +1920,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
+	init_rwsem(&sbi->node_change);
 
 	/* disallow all the data/node/meta page writes */
 	set_sbi_flag(sbi, SBI_POR_DOING);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
