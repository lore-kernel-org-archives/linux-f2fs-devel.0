From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: avoid wait if IO end up when do_checkpoint for better
 performance
Date: Mon, 14 Oct 2013 18:45:56 +0800
Message-ID: <525BCB64.3060305@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "yuan.mark.zhong@samsung.com" <yuan.mark.zhong@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, do_checkpoint() will call congestion_wait() for waiting the pages
(previous submitted node/meta/data pages) to be written back.
Because congestion_wait() will set a regular period (e.g. HZ / 50 ) for waiting, and
no additional wake up mechanism was introduced if IO ends up before regular period costed.
Yuan Zhong found there is a situation that after the pages have been written back, 
but the checkpoint thread still wait for congestion_wait to exit.

So here we store checkpoint task into f2fs_sb when doing checkpoint, it'll wait for IO completes
if there's IO going on, and in the end IO path, wake up checkpoint task when IO ends up.

Thanks to Yuan Zhong's pre work about this problem.


Reported-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   11 +++++++++--
 fs/f2fs/f2fs.h       |    1 +
 fs/f2fs/segment.c    |    4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d808827..2a5999d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -757,8 +757,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	f2fs_put_page(cp_page, 1);
 
 	/* wait for previous submitted node/meta pages writeback */
-	while (get_pages(sbi, F2FS_WRITEBACK))
-		congestion_wait(BLK_RW_ASYNC, HZ / 50);
+	sbi->cp_task = current;
+	while (get_pages(sbi, F2FS_WRITEBACK)) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!get_pages(sbi, F2FS_WRITEBACK))
+			break;
+		io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+	sbi->cp_task = NULL;
 
 	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
 	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 308967b..171c52f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -362,6 +362,7 @@ struct f2fs_sb_info {
 	struct mutex writepages;		/* mutex for writepages() */
 	int por_doing;				/* recovery is doing or not */
 	int on_build_free_nids;			/* build_free_nids is doing */
+	struct task_struct *cp_task;		/* checkpoint task */
 
 	/* for orphan inode management */
 	struct list_head orphan_inode_list;	/* orphan inode list */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bd79bbe..3b20359 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -597,6 +597,10 @@ static void f2fs_end_io_write(struct bio *bio, int err)
 
 	if (p->is_sync)
 		complete(p->wait);
+
+	if (!get_pages(p->sbi, F2FS_WRITEBACK) && p->sbi->cp_task)
+		wake_up_process(p->sbi->cp_task);
+
 	kfree(p);
 	bio_put(bio);
 }
-- 
1.7.7
