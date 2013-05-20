From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 03/15] f2fs: fix por_doing variable coverage
Date: Mon, 20 May 2013 12:32:17 +0900
Message-ID: <1369020743-18520-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UeGr4-0007aP-9Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:33:46 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeGr3-000513-7K for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:33:46 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN2000TKV7K42I0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 12:33:34 +0900 (KST)
In-reply-to: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The reason of using sbi->por_doing is to alleviate data writes during the
recovery.
The find_fsync_dnodes() produces some dirty dentry pages, so we should
cover it too with sbi->por_doing.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 993b601..f77aedd 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -377,6 +377,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&inode_list);
 
 	/* step #1: find fsynced inode numbers */
+	sbi->por_doing = 1;
 	err = find_fsync_dnodes(sbi, &inode_list);
 	if (err)
 		goto out;
@@ -385,13 +386,12 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
 		goto out;
 
 	/* step #2: recover data */
-	sbi->por_doing = 1;
 	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
-	sbi->por_doing = 0;
 	BUG_ON(!list_empty(&inode_list));
 out:
 	destroy_fsync_dnodes(sbi, &inode_list);
 	kmem_cache_destroy(fsync_entry_slab);
+	sbi->por_doing = 0;
 	write_checkpoint(sbi, false);
 	return err;
 }
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
