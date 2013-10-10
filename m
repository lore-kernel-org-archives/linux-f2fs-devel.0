From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: fix the starvation problem on cp_rwsem
Date: Thu, 10 Oct 2013 14:50:25 +0900
Message-ID: <1381384225-32126-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VU99L-00074s-AE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 05:51:03 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VU99J-0001gL-3D for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 05:51:03 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MUF00684UWUY3A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 14:50:54 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch removes the logic previously introduced to address the starvation
on cp_rwsem.

One potential there-in bug is that we should cover the wait.list with spin_lock,
but the previous code broke this rule.

And, actually current rwsem handles this starvation issue reasonably, so that we
didn't need to do this before neither.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  | 13 -------------
 fs/f2fs/super.c |  1 -
 2 files changed, 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a955a59..308967b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -18,8 +18,6 @@
 #include <linux/crc32.h>
 #include <linux/magic.h>
 #include <linux/kobject.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
 
 /*
  * For mount options
@@ -360,7 +358,6 @@ struct f2fs_sb_info {
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
-	wait_queue_head_t cp_wait;		/* checkpoint wait queue */
 	struct mutex node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
 	int por_doing;				/* recovery is doing or not */
@@ -516,13 +513,6 @@ static inline void clear_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
-	/*
-	 * If the checkpoint thread is waiting for cp_rwsem, add cuurent task
-	 * into wait list to avoid the checkpoint thread starvation
-	 */
-	while (!list_empty(&sbi->cp_rwsem.wait_list))
-		wait_event_interruptible(sbi->cp_wait,
-				list_empty(&sbi->cp_rwsem.wait_list));
 	down_read(&sbi->cp_rwsem);
 }
 
@@ -539,9 +529,6 @@ static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
 {
 	up_write(&sbi->cp_rwsem);
-
-	/* wake up all tasks blocked by checkpoint */
-	wake_up_all(&sbi->cp_wait);
 }
 
 /*
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 539c009..3b786c8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -841,7 +841,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->stat_lock);
 	init_rwsem(&sbi->bio_sem);
 	init_rwsem(&sbi->cp_rwsem);
-	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
 	/* get an inode for meta space */
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
