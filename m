From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: sync/umount hang on 3.18.21, 1.4TB gone after crash
Date: Fri, 25 Sep 2015 17:13:16 +0800
Message-ID: <01be01d0f772$821c2780$86547680$@samsung.com>
References: <20150923215850.GC2360@schmorp.de>
	<20150924185023.GE40291@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZfP50-0004YM-Ln
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 09:14:10 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfP4x-0002Pd-EO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 09:14:10 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NV801XCG6ZC4E20@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 18:14:00 +0900 (KST)
In-reply-to: <20150924185023.GE40291@jaegeuk-mac02>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Marc Lehmann' <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, September 25, 2015 2:50 AM
> To: Marc Lehmann
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] sync/umount hang on 3.18.21, 1.4TB gone after crash
> 
> On Wed, Sep 23, 2015 at 11:58:51PM +0200, Marc Lehmann wrote:
> > Hi!
> >
> > I moved one of the SMR disks to another box with a 3.18.21 kernel.
> >
> > I formatted and mounted like this:
> >
> >    /opt/f2fs-tools/sbin/mkfs.f2fs -lTEST -s90 -t0 -a0 /dev/vg_test/test
> >    mount -t f2fs -onoatime,flush_merge,no_heap /dev/vg_test/test /mnt
> >
> > I then copied (tar | tar) 2.1TB of data to the disk, which took about 6
> > hours, which is about the read speed of this data set (so the speed was very
> > good).
> >
> > When I came back after ~10 hours, I found a number of hung task messages
> > in syslog, and when I entered sync, sync was consuming 100% system time.
> 
> Hmm, at this time, it would be good to check what process is stuck through
> sysrq.
> 
> > I took a snapshot of /sys/kernel/debug/f2fs/status before sync, and the
> > values arfe "frozen", i.e. they didn't change.
> >
> > I was able to read from the mounted filesystem normally, and I was able to
> > read and write the block device itself, so the disk is responsive.
> >
> > After ~1h in this state, I tried to umount, which made the filesystem
> > mountpoint go away, but umount hangs, and /sys/kernel/debug/f2fs/status still
> > doesn't change.
> >
> > This is the output of /sys/kernel/debug/f2fs/status:
> >
> > http://ue.tst.eu/d88ce0e21a7ca0fb74b1ecadfa475df0.txt
> >
> > I then deleted the device, but the echo 1 >/sys/block/sde/device/delete was
> > also hanging.
> >
> > Here are /proc/.../stack outputs of sync, umount and bash(echo):
> >
> >    sync:
> >    [<ffffffffffffffff>] 0xffffffffffffffff
> >
> >    umount:
> >    [<ffffffff8139ba03>] call_rwsem_down_write_failed+0x13/0x20
> >    [<ffffffff811e7ee6>] deactivate_super+0x46/0x70
> >    [<ffffffff81204733>] cleanup_mnt+0x43/0x90
> >    [<ffffffff812047d2>] __cleanup_mnt+0x12/0x20
> >    [<ffffffff8108e8a4>] task_work_run+0xc4/0xe0
> >    [<ffffffff81012fa7>] do_notify_resume+0x97/0xb0
> >    [<ffffffff8178896f>] int_signal+0x12/0x17
> >    [<ffffffffffffffff>] 0xffffffffffffffff
> >
> >    bash (delete):
> >    [<ffffffff810d8917>] msleep+0x37/0x50
> >    [<ffffffff8135d686>] __blk_drain_queue+0xa6/0x1a0
> >    [<ffffffff8135da05>] blk_cleanup_queue+0x1b5/0x1c0
> >    [<ffffffff8152082a>] __scsi_remove_device+0x5a/0xe0
> >    [<ffffffff815208d6>] scsi_remove_device+0x26/0x40
> >    [<ffffffff81520917>] sdev_store_delete+0x27/0x30
> >    [<ffffffff814bf748>] dev_attr_store+0x18/0x30
> >    [<ffffffff8125bc4d>] sysfs_kf_write+0x3d/0x50
> >    [<ffffffff8125b154>] kernfs_fop_write+0xe4/0x160
> >    [<ffffffff811e51a7>] vfs_write+0xb7/0x1f0
> >    [<ffffffff811e5c26>] SyS_write+0x46/0xb0
> >    [<ffffffff817886cd>] system_call_fastpath+0x16/0x1b
> >    [<ffffffffffffffff>] 0xffffffffffffffff
> >
> > After a forced reboot, I did a fsck, and got this, which looks good except
> > for the "Wrong segment type" message, which hopefully is harmless.
> >
> > http://ue.tst.eu/4c750d2301a581cb07249d607aa0e6d0.txt
> >
> > After mounting, status was this (and was changing):
> >
> > http://ue.tst.eu/6462606ac3aa85bde0d6674365c86318.txt
> >
> > Note that 1.4TB of data are missing(!)
> >
> > This large amount of missing data was certainly unexpected. I assume f2fs
> > stopped checkpointing earlier, and only after a checkpoint the data is
> > safe, but being able to write 1.4TB of data without it ever reaching the
> > disk is very unexpected behaviour for a filesystem (which normally loses
> > about half a minute of data at most).
> 
> It seems there was no fsync after sync at all. That's why f2fs recovered back to
> the latest checkpoint. Anyway, I'm thinking that it's worth to add a kind of
> periodic checkpoints.

