From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH RFC 1/1] f2fs: add per-device superblocks
Date: Thu, 9 Nov 2017 11:26:16 +0800
Message-ID: <20171109032616.16858-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: sunqiuyang@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Qiuyang Sun <sunqiuyang@huawei.com>

Currently, a multi-device F2FS only has superblocks written in its start
device, but not the others. Thus, we cannot tell if a single device is part
of a F2FS by reading itself only, which may be unsafe in scenarios like
transferring devices between computer systems. This patch embeds per-device
superblock sections into the main area.

- In the main area, we reserve the start section of each device for extra
  copies of the superblock on its 0th and 1st blocks. All blocks in such
  segments are counted as valid, disabling them to be allocated for other
  uses. These segments cannot be GCed.
- Reserve a bit in f2fs_super_block::feature to represent whether
  superblock sections exist on all devices. This feature is backward
  compatible by a mount option "-o per_dev_sb": Any valid data or node
  blocks in the target sections will be moved out by calling
  do_garbage_collect(); if succeeded, new superblock sections will be
  built, otherwise the mount fails.
- With this feature, a F2FS can be mounted from any of its devices.

TODO:
- f2fs-tools:
  - mkfs.f2fs: allow building per-device superblocks offline when
    formatting a F2FS;
  - fsck.f2fs: treat the per-device superblock segments correctly.
- Identify each device in a F2FS by its UUID in struct f2fs_super_block,
  instead of the path.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/f2fs.h    |  18 ++++++++
 fs/f2fs/gc.c      |   7 ++-
 fs/f2fs/gc.h      |   5 --
 fs/f2fs/segment.c | 102 +++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/segment.h |   1 +
 fs/f2fs/super.c   | 133 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 248 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e1d3a94..f994dab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -96,6 +96,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_PRJQUOTA		0x00200000
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
+#define F2FS_MOUNT_PER_DEV_SB		0x01000000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -123,6 +124,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_INODE_CHKSUM	0x0020
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
+#define F2FS_FEATURE_PER_DEV_SB		0x0100
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -969,6 +971,7 @@ struct f2fs_dev_info {
 	unsigned int nr_blkz;			/* Total number of zones */
 	u8 *blkz_type;				/* Array of zones type */
 #endif
+	bool sb_valid[2];	/* Validity of two per-device superblocks */
 };
 
 enum inode_type {
@@ -2648,6 +2651,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi);
 void destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init create_segment_manager_caches(void);
 void destroy_segment_manager_caches(void);
+int build_device_sb_sections(struct f2fs_sb_info *sbi);
+void set_per_device_sb_sentries(struct f2fs_sb_info *sbi);
 
 /*
  * checkpoint.c
@@ -2732,12 +2737,20 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 /*
  * gc.c
  */
+struct gc_inode_list {
+	struct list_head ilist;
+	struct radix_tree_root iroot;
+};
+
 int start_gc_thread(struct f2fs_sb_info *sbi);
 void stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
 			unsigned int segno);
 void build_gc_manager(struct f2fs_sb_info *sbi);
+void put_gc_inode(struct gc_inode_list *gc_list);
+int do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int start_segno,
+				struct gc_inode_list *gc_list, int gc_type);
 
 /*
  * recovery.c
@@ -3083,6 +3096,11 @@ static inline int f2fs_sb_has_quota_ino(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_QUOTA_INO);
 }
 
+static inline int f2fs_sb_has_per_device_sb(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_PER_DEV_SB);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c7b1d70..2f665e2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -438,7 +438,7 @@ static void add_gc_inode(struct gc_inode_list *gc_list, struct inode *inode)
 	list_add_tail(&new_ie->list, &gc_list->ilist);
 }
 
-static void put_gc_inode(struct gc_inode_list *gc_list)
+void put_gc_inode(struct gc_inode_list *gc_list)
 {
 	struct inode_entry *ie, *next_ie;
 	list_for_each_entry_safe(ie, next_ie, &gc_list->ilist, list) {
@@ -900,7 +900,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	return ret;
 }
 
-static int do_garbage_collect(struct f2fs_sb_info *sbi,
+int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type)
 {
@@ -913,6 +913,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 
+	if (get_seg_entry(sbi, segno)->per_dev_sb)
+		return 0;
+
 	/* readahead multi ssa blocks those have contiguous address */
 	if (sbi->segs_per_sec > 1)
 		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 9325191..01d0da5 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -39,11 +39,6 @@ struct f2fs_gc_kthread {
 	unsigned int gc_wake;
 };
 
