From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: wake up gc thread immediately when
 gc_urgent is set
Date: Sun, 5 Aug 2018 12:45:35 +0800
Message-ID: <20180805044535.129761-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fmAvc-0004hA-8u
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Aug 2018 04:46:04 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmAvZ-009gb5-OQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Aug 2018 04:46:04 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Fixes: 5b0e95398e2b ("f2fs: introduce sbi->gc_mode to determine the policy")
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f22782a0defe..cd2e030e47b8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -253,6 +253,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		if (t >= 1) {
 			sbi->gc_mode = GC_URGENT;
 			if (sbi->gc_thread) {
+				sbi->gc_thread->gc_wake = 1;
 				wake_up_interruptible_all(
 					&sbi->gc_thread->gc_wait_queue_head);
 				wake_up_discard_thread(sbi, true);
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
