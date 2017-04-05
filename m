From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 2/4] f2fs: introduce f2fs_wait_discard_bios
Date: Wed, 5 Apr 2017 18:19:49 +0800
Message-ID: <20170405101949.59292-2-yuchao0@huawei.com>
References: <20170405101949.59292-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cvi31-0000Xc-L9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:20:19 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cvi30-0007b7-AH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:20:19 +0000
In-Reply-To: <20170405101949.59292-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Split f2fs_wait_discard_bios from f2fs_wait_discard_bio, just for cleanup,
no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 37 ++++++++++++++++++++++---------------
 fs/f2fs/super.c   |  2 +-
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68e55bd6b50e..33073bd1f090 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2187,7 +2187,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
-void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr);
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void release_discard_addrs(struct f2fs_sb_info *sbi);
 int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 07dddcb0d03d..4243c7539f42 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -786,13 +786,9 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct list_head *pend_list = &(dcc->discard_pend_list);
 	struct list_head *wait_list = &(dcc->discard_wait_list);
 	struct discard_cmd *dc, *tmp;
-	struct blk_plug plug;
 
 	mutex_lock(&dcc->cmd_lock);
 
-	if (blkaddr == NULL_ADDR)
-		goto release_discard;
-
 	list_for_each_entry_safe(dc, tmp, pend_list, list) {
 		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len)
 			__punch_discard_cmd(sbi, dc, blkaddr);
@@ -806,19 +802,30 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		}
 	}
 
-release_discard:
-	/* this comes from f2fs_put_super */
-	if (blkaddr == NULL_ADDR) {
-		blk_start_plug(&plug);
-		list_for_each_entry_safe(dc, tmp, pend_list, list)
-			__submit_discard_cmd(sbi, dc);
-		blk_finish_plug(&plug);
+	mutex_unlock(&dcc->cmd_lock);
+}
 
-		list_for_each_entry_safe(dc, tmp, wait_list, list) {
-			wait_for_completion_io(&dc->wait);
-			__remove_discard_cmd(sbi, dc);
-		}
+/* This comes from f2fs_put_super */
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *pend_list = &(dcc->discard_pend_list);
+	struct list_head *wait_list = &(dcc->discard_wait_list);
+	struct discard_cmd *dc, *tmp;
+	struct blk_plug plug;
+
+	mutex_lock(&dcc->cmd_lock);
+
+	blk_start_plug(&plug);
+	list_for_each_entry_safe(dc, tmp, pend_list, list)
+		__submit_discard_cmd(sbi, dc);
+	blk_finish_plug(&plug);
+
+	list_for_each_entry_safe(dc, tmp, wait_list, list) {
+		wait_for_completion_io(&dc->wait);
+		__remove_discard_cmd(sbi, dc);
 	}
+
 	mutex_unlock(&dcc->cmd_lock);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f315b54cd840..b4c5c6298698 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -793,7 +793,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	f2fs_wait_discard_bio(sbi, NULL_ADDR);
+	f2fs_wait_discard_bios(sbi);
 
 	/* write_checkpoint can update stat informaion */
 	f2fs_destroy_stats(sbi);
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
