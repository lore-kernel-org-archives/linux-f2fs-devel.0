Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9010EC79FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25ZLayzqBkfAkUF93CXgLgze/gpfNm7Z3zNUnQwfIyg=; b=bxjamgd1YxRh6Q3+k1Q96QtV9I
	PXa/oMwyRfk0SdcvH+X/zgnMFOFsmuMpnoB/bof5h8d1gsGIPeBzJpuLQNNcBMwkDGh8vcP6i+1EL
	82hmwLyxp5bSXGhdqnOr6JTUHX7yvZNjQwWxW2rrX41Wji3VtGE+TyaondGHeSRPxPZE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FF-0006AZ-PL;
	Wed, 09 Sep 2026 01:37:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FE-00069x-KJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rwFxUvJ/C+TLhgsn1Kn7fGdRIT8+lxUWWF3LsrBhsYE=; b=eDsBaFiysKtjoLzqoQLM7SZXb+
 nyVpx+YWtO8AqpyCpZo7FUmdmIUX4zEMIH+rQRyZ0BiEMGEdtxkL0NDHvyDj591E39IgD28OhOhMd
 V8jFw7jGCgoWn2bn2EZndB95PlMys71ePHIrfnylzApW2WdajQjCO4DaGjolyY4QwE9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rwFxUvJ/C+TLhgsn1Kn7fGdRIT8+lxUWWF3LsrBhsYE=; b=GEl7U7ICfud/WboOd1TZGOxFaK
 iEc1FiKJkzkWlnr5dmGkHmdVnoJXuqU/YxesqRmWCn2LxlLrv+dzaqoWTDyYpTmknki47jPf5MGt8
 XLte0BonhZbG5/VdnsrTs2+MY6zQSInP+UyNN0yAknwJlMZkv+55GA5Th8iGPxL1K61E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47Ev-0006xN-UU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A622740AE7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65B51F00A3A;
 Wed,  9 Sep 2026 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917796;
 bh=rwFxUvJ/C+TLhgsn1Kn7fGdRIT8+lxUWWF3LsrBhsYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iv6yv95Zv/eAie4pe6IfDj06zPe8v2yfPcQYDvY0PUn+8hYUmyZd2FWMNbiTBikr1
 04fNYP4tMowebI/yhVjCBVFgMk9g3iYPeh0QM9yjZqGjzttpSUkmD3H9VQzPh6h2lD
 H9f/k1c7bTWPyxNsJN7xte1WSfakCkDFI9oa0D100Tk7JqCwVuEcQj2hnLtChNOQJt
 18ybd9xwhJbtiOPpTPkfaTHQlUqneJdjtmmgKbFI4+v/JwGFKOWz2N02Z8HSZcZT7A
 23JEaJ8Psnmo1YatlDG9wEruNx96xivwrEzWrKqwDzAn1vTvtULtRbCSyrSUtdDZ0E
 Txssxp/qONLWw==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:03 +0800
Message-ID: <20260909013611.3418568-5-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47Ev-0006xN-UU
Subject: [f2fs-dev] [PATCH v6 04/12] f2fs: cache: introduce writeback thread
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch introduces a background writeback kthread (f2fs_writeback-x:y)
to periodically flush dirty metadata cache entries with a default
interval of 5 seconds.

It manages thread lifecycle across mount, unmount, and remount (rw/ro)
transitions.

It introduces a sysfs entry /sys/fs/f2fs/<disk>/cache_wb_interval to control
writeback interval.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 +++
 fs/f2fs/cache.c                         | 56 +++++++++++++++++++++++++
 fs/f2fs/cache.h                         | 12 ++++++
 fs/f2fs/f2fs.h                          |  3 ++
 fs/f2fs/super.c                         | 33 ++++++++++++++-
 fs/f2fs/sysfs.c                         | 13 +++++-
 6 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0cebc89799dd..d2665b7f1f14 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1020,3 +1020,9 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	This is a read-only entry to show the upper bound section number
 		for pinned files. Pinned files will only be allocated within
 		sections 0 to pinned_area_max_secno - 1.
+
+What:		/sys/fs/f2fs/<disk>/cache_wb_interval
+Date:		August 2026
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	This is a writable entry to control writeback interval of
+		f2fs_writeback-x:y, by default the value is 5000, unit is ms.
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 5524c0c81c83..7faedcab11f5 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -622,3 +622,59 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 {
 	return f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
 }
+
+static int f2fs_cache_writeback_kthread(void *data)
+{
+	struct f2fs_sb_info *sbi = data;
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+	wait_queue_head_t *wq = &cache_thread->cache_wb_wq;
+	unsigned int interval = cache_thread->cache_wb_interval;
+
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		wait_event_freezable_timeout(*wq,
+				kthread_should_stop(),
+				msecs_to_jiffies(interval));
+
+		if (kthread_should_stop())
+			break;
+		if (f2fs_cp_error(sbi))
+			continue;
+	}
+	return 0;
+}
+
+int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+	struct task_struct *task;
+	dev_t dev = sbi->sb->s_dev;
+	char name[36];
+
+	if (cache_thread->cache_wb_task)
+		return 0;
+
+	init_waitqueue_head(&cache_thread->cache_wb_wq);
+	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
+			MAJOR(dev), MINOR(dev));
+
+	task = kthread_run(f2fs_cache_writeback_kthread, sbi, "%s", name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	cache_thread->cache_wb_task = task;
+	return 0;
+}
+
+void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+
+	if (!cache_thread->cache_wb_task)
+		return;
+
+	kthread_stop(cache_thread->cache_wb_task);
+	cache_thread->cache_wb_task = NULL;
+}
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index d5aa89d59474..0786d375b159 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -208,4 +208,16 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 				unsigned long nr_to_scan);
 