-struct gc_inode_list {
-	struct list_head ilist;
-	struct radix_tree_root iroot;
-};
-
 /*
  * inline functions
  */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 919798a..e054963 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2139,6 +2139,8 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	struct summary_footer *sum_footer;
 
+	f2fs_bug_on(sbi, get_seg_entry(sbi, curseg->next_segno)->per_dev_sb);
+
 	curseg->segno = curseg->next_segno;
 	curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);
 	curseg->next_blkoff = 0;
@@ -3858,3 +3860,103 @@ void destroy_segment_manager_caches(void)
 	kmem_cache_destroy(discard_entry_slab);
 	kmem_cache_destroy(inmem_entry_slab);
 }
+
+int build_device_sb_sections(struct f2fs_sb_info *sbi)
+{
+	struct gc_inode_list gc_list;
+	unsigned int segoff, segno, dev_sb_segno[MAX_DEVICES];
+	int sb_secs, i, type, err = 0, ret;
+	block_t blkaddr;
+	struct cp_control cpc;
+
+	sb_secs = sbi->s_ndevs - 1;
+	if (has_not_enough_free_secs(sbi, 0, sb_secs) ||
+			valid_user_blocks(sbi) + BLKS_PER_SEC(sbi) * sb_secs >
+			sbi->user_block_count) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"Not eough space for building per-device SB sections!");
+		return -ENOSPC;
+	}
+
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		dev_sb_segno[i] = GET_SEGNO(sbi, FDEV(i).start_blk);
+		for (segoff = 0; segoff < sbi->segs_per_sec; segoff++)
+			__set_test_and_inuse(sbi, dev_sb_segno[i] + segoff);
+	}
+
+	for (i = 1; i < sbi->s_ndevs; i++)
+		for (segoff = 0; segoff < sbi->segs_per_sec; segoff++)
+			for (type = 0; type < NO_CHECK_TYPE; type++)
+				if (CURSEG_I(sbi, type)->segno ==
+						dev_sb_segno[i] + segoff)
+					SIT_I(sbi)->s_ops->allocate_segment
+							(sbi, type, true);
+
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		if (!get_valid_blocks(sbi, dev_sb_segno[i], true))
+			continue;
+
+		mutex_lock(&sbi->gc_mutex);
+		INIT_LIST_HEAD(&gc_list.ilist);
+		INIT_RADIX_TREE(&gc_list.iroot, GFP_NOFS);
+		do_garbage_collect(sbi, dev_sb_segno[i], &gc_list, FG_GC);
+		mutex_unlock(&sbi->gc_mutex);
+		put_gc_inode(&gc_list);
+
+		if (get_valid_blocks(sbi, dev_sb_segno[i], true)) {
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"Cannot write superblocks on %s; GC failed.",
+				FDEV(i).path);
+			err = -ENOSPC;
+			goto out;
+		}
+	}
+
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		f2fs_bug_on(sbi, get_valid_blocks(sbi, dev_sb_segno[i], true));
+
+		blkaddr = FDEV(i).start_blk;
+		while (blkaddr < FDEV(i).start_blk + BLKS_PER_SEC(sbi)) {
+			update_sit_entry(sbi, blkaddr, 1);
+			blkaddr++;
+		}
+
+		for (segoff = 0; segoff < sbi->segs_per_sec; segoff++) {
+			segno = dev_sb_segno[i] + segoff;
+			mutex_lock(&DIRTY_I(sbi)->seglist_lock);
+			__remove_dirty_segment(sbi, segno, PRE);
+			__remove_dirty_segment(sbi, segno, DIRTY);
+			mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
+
+			sbi->total_valid_block_count += sbi->blocks_per_seg;
+		}
+	}
+out:
+	cpc.reason = __get_cp_reason(sbi);
+	mutex_lock(&sbi->gc_mutex);
+	ret = write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
+	if (err || ret)
+		return err ? err : ret;
+
+	F2FS_SET_FEATURE(sbi->sb, F2FS_FEATURE_PER_DEV_SB);
+	return f2fs_commit_super(sbi, false);
+}
+
+void set_per_device_sb_sentries(struct f2fs_sb_info *sbi)
+{
+	int i;
+	unsigned int segno, start_segno;
+	struct seg_entry *sentry;
+
+	for (i = 1; i < sbi->s_ndevs; i++) {
+		start_segno = GET_SEGNO(sbi, FDEV(i).start_blk);
+		sentry = get_seg_entry(sbi, start_segno);
+		segno = start_segno;
+
+		while (segno++ < start_segno + sbi->segs_per_sec) {
+			sentry->per_dev_sb = true;
+			sentry++;
+		}
+	}
+}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8d93652..dff4b29 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -187,6 +187,7 @@ struct seg_entry {
 	unsigned char *ckpt_valid_map;	/* validity bitmap of blocks last cp */
 	unsigned char *discard_map;
 	unsigned long long mtime;	/* modification time of the segment */
+	bool per_dev_sb;
 };
 
 struct sec_entry {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0ca7b05..26bae08 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -125,6 +125,7 @@ enum {
 	Opt_jqfmt_vfsold,
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
+	Opt_per_dev_sb,
 	Opt_err,
 };
 
@@ -175,6 +176,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
+	{Opt_per_dev_sb, "per_dev_sb"},
 	{Opt_err, NULL},
 };
 
