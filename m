From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH RFC] f2fs: allow write page cache when writting cp
Date: Tue, 7 Mar 2017 20:47:14 +0800
Message-ID: <20170307124714.20676-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1clESv-0000FN-8G
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 12:43:45 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clESs-0005yJ-DD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 12:43:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch allow write data to normal file when writting
new checkpoint.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c |  4 +++-
 fs/f2fs/data.c       | 23 ++++++++++++++++-------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0339daf..1d86171 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -979,9 +979,10 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 * POR: we should ensure that there are no dirty node pages
 	 * until finishing nat/sit flush.
 	 */
+
+	down_write(&sbi->node_change);
 retry_flush_nodes:
 	down_write(&sbi->node_write);
-
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
 		err = sync_node_pages(sbi, &wbc);
@@ -992,6 +993,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_nodes;
 	}
 out:
+	up_write(&sbi->node_change);
 	blk_finish_plug(&plug);
 	return err;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1375fef..c7eccb0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -827,7 +827,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 
 next_dnode:
-	if (create)
+	if (create && flag == F2FS_GET_BLOCK_PRE_AIO)
+		down_read(&sbi->node_change);
+	else if (create)
 		f2fs_lock_op(sbi);
 
 	/* When reading holes, we need its node page */
@@ -936,17 +938,23 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto next_block;
 
 	f2fs_put_dnode(&dn);
-
-	if (create) {
+	if (create && flag == F2FS_GET_BLOCK_PRE_AIO) {
+		up_read(&sbi->node_change);
+		f2fs_balance_fs(sbi, dn.node_changed);
+	} else if (create) {
 		f2fs_unlock_op(sbi);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
+
 	goto next_dnode;
 
 sync_out:
 	f2fs_put_dnode(&dn);
 unlock_out:
-	if (create) {
+	if (create && flag == F2FS_GET_BLOCK_PRE_AIO) {
+		up_read(&sbi->node_change);
+		f2fs_balance_fs(sbi, dn.node_changed);
+	} else if (create) {
 		f2fs_unlock_op(sbi);
 		f2fs_balance_fs(sbi, dn.node_changed);
 	}
@@ -1686,7 +1694,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		f2fs_lock_op(sbi);
+		down_read(&sbi->node_change);
 		locked = true;
 	}
 restart:
@@ -1703,6 +1711,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 		if (pos + len <= MAX_INLINE_DATA) {
 			read_inline_data(page, ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
+			dn.node_changed = true;
 			if (inode->i_nlink)
 				set_inline_node(ipage);
 		} else {
@@ -1722,7 +1731,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
 			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
-				f2fs_lock_op(sbi);
+				down_read(&sbi->node_change);
 				locked = true;
 				goto restart;
 			}
@@ -1736,7 +1745,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		f2fs_unlock_op(sbi);
+		up_read(&sbi->node_change);
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e29249..35164ab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -830,6 +830,7 @@ struct f2fs_sb_info {
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
 	struct rw_semaphore node_write;		/* locking node writes */
+	struct rw_semaphore node_change;	/* locking node change */
 	wait_queue_head_t cp_wait;
 	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
 	long interval_time[MAX_TIME];		/* to store thresholds */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2d494d5..d217114 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1929,6 +1929,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
+	init_rwsem(&sbi->node_change);
 
 	/* disallow all the data/node/meta page writes */
 	set_sbi_flag(sbi, SBI_POR_DOING);
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
