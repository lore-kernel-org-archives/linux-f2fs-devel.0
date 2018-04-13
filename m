From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v5] f2fs: stop issue discard if something wrong
 with f2fs
Date: Fri, 13 Apr 2018 11:08:05 +0800
Message-ID: <1523588885-9704-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f6pIA-0006Lm-0M
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 03:22:26 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6pI8-004aI4-DS
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Apr 2018 03:22:25 +0000
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
Cc: zhangdianfang@huawei.com

v4->v5: move data corruption check to __submit_discard_cmd, in order to
control discard io submitted more accurately, besides, increase async
thread wait time if data corruption detected.

This patch stop async thread and umount process to issue discard
if something wrong with f2fs, which is similar to fstrim.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d923ef5..991d1a2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -929,6 +929,9 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (dc->state != D_PREP)
 		return;
 
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		return;
+
 	trace_f2fs_issue_discard(dc->bdev, dc->start, dc->len);
 
 	dc->error = __blkdev_issue_discard(dc->bdev,
@@ -1410,6 +1413,10 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
+		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
+			wait_ms = dpolicy.max_interval;
+			continue;
+		}
 
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
