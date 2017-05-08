From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: move f2fs_sb_info.{log_io,wio_mutex} into struct curseg_info
Date: Tue,  9 May 2017 00:33:21 +0800
Message-ID: <20170508163322.8087-2-chao@kernel.org>
References: <20170508163322.8087-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170508163322.8087-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Just cleanup, no logic changed.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    |  4 ++--
 fs/f2fs/f2fs.h    |  2 --
 fs/f2fs/segment.c | 10 ++++++++--
 fs/f2fs/segment.h |  2 ++
 fs/f2fs/super.c   |  7 -------
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 37d0896021c7..5f001b471252 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -289,7 +289,7 @@ static struct f2fs_bio_info *__get_bio_info(struct f2fs_sb_info *sbi, int rw,
 
 		io = &sbi->meta_io[io_type];
 	} else {
-		io = &sbi->log_io[seg_type];
+		io = &CURSEG_I(sbi, seg_type)->bio_info;
 	}
 
 	return io;
@@ -326,7 +326,7 @@ void f2fs_submit_log_bio_cond(struct f2fs_sb_info *sbi,
 	int max = is_data ? CURSEG_COLD_DATA : CURSEG_COLD_NODE;
 
 	for (; i <= max; i++)
-		__f2fs_submit_merged_bio(&sbi->log_io[i],
+		__f2fs_submit_merged_bio(&CURSEG_I(sbi, i)->bio_info,
 					inode, ino, idx, type);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 500a4c21cfe8..9129a6229bc8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -881,8 +881,6 @@ struct f2fs_sb_info {
 
 	/* for bio operations */
 	struct f2fs_bio_info meta_io[2];		/* for meta bios */
-	struct f2fs_bio_info log_io[NR_CURSEG_TYPE];	/* for log bios */
-	struct mutex wio_mutex[NR_CURSEG_TYPE];	/* bio ordering for NODE/DATA */
 	int write_io_size_bits;			/* Write IO size bits */
 	mempool_t *write_io_dummy;		/* Dummy pages */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9fa6b0682d94..c047b5d8b9d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2145,7 +2145,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 
 	fio->seg_type = __get_segment_type(fio->page, fio->type);
 
-	mutex_lock(&fio->sbi->wio_mutex[fio->seg_type]);
+	mutex_lock(&CURSEG_I(fio->sbi, fio->seg_type)->wio_mutex);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 					&fio->new_blkaddr, sum, fio->seg_type);
@@ -2157,7 +2157,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		goto reallocate;
 	}
 
-	mutex_unlock(&fio->sbi->wio_mutex[fio->seg_type]);
+	mutex_unlock(&CURSEG_I(fio->sbi, fio->seg_type)->wio_mutex);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
@@ -2973,6 +2973,12 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 			return -ENOMEM;
 		array[i].segno = NULL_SEGNO;
 		array[i].next_blkoff = 0;
+
+		init_rwsem(&array[i].bio_info.io_rwsem);
+		array[i].bio_info.sbi = sbi;
+		array[i].bio_info.bio = NULL;
+
+		mutex_init(&array[i].wio_mutex);
 	}
 	return restore_curseg_summaries(sbi);
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 10bf05d4cff4..701944b462cd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -282,6 +282,8 @@ struct curseg_info {
 	struct f2fs_summary_block *sum_blk;	/* cached summary block */
 	struct rw_semaphore journal_rwsem;	/* protect journal area */
 	struct f2fs_journal *journal;		/* cached journal info */
+	struct f2fs_bio_info bio_info;		/* for log bios */
+	struct mutex wio_mutex;			/* serialize DATA/NODE IOs */
 	unsigned char alloc_type;		/* current allocation type */
 	unsigned int segno;			/* current segment number */
 	unsigned short next_blkoff;		/* next block offset to write */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fb16e9e6eb4..5c2bb3851b89 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1584,8 +1584,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
-	for (i = 0; i < NR_CURSEG_TYPE; i++)
-		mutex_init(&sbi->wio_mutex[i]);
 	spin_lock_init(&sbi->cp_lock);
 }
 
@@ -1955,11 +1953,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->meta_io[i].sbi = sbi;
 		sbi->meta_io[i].bio = NULL;
 	}
-	for (i = 0; i < NR_CURSEG_TYPE; i++) {
-		init_rwsem(&sbi->log_io[i].io_rwsem);
-		sbi->log_io[i].sbi = sbi;
-		sbi->log_io[i].bio = NULL;
-	}
 
 	init_rwsem(&sbi->cp_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
-- 
2.12.2.575.gb14f27f
