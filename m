From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: remove duplicated dquot_initialize and fix
 error handling
Date: Sat, 21 Apr 2018 14:12:50 +0800
Message-ID: <20180421061250.69728-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1f9llq-0005FE-JW
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 06:13:14 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9llm-000P3M-Hc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 06:13:14 +0000
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

This patch removes duplicated dquot_initialize in recover_orphan_inode(),
and fix the error handling if dquot_initialize fails.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/checkpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2e23b953d304..b1e61a125cc7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -589,10 +589,11 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	}
 
 	err = dquot_initialize(inode);
-	if (err)
+	if (err) {
+		iput(inode);
 		goto err_out;
+	}
 
-	dquot_initialize(inode);
 	clear_nlink(inode);
 
 	/* truncate all the data during iput */
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
