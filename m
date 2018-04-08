From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: stop issue discard if something wrong
 with f2fs
Date: Sun, 8 Apr 2018 15:11:10 +0800
Message-ID: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f54hg-0000Fg-Bo
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 07:25:32 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f54he-009w1c-8B
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 07:25:32 +0000
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

This patch stop discard thread to issue discard io if
something wrong with f2fs, which is similar to fstrim.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5854cc4..f75f503 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1410,6 +1410,11 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
+		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"Found FS corruption, run fsck to fix.");
+			continue;
+		}
 
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
