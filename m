From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: stop discard thread in prior during umount
Date: Fri, 23 Jun 2017 16:11:13 +0800
Message-ID: <20170623081113.22980-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dOJgp-0007lK-3r
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jun 2017 08:11:39 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dOJgn-0006YP-2A
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jun 2017 08:11:39 +0000
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

This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on

 f2fs: add f2fs_bug_on in __remove_discard_cmd

For fixing, we will stop discard thread in prior in put_super, in order to
avoid racing in between referrer and releaser.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9a44aca8d2c5..8e4b70b4174d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1063,9 +1063,22 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+static void stop_discard_thread(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	if (dcc->f2fs_issue_discard) {
+		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
+
+		dcc->f2fs_issue_discard = NULL;
+		kthread_stop(discard_thread);
+	}
+}
+
 /* This comes from f2fs_put_super */
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
+	stop_discard_thread(sbi);
 	__issue_discard_cmd(sbi, false);
 	__wait_discard_cmd(sbi, false);
 }
@@ -1420,12 +1433,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return;
 
-	if (dcc->f2fs_issue_discard) {
-		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
-
-		dcc->f2fs_issue_discard = NULL;
-		kthread_stop(discard_thread);
-	}
+	stop_discard_thread(sbi);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