Agree, I have that in my mind for long time, since Yunlei said that they
may lost all data of new generated photos after an abnormal poweroff, I
wrote the below patch, but I have not much time to test and tuned up with
it.

I hope if you have time, we can discuss the implementation of periodic cp.
Maybe in another thread. :)

>From c81c03fb69612350b12a14bccc07a1fd95cf606b Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Wed, 5 Aug 2015 22:58:54 +0800
Subject: [PATCH] f2fs: support background data flush

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h  |  15 +++++++++
 fs/f2fs/inode.c |  16 +++++++++
 fs/f2fs/namei.c |   7 ++++
 fs/f2fs/super.c |  50 ++++++++++++++++++++++++++--
 5 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a82abe9..39b6339 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -20,6 +20,8 @@
 #include <linux/prefetch.h>
 #include <linux/uio.h>
 #include <linux/cleancache.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -27,6 +29,104 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
+static void f2fs_do_data_flush(struct f2fs_sb_info *sbi)
+{
+	struct list_head *inode_list = &sbi->inode_list;
+	struct f2fs_inode_info *fi, *tmp;
+	struct inode *inode;
+	unsigned int number;
+
+	spin_lock(&sbi->inode_lock);
+	number = sbi->inode_num;
+	list_for_each_entry_safe(fi, tmp, inode_list, i_flush) {
+
+		if (number-- == 0)
+			break;
+
+		inode = &fi->vfs_inode;
+
+		/*
+		 * If the inode is in evicting path, we will fail to igrab
+		 * inode since I_WILL_FREE or I_FREEING should be set in
+		 * inode, so after grab valid inode, it's safe to flush
+		 * dirty page after unlock inode_lock.
+		 */
+		inode = igrab(inode);
+		if (!inode)
+			continue;
+
+		spin_unlock(&sbi->inode_lock);
+
+		if (!get_dirty_pages(inode))
+			goto next;
+
+		filemap_flush(inode->i_mapping);
+next:
+		iput(inode);
+		spin_lock(&sbi->inode_lock);
+	}
+	spin_unlock(&sbi->inode_lock);
+}
+
+static int f2fs_data_flush_thread(void *data)
+{
+	struct f2fs_sb_info *sbi = data;
+	wait_queue_head_t *wq = &sbi->dflush_wait_queue;
+	struct cp_control cpc;
+	unsigned long wait_time;
+
+	wait_time = sbi->wait_time;
+
+	do {
+		if (try_to_freeze())
+			continue;
+		else
+			wait_event_interruptible_timeout(*wq,
+						kthread_should_stop(),
+						msecs_to_jiffies(wait_time));
+		if (kthread_should_stop())
+			break;
+
+		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE)
+			continue;
+
+		mutex_lock(&sbi->gc_mutex);
+
+		f2fs_do_data_flush(sbi);
+
+		cpc.reason = __get_cp_reason(sbi);
+		write_checkpoint(sbi, &cpc);
+
+		mutex_unlock(&sbi->gc_mutex);
+
+	} while (!kthread_should_stop());
+	return 0;
+}
+
+int start_data_flush_thread(struct f2fs_sb_info *sbi)
+{
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	int err = 0;
+
+	init_waitqueue_head(&sbi->dflush_wait_queue);
+	sbi->data_flush_thread = kthread_run(f2fs_data_flush_thread, sbi,
+			"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
+	if (IS_ERR(sbi->data_flush_thread)) {
+		err = PTR_ERR(sbi->data_flush_thread);
+		sbi->data_flush_thread = NULL;
+	}
+
+	return err;
+}
+
+void stop_data_flush_thread(struct f2fs_sb_info *sbi)
+{
+	if (!sbi->data_flush_thread)
+		return;
+	kthread_stop(sbi->data_flush_thread);
+	sbi->data_flush_thread = NULL;
+}
+
 static void f2fs_read_end_io(struct bio *bio)
 {
 	struct bio_vec *bvec;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1a90ff..b6790c9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -52,6 +52,7 @@
 #define F2FS_MOUNT_NOBARRIER		0x00000800
 #define F2FS_MOUNT_FASTBOOT		0x00001000
 #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
+#define F2FS_MOUNT_DATA_FLUSH		0X00004000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -322,6 +323,8 @@ enum {
 					 */
 };
 
+#define DEF_DATA_FLUSH_DELAY_TIME	5000	/* delay time of data flush */
+
 #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
 
 #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
@@ -436,6 +439,8 @@ struct f2fs_inode_info {
 
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
 
+	struct list_head i_flush;	/* link in inode_list of sbi */
+
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	/* Encryption params */
 	struct f2fs_crypt_info *i_crypt_info;
@@ -808,6 +813,14 @@ struct f2fs_sb_info {
 	struct list_head s_list;
 	struct mutex umount_mutex;
 	unsigned int shrinker_run_no;
+
+	/* For data flush support */
+	struct task_struct *data_flush_thread;	/* data flush task */
+	wait_queue_head_t dflush_wait_queue;	/* data flush wait queue */
+	unsigned long wait_time;		/* wait time for flushing */
+	struct list_head inode_list;		/* link all inmem inode */
+	spinlock_t inode_lock;			/* protect inode list */
+	unsigned int inode_num;			/* inode number in inode_list */
 };
 
 /*
@@ -1780,6 +1793,8 @@ void destroy_checkpoint_caches(void);
 /*
  * data.c
  */
+int start_data_flush_thread(struct f2fs_sb_info *);
+void stop_data_flush_thread(struct f2fs_sb_info *);
 void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 35aae65..6bf22ad 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -158,6 +158,13 @@ static int do_read_inode(struct inode *inode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
+	if (S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) {
+		spin_lock(&sbi->inode_lock);
+		list_add_tail(&fi->i_flush, &sbi->inode_list);
+		sbi->inode_num++;
+		spin_unlock(&sbi->inode_lock);
+	}
+
 	return 0;
 }
 
@@ -335,6 +342,15 @@ void f2fs_evict_inode(struct inode *inode)
 
 	f2fs_destroy_extent_tree(inode);
 
+	if (S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) {
+		spin_lock(&sbi->inode_lock);
+		if (!list_empty(&fi->i_flush)) {
+			list_del(&fi->i_flush);
+			sbi->inode_num--;
+		}
+		spin_unlock(&sbi->inode_lock);
+	}
+
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a680bf3..f639e96 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -71,6 +71,13 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
+	if (S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) {
+		spin_lock(&sbi->inode_lock);
+		list_add_tail(&F2FS_I(inode)->i_flush, &sbi->inode_list);
+		sbi->inode_num++;
+		spin_unlock(&sbi->inode_lock);
+	}
+
 	trace_f2fs_new_inode(inode, 0);
 	mark_inode_dirty(inode);
 	return inode;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f794781..286cdb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -67,6 +67,7 @@ enum {
 	Opt_extent_cache,
 	Opt_noextent_cache,
 	Opt_noinline_data,
+	Opt_data_flush,
 	Opt_err,
 };
 
@@ -91,6 +92,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_extent_cache, "extent_cache"},
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
+	{Opt_data_flush, "data_flush"},
 	{Opt_err, NULL},
 };
 
