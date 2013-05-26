From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: add sysfs support for controlling the
	gc_thread
Date: Sun, 26 May 2013 11:05:45 +0900
Message-ID: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UgQLQ-0002xR-AA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 02:06:00 +0000
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UgQLO-0007UD-QB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 May 2013 02:06:00 +0000
Received: by mail-pa0-f44.google.com with SMTP id wp1so3050504pac.31
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 May 2013 19:05:53 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

Add sysfs entries to control the timing parameters for
f2fs gc thread and also provide a control flag, which will
allow the user to forcefully start a FG garbage collection
if required.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/f2fs.h  |    6 +++
 fs/f2fs/gc.c    |   20 +++++---
 fs/f2fs/gc.h    |   33 +++++++------
 fs/f2fs/super.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 00c8c5f..40abd81 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -400,6 +400,8 @@ struct f2fs_sb_info {
 	struct mutex gc_mutex;			/* mutex for GC */
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
+	unsigned int forced_fg;			/* forced forgound gc */
+
 
 	/*
 	 * for stat information.
@@ -415,6 +417,10 @@ struct f2fs_sb_info {
 #endif
 	unsigned int last_victim[2];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
+
+	/* For sysfs suppport */
+	struct kobject s_kobj;
+	struct completion s_kobj_unregister;
 };
 
 /*
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ddc2c67..8041d70 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -29,10 +29,11 @@ static struct kmem_cache *winode_slab;
 static int gc_thread_func(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
+	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
 	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
 	long wait_ms;
 
-	wait_ms = GC_THREAD_MIN_SLEEP_TIME;
+	wait_ms = gc_th->min_sleep_time;
 
 	do {
 		if (try_to_freeze())
@@ -45,7 +46,7 @@ static int gc_thread_func(void *data)
 			break;
 
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
-			wait_ms = GC_THREAD_MAX_SLEEP_TIME;
+			wait_ms = gc_th->max_sleep_time;
 			continue;
 		}
 
@@ -66,15 +67,15 @@ static int gc_thread_func(void *data)
 			continue;
 
 		if (!is_idle(sbi)) {
-			wait_ms = increase_sleep_time(wait_ms);
+			wait_ms = increase_sleep_time(gc_th, wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
 			continue;
 		}
 
 		if (has_enough_invalid_blocks(sbi))
-			wait_ms = decrease_sleep_time(wait_ms);
+			wait_ms = decrease_sleep_time(gc_th, wait_ms);
 		else
-			wait_ms = increase_sleep_time(wait_ms);
+			wait_ms = increase_sleep_time(gc_th, wait_ms);
 
 #ifdef CONFIG_F2FS_STAT_FS
 		sbi->bg_gc++;
@@ -82,7 +83,7 @@ static int gc_thread_func(void *data)
 
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi))
-			wait_ms = GC_THREAD_NOGC_SLEEP_TIME;
+			wait_ms = gc_th->no_gc_sleep_time;
 	} while (!kthread_should_stop());
 	return 0;
 }
@@ -101,7 +102,12 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 		goto out;
 	}
 
+	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
+	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
+	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+
 	sbi->gc_thread = gc_th;
+
 	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
 	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
 			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
@@ -677,7 +683,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
 {
 	struct list_head ilist;
 	unsigned int segno, i;
-	int gc_type = BG_GC;
+	int gc_type = sbi->forced_fg ? FG_GC : BG_GC;
 	int nfree = 0;
 	int ret = -1;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 2c6a6bd..f4bf44c 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -13,9 +13,9 @@
 						 * whether IO subsystem is idle
 						 * or not
 						 */
-#define GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
-#define GC_THREAD_MAX_SLEEP_TIME	60000
-#define GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
+#define DEF_GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
+#define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
+#define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
@@ -25,6 +25,11 @@
 struct f2fs_gc_kthread {
 	struct task_struct *f2fs_gc_task;
 	wait_queue_head_t gc_wait_queue_head;
+
+	/* for gc sleep time */
+	unsigned int min_sleep_time;
+	unsigned int max_sleep_time;
+	unsigned int no_gc_sleep_time;
 };
 
 struct inode_entry {
@@ -56,25 +61,25 @@ static inline block_t limit_free_user_blocks(struct f2fs_sb_info *sbi)
 	return (long)(reclaimable_user_blocks * LIMIT_FREE_BLOCK) / 100;
 }
 
-static inline long increase_sleep_time(long wait)
+static inline long increase_sleep_time(struct f2fs_gc_kthread *gc_th, long wait)
 {
-	if (wait == GC_THREAD_NOGC_SLEEP_TIME)
+	if (wait == gc_th->no_gc_sleep_time)
 		return wait;
 
-	wait += GC_THREAD_MIN_SLEEP_TIME;
-	if (wait > GC_THREAD_MAX_SLEEP_TIME)
-		wait = GC_THREAD_MAX_SLEEP_TIME;
+	wait += gc_th->min_sleep_time;
+	if (wait > gc_th->max_sleep_time)
+		wait = gc_th->max_sleep_time;
 	return wait;
 }
 
