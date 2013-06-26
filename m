From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [f2fs-dev] [PATCH] f2fs: Remove the unused argument "sbi" of func
	destroy_fsync_dnodes()
Date: Wed, 26 Jun 2013 17:58:14 +0800
Message-ID: <51CABB36.4060808@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1UrmXW-0003Xa-Uk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Jun 2013 10:01:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UrmXU-0007wl-3t for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Jun 2013 10:01:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Destroy_fsync_dnodes() is a simple list-cleanup func, so delete the unused and unrelated f2fs_sb_info argument of it.


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/recovery.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9db8239..d56d951 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -192,8 +192,7 @@ out:
        return err;
 }
 
-static void destroy_fsync_dnodes(struct f2fs_sb_info *sbi,
-                                       struct list_head *head)
+static void destroy_fsync_dnodes(struct list_head *head)
 {
        struct fsync_inode_entry *entry, *tmp;
 
@@ -438,7 +437,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
        err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
        BUG_ON(!list_empty(&inode_list));
 out:
-       destroy_fsync_dnodes(sbi, &inode_list);
+       destroy_fsync_dnodes(&inode_list);
        kmem_cache_destroy(fsync_entry_slab);
        sbi->por_doing = 0;
        if (!err)
-- 
1.7.7

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
