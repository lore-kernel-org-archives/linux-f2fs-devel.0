From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: cleanup waiting routine for writeback
 completion during cp
Date: Mon, 04 Nov 2013 15:32:44 +0900
Message-ID: <1383546764-29370-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1VdDk9-0000jn-50
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 06:34:33 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdDk7-0000hO-4E for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 06:34:33 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVQ0073E7KJ7WQ0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 15:34:24 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

use general method supported by kernel

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |   25 ++++++++++++++++---------
 fs/f2fs/f2fs.h       |    2 +-
 fs/f2fs/segment.c    |    4 ++--
 fs/f2fs/super.c      |    1 +
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5649a9d..f39c92e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -632,6 +632,21 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 	f2fs_unlock_all(sbi);
 }
 
+static void wait_for_writeback_pages(struct f2fs_sb_info *sbi)
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
@@ -741,15 +756,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
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
+	wait_for_writeback_pages(sbi);
 
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
 	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 590a09e..e0e4515 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -363,7 +363,7 @@ struct f2fs_sb_info {
 	struct mutex writepages;		/* mutex for writepages() */
 	bool por_doing;				/* recovery is doing or not */
 	bool on_build_free_nids;		/* build_free_nids is doing */
-	struct task_struct *cp_task;		/* checkpoint task */
+	wait_queue_head_t cp_wait;
 
 	/* for orphan inode management */
 	struct list_head orphan_inode_list;	/* orphan inode list */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9af59fb..b690b9b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -597,8 +597,8 @@ static void f2fs_end_io_write(struct bio *bio, int err)
 	if (p->is_sync)
 		complete(p->wait);
 
-	if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
-		wake_up_process(p->sbi->cp_task);
+	if (!get_pages(p->sbi, F2FS_WRITEBACK))
+		wake_up(&p->sbi->cp_wait);
 
 	kfree(p);
 	bio_put(bio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a09459..5cea7f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -854,6 +854,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->stat_lock);
 	init_rwsem(&sbi->bio_sem);
 	init_rwsem(&sbi->cp_rwsem);
+	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
 	/* get an inode for meta space */
-- 
1.7.9.5


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
