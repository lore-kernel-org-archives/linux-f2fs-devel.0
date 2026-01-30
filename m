Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A5AE6BF33
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4D7OqcExzFQ29j9k/rIHZal7aOaYN0tafiTIddRQYmY=; b=C9NDNru3C8ArJCFDIO3ZrjCFVu
	6gZ8CGs/lqamzoeejSfTPysGcSz54fh/wCuTfUXVZB1xcJ1EMMlHGd3BZba6vxPi2NZdqBNbqhjTe
	f/AtnQrnILayUaxcRJsgV/a20BazagNPaxxyVhy3IOW4EKoSOaYoJ2jvfRo5UivWPdGU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vm0h9-0000tB-MI;
	Sat, 31 Jan 2026 02:26:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vm0h8-0000t5-Pm
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Jan 2026 02:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9ldYNHHj6TlZlKG56cHBP3A2eXrXwFLfV69uuzQBp/4=; b=etKZ/p/KDBZiphWC/wfHHQCES+
 slJLVbZsbOqx7AO80vbA/oLbAejMfv3hYl89gVRbuYV5maJQF2yHiKR/GKJ973mRdVqCPLvDFMNuF
 yF2L19wo67gjappMx66qHhgCh0dye1X3XyNxJkgoEi+l7izaaS1Eusu8tYGdHRAv6aNY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9ldYNHHj6TlZlKG56cHBP3A2eXrXwFLfV69uuzQBp/4=; b=K
 XBhcD30ILjuSCGPYuFL1QbFEdBBorgF5oAKlnz7wxURsvSf9vglWBs+VdL1eXgDAJXVke+rakUFqv
 UWqjWY401vYO/U4MGp9f1ty7qrDYdjFVuytAciljk5PkhrclrVlUC7GgtuwrOu9pQLc/i3zcVPIu2
 wulLrCS5Sr3FRMI8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vm0h7-0001tc-RO for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 31 Jan 2026 02:26:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C84140BD5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 31 Jan 2026 02:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A6C4CEF7;
 Sat, 31 Jan 2026 02:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769826391;
 bh=Uv+a6I66lHaFbYAf2WUikV5LwVvUapVVftUM9J/T8J0=;
 h=From:To:Cc:Subject:Date:From;
 b=m/X3dpokhcd3zlhJRqANdCcGalyAlT0LLyoASUKcAaeG2sZmWVDZLQ3ec5bCp8LKk
 JpahTpdLGzNzzHTGpWCIA6cXT0LLrq5yn+rDX0rHWdCR+jSquLc/yJHcKk1uWYcmKo
 9kqUjX+aFrplXOKd1Km9TN6KIHgfKOyMIZycMDgBBNl88sWsi617eNJuSTFBNx4dBF
 kOfPapHTBUyOoslKkiQPhTVgihK0RmxHjRsupkBfc6FqLhdYABAJ+f/WXwzr2k4Te9
 2vgNI+nsSxRg/E/6g7oo7vHsFwcanye27aFuoGhTqYXLGeA8tr8Agy5eh4E9xRUQN8
 8s73/MoMh6bWA==
To: jaegeuk@kernel.org
Date: Fri, 30 Jan 2026 21:28:08 +0800
Message-Id: <20260130132809.59707-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1vm0h7-0001tc-RO
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix lock priority inversion issue
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

If userspace thread has held f2fs rw semaphore, due to its low priority,
it could be runnable or preempted state for long time, during the time,
it will block high priority thread which is trying to grab the same rw
semaphore, e.g. cp_rwsem, io_rwsem...

To fix such issue, let's detect thread's priority when it tries to grab
f2fs_rwsem lock, if the priority is lower than a priority threshold, let's
uplift the priority before it enters into critical region of lock, and
restore the priority after it leaves from critical region.

