From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: fix a hungtask problem caused by
 congestion_wait
Date: Thu, 21 Jun 2018 14:49:06 +0800
Message-ID: <1529563746-8608-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fVtcC-0000fr-Pl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 07:02:44 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVtc9-004jT8-LW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 07:02:44 +0000
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

This patch fix hungtask problem which can be reproduced as follow:

Thread 0~3:
while true
do
        touch /xxx/test/file_xxx
done

Thread 4 write a new checkpoint every three seconds.

In the meantime, fio start 16 threads for randwrite.

With my debug info, cycles num will exceed 1000 in function
f2fs_sync_dirty_inodes, and most of cycle will be dropped
into congestion_wait() and sleep more than 20ms. Cycles num
reduced to 3 with this patch.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9624a8f..1a1a0a2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -979,12 +979,10 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 
 		iput(inode);
 		/* We need to give cpu to another writers. */
-		if (ino == cur_ino) {
-			congestion_wait(BLK_RW_ASYNC, HZ/50);
+		if (ino == cur_ino)
 			cond_resched();
-		} else {
+		else
 			ino = cur_ino;
-		}
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
