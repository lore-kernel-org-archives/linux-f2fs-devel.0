From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: clear discard_wake earlier
Date: Tue, 8 May 2018 17:51:34 +0800
Message-ID: <20180508095134.39238-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fFzIX-0000WN-L2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 09:52:41 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFzIS-00FIOM-Do
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 May 2018 09:52:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

If SBI_NEED_FSCK is set, discard_wake will never be cleared. As a
result, the condition of wait_event_interruptible_timeout() is always
true, which gets discard thread run too frequently.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/segment.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 503a98abdb2f..e53e28fd397e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1404,6 +1404,10 @@ static int issue_discard_thread(void *data)
 				kthread_should_stop() || freezing(current) ||
 				dcc->discard_wake,
 				msecs_to_jiffies(wait_ms));
+
+		if (dcc->discard_wake)
+			dcc->discard_wake = 0;
+
 		if (try_to_freeze())
 			continue;
 		if (f2fs_readonly(sbi->sb))
@@ -1415,9 +1419,6 @@ static int issue_discard_thread(void *data)
 			continue;
 		}
 
-		if (dcc->discard_wake)
-			dcc->discard_wake = 0;
-
 		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
 			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
 
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
