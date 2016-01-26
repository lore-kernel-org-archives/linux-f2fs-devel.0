From: Liu Shuoran <liushuoran@huawei.com>
Subject: [PATCH] f2fs: Introduce lifetime write IO statistics
Date: Tue, 26 Jan 2016 11:16:22 +0800
Message-ID: <1453778182-66323-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liushuoran@huawei.com>) id 1aNu7z-0007kw-6f
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 03:17:11 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aNu7v-0003wN-5V
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 03:17:11 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Shuoran Liu <liushuoran@huawei.com>

Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
Signed-off-by: Pengyang Hou <houpengyang@huawei.com>
---
 fs/f2fs/checkpoint.c    | 14 ++++++++++++++
 fs/f2fs/f2fs.h          |  4 ++++
 fs/f2fs/super.c         | 34 ++++++++++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |  6 ++++++
 4 files changed, 58 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3842af9..15dfce9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -921,6 +921,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	int cp_payload_blks = __cp_payload(sbi);
 	block_t discard_blk = NEXT_FREE_BLKADDR(sbi, curseg);
 	bool invalidate = false;
+	struct super_block *sb = sbi->sb;
+	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
+	__u64 kbytes_written;
+
 
 	/*
 	 * This avoids to conduct wrong roll-forward operations and uses
@@ -1034,6 +1038,16 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	write_data_summaries(sbi, start_blk);
 	start_blk += data_sum_blocks;
+
+	/* Record write statistics in HOT_NODE*/
+	kbytes_written = sbi->kbytes_written;
+	if (sb->s_bdev->bd_part)
+		kbytes_written +=
+			((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+				sbi->sectors_written_start) >> 1);
+
+	seg_i->sum_blk->info.kbytes_written = cpu_to_le64(kbytes_written);
+
 	if (__remain_node_summaries(cpc->reason)) {
 		write_node_summaries(sbi, start_blk);
 		start_blk += NR_CURSEG_NODE_TYPE;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ff79054..7b1b5ba 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -844,6 +844,10 @@ struct f2fs_sb_info {
 	struct list_head s_list;
 	struct mutex umount_mutex;
 	unsigned int shrinker_run_no;
+
+	/* For write statistics */
+	unsigned long sectors_written_start;
+	unsigned long long kbytes_written;
 };
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3bf990b..68674da 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -126,6 +126,20 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 	return NULL;
 }
 
+static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	struct super_block *sb = sbi->sb;
+
+	if (!sb->s_bdev->bd_part)
+		return snprintf(buf, PAGE_SIZE, "0\n");
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+		(unsigned long long)(sbi->kbytes_written +
+			((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			sbi->sectors_written_start) >> 1)));
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -204,6 +218,9 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 		f2fs_sbi_show, f2fs_sbi_store,			\
 		offsetof(struct struct_name, elname))
 
+#define F2FS_GENERAL_RO_ATTR(name) \
+static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
+
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
@@ -220,6 +237,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -239,6 +257,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ra_nid_pages),
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
+	ATTR_LIST(lifetime_write_kbytes),
 	NULL,
 };
 
@@ -766,6 +785,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
 
+	if (*flags & MS_RDONLY) {
+		set_opt(sbi, FASTBOOT);
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
+	}
+
 	sync_filesystem(sb);
 
 	/*
@@ -1242,6 +1266,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	bool retry = true, need_fsck = false;
 	char *options = NULL;
 	int recovery, i, valid_super_block;
+	struct curseg_info *seg_i;
 
 try_onemore:
 	err = -EINVAL;
@@ -1372,6 +1397,15 @@ try_onemore:
 		goto free_nm;
 	}
 
+	/* For write statistics */
+	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
+	if (sb->s_bdev->bd_part)
+		sbi->sectors_written_start =
+			part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+
+	if(__exist_node_summaries(sbi))
+		sbi->kbytes_written = le64_to_cpu(seg_i->sum_blk->info.kbytes_written);
+
 	build_gc_manager(sbi);
 
 	/* get an inode for node space */
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e59c3be..05ae034 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -387,6 +387,11 @@ struct sit_journal {
 	__u8 reserved[SIT_JOURNAL_RESERVED];
 } __packed;
 
+struct f2fs_extra_info {
+	__le64 kbytes_written;
+	__u8 reserved[SUM_JOURNAL_SIZE - 10];
+} __packed;
+
 /* 4KB-sized summary block structure */
 struct f2fs_summary_block {
 	struct f2fs_summary entries[ENTRIES_IN_SUM];
@@ -398,6 +403,7 @@ struct f2fs_summary_block {
 	union {
 		struct nat_journal nat_j;
 		struct sit_journal sit_j;
+		struct f2fs_extra_info info;
 	};
 	struct summary_footer footer;
 } __packed;
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
