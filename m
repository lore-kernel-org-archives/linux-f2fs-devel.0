From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix performance issue observed with
 multi-thread sequential read
Date: Thu, 9 Aug 2018 19:48:59 -0700
Message-ID: <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810023758.46974-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This reverts the commit - "b93f771 - f2fs: remove writepages lock"
to fix the drop in sequential read throughput.

Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
device: UFS

Before -
read throughput: 185 MB/s
total read requests: 85177 (of these ~80000 are 4KB size requests).
total write requests: 2546 (of these ~2208 requests are written in 512KB).

After -
read throughput: 758 MB/s
total read requests: 2417 (of these ~2042 are 512KB reads).
total write requests: 2701 (of these ~2034 requests are written in 512KB).

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - quick code fix

 fs/f2fs/data.c  | 14 ++++++++++++--
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45f043ee48bd..6da143a27b3a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2132,6 +2132,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct blk_plug plug;
 	int ret;
+	bool locked = false;
 
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
@@ -2157,15 +2158,24 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
 	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
-	if (wbc->sync_mode == WB_SYNC_ALL)
+	if (wbc->sync_mode == WB_SYNC_ALL) {
 		atomic_inc(&sbi->wb_sync_req[DATA]);
-	else if (atomic_read(&sbi->wb_sync_req[DATA]))
+		goto writepages_lock;
+	} else if (atomic_read(&sbi->wb_sync_req[DATA])) {
 		goto skip_write;
+	} else {
+writepages_lock:
+		mutex_lock(&sbi->writepages);
+		locked = true;
+	}
 
 	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
+	if (locked)
+		mutex_unlock(&sbi->writepages);
+
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		atomic_dec(&sbi->wb_sync_req[DATA]);
 	/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b1c127d8383b..29bbc55cbc0b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1133,6 +1133,7 @@ struct f2fs_sb_info {
 	struct rw_semaphore sb_lock;		/* lock for raw super block */
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
+	struct mutex writepages;		/* mutex for writepages() */
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be41dbd7b261..53d70b64fea1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2842,6 +2842,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
+	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
-- 
2.17.0.441.gb46fe60e1d-goog
