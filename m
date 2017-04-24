From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3 v2] f2fs: add ioctl to flush data from
 faster device to cold area
Date: Mon, 24 Apr 2017 12:59:57 -0700
Message-ID: <20170424195957.GA1200@jaegeuk.local>
References: <20170419014520.12536-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d2k9Y-0000P2-9q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 20:00:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d2k9W-0006aG-RA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Apr 2017 20:00:08 +0000
Content-Disposition: inline
In-Reply-To: <20170419014520.12536-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Change log from v1:
 - move last_victim[] into sit_info
 - change last_victim[] under gc_mutex

>From e066b83c9b40f3a6951fb693ef0943fa1dfc40c2 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 13 Apr 2017 15:17:00 -0700
Subject: [PATCH] f2fs: add ioctl to flush data from faster device to cold area

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
 fs/f2fs/f2fs.h    | 11 +++++++--
 fs/f2fs/file.c    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/gc.c      | 42 ++++++++++++++++++++++-----------
 fs/f2fs/segment.c | 14 +++++++----
 fs/f2fs/segment.h |  7 +++++-
 5 files changed, 120 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 58d288e596a7..59a08e73f194 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -300,6 +300,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 #define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
 						struct f2fs_move_range)
+#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
+						struct f2fs_flush_device)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -336,6 +338,11 @@ struct f2fs_move_range {
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
@@ -980,7 +987,6 @@ struct f2fs_sb_info {
 	int bg_gc;				/* background gc calls */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
-	unsigned int last_victim[2];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
 
 	/* For sysfs suppport */
@@ -2362,7 +2368,8 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 int start_gc_thread(struct f2fs_sb_info *sbi);
 void stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
-int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background);
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
+			unsigned int segno);
 void build_gc_manager(struct f2fs_sb_info *sbi);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0ccc8cf70e7a..32050f4c3592 100644
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
@@ -2211,6 +2211,69 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 	return err;
 }
 
+static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct sit_info *sm = SIT_I(sbi);
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
+	if (sbi->s_ndevs <= 1 || sbi->s_ndevs - 1 <= range.dev_num ||
+			sbi->segs_per_sec != 1) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"Can't flush %u in %d for segs_per_sec %u != 1\n",
+				range.dev_num, sbi->s_ndevs,
+				sbi->segs_per_sec);
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
+	start_segno = sm->last_victim[FLUSH_DEVICE];
+	if (start_segno < dev_start_segno || start_segno >= dev_end_segno)
+		start_segno = dev_start_segno;
+	end_segno = min(start_segno + range.segments, dev_end_segno);
+
+	while (start_segno < end_segno) {
+		if (!mutex_trylock(&sbi->gc_mutex)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		sm->last_victim[GC_CB] = end_segno + 1;
+		sm->last_victim[GC_GREEDY] = end_segno + 1;
+		sm->last_victim[ALLOC_NEXT] = end_segno + 1;
+		ret = f2fs_gc(sbi, true, true, start_segno);
+		if (ret == -EAGAIN)
+			ret = 0;
+		else if (ret < 0)
+			break;
+		start_segno++;
+	}
+out:
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -2248,6 +2311,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
 		return f2fs_ioc_move_range(filp, arg);
+	case F2FS_IOC_FLUSH_DEVICE:
+		return f2fs_ioc_flush_device(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -2315,8 +2380,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
index 9172112d6246..74a10b7675f5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -84,7 +84,7 @@ static int gc_thread_func(void *data)
 		stat_inc_bggc_count(sbi);
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true))
+		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, NULL_SEGNO))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
@@ -176,7 +176,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		p->offset = 0;
 	else
-		p->offset = sbi->last_victim[p->gc_mode];
+		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
 }
 
 static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
@@ -295,6 +295,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		unsigned int *result, int gc_type, int type, char alloc_mode)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	struct sit_info *sm = SIT_I(sbi);
 	struct victim_sel_policy p;
 	unsigned int secno, last_victim;
 	unsigned int last_segment = MAIN_SEGS(sbi);
@@ -308,10 +309,18 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
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
 
-	last_victim = sbi->last_victim[p.gc_mode];
+	last_victim = sm->last_victim[p.gc_mode];
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
 		if (p.min_segno != NULL_SEGNO)
@@ -324,9 +333,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 
 		segno = find_next_bit(p.dirty_segmap, last_segment, p.offset);
 		if (segno >= last_segment) {
-			if (sbi->last_victim[p.gc_mode]) {
-				last_segment = sbi->last_victim[p.gc_mode];
-				sbi->last_victim[p.gc_mode] = 0;
+			if (sm->last_victim[p.gc_mode]) {
+				last_segment =
+					sm->last_victim[p.gc_mode];
+				sm->last_victim[p.gc_mode] = 0;
 				p.offset = 0;
 				continue;
 			}
@@ -361,11 +371,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 next:
 		if (nsearched >= p.max_search) {
-			if (!sbi->last_victim[p.gc_mode] && segno <= last_victim)
-				sbi->last_victim[p.gc_mode] = last_victim + 1;
+			if (!sm->last_victim[p.gc_mode] && segno <= last_victim)
+				sm->last_victim[p.gc_mode] = last_victim + 1;
 			else
-				sbi->last_victim[p.gc_mode] = segno + 1;
-			sbi->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
+				sm->last_victim[p.gc_mode] = segno + 1;
+			sm->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
 			break;
 		}
 	}
@@ -912,7 +922,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		 *   - mutex_lock(sentry_lock)     - change_curseg()
 		 *                                  - lock_page(sum_page)
 		 */
-
 		if (type == SUM_TYPE_NODE)
 			gc_node_segment(sbi, sum->entries, segno, gc_type);
 		else
@@ -939,13 +948,14 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
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
 	struct cp_control cpc;
+	unsigned int init_segno = segno;
 	struct gc_inode_list gc_list = {
 		.ilist = LIST_HEAD_INIT(gc_list.ilist),
 		.iroot = RADIX_TREE_INIT(GFP_NOFS),
@@ -990,13 +1000,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
 	if (!sync) {
-		if (has_not_enough_free_secs(sbi, sec_freed, 0))
+		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
+			segno = NULL_SEGNO;
 			goto gc_more;
+		}
 
 		if (gc_type == FG_GC)
 			ret = write_checkpoint(sbi, &cpc);
 	}
 stop:
+	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
+	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
 	mutex_unlock(&sbi->gc_mutex);
 
 	put_gc_inode(&gc_list);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dd07c5c91ac4..1b16770f9d2e 100644
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
 
@@ -1755,6 +1755,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		return 0;
 
+	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
+		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
 	return CURSEG_I(sbi, type)->segno;
 }
 
@@ -1852,12 +1854,15 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
+	unsigned segno = NULL_SEGNO;
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
@@ -1881,9 +1886,10 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
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
index 3cd780a42f51..93cc4e504aab 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -138,7 +138,10 @@ enum {
  */
 enum {
 	GC_CB = 0,
-	GC_GREEDY
+	GC_GREEDY,
+	ALLOC_NEXT,
+	FLUSH_DEVICE,
+	MAX_GC_POLICY,
 };
 
 /*
@@ -233,6 +236,8 @@ struct sit_info {
 	unsigned long long mounted_time;	/* mount time */
 	unsigned long long min_mtime;		/* min. modification time */
 	unsigned long long max_mtime;		/* max. modification time */
+
+	unsigned int last_victim[MAX_GC_POLICY]; /* last victim segment # */
 };
 
 struct free_segmap_info {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
