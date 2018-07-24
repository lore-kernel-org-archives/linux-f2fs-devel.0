From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/3] f2fs: quota: decrease the lock granularity
 of statfs_project
Date: Tue, 24 Jul 2018 20:17:53 +0800
Message-ID: <20180724121754.19920-2-shengyong1@huawei.com>
References: <20180724121754.19920-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fhwGi-0001L9-4a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 12:18:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fhwGg-00Ha0x-FS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Jul 2018 12:18:20 +0000
In-Reply-To: <20180724121754.19920-1-shengyong1@huawei.com>
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

According to fs/quota/dquot.c, `dq_data_lock' protects mem_dqinfo
structures and modifications of dquot pointers in the inode, and
`dquot->dq_dqb_lock' protects data from dq_dqb.

We should use dquot->dq_dqb_lock in statfs_project instead of
dq_dat_lock.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 796a2d756572..4ed91ceab3ee 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1118,7 +1118,7 @@ static int f2fs_statfs_project(struct super_block *sb,
 	dquot = dqget(sb, qid);
 	if (IS_ERR(dquot))
 		return PTR_ERR(dquot);
-	spin_lock(&dq_data_lock);
+	spin_lock(&dquot->dq_dqb_lock);
 
 	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
 		 dquot->dq_dqb.dqb_bsoftlimit :
@@ -1141,7 +1141,7 @@ static int f2fs_statfs_project(struct super_block *sb,
 			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
 	}
 
-	spin_unlock(&dq_data_lock);
+	spin_unlock(&dquot->dq_dqb_lock);
 	dqput(dquot);
 	return 0;
 }
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
