From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix performance issue observed with
 multi-thread sequential read
Date: Fri, 10 Aug 2018 11:56:40 -0700
Message-ID: <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
 <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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
Changelog from v2:
 - fix deadlock in f2fs_gc

 fs/f2fs/data.c  | 9 +++++++++
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/super.c | 1 +
 3 files changed, 11 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45f043ee48bd..9f0149cdeed8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2132,6 +2132,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct blk_plug plug;
 	int ret;
+	bool locked = false;
 
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
@@ -2162,10 +2163,18 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	else if (atomic_read(&sbi->wb_sync_req[DATA]))
 		goto skip_write;
 
+	if (!S_ISDIR(inode->i_mode)) {
+		mutex_lock(&sbi->writepages);
+		locked = true;
+	}
+
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
