From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: clean up error path of fill_super
Date: Wed, 17 Jan 2018 16:31:35 +0800
Message-ID: <20180117083138.27755-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ebj8n-0000kP-8x
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ebj8m-00046a-7O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
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

This patch cleans up error path of fille_super to avoid unneeded
release step.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a76d229a802..86410875cbb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2607,14 +2607,14 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	err = init_percpu_info(sbi);
 	if (err)
-		goto free_options;
+		goto free_bio_info;
 
 	if (F2FS_IO_SIZE(sbi) > 1) {
 		sbi->write_io_dummy =
 			mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
 		if (!sbi->write_io_dummy) {
 			err = -ENOMEM;
-			goto free_options;
+			goto free_percpu;
 		}
 	}
 
@@ -2846,10 +2846,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	iput(sbi->meta_inode);
 free_io_dummy:
 	mempool_destroy(sbi->write_io_dummy);
-free_options:
+free_percpu:
+	destroy_percpu_info(sbi);
+free_bio_info:
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kfree(sbi->write_io[i]);
-	destroy_percpu_info(sbi);
+free_options:
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
 		kfree(sbi->s_qf_names[i]);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