@@ -614,6 +616,9 @@ static int parse_options(struct super_block *sb, char *options)
 					"quota operations not supported");
 			break;
 #endif
+		case Opt_per_dev_sb:
+			set_opt(sbi, PER_DEV_SB);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -1153,6 +1158,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",prjquota");
 #endif
 	f2fs_show_quota_options(seq, sbi->sb);
+	if (test_opt(sbi, PER_DEV_SB))
+		seq_puts(seq, ",per_dev_sb");
 
 	return 0;
 }
@@ -2252,10 +2259,49 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 	return err;
 }
 
+static void check_device_super_blocks(struct f2fs_sb_info *sbi, int *recovery)
+{
+	struct buffer_head *bh;
+	int i, block;
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		if (sbi->sb->s_bdev == FDEV(i).bdev) {
+			FDEV(i).sb_valid[sbi->valid_super_block] = true;
+			FDEV(i).sb_valid[1 - sbi->valid_super_block] =
+								!*recovery;
+			continue;
+		}
+
+		for (block = 0; block < 2; block++) {
+			bh = __bread_gfp(FDEV(i).bdev, block,
+				sbi->sb->s_blocksize, __GFP_MOVABLE);
+			if (!bh) {
+				f2fs_msg(sbi->sb, KERN_ERR,
+					"Unable to read %dth superblock on "
+					"device %s", block + 1, FDEV(i).path);
+				*recovery = 1;
+				continue;
+			}
+
+			if (sanity_check_raw_super(sbi, bh)) {
+				f2fs_msg(sbi->sb, KERN_ERR, "Can't find valid "
+					"%dth superblock on device %s",
+					block + 1, FDEV(i).path);
+				*recovery = 1;
+			} else {
+				FDEV(i).sb_valid[block] = true;
+			}
+			brelse(bh);
+		}
+	}
+}
+
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
 	struct buffer_head *bh;
