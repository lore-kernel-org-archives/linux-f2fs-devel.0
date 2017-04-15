From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: add flush data in faster device to
	cold area
Date: Fri, 14 Apr 2017 17:16:10 -0700
Message-ID: <20170415001611.9059-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1czBO4-0000FV-No
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 00:16:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1czBO3-00079x-FQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 00:16:24 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch flushes data in faster device to cold area.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  6 ++++--
 fs/f2fs/file.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.c      | 19 ++++++++++++++-----
 fs/f2fs/segment.c | 14 ++++++++++----
 fs/f2fs/segment.h |  3 ++-
 5 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 562db8989a4e..f2b58ca86473 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -280,6 +280,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 #define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
 						struct f2fs_move_range)
+#define F2FS_IOC_FLUSH_DEVICE		_IO(F2FS_IOCTL_MAGIC, 10)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -941,7 +942,7 @@ struct f2fs_sb_info {
 	int bg_gc;				/* background gc calls */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
-	unsigned int last_victim[2];		/* last victim segment # */
+	unsigned int last_victim[3];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
 
 	/* For sysfs suppport */
@@ -2323,7 +2324,8 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 int start_gc_thread(struct f2fs_sb_info *sbi);
 void stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
-int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background);
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
+			unsigned int segno);
 void build_gc_manager(struct f2fs_sb_info *sbi);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0ac833dd2634..9d8f2126ebbb 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1855,7 +1855,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 		mutex_lock(&sbi->gc_mutex);
 	}
 
-	ret = f2fs_gc(sbi, sync, true);
+	ret = f2fs_gc(sbi, sync, true, 0);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2211,6 +2211,56 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 	return err;
 }
 
+static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int start_segno = 0, end_segno = 0;
+	__u32 dev_num;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(dev_num, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (sbi->s_ndevs <= 1 || sbi->s_ndevs - 1 <= dev_num) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "Can't flush %u in %d\n",
+				dev_num, sbi->s_ndevs);
+		return -EINVAL;
+	}
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	if (FDEV(dev_num).start_blk != 0)
+		start_segno = GET_SEGNO(sbi, FDEV(dev_num).start_blk);
+	end_segno = GET_SEGNO(sbi, FDEV(dev_num).end_blk);
+
+	while (start_segno++ < end_segno) {
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
@@ -2248,6 +2298,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
 		return f2fs_ioc_move_range(filp, arg);
+	case F2FS_IOC_FLUSH_DEVICE:
+		return f2fs_ioc_flush_device(filp, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9172112d6246..834d3b641b88 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -84,7 +84,7 @@ static int gc_thread_func(void *data)
 		stat_inc_bggc_count(sbi);
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true))
+		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, 0))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
@@ -308,6 +308,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	p.min_segno = NULL_SEGNO;
 	p.min_cost = get_max_cost(sbi, &p);
 
+	if (*result) {
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
+			segno = 0;
 			goto gc_more;
+		}
 
 		if (gc_type == FG_GC)
 			ret = write_checkpoint(sbi, &cpc);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58cfbe3d4dc7..a9624cdb6db2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -401,7 +401,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		mutex_lock(&sbi->gc_mutex);
-		f2fs_gc(sbi, false, false);
+		f2fs_gc(sbi, false, false, 0);
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
index 5f6ef163aa8f..155c53b79992 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -138,7 +138,8 @@ enum {
  */
 enum {
 	GC_CB = 0,
-	GC_GREEDY
+	GC_GREEDY,
+	ALLOC_NEXT,
 };
 
 /*
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
