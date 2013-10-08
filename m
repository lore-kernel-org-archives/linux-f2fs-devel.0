From: Yuan Zhong <yuan.mark.zhong@samsung.com>
Subject: [PATCH v2] f2fs: avoid congestion_wait when
 do_checkpoint for better performance
Date: Tue, 08 Oct 2013 08:30:39 +0000 (GMT)
Message-ID: <25944790.263941381221039729.JavaMail.weblogic@epml12>
Reply-To: yuan.mark.zhong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuan.mark.zhong@samsung.com>) id 1VTSgq-0003MJ-Ne
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 08:30:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTSgo-0001Br-K1 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 08:30:48 +0000
Received: from epcpsbgx3.samsung.com
	(u163.gpu120.samsung.co.kr [203.254.230.163])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MUC00806CW90YK0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Oct 2013 17:30:40 +0900 (KST)
MIME-version: 1.0
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, shu.tan@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, do_checkpoint() will call congestion_wait() for waiting the pages (previous submitted node/meta/data pages) to be written back.
Because congestion_wait() will set a regular period (e.g. HZ / 50 ) for waiting.
For this reason, there is a situation that after the pages have been written back, but the checkpoint thread still wait for congestion_wait to exit.
This is a problem here, especially, when sync a large number of small files or dirs.
In order to avoid this, a wait_list is introduced, the checkpoint thread will be dropped into the wait_list if the pages have not been written back, and will be waked up by contrast.

Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
---  
 fs/f2fs/checkpoint.c |    3 +--
 fs/f2fs/f2fs.h       |   19 +++++++++++++++++++
 fs/f2fs/segment.c    |    1 +
 fs/f2fs/super.c      |    1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ca39442..5d69ae0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -758,8 +758,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	f2fs_put_page(cp_page, 1);
 
 	/* wait for previous submitted node/meta pages writeback */
-	while (get_pages(sbi, F2FS_WRITEBACK))
-		congestion_wait(BLK_RW_ASYNC, HZ / 50);
+	f2fs_writeback_wait(sbi);
 
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
 	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fd99d8..4b0d70e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -18,6 +18,8 @@
 #include <linux/crc32.h>
 #include <linux/magic.h>
 #include <linux/kobject.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
 
 /*
  * For mount options
@@ -368,6 +370,7 @@ struct f2fs_sb_info {
 	struct mutex fs_lock[NR_GLOBAL_LOCKS];	/* blocking FS operations */
 	struct mutex node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
+	wait_queue_head_t writeback_wqh;	/* wait_queue for writeback */
 	unsigned char next_lock_num;		/* round-robin global locks */
 	int por_doing;				/* recovery is doing or not */
 	int on_build_free_nids;			/* build_free_nids is doing */
@@ -961,6 +964,22 @@ static inline int f2fs_readonly(struct super_block *sb)
 	return sb->s_flags & MS_RDONLY;
 }
 
+static inline void f2fs_writeback_wait(struct f2fs_sb_info *sbi)
+{
+	DEFINE_WAIT(wait);
+
+	prepare_to_wait(&sbi->writeback_wqh, &wait, TASK_UNINTERRUPTIBLE);
+	if (get_pages(sbi, F2FS_WRITEBACK))
+		io_schedule();
+	finish_wait(&sbi->writeback_wqh, &wait);
+}
+
+static inline void f2fs_writeback_wake(struct f2fs_sb_info *sbi)
+{
+	if (!get_pages(sbi, F2FS_WRITEBACK))
+		wake_up_all(&sbi->writeback_wqh);
+}
+
 /*
  * file.c
  */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bd79bbe..0708aa9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -597,6 +597,7 @@ static void f2fs_end_io_write(struct bio *bio, int err)
 
 	if (p->is_sync)
 		complete(p->wait);
+	f2fs_writeback_wake(p->sbi);
 	kfree(p);
 	bio_put(bio);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 094ccc6..3ac6d85 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -835,6 +835,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
+	init_waitqueue_head(&sbi->writeback_wqh);
 	for (i = 0; i < NR_GLOBAL_LOCKS; i++)
 		mutex_init(&sbi->fs_lock[i]);
 	mutex_init(&sbi->node_write);
------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
