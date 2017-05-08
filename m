From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: split wio_mutex
Date: Tue,  9 May 2017 00:33:20 +0800
Message-ID: <20170508163322.8087-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Split wio_mutex to adjust different temperature bio cache.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/segment.c | 6 ++----
 fs/f2fs/super.c   | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4ab42749fd5f..500a4c21cfe8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -882,7 +882,7 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	struct f2fs_bio_info meta_io[2];		/* for meta bios */
 	struct f2fs_bio_info log_io[NR_CURSEG_TYPE];	/* for log bios */
-	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
+	struct mutex wio_mutex[NR_CURSEG_TYPE];	/* bio ordering for NODE/DATA */
 	int write_io_size_bits;			/* Write IO size bits */
 	mempool_t *write_io_dummy;		/* Dummy pages */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cdf7d61ac213..9fa6b0682d94 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2145,8 +2145,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 
 	fio->seg_type = __get_segment_type(fio->page, fio->type);
 
-	if (fio->type == NODE || fio->type == DATA)
-		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
+	mutex_lock(&fio->sbi->wio_mutex[fio->seg_type]);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 					&fio->new_blkaddr, sum, fio->seg_type);
@@ -2158,8 +2157,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto reallocate;
 	}
 
-	if (fio->type == NODE || fio->type == DATA)
-		mutex_unlock(&fio->sbi->wio_mutex[fio->type]);
+	mutex_unlock(&fio->sbi->wio_mutex[fio->seg_type]);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fed25ca609e4..8fb16e9e6eb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1584,8 +1584,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-	mutex_init(&sbi->wio_mutex[NODE]);
-	mutex_init(&sbi->wio_mutex[DATA]);
+	for (i = 0; i < NR_CURSEG_TYPE; i++)
+		mutex_init(&sbi->wio_mutex[i]);
 	spin_lock_init(&sbi->cp_lock);
 }
 
-- 
2.12.2.575.gb14f27f
