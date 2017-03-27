From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: clean up destroy_discard_cmd_control
Date: Mon, 27 Mar 2017 18:14:04 +0800
Message-ID: <20170327101406.56028-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1csRfZ-0007FY-HN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:37 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1csRfY-0004ZV-Im
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Remove unneeded parameter and simply change flow in
destroy_discard_cmd_control.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ff53423e35fb..c1a03b0857f9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1181,20 +1181,22 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi, bool free)
+static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
-	if (dcc && dcc->f2fs_issue_discard) {
+	if (!dcc)
+		return;
+
+	if (dcc->f2fs_issue_discard) {
 		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
 
 		dcc->f2fs_issue_discard = NULL;
 		kthread_stop(discard_thread);
 	}
-	if (free) {
-		kfree(dcc);
-		SM_I(sbi)->dcc_info = NULL;
-	}
+
+	kfree(dcc);
+	SM_I(sbi)->dcc_info = NULL;
 }
 
 static bool __mark_sit_entry_dirty(struct f2fs_sb_info *sbi, unsigned int segno)
@@ -3086,7 +3088,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	if (!sm_info)
 		return;
 	destroy_flush_cmd_control(sbi, true);
-	destroy_discard_cmd_control(sbi, true);
+	destroy_discard_cmd_control(sbi);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
