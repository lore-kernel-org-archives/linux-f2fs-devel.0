From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove unneeded memory footprint accounting
Date: Tue, 21 Nov 2017 17:49:54 +0800
Message-ID: <20171121094954.34673-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eH5CG-0006jh-L2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Nov 2017 09:50:28 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eH5CE-0000Lp-Qu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Nov 2017 09:50:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We forgot to remov memory footprint accounting of per-cpu type
variables, fix it.

Fixes: 35782b233f37 ("f2fs: remove percpu_count due to performance regression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4d929627e210..674f9bbe98d9 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -179,7 +179,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
 	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
 	si->base_mem += sizeof(*sbi->ckpt);
-	si->base_mem += sizeof(struct percpu_counter) * NR_COUNT_TYPE;
 
 	/* build sm */
 	si->base_mem += sizeof(struct f2fs_sm_info);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