-static inline long decrease_sleep_time(long wait)
+static inline long decrease_sleep_time(struct f2fs_gc_kthread *gc_th, long wait)
 {
-	if (wait == GC_THREAD_NOGC_SLEEP_TIME)
-		wait = GC_THREAD_MAX_SLEEP_TIME;
+	if (wait == gc_th->no_gc_sleep_time)
+		wait = gc_th->max_sleep_time;
 
-	wait -= GC_THREAD_MIN_SLEEP_TIME;
-	if (wait <= GC_THREAD_MIN_SLEEP_TIME)
-		wait = GC_THREAD_MIN_SLEEP_TIME;
+	wait -= gc_th->min_sleep_time;
+	if (wait <= gc_th->min_sleep_time)
+		wait = gc_th->min_sleep_time;
 	return wait;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3ac305d..ef16d2c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -22,16 +22,20 @@
 #include <linux/exportfs.h>
 #include <linux/blkdev.h>
 #include <linux/f2fs_fs.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 #include "f2fs.h"
 #include "node.h"
 #include "segment.h"
 #include "xattr.h"
+#include "gc.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
 
 static struct kmem_cache *f2fs_inode_cachep;
+static struct kset *f2fs_kset;
 
 enum {
 	Opt_gc_background_off,
@@ -57,6 +61,136 @@ static match_table_t f2fs_tokens = {
 	{Opt_err, NULL},
 };
 
+/*Sysfs support for F2fs */
+struct f2fs_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
+	ssize_t (*store)(struct f2fs_attr *, struct f2fs_sb_info *,
+			 const char *, size_t);
+	int offset;
+};
+
+static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
+			   struct f2fs_sb_info *sbi, char *buf)
+{
+	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
+	unsigned int *ui = (unsigned int *) (((char *)gc_kth) + a->offset);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
+}
+
+static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
+			    struct f2fs_sb_info *sbi,
+			    const char *buf, size_t count)
+{
+	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
+	unsigned int *ui = (unsigned int *) (((char *)gc_kth) + a->offset);
+	unsigned long t;
+	ssize_t ret;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret < 0)
+		return ret;
+	*ui = t;
+	return count;
+}
+
+static ssize_t f2fs_forced_fg_trigger(struct f2fs_attr *a,
+					struct f2fs_sb_info *sbi,
+					const char *buf, size_t count)
+{
+	unsigned long t;
+	ssize_t ret;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret < 0)
+		return ret;
+	if (t == 0)
+		return count;
+	else if (t == 1) {
+		sbi->forced_fg = t;
+		mutex_lock(&sbi->gc_mutex);
+		f2fs_gc(sbi);
+		sbi->forced_fg = 0;
+	}
+
+	return count;
+}
+
+static ssize_t f2fs_forced_fg_show(struct f2fs_attr *a,
+					struct f2fs_sb_info *sbi,
+							char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", sbi->forced_fg);
+}
+
+static ssize_t f2fs_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->show ? a->show(a, sbi, buf) : 0;
+}
+
+static ssize_t f2fs_attr_store(struct kobject *kobj, struct attribute *attr,
+						const char *buf, size_t len)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+									s_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->store ? a->store(a, sbi, buf, len) : 0;
+}
+
+static void f2fs_sb_release(struct kobject *kobj)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_kobj);
+	complete(&sbi->s_kobj_unregister);
+}
+
+#define F2FS_ATTR_OFFSET(_name, _mode, _show, _store, _elname) \
+static struct f2fs_attr f2fs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
+	.offset = offsetof(struct f2fs_gc_kthread, _elname),	\
+}
+
+#define F2FS_ATTR(name, mode, show, store) \
+static struct f2fs_attr f2fs_attr_##name = __ATTR(name, mode, show, store)
+
+#define F2FS_RW_ATTR(name, elname)	\
+	F2FS_ATTR_OFFSET(name, 0644, f2fs_sbi_show, f2fs_sbi_store, elname)
+
+F2FS_RW_ATTR(gc_min_sleep_time, min_sleep_time);
+F2FS_RW_ATTR(gc_max_sleep_time, max_sleep_time);
+F2FS_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
+F2FS_ATTR(gc_forced_fg, 0644, f2fs_forced_fg_show, f2fs_forced_fg_trigger);
+
+#define ATTR_LIST(name) (&f2fs_attr_##name.attr)
+static struct attribute *f2fs_attrs[] = {
+	ATTR_LIST(gc_min_sleep_time),
+	ATTR_LIST(gc_max_sleep_time),
+	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_forced_fg),
+	NULL,
+};
+
+static const struct sysfs_ops f2fs_attr_ops = {
+	.show   = f2fs_attr_show,
+	.store  = f2fs_attr_store,
+};
+
+static struct kobj_type f2fs_ktype = {
+	.default_attrs  = f2fs_attrs,
+	.sysfs_ops      = &f2fs_attr_ops,
+	.release        = f2fs_sb_release,
+};
+
+
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -582,6 +716,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		mutex_init(&sbi->fs_lock[i]);
 	mutex_init(&sbi->node_write);
 	sbi->por_doing = 0;
+	sbi->forced_fg = 0;
 	spin_lock_init(&sbi->stat_lock);
 	init_rwsem(&sbi->bio_sem);
 	init_sb_info(sbi);
@@ -691,6 +826,14 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 					"the device does not support discard");
 	}
 
+	sbi->s_kobj.kset = f2fs_kset;
+	init_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
+							"%s", sb->s_id);
+	if (err)
+		goto fail;
+
+
 	return 0;
 fail:
 	stop_gc_thread(sbi);
@@ -765,6 +908,9 @@ static int __init init_f2fs_fs(void)
 	err = create_checkpoint_caches();
 	if (err)
 		goto fail;
+	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
+	if (!f2fs_kset)
+		goto fail;
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
 		goto fail;
@@ -781,6 +927,7 @@ static void __exit exit_f2fs_fs(void)
 	destroy_gc_caches();
 	destroy_node_manager_caches();
 	destroy_inodecache();
+	kset_unregister(f2fs_kset);
 }
 
 module_init(init_f2fs_fs)
-- 
1.7.9.5


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