-	int err;
+	int err, i, block;
+	bool dev_sb = sbi->s_ndevs > 1 && f2fs_sb_has_per_device_sb(sbi->sb);
+	bool committed[MAX_DEVICES][2];
 
 	if ((recover && f2fs_readonly(sbi->sb)) ||
 				bdev_read_only(sbi->sb->s_bdev)) {
@@ -2270,6 +2316,32 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
 	brelse(bh);
 
+	if (!dev_sb)
+		goto skip;
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		if (FDEV(i).bdev == sbi->sb->s_bdev)
+			continue;
+
+		for (block = 0; block < 2; block++) {
+			committed[i][block] = false;
+			if (FDEV(i).sb_valid[block])
+				continue;
+
+			bh = __getblk_gfp(FDEV(i).bdev, block,
+					sbi->sb->s_blocksize, __GFP_MOVABLE);
+			if (!bh)
+				return -EIO;
+
+			err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
+			brelse(bh);
+			if (err)
+				return err;
+			FDEV(i).sb_valid[block] = true;
+			committed[i][block] = true;
+		}
+	}
+skip:
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
@@ -2280,6 +2352,29 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 		return -EIO;
 	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
 	brelse(bh);
+
+	if (!dev_sb)
+		return err;
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		if (FDEV(i).bdev == sbi->sb->s_bdev)
+			continue;
+
+		for (block = 0; block < 2; block++) {
+			if (committed[i][block])
+				continue;
+
+			bh = __getblk_gfp(FDEV(i).bdev, block,
+					sbi->sb->s_blocksize, __GFP_MOVABLE);
+			if (!bh)
+				return -EIO;
+
+			err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
+			brelse(bh);
+			if (err)
+				return err;
+		}
+	}
 	return err;
 }
 
@@ -2338,6 +2433,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 		if (IS_ERR(FDEV(i).bdev))
 			return PTR_ERR(FDEV(i).bdev);
 
+		FDEV(i).sb_valid[0] = FDEV(i).sb_valid[1] = false;
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 
@@ -2539,12 +2635,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_io_dummy;
 	}
 
-	err = get_valid_checkpoint(sbi);
-	if (err) {
-		f2fs_msg(sb, KERN_ERR, "Failed to get valid F2FS checkpoint");
-		goto free_meta_inode;
-	}
-
 	/* Initialize device list */
 	err = f2fs_scan_devices(sbi);
 	if (err) {
@@ -2552,6 +2642,15 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_devices;
 	}
 
+	if (f2fs_sb_has_per_device_sb(sb))
+		check_device_super_blocks(sbi, &recovery);
+
+	err = get_valid_checkpoint(sbi);
+	if (err) {
+		f2fs_msg(sb, KERN_ERR, "Failed to get valid F2FS checkpoint");
+		goto free_devices;
+	}
+
 	sbi->total_valid_node_count =
 				le32_to_cpu(sbi->ckpt->valid_node_count);
 	percpu_counter_set(&sbi->total_valid_inode_count,
@@ -2710,10 +2809,23 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (recovery) {
 		err = f2fs_commit_super(sbi, true);
 		f2fs_msg(sb, KERN_INFO,
-			"Try to recover %dth superblock, ret: %d",
-			sbi->valid_super_block ? 1 : 2, err);
+			"Try to recover all invalid superblocks, ret: %d", err);
 	}
 
+	if (test_opt(sbi, PER_DEV_SB) && !f2fs_sb_has_per_device_sb(sb)
+							&& sbi->s_ndevs > 1) {
+		err = build_device_sb_sections(sbi);
+		if (err) {
+			stop_gc_thread(sbi);
+			goto free_meta;
+		}
+		f2fs_msg(sb, KERN_INFO,
+			"Per-device superblock sections created");
+	}
+
+	if (sbi->s_ndevs > 1 && f2fs_sb_has_per_device_sb(sb))
+		set_per_device_sb_sentries(sbi);
+
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Mounted with checkpoint version = %llx",
 				cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
@@ -2750,10 +2862,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
+	kfree(sbi->ckpt);
 free_devices:
 	destroy_device_list(sbi);
-	kfree(sbi->ckpt);
-free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 free_io_dummy:
-- 
2.5.0
