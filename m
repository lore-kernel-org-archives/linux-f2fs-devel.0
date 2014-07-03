From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: reduce competition among node page writes
Date: Thu, 03 Jul 2014 18:58:39 +0800
Message-ID: <003901cf96ad$dbd17680$93746380$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We do not need to block on ->node_write among different node page writers e.g.
fsync/flush, unless we have a node page writer from write_checkpoint.
So it's better use rw_semaphore instead of mutex type for ->node_write to
promote performance.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |    6 +++---
 fs/f2fs/f2fs.h       |    2 +-
 fs/f2fs/node.c       |    4 ++--
 fs/f2fs/super.c      |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0b4710c..eec406b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -714,10 +714,10 @@ retry_flush_dents:
 	 * until finishing nat/sit flush.
 	 */
 retry_flush_nodes:
-	mutex_lock(&sbi->node_write);
+	down_write(&sbi->node_write);
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
-		mutex_unlock(&sbi->node_write);
+		up_write(&sbi->node_write);
 		sync_node_pages(sbi, 0, &wbc);
 		goto retry_flush_nodes;
 	}
@@ -726,7 +726,7 @@ retry_flush_nodes:
 
 static void unblock_operations(struct f2fs_sb_info *sbi)
 {
-	mutex_unlock(&sbi->node_write);
+	up_write(&sbi->node_write);
 	f2fs_unlock_all(sbi);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae3b4ac..ca30b5a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -444,7 +444,7 @@ struct f2fs_sb_info {
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
-	struct mutex node_write;		/* locking node writes */
+	struct rw_semaphore node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
 	bool por_doing;				/* recovery is doing or not */
 	wait_queue_head_t cp_wait;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a90f51d..7b5b5de 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1231,12 +1231,12 @@ static int f2fs_write_node_page(struct page *page,
 	if (wbc->for_reclaim)
 		goto redirty_out;
 
-	mutex_lock(&sbi->node_write);
+	down_read(&sbi->node_write);
 	set_page_writeback(page);
 	write_node_page(sbi, page, &fio, nid, ni.blk_addr, &new_addr);
 	set_node_addr(sbi, &ni, new_addr, is_fsync_dnode(page));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
-	mutex_unlock(&sbi->node_write);
+	up_read(&sbi->node_write);
 	unlock_page(page);
 	return 0;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8f96d93..bed9413 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -947,7 +947,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
-	mutex_init(&sbi->node_write);
+	init_rwsem(&sbi->node_write);
 	sbi->por_doing = false;
 	spin_lock_init(&sbi->stat_lock);
 
-- 
1.7.9.5
