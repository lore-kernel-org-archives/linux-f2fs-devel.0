From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH RFC] Revert "f2fs: avoid cpu lockup"
Date: Thu, 31 May 2018 16:32:29 +0800
Message-ID: <1527755549-22660-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fOJFh-0002Ii-FK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 May 2018 08:48:09 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fOJFf-00E3KG-8f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 May 2018 08:48:09 +0000
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

This reverts commit 4db08d016ccedb5b97869724a096990acad59685 to
fix hungtask problem which can be reproduced as follow:

Thread 0~3:

while true
do
	touch /xxx/test/file_xxx
done

Thread 5 write a new checkpoint every three seconds.

In the meantime, fio start 16 threads for randwrite.

With my debug info, cycles num will exceed 1000 in function
f2fs_sync_dirty_inodes, and most of cycle will be dropped
into congestion_wait() and sleep more than 20ms.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8eb184c..76e1856 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -944,7 +944,6 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	struct inode *inode;
 	struct f2fs_inode_info *fi;
 	bool is_dir = (type == DIR_INODE);
-	unsigned long ino = 0;
 
 	trace_f2fs_sync_dirty_inodes_enter(sbi->sb, is_dir,
 				get_pages(sbi, is_dir ?
@@ -967,8 +966,6 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	inode = igrab(&fi->vfs_inode);
 	spin_unlock(&sbi->inode_lock[type]);
 	if (inode) {
-		unsigned long cur_ino = inode->i_ino;
-
 		if (is_dir)
 			F2FS_I(inode)->cp_task = current;
 
@@ -978,13 +975,6 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 			F2FS_I(inode)->cp_task = NULL;
 
 		iput(inode);
-		/* We need to give cpu to another writers. */
-		if (ino == cur_ino) {
-			congestion_wait(BLK_RW_ASYNC, HZ/50);
-			cond_resched();
-		} else {
-			ino = cur_ino;
-		}
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
