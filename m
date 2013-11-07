From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH v2] f2fs: cleanup waiting routine for writeback pages in cp
Date: Thu, 07 Nov 2013 12:48:25 +0900
Message-ID: <1383796105-26948-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

use genernal method supported by kernel

 o changes from v1
   If any waiter exists at end io, wake up it.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |   25 ++++++++++++++++---------
 fs/f2fs/f2fs.h       |    2 +-
 fs/f2fs/segment.c    |    5 +++--
 fs/f2fs/super.c      |    1 +
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d430157..5716e5e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -634,6 +634,21 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 	f2fs_unlock_all(sbi);
 }
 
+static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
+{
+	DEFINE_WAIT(wait);
+
+	for (;;) {
+		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
+
+		if (!get_pages(sbi, F2FS_WRITEBACK))
+			break;
+
+		io_schedule();
+	}
+	finish_wait(&sbi->cp_wait, &wait);
+}
+
 static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -743,15 +758,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	f2fs_put_page(cp_page, 1);
 
 	/* wait for previous submitted node/meta pages writeback */
-	sbi->cp_task = current;
-	while (get_pages(sbi, F2FS_WRITEBACK)) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!get_pages(sbi, F2FS_WRITEBACK))
-			break;
-		io_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-	sbi->cp_task = NULL;
+	wait_on_all_pages_writeback(sbi);
 
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
 	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 625eb4b..89dc750 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -372,7 +372,7 @@ struct f2fs_sb_info {
 	struct mutex writepages;		/* mutex for writepages() */
 	bool por_doing;				/* recovery is doing or not */
 	bool on_build_free_nids;		/* build_free_nids is doing */
-	struct task_struct *cp_task;		/* checkpoint task */
+	wait_queue_head_t cp_wait;
 
 	/* for orphan inode management */
 	struct list_head orphan_inode_list;	/* orphan inode list */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3d4d5fc..74e81cb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -592,8 +592,9 @@ static void f2fs_end_io_write(struct bio *bio, int err)
 	if (p->is_sync)
 		complete(p->wait);
 
-	if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
-		wake_up_process(p->sbi->cp_task);
+	if (!get_pages(p->sbi, F2FS_WRITEBACK) &&
+			!list_empty(&p->sbi->cp_wait.task_list))
+		wake_up(&p->sbi->cp_wait);
 
 	kfree(p);
 	bio_put(bio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e42351c..00e79df 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -876,6 +876,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->stat_lock);
 	init_rwsem(&sbi->bio_sem);
 	init_rwsem(&sbi->cp_rwsem);
+	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
 	/* get an inode for meta space */
-- 
1.7.10.4

