From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a panic caused by NULL
 flush_cmd_control
Date: Thu, 1 Jun 2017 16:43:51 +0800
Message-ID: <1496306631-23944-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dGLto-0001kH-E6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 08:56:08 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dGLth-0008Pj-Nb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 08:56:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Mount fs with option noflush_merge, boot failed for illegal address
fcc in function f2fs_issue_flush:

        if (!test_opt(sbi, FLUSH_MERGE)) {
                ret = submit_flush_wait(sbi);
                atomic_inc(&fcc->issued_flush);   ->  Here, fcc illegal
                return ret;
        }

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a8f4c81..029b5ea 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -566,6 +566,9 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->fcc_info = fcc;
+	if (!test_opt(sbi, FLUSH_MERGE))
+		return err;
+
 init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
@@ -3239,7 +3242,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
-	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
+	if (!f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			return err;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
