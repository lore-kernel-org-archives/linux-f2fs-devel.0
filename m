From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: do not check F2FS_INLINE_DOTS in recover
Date: Mon, 23 Apr 2018 10:29:13 +0800
Message-ID: <20180423022913.131398-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fARFG-00047C-15
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:30:22 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fARFE-0034Ya-02
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 02:30:21 +0000
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

Only dir may have F2FS_INLINE_DOTS flag, so there is no need to check
the flag in recover flow.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/recovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 1b23d3febe4c..709dd4daaf29 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -204,8 +204,6 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
 		set_inode_flag(inode, FI_DATA_EXIST);
 	else
 		clear_inode_flag(inode, FI_DATA_EXIST);
-	if (!(ri->i_inline & F2FS_INLINE_DOTS))
-		clear_inode_flag(inode, FI_INLINE_DOTS);
 }
 
 static void recover_inode(struct inode *inode, struct page *page)
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
