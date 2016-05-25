From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/12] f2fs: detect congestion of flush command
	issues
Date: Tue, 24 May 2016 17:03:36 -0700
Message-ID: <1464134619-37015-10-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIw-0002Zg-NV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIv-0006is-Sb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:06 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
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

If flush commands do not incur any congestion, we don't need to throw that to
dispatching queue which causes unnecessary latency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 917cc9b..97cd3c8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -603,6 +603,7 @@ struct flush_cmd {
 struct flush_cmd_control {
 	struct task_struct *f2fs_issue_flush;	/* flush thread */
 	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
+	atomic_t submit_flush;			/* # of issued flushes */
 	struct llist_head issue_list;		/* list for command issue */
 	struct llist_node *dispatch_list;	/* list for command dispatch */
 };
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 77dc929..34a9159 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -433,24 +433,28 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
-	if (!test_opt(sbi, FLUSH_MERGE)) {
+	if (!test_opt(sbi, FLUSH_MERGE) || !atomic_read(&fcc->submit_flush)) {
 		struct bio *bio = f2fs_bio_alloc(0);
 		int ret;
 
+		atomic_inc(&fcc->submit_flush);
 		bio->bi_bdev = sbi->sb->s_bdev;
 		ret = submit_bio_wait(WRITE_FLUSH, bio);
+		atomic_dec(&fcc->submit_flush);
 		bio_put(bio);
 		return ret;
 	}
 
 	init_completion(&cmd.wait);
 
+	atomic_inc(&fcc->submit_flush);
 	llist_add(&cmd.llnode, &fcc->issue_list);
 
 	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
 
 	wait_for_completion(&cmd.wait);
+	atomic_dec(&fcc->submit_flush);
 
 	return cmd.ret;
 }
@@ -464,6 +468,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
 	if (!fcc)
 		return -ENOMEM;
+	atomic_set(&fcc->submit_flush, 0);
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->cmd_control_info = fcc;
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