Meanwhile, introducing two new sysfs nodes:
- /sys/fs/f2fs/<disk>/adjust_lock_priority, it is used to control whether
the functionality is enable or not.
==========     ==================
Flag_Value     Flag_Description
==========     ==================
0x00000000     Disabled (default)
0x00000001     cp_rwsem
0x00000002     node_change
0x00000004     node_write
0x00000008     gc_lock
0x00000010     cp_global
0x00000020     io_rwsem
==========     ==================
- /sys/fs/f2fs/<disk>/lock_duration_priority, it is used to control
priority threshold.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 24 +++++++++
 fs/f2fs/checkpoint.c                    | 66 ++++++++++++++++++++++++-
 fs/f2fs/f2fs.h                          | 12 +++++
 fs/f2fs/super.c                         |  2 +
 fs/f2fs/sysfs.c                         | 18 +++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 9a8ec2290f68..ea6474db8a31 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -963,3 +963,27 @@ Description:	This sysfs entry can be used to change type of injected timeout:
 		0x00000003     Simulate Non-IO type sleep time
 		0x00000004     Simulate runnable time
 		==========     ===============================
+
+What:		/sys/fs/f2fs/<disk>/adjust_lock_priority
+Date:		January 2026
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	This sysfs entry can be used to enable/disable to adjust priority for task
+		which is in critical region covered by lock.
+		==========     ==================
+		Flag_Value     Flag_Description
+		==========     ==================
+		0x00000000     Disabled (default)
+		0x00000001     cp_rwsem
+		0x00000002     node_change
+		0x00000004     node_write
+		0x00000008     gc_lock
+		0x00000010     cp_global
+		0x00000020     io_rwsem
+		==========     ==================
+
+What:		/sys/fs/f2fs/<disk>/lock_duration_priority
+Date:		January 2026
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	f2fs can tune priority of thread which has entered into critical region covered by
+		f2fs rwsemphore lock. This sysfs entry can be used to control priority value, the
+		range is [100,139], by default the value is 120.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5172396c0b01..2f5a03e29d0b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -90,16 +90,72 @@ static inline void trace_lock_elapsed_time_end(struct f2fs_rwsem *sem,
 			runnable_time, io_sleep_time, other_time);
 }
 
+static bool need_uplift_priority(struct f2fs_rwsem *sem, bool is_write)
+{
+	if (!(sem->sbi->adjust_lock_priority & BIT(sem->name - 1)))
+		return false;
+
+	switch (sem->name) {
+	/*
+	 * writer is checkpoint which has high priority, let's just uplift
+	 * priority for reader
+	 */
+	case LOCK_NAME_CP_RWSEM:
+	case LOCK_NAME_NODE_CHANGE:
+	case LOCK_NAME_NODE_WRITE:
+		return !is_write;
+	case LOCK_NAME_GC_LOCK:
+	case LOCK_NAME_CP_GLOBAL:
+	case LOCK_NAME_IO_RWSEM:
+		return true;
+	default:
+		f2fs_bug_on(sem->sbi, 1);
+	}
+	return false;
+}
+
+static void uplift_priority(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc,
+						bool is_write)
+{
+	lc->need_restore = false;
+	if (!sem->sbi->adjust_lock_priority)
+		return;
+	if (rt_task(current))
+		return;
+	if (!need_uplift_priority(sem, is_write))
+		return;
+	lc->orig_nice = task_nice(current);
+	lc->new_nice = PRIO_TO_NICE(sem->sbi->lock_duration_priority);
+	if (lc->orig_nice <= lc->new_nice)
+		return;
+	set_user_nice(current, lc->new_nice);
+	lc->need_restore = true;
+}
+
+static void restore_priority(struct f2fs_lock_context *lc)
+{
+	if (!lc->need_restore)
+		return;
+	/* someone has updated the priority */
+	if (task_nice(current) != lc->new_nice)
+		return;
+	set_user_nice(current, lc->orig_nice);
+}
+
 void f2fs_down_read_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
+	uplift_priority(sem, lc, false);
 	f2fs_down_read(sem);
 	trace_lock_elapsed_time_start(sem, lc);
 }
 
 int f2fs_down_read_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
-	if (!f2fs_down_read_trylock(sem))
+	uplift_priority(sem, lc, false);
+	if (!f2fs_down_read_trylock(sem)) {
+		restore_priority(lc);
 		return 0;
+	}
 	trace_lock_elapsed_time_start(sem, lc);
 	return 1;
 }
@@ -107,19 +163,24 @@ int f2fs_down_read_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_contex
 void f2fs_up_read_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
 	f2fs_up_read(sem);
+	restore_priority(lc);
 	trace_lock_elapsed_time_end(sem, lc, false);
 }
 
 void f2fs_down_write_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
