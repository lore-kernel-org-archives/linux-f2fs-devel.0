From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: shrink blk plug region
Date: Mon, 27 Mar 2017 18:14:05 +0800
Message-ID: <20170327101406.56028-2-yuchao0@huawei.com>
References: <20170327101406.56028-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1csRfX-0001Eo-TB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:35 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1csRfV-0006p4-Lt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Mar 2017 10:14:35 +0000
In-Reply-To: <20170327101406.56028-1-yuchao0@huawei.com>
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

Don't use blk plug covering area where there won't be any IOs being issued.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c1a03b0857f9..57a81f9c8c14 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -848,9 +848,8 @@ static int issue_discard_thread(void *data)
 	if (kthread_should_stop())
 		return 0;
 
-	blk_start_plug(&plug);
-
 	mutex_lock(&dcc->cmd_lock);
+	blk_start_plug(&plug);
 	list_for_each_entry_safe(dc, tmp, pend_list, list) {
 		f2fs_bug_on(sbi, dc->state != D_PREP);
 
@@ -860,6 +859,7 @@ static int issue_discard_thread(void *data)
 		if (iter++ > DISCARD_ISSUE_RATE)
 			break;
 	}
+	blk_finish_plug(&plug);
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->state == D_DONE)
@@ -867,8 +867,6 @@ static int issue_discard_thread(void *data)
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-	blk_finish_plug(&plug);
-
 	iter = 0;
 	congestion_wait(BLK_RW_SYNC, HZ/50);
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
