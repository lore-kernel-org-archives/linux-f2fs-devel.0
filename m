From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: fix to flush multiple device in checkpoint
Date: Fri, 29 Sep 2017 13:59:39 +0800
Message-ID: <20170929055939.39937-5-yuchao0@huawei.com>
References: <20170929055939.39937-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929055939.39937-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If f2fs manages multiple devices, in checkpoint, we need to issue flush
in those devices which contain dirty data/node in their cache before
we write checkpoint region, otherwise, filesystem metadata could be
corrupted if hitting SPO after checkpoint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  6 ++++++
 fs/f2fs/f2fs.h       |  3 +++
 fs/f2fs/segment.c    | 29 +++++++++++++++++++++++++++++
 fs/f2fs/super.c      |  3 +++
 4 files changed, 41 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 571980793542..201608281681 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1172,6 +1172,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct super_block *sb = sbi->sb;
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
+	int err;
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
@@ -1265,6 +1266,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
+	/* flush all device cache */
+	err = f2fs_flush_device_cache(sbi);
+	if (err)
+		return err;
+
 	/* write out checkpoint buffer at block 0 */
 	update_meta_page(sbi, ckpt, start_blk++);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ce63e778136a..c85f49c41003 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1145,6 +1145,8 @@ struct f2fs_sb_info {
 	struct list_head s_list;
 	int s_ndevs;				/* number of devices */
 	struct f2fs_dev_info *devs;		/* for device list */
+	unsigned int dirty_device;		/* for checkpoint data flush */
+	spinlock_t dev_lock;			/* protect dirty_device */
 	struct mutex umount_mutex;
 	unsigned int shrinker_run_no;
 
@@ -2555,6 +2557,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
 int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int create_flush_cmd_control(struct f2fs_sb_info *sbi);
+int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9d096f0014dc..2fe3343d876c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -659,6 +659,28 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 	}
 }
 
+int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
+{
+	int ret = 0, i;
+
+	if (!sbi->s_ndevs)
+		return 0;
+
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		if (!f2fs_test_bit(i, (char *)&sbi->dirty_device))
+			continue;
+		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+		if (ret)
+			break;
+
+		spin_lock(&sbi->dev_lock);
+		f2fs_clear_bit(i, (char *)&sbi->dirty_device);
+		spin_unlock(&sbi->dev_lock);
+	}
+
+	return ret;
+}
+
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
@@ -2515,6 +2537,13 @@ static void update_device_state(struct f2fs_io_info *fio)
 
 	/* update device state for fsync */
 	set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+
+	/* update device state for checkpoint */
+	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
+		spin_lock(&sbi->dev_lock);
+		f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
+		spin_unlock(&sbi->dev_lock);
+	}
 }
 
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1c56100d28c1..1d68c18a487b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1996,6 +1996,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		for (j = HOT; j < NR_TEMP_TYPE; j++)
 			mutex_init(&sbi->wio_mutex[i][j]);
 	spin_lock_init(&sbi->cp_lock);
+
+	sbi->dirty_device = 0;
+	spin_lock_init(&sbi->dev_lock);
 }
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
-- 
2.13.1.388.g69e6b9b4f4a9
