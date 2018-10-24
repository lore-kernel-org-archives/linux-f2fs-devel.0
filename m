From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: remove codes of unused wio_mutex
Date: Wed, 24 Oct 2018 16:09:42 +0800
Message-ID: <1540368582-14312-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/super.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 56204a8..4dfa28d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1170,7 +1170,6 @@ struct f2fs_sb_info {
 
 	/* for bio operations */
 	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
-	struct mutex wio_mutex[NR_PAGE_TYPE - 1][NR_TEMP_TYPE];
 						/* bio ordering for NODE/DATA */
 	/* keep migration IO order for LFS mode */
 	struct rw_semaphore io_order_lock;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2c..2d18de5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2674,7 +2674,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
-	int i, j;
+	int i;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -2710,9 +2710,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-	for (i = 0; i < NR_PAGE_TYPE - 1; i++)
-		for (j = HOT; j < NR_TEMP_TYPE; j++)
-			mutex_init(&sbi->wio_mutex[i][j]);
 	init_rwsem(&sbi->io_order_lock);
 	spin_lock_init(&sbi->cp_lock);
 
-- 
1.8.5.2