@@ -215,6 +217,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, wait_time, wait_time);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -231,6 +234,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
+	ATTR_LIST(wait_time),
 	NULL,
 };
 
@@ -397,6 +401,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
 			break;
+		case Opt_data_flush:
+			set_opt(sbi, DATA_FLUSH);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -434,6 +441,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 
+	INIT_LIST_HEAD(&fi->i_flush);
+
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
 #endif
@@ -514,6 +523,8 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 	kobject_del(&sbi->s_kobj);
 
+	stop_data_flush_thread(sbi);
+
 	stop_gc_thread(sbi);
 
 	/* prevent remaining shrinker jobs */
@@ -742,6 +753,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	int err, active_logs;
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
+	bool need_restart_df = false;
+	bool need_stop_df = false;
 
 	sync_filesystem(sb);
 
@@ -785,6 +798,19 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
+	if ((*flags & MS_RDONLY) || !test_opt(sbi, DATA_FLUSH)) {
+		if (sbi->data_flush_thread) {
+			stop_data_flush_thread(sbi);
+			f2fs_sync_fs(sb, 1);
+			need_restart_df = true;
+		}
+	} else if (!sbi->data_flush_thread) {
+		err = start_data_flush_thread(sbi);
+		if (err)
+			goto restore_gc;
+		need_stop_df = true;
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -794,13 +820,21 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	} else if (!SM_I(sbi)->cmd_control_info) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
-			goto restore_gc;
+			goto restore_df;
 	}
 skip:
 	/* Update the POSIXACL Flag */
 	 sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
 	return 0;
