From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/6] f2fs: reduce cmd_lock coverage in
 __issue_discard_cmd
Date: Tue, 19 Sep 2017 23:30:14 +0800
Message-ID: <20170919153016.4116-4-chao@kernel.org>
References: <20170919153016.4116-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1duKU6-0006Vd-P2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Sep 2017 15:30:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1duKU5-00069g-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Sep 2017 15:30:50 +0000
In-Reply-To: <20170919153016.4116-1-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

__submit_discard_cmd may lead long latency due to exhaustion of I/O
request resource in block layer, so issuing all discard under cmd_lock
may lead to hangtask, in order to avoid that, let's reduce it's coverage.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c3eb355b0171..412ac3a68be3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1130,14 +1130,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, iter = 0, issued = 0;
 	bool io_interrupted = false;
 
-	mutex_lock(&dcc->cmd_lock);
-	f2fs_bug_on(sbi,
-		!__check_rb_tree_consistence(sbi, &dcc->root));
-	blk_start_plug(&plug);
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
 			break;
 		pend_list = &dcc->pend_list[i];
+
+		mutex_lock(&dcc->cmd_lock);
+		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
+		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
@@ -1151,12 +1151,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			issued++;
 skip:
 			if (++iter >= dpolicy->max_requests)
-				goto out;
+				break;
 		}
+		blk_finish_plug(&plug);
+		mutex_unlock(&dcc->cmd_lock);
+
+		if (iter >= dpolicy->max_requests)
+			break;
 	}
-out:
-	blk_finish_plug(&plug);
-	mutex_unlock(&dcc->cmd_lock);
 
 	if (!issued && io_interrupted)
 		issued = -1;
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
