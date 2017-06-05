From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: introduce __wait_one_discard_bio
Date: Mon, 5 Jun 2017 18:29:06 +0800
Message-ID: <20170605102909.57625-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dHpGk-0002Rk-Bq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:29:54 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dHpGh-00012g-VG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:29:54 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In order to avoid copied codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e073f65eef4..4ec40563e86d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -995,6 +995,20 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	mutex_unlock(&dcc->cmd_lock);
 }
 
+static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
+							struct discard_cmd *dc)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	wait_for_completion_io(&dc->wait);
+	mutex_lock(&dcc->cmd_lock);
+	f2fs_bug_on(sbi, dc->state != D_DONE);
+	dc->ref--;
+	if (!dc->ref)
+		__remove_discard_cmd(sbi, dc);
+	mutex_unlock(&dcc->cmd_lock);
+}
+
 static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
@@ -1019,13 +1033,7 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 	mutex_unlock(&dcc->cmd_lock);
 
 	if (need_wait) {
-		wait_for_completion_io(&dc->wait);
-		mutex_lock(&dcc->cmd_lock);
-		f2fs_bug_on(sbi, dc->state != D_DONE);
-		dc->ref--;
-		if (!dc->ref)
-			__remove_discard_cmd(sbi, dc);
-		mutex_unlock(&dcc->cmd_lock);
+		__wait_one_discard_bio(sbi, dc);
 		goto next;
 	}
 }
@@ -1049,15 +1057,8 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (need_wait) {
-		wait_for_completion_io(&dc->wait);
-		mutex_lock(&dcc->cmd_lock);
-		f2fs_bug_on(sbi, dc->state != D_DONE);
-		dc->ref--;
-		if (!dc->ref)
-			__remove_discard_cmd(sbi, dc);
-		mutex_unlock(&dcc->cmd_lock);
-	}
+	if (need_wait)
+		__wait_one_discard_bio(sbi, dc);
 }
 
 /* This comes from f2fs_put_super */
-- 
2.13.0.67.g10c78a162fa8


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