+restore_df:
+	if (need_restart_df) {
+		if (start_data_flush_thread(sbi))
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"background data flush thread has stopped");
+	} else if (need_stop_df) {
+		stop_data_flush_thread(sbi);
+	}
 restore_gc:
 	if (need_restart_gc) {
 		if (start_gc_thread(sbi))
@@ -1216,6 +1250,11 @@ try_onemore:
 	INIT_LIST_HEAD(&sbi->dir_inode_list);
 	spin_lock_init(&sbi->dir_inode_lock);
 
+	sbi->wait_time = DEF_DATA_FLUSH_DELAY_TIME;
+	INIT_LIST_HEAD(&sbi->inode_list);
+	spin_lock_init(&sbi->inode_lock);
+	sbi->inode_num = 0;
+
 	init_extent_cache_info(sbi);
 
 	init_ino_entry_info(sbi);
@@ -1324,6 +1363,12 @@ try_onemore:
 		if (err)
 			goto free_kobj;
 	}
+
+	if (test_opt(sbi, DATA_FLUSH) && !f2fs_readonly(sb)) {
+		err = start_data_flush_thread(sbi);
+		if (err)
+			goto stop_gc;
+	}
 	kfree(options);
 
 	/* recover broken superblock */
@@ -1333,7 +1378,8 @@ try_onemore:
 	}
 
 	return 0;
-
+stop_gc:
+	stop_gc_thread(sbi);
 free_kobj:
 	kobject_del(&sbi->s_kobj);
 free_proc:
-- 
2.4.2



------------------------------------------------------------------------------
