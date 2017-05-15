From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: combine huge num of discard rb tree
	consistence checks
Date: Mon, 15 May 2017 18:01:17 +0800
Message-ID: <1494842477-14116-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1dACzc-0005K8-5E
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 10:12:44 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dACza-0001ab-2d
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 10:12:44 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Came across a hungtask caused by huge number of rb tree traversing
during adding discard addrs in cp. This patch combine these consistence
checks and move it to discard thread.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index de31030..878ac90 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -918,8 +918,6 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			prev_dc->di.len += di.len;
 			dcc->undiscard_blks += di.len;
 			__relocate_discard_cmd(dcc, prev_dc);
-			f2fs_bug_on(sbi,
-				!__check_rb_tree_consistence(sbi, &dcc->root));
 			di = prev_dc->di;
 			tdc = prev_dc;
 			merged = true;
@@ -935,16 +933,12 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			__relocate_discard_cmd(dcc, next_dc);
 			if (tdc)
 				__remove_discard_cmd(sbi, tdc);
-			f2fs_bug_on(sbi,
-				!__check_rb_tree_consistence(sbi, &dcc->root));
 			merged = true;
 		}
 
 		if (!merged) {
 			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
 							di.len, NULL, NULL);
-			f2fs_bug_on(sbi,
-				!__check_rb_tree_consistence(sbi, &dcc->root));
 		}
  next:
 		prev_dc = next_dc;
@@ -983,6 +977,8 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	int i, iter = 0;
 
 	mutex_lock(&dcc->cmd_lock);
+	f2fs_bug_on(sbi,
+		!__check_rb_tree_consistence(sbi, &dcc->root));
 	blk_start_plug(&plug);
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		pend_list = &dcc->pend_list[i];
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
