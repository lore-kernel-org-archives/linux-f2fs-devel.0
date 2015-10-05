From: Chao Yu <yuchaochina@hotmail.com>
Subject: [PATCH 3/4] f2fs: support synchronous gc in ioctl
Date: Mon, 5 Oct 2015 22:22:44 +0800
Message-ID: <COL402-EAS157E5EBA298E70844BA617CAB480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1Zj6gu-0002Ei-Tj
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:24:36 +0000
Received: from col004-omc1s15.hotmail.com ([65.55.34.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zj6gt-00061V-PP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:24:36 +0000
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch drops in batches gc triggered through ioctl, since user
can easily control the gc by designing the loop around the ->ioctl.

We support synchronous gc by forcing using FG_GC in f2fs_gc, so with
it, user can make sure that in this round all blocks gced were
persistent in the device until ioctl returned.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    | 22 +++++++++-------------
 fs/f2fs/gc.c      | 21 +++++++++++++--------
 fs/f2fs/gc.h      |  6 ------
 fs/f2fs/segment.c |  2 +-
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1fa0555..1b2fc23 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1830,7 +1830,7 @@ int f2fs_release_page(struct page *, gfp_t);
 int start_gc_thread(struct f2fs_sb_info *);
 void stop_gc_thread(struct f2fs_sb_info *);
 block_t start_bidx_of_node(unsigned int, struct f2fs_inode_info *);
-int f2fs_gc(struct f2fs_sb_info *);
+int f2fs_gc(struct f2fs_sb_info *, bool);
 void build_gc_manager(struct f2fs_sb_info *);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a350c2a..c269966 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1618,29 +1618,25 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	__u32 i, count;
+	__u32 sync;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (get_user(count, (__u32 __user *)arg))
+	if (get_user(sync, (__u32 __user *)arg))
 		return -EFAULT;
 
-	if (!count || count > F2FS_BATCH_GC_MAX_NUM)
-		return -EINVAL;
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
 
-	for (i = 0; i < count; i++) {
+	if (!sync) {
 		if (!mutex_trylock(&sbi->gc_mutex))
-			break;
-
-		if (f2fs_gc(sbi))
-			break;
+			return -EBUSY;
+	} else {
+		mutex_lock(&sbi->gc_mutex);
 	}
 
-	if (put_user(i, (__u32 __user *)arg))
-		return -EFAULT;
-
-	return 0;
+	return f2fs_gc(sbi, sync);
 }
 
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d844a80..830d277 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -78,7 +78,7 @@ static int gc_thread_func(void *data)
 		stat_inc_bggc_count(sbi);
 
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi))
+		if (f2fs_gc(sbi, false))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		/* balancing f2fs's metadata periodically */
@@ -803,12 +803,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int
segno,
 	return nfree;
 }
 
-int f2fs_gc(struct f2fs_sb_info *sbi)
+int f2fs_gc(struct f2fs_sb_info *sbi, bool sync)
 {
 	unsigned int segno, i;
-	int gc_type = BG_GC;
+	int gc_type = sync ? FG_GC : BG_GC;
 	int sec_freed = 0;
-	int ret = -1;
+	int ret = -EINVAL;
 	struct cp_control cpc;
 	struct gc_inode_list gc_list = {
 		.ilist = LIST_HEAD_INIT(gc_list.ilist),
@@ -855,15 +855,20 @@ gc_more:
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (has_not_enough_free_secs(sbi, sec_freed))
-		goto gc_more;
+	if (!sync) {
+		if (has_not_enough_free_secs(sbi, sec_freed))
+			goto gc_more;
 
-	if (gc_type == FG_GC)
-		write_checkpoint(sbi, &cpc);
+		if (gc_type == FG_GC)
+			write_checkpoint(sbi, &cpc);
+	}
 stop:
 	mutex_unlock(&sbi->gc_mutex);
 
 	put_gc_inode(&gc_list);
+
+	if (sync)
+		ret = sec_freed ? 0 : -EAGAIN;
 	return ret;
 }
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index c5a055b..b4a65be 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -19,12 +19,6 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
-/*
- * with this macro, we can control the max time we do garbage collection,
- * when user triggers batch mode gc by ioctl.
- */
-#define F2FS_BATCH_GC_MAX_NUM		16
-
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0ceff28..6b8edf2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -295,7 +295,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi)
 	 */
 	if (has_not_enough_free_secs(sbi, 0)) {
 		mutex_lock(&sbi->gc_mutex);
-		f2fs_gc(sbi);
+		f2fs_gc(sbi, false);
 	}
 }
 
-- 
2.5.3


------------------------------------------------------------------------------