+#define DEF_DIRTY_CACHE_TIMEOUT 5000
+
+struct f2fs_cache_kthread {
+	struct task_struct *cache_wb_task;
+	wait_queue_head_t cache_wb_wq;
+	atomic_t cache_wb_trigger;
+	unsigned int cache_wb_interval;
+};
+
+int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8bce5cc2b09a..c8e93dd2fc4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2110,6 +2110,9 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+
+	/* internal cache flush thread */
+	struct f2fs_cache_kthread cache_thread;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f6ac2a56b0da..ac9e3dcd34ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2039,6 +2039,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * flush all issued checkpoints and stop checkpoint issue thread.
 	 * after then, all checkpoints should be done by each process context.
 	 */
+	f2fs_stop_cache_wb_thread(sbi);
 	f2fs_stop_ckpt_thread(sbi);
 
 	/*
@@ -2845,6 +2846,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	unsigned int flags = fc->sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
+	bool need_restart_wb = false, need_stop_wb = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool need_restart_discard = false, need_stop_discard = false;
 	bool need_enable_checkpoint = false, need_disable_checkpoint = false;
@@ -3003,6 +3005,18 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 		need_stop_gc = true;
 	}
 
+	if (flags & SB_RDONLY) {
+		if (sbi->cache_thread.cache_wb_task) {
+			f2fs_stop_cache_wb_thread(sbi);
+			need_restart_wb = true;
+		}
+	} else if (!sbi->cache_thread.cache_wb_task) {
+		err = f2fs_start_cache_wb_thread(sbi);
+		if (err)
+			goto restore_gc;
+		need_stop_wb = true;
+	}
+
 	if (flags & SB_RDONLY) {
 		sync_inodes_sb(sb);
 
@@ -3010,7 +3024,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
 		err = f2fs_sync_fs(sb, 1);
 		if (err)
-			goto restore_gc;
+			goto restore_wb;
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
@@ -3025,7 +3039,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	} else {
 		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
-			goto restore_gc;
+			goto restore_wb;
 		need_stop_flush = true;
 	}
 
@@ -3122,6 +3136,13 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 		clear_opt(sbi, FLUSH_MERGE);
 		f2fs_destroy_flush_cmd_control(sbi, false);
 	}
+restore_wb:
+	if (need_restart_wb) {
+		if (f2fs_start_cache_wb_thread(sbi))
+			f2fs_warn(sbi, "background cache writeback thread has stopped");
+	} else if (need_stop_wb) {
+		f2fs_stop_cache_wb_thread(sbi);
+	}
 restore_gc:
 	if (need_restart_gc) {
 		if (f2fs_start_gc_thread(sbi))
@@ -5527,6 +5548,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto sync_free_meta;
 	}
 
+	if (!f2fs_readonly(sb)) {
+		err = f2fs_start_cache_wb_thread(sbi);
+		if (err)
+			goto stop_gc_thread;
+	}
+
 	/* recover broken superblock */
 	if (recovery) {
 		err = f2fs_commit_super(sbi, true);
@@ -5549,6 +5576,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->umount_lock_holder = NULL;
 	return 0;
 
+stop_gc_thread:
+	f2fs_stop_gc_thread(sbi);
 sync_free_meta:
 	/* safe to flush all the data */
 	sync_filesystem(sbi->sb);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index aaca9ed9b169..ad25733e32c0 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -40,6 +40,7 @@ enum {
 	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
 	CPRC_INFO,	/* struct ckpt_req_control */
 	ATGC_INFO,	/* struct atgc_management */
+	WB_THREAD,	/* struct f2fs_cache_kthread */
 };
 
 static const char *gc_mode_names[MAX_GC_MODE] = {
@@ -98,6 +99,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)&sbi->cprc_info;
 	else if (struct_type == ATGC_INFO)
 		return (unsigned char *)&sbi->am;
+	else if (struct_type == WB_THREAD)
+		return (unsigned char *)&sbi->cache_thread;
 	return NULL;
 }
 
@@ -1008,7 +1011,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
 	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
-			!strcmp(a->attr.name, "critical_task_priority");
+			!strcmp(a->attr.name, "critical_task_priority") ||
+			!strcmp(a->attr.name, "cache_wb_interval");
 
 	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
@@ -1218,6 +1222,9 @@ static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
 #define ATGC_INFO_RW_ATTR(name, elname)				\
 	F2FS_RW_ATTR(ATGC_INFO, atgc_management, name, elname)
 
+#define WB_THREAD_RW_ATTR(name, elname)				\
+	F2FS_RW_ATTR(WB_THREAD, f2fs_cache_kthread, name, elname)
+
 /* GC_THREAD ATTR */
 GC_THREAD_RW_ATTR(gc_urgent_sleep_time, urgent_sleep_time);
 GC_THREAD_RW_ATTR(gc_min_sleep_time, min_sleep_time);
@@ -1347,6 +1354,9 @@ ATGC_INFO_RW_ATTR(atgc_candidate_count, max_candidate_count);
 ATGC_INFO_RW_ATTR(atgc_age_weight, age_weight);
 ATGC_INFO_RW_ATTR(atgc_age_threshold, age_threshold);
 
+/* WB_THREAD ATTR */
+WB_THREAD_RW_ATTR(cache_wb_interval, cache_wb_interval);
+
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
 F2FS_GENERAL_RO_ATTR(ovp_segments);
@@ -1533,6 +1543,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(lock_duration_priority),
 	ATTR_LIST(adjust_lock_priority),
 	ATTR_LIST(critical_task_priority),
+	ATTR_LIST(cache_wb_interval),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
