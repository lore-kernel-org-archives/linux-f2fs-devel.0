From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2] f2fs: quota: fix incorrect comments
Date: Thu, 26 Jul 2018 19:24:25 +0800
Message-ID: <20180726112425.58904-1-shengyong1@huawei.com>
References: <20180724121754.19920-3-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fieO3-0003xZ-6B
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:24:51 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fieO0-0025H1-VW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 11:24:51 +0000
In-Reply-To: <20180724121754.19920-3-shengyong1@huawei.com>
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

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 fs/f2fs/super.c      | 5 +----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 04841f32d4d9..581710760ba6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -661,7 +661,10 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	/* Needed for iput() to work correctly and not trash data */
 	sbi->sb->s_flags |= SB_ACTIVE;
 
-	/* Turn on quotas so that they are updated correctly */
+	/*
+	 * Turn on quotas which were not enabled for read-only mounts if
+	 * filesystem has quota feature, so that they are updated correctly.
+	 */
 	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7187885da251..6ad0414ba303 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2968,10 +2968,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_root_inode;
 
 #ifdef CONFIG_QUOTA
-	/*
-	 * Turn on quotas which were not enabled for read-only mounts if
-	 * filesystem has quota feature, so that they are updated correctly.
-	 */
+	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
 		err = f2fs_enable_quotas(sb);
 		if (err) {
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