+	uplift_priority(sem, lc, true);
 	f2fs_down_write(sem);
 	trace_lock_elapsed_time_start(sem, lc);
 }
 
 int f2fs_down_write_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
-	if (!f2fs_down_write_trylock(sem))
+	uplift_priority(sem, lc, true);
+	if (!f2fs_down_write_trylock(sem)) {
+		restore_priority(lc);
 		return 0;
+	}
 	trace_lock_elapsed_time_start(sem, lc);
 	return 1;
 }
@@ -127,6 +188,7 @@ int f2fs_down_write_trylock_trace(struct f2fs_rwsem *sem, struct f2fs_lock_conte
 void f2fs_up_write_trace(struct f2fs_rwsem *sem, struct f2fs_lock_context *lc)
 {
 	f2fs_up_write(sem);
+	restore_priority(lc);
 	trace_lock_elapsed_time_end(sem, lc, true);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 29f81a496b72..a6e7368fc40a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -185,6 +185,7 @@ enum f2fs_lock_name {
 	LOCK_NAME_GC_LOCK,
 	LOCK_NAME_CP_GLOBAL,
 	LOCK_NAME_IO_RWSEM,
+	LOCK_NAME_MAX,
 };
 
 enum f2fs_timeout_type {
@@ -1447,7 +1448,10 @@ struct f2fs_time_stat {
 
 struct f2fs_lock_context {
 	struct f2fs_time_stat ts;
+	int orig_nice;
+	int new_nice;
 	bool lock_trace;
+	bool need_restore;
 };
 
 struct f2fs_gc_control {
@@ -1588,6 +1592,8 @@ enum node_type {
 /* a threshold of maximum elapsed time in critical region to print tracepoint */
 #define MAX_LOCK_ELAPSED_TIME		500
 
+#define F2FS_DEFAULT_TASK_PRIORITY		(DEFAULT_PRIO)
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -1998,6 +2004,12 @@ struct f2fs_sb_info {
 	/* max elapsed time threshold in critical region that lock covered */
 	unsigned long long max_lock_elapsed_time;
 
+	/* enable/disable to adjust task priority in critical region covered by lock */
+	unsigned int adjust_lock_priority;
+
+	/* adjust priority for task which is in critical region covered by lock */
+	unsigned int lock_duration_priority;
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9d421a07d2d5..d5cf7265e5d3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4338,6 +4338,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	spin_lock_init(&sbi->gc_remaining_trials_lock);
 	atomic64_set(&sbi->current_atomic_write, 0);
 	sbi->max_lock_elapsed_time = MAX_LOCK_ELAPSED_TIME;
+	sbi->adjust_lock_priority = 0;
+	sbi->lock_duration_priority = F2FS_DEFAULT_TASK_PRIORITY;
 
 	sbi->sum_blocksize = f2fs_sb_has_packed_ssa(sbi) ?
 		4096 : sbi->blocksize;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index d01a2664a250..3a272e7edf23 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -955,6 +955,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "adjust_lock_priority")) {
+		if (t >= BIT(LOCK_NAME_MAX - 1))
+			return -EINVAL;
+		sbi->adjust_lock_priority = t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "lock_duration_priority")) {
+		if (t < NICE_TO_PRIO(MIN_NICE) || t > NICE_TO_PRIO(MAX_NICE))
+			return -EINVAL;
+		sbi->lock_duration_priority = t;
+		return count;
+	}
+
 	__sbi_store_value(a, sbi, ptr + a->offset, t);
 
 	return count;
@@ -1272,6 +1286,8 @@ F2FS_SBI_GENERAL_RW_ATTR(carve_out);
 F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
 F2FS_SBI_GENERAL_RW_ATTR(bggc_io_aware);
 F2FS_SBI_GENERAL_RW_ATTR(max_lock_elapsed_time);
+F2FS_SBI_GENERAL_RW_ATTR(lock_duration_priority);
+F2FS_SBI_GENERAL_RW_ATTR(adjust_lock_priority);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
@@ -1478,6 +1494,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(allocate_section_hint),
 	ATTR_LIST(allocate_section_policy),
 	ATTR_LIST(max_lock_elapsed_time),
+	ATTR_LIST(lock_duration_priority),
+	ATTR_LIST(adjust_lock_priority),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
