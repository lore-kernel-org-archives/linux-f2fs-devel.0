From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: add ioctl to flush data from faster device to cold area
Date: Tue, 18 Apr 2017 18:45:18 -0700
Message-ID: <20170419014520.12536-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds an ioctl to flush data in faster device to cold area. User can
give device number and number of segments to move. It doesn't move it if there
is only one device.

The parameter looks like:

struct f2fs_flush_device {
	u32 dev_num;		/* device number to flush */
	u32 segments;		/* # of segments to flush */
};

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    | 12 ++++++++--
 fs/f2fs/file.c    | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/gc.c      | 19 +++++++++++-----
 fs/f2fs/segment.c | 14 ++++++++----
 fs/f2fs/segment.h |  4 +++-
 5 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 562db8989a4e..c28e8e7d6a5f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -280,6 +280,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 #define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
 						struct f2fs_move_range)
+#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
+						struct f2fs_flush_device)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -316,6 +318,11 @@ struct f2fs_move_range {
 	u64 len;		/* size to move */
 };
 
+struct f2fs_flush_device {
+	u32 dev_num;		/* device number to flush */
+	u32 segments;		/* # of segments to flush */
+};
+
 /*
  * For INODE and NODE manager
  */
@@ -941,7 +948,7 @@ struct f2fs_sb_info {
 	int bg_gc;				/* background gc calls */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
-	unsigned int last_victim[2];		/* last victim segment # */
+	unsigned int last_victim[4];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
 
 	/* For sysfs suppport */
@@ -2323,7 +2330,8 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 int start_gc_thread(struct f2fs_sb_info *sbi);
 void stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
-int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background);
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
+			unsigned int segno);
 void build_gc_manager(struct f2fs_sb_info *sbi);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0ac833dd2634..561ecb46007b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1855,7 +1855,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 		mutex_lock(&sbi->gc_mutex);
 	}
 
-	ret = f2fs_gc(sbi, sync, true);
+	ret = f2fs_gc(sbi, sync, true, NULL_SEGNO);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2211,6 +2211,67 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 	return err;
 }
 
+static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int start_segno = 0, end_segno = 0;
+	unsigned int dev_start_segno = 0, dev_end_segno = 0;
+	struct f2fs_flush_device range;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
+							sizeof(range)))
+		return -EFAULT;
+
+	if (sbi->s_ndevs <= 1 || sbi->s_ndevs - 1 <= range.dev_num) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "Can't flush %u in %d\n",
+				range.dev_num, sbi->s_ndevs);
+		return -EINVAL;
+	}
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	if (range.dev_num != 0)
+		dev_start_segno = GET_SEGNO(sbi, FDEV(range.dev_num).start_blk);
+	dev_end_segno = GET_SEGNO(sbi, FDEV(range.dev_num).end_blk);
+
+	start_segno = sbi->last_victim[FLUSH_DEVICE];
+	if (start_segno < dev_start_segno || start_segno >= dev_end_segno)
+		start_segno = dev_start_segno;
+	end_segno = min(start_segno + range.segments, dev_end_segno);
+
+	while (start_segno < end_segno) {
+		if (!mutex_trylock(&sbi->gc_mutex)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		sbi->last_victim[GC_CB] = end_segno + 1;
+		sbi->last_victim[GC_GREEDY] = end_segno + 1;
+		sbi->last_victim[ALLOC_NEXT] = end_segno + 1;
+		ret = f2fs_gc(sbi, true, true, start_segno);
+		sbi->last_victim[ALLOC_NEXT] = 0;
+		if (ret == -EAGAIN)
+			ret = 0;
+		else if (ret < 0)
+			break;
+		start_segno++;
+	}
+	sbi->last_victim[FLUSH_DEVICE] = start_segno;
+out:
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -2248,6 +2309,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
 		return f2fs_ioc_move_range(filp, arg);
+	case F2FS_IOC_FLUSH_DEVICE:
+		return f2fs_ioc_flush_device(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -2315,8 +2378,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GARBAGE_COLLECT:
 	case F2FS_IOC_WRITE_CHECKPOINT:
 	case F2FS_IOC_DEFRAGMENT:
-		break;
 	case F2FS_IOC_MOVE_RANGE:
+	case F2FS_IOC_FLUSH_DEVICE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9172112d6246..d988c1aaf132 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -84,7 +84,7 @@ static int gc_thread_func(void *data)
 		stat_inc_bggc_count(sbi);
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true))
+		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, NULL_SEGNO))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
@@ -308,6 +308,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_segno = NULL_SEGNO;
 	p.min_cost = get_max_cost(sbi, &p);
 
+	if (*result != NULL_SEGNO) {
+		if (IS_DATASEG(get_seg_entry(sbi, *result)->type) &&
+			get_valid_blocks(sbi, *result, false) &&
+			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
+			p.min_segno = *result;
+		goto out;
+	}
+
 	if (p.max_search == 0)
 		goto out;
 
@@ -912,7 +920,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		 *   - mutex_lock(sentry_lock)     - change_curseg()
 		 *                                  - lock_page(sum_page)
 		 */
-
 		if (type == SUM_TYPE_NODE)
 			gc_node_segment(sbi, sum->entries, segno, gc_type);
 		else
@@ -939,9 +946,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	return sec_freed;
 }
 
-int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
+			bool background, unsigned int segno)
 {
-	unsigned int segno;
 	int gc_type = sync ? FG_GC : BG_GC;
 	int sec_freed = 0;
 	int ret = -EINVAL;
@@ -990,8 +997,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (!sync) {
-		if (has_not_enough_free_secs(sbi, sec_freed, 0))
+		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
+			segno = NULL_SEGNO;
 			goto gc_more;
+		}
 
 		if (gc_type == FG_GC)
 			ret = write_checkpoint(sbi, &cpc);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58cfbe3d4dc7..88489d3156ab 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -401,7 +401,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		mutex_lock(&sbi->gc_mutex);
-		f2fs_gc(sbi, false, false);
+		f2fs_gc(sbi, false, false, NULL_SEGNO);
 	}
 }
 
@@ -1566,6 +1566,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		return 0;
 
+	if (sbi->last_victim[ALLOC_NEXT])
+		return sbi->last_victim[ALLOC_NEXT];
 	return CURSEG_I(sbi, type)->segno;
 }
 
@@ -1663,12 +1665,15 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
+	unsigned segno = 0;
 	int i, cnt;
 	bool reversed = false;
 
 	/* need_SSR() already forces to do this */
-	if (v_ops->get_victim(sbi, &(curseg)->next_segno, BG_GC, type, SSR))
+	if (v_ops->get_victim(sbi, &segno, BG_GC, type, SSR)) {
+		curseg->next_segno = segno;
 		return 1;
+	}
 
 	/* For node segments, let's do SSR more intensively */
 	if (IS_NODESEG(type)) {
@@ -1692,9 +1697,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 	for (; cnt-- > 0; reversed ? i-- : i++) {
 		if (i == type)
 			continue;
-		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
-						BG_GC, i, SSR))
+		if (v_ops->get_victim(sbi, &segno, BG_GC, i, SSR)) {
+			curseg->next_segno = segno;
 			return 1;
+		}
 	}
 	return 0;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5f6ef163aa8f..1d35f8d298cd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -138,7 +138,9 @@ enum {
  */
 enum {
 	GC_CB = 0,
-	GC_GREEDY
+	GC_GREEDY,
+	ALLOC_NEXT,
+	FLUSH_DEVICE,
 };
 
 /*
-- 
2.11.0
