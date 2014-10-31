From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: avoid race condition in handling
	wait_io
Date: Thu, 30 Oct 2014 23:16:14 -0700
Message-ID: <1414736176-13201-2-git-send-email-jaegeuk@kernel.org>
References: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xk5VV-0003pa-Fh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:21 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xk5VU-0007dP-Bg for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:16:21 +0000
In-Reply-To: <1414736176-13201-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

__submit_merged_bio    f2fs_write_end_io        f2fs_write_end_io
                       wait_io = X              wait_io = x
                       complete(X)              complete(X)
                       wait_io = NULL
wait_for_completion()
free(X)
                                                 spin_lock(X)
                                                 kernel panic

In order to avoid this, this patch removes the wait_io facility.
Instead, we can use wait_on_all_pages_writeback(sbi) to wait for end_ios.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  3 +++
 fs/f2fs/data.c       | 35 +++++++----------------------------
 fs/f2fs/f2fs.h       |  1 -
 3 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ca514d5..dd6a357 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -978,6 +978,9 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* Here, we only have one bio having CP pack */
 	sync_meta_pages(sbi, META_FLUSH, LONG_MAX);
 
+	/* wait for previous submitted meta pages writeback */
+	wait_on_all_pages_writeback(sbi);
+
 	release_dirty_inode(sbi);
 
 	if (unlikely(f2fs_cp_error(sbi)))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ceee1a6..8f16443 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -61,11 +61,6 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 		dec_page_count(sbi, F2FS_WRITEBACK);
 	}
 
-	if (sbi->wait_io) {
-		complete(sbi->wait_io);
-		sbi->wait_io = NULL;
-	}
-
 	if (!get_pages(sbi, F2FS_WRITEBACK) &&
 			!list_empty(&sbi->cp_wait.task_list))
 		wake_up(&sbi->cp_wait);
@@ -95,34 +90,18 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 static void __submit_merged_bio(struct f2fs_bio_info *io)
 {
 	struct f2fs_io_info *fio = &io->fio;
-	int rw;
 
 	if (!io->bio)
 		return;
 
-	rw = fio->rw;
-
-	if (is_read_io(rw)) {
-		trace_f2fs_submit_read_bio(io->sbi->sb, rw,
-						fio->type, io->bio);
-		submit_bio(rw, io->bio);
-	} else {
-		trace_f2fs_submit_write_bio(io->sbi->sb, rw,
-						fio->type, io->bio);
-		/*
-		 * META_FLUSH is only from the checkpoint procedure, and we
-		 * should wait this metadata bio for FS consistency.
-		 */
-		if (fio->type == META_FLUSH) {
-			DECLARE_COMPLETION_ONSTACK(wait);
-			io->sbi->wait_io = &wait;
-			submit_bio(rw, io->bio);
-			wait_for_completion(&wait);
-		} else {
-			submit_bio(rw, io->bio);
-		}
-	}
+	if (is_read_io(fio->rw))
+		trace_f2fs_submit_read_bio(io->sbi->sb, fio->rw,
+							fio->type, io->bio);
+	else
+		trace_f2fs_submit_write_bio(io->sbi->sb, fio->rw,
+							fio->type, io->bio);
 
+	submit_bio(fio->rw, io->bio);
 	io->bio = NULL;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index afe3022..5a97058 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -516,7 +516,6 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	struct f2fs_bio_info read_io;			/* for read bios */
 	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
-	struct completion *wait_io;		/* for completion bios */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
-- 
2.1.1


------------------------------------------------------------------------------
