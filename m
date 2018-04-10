From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v4] f2fs: stop issue discard if something wrong
 with f2fs
Date: Tue, 10 Apr 2018 12:01:45 +0800
Message-ID: <1523332905-12688-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f5khQ-0001lq-Jb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 04:16:04 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5khM-004JRN-NK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 04:16:04 +0000
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

This patch stop async thread and umount process to issue discard
if something wrong with f2fs, which is similar to fstrim.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5854cc4..1659985 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1202,6 +1202,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, iter = 0, issued = 0;
 	bool io_interrupted = false;
 
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+		return issued;
+
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
 			break;
@@ -1410,6 +1413,8 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
+		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+			continue;
 
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
