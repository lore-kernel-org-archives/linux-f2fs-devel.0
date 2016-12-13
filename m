From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove unused values in recover_fsync_data
Date: Tue, 13 Dec 2016 17:23:37 +0800
Message-ID: <20161213092338.20996-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cGjFo-0007wX-MC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 09:20:08 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cGjFm-0001Oh-62
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 09:20:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch remove unused values in function recover_fsync_data

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/recovery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 981a958..4fb4471 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -552,10 +552,8 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 
 int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 {
-	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct list_head inode_list;
 	struct list_head dir_list;
-	block_t blkaddr;
 	int err;
 	int ret = 0;
 	bool need_writecp = false;
@@ -571,8 +569,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	/* prevent checkpoint */
 	mutex_lock(&sbi->cp_mutex);
 
-	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
-
 	/* step #1: find fsynced inode numbers */
 	err = find_fsync_dnodes(sbi, &inode_list);
 	if (err || list_empty(&inode_list))
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
