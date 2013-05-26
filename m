From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: return proper error from
	start_gc_thread
Date: Sun, 26 May 2013 11:05:32 +0900
Message-ID: <1369533932-6921-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UgQLE-0002x0-Qe
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 02:05:48 +0000
Received: from mail-pd0-f181.google.com ([209.85.192.181])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UgQLB-0004sk-9P
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 02:05:48 +0000
Received: by mail-pd0-f181.google.com with SMTP id bv13so3567895pdb.26
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 May 2013 19:05:39 -0700 (PDT)
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
Cc: Namjae Jeon <linkinjeon@gmail.com>, Amit Sahrawat <a.sahrawat@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

when there is an error from kthread_run, then return proper error
rather than returning -ENOMEM.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 fs/f2fs/gc.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 25b083c..ddc2c67 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -91,23 +91,28 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_gc_kthread *gc_th;
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	int err = 0;
 
 	if (!test_opt(sbi, BG_GC))
-		return 0;
+		goto out;
 	gc_th = kmalloc(sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
-	if (!gc_th)
-		return -ENOMEM;
+	if (!gc_th) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	sbi->gc_thread = gc_th;
 	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
 	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(gc_th->f2fs_gc_task)) {
+		err = PTR_ERR(gc_th->f2fs_gc_task);
 		kfree(gc_th);
 		sbi->gc_thread = NULL;
-		return -ENOMEM;
 	}
-	return 0;
+
+out:
+	return err;
 }
 
 void stop_gc_thread(struct f2fs_sb_info *sbi)
-- 
1.7.9.5


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
