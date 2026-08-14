Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB79C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TUyh6Cyi/37pa6RJcGw3Kcpk3/lVQOW99vkms1Utyao=; b=OUmDTUHoiD8XsPXK7T3s8Ez/yq
	YzazqvNrox5/twk84jB10k/d5MuxC2yc8hFVcDI808LH7cnYkjtBUbMxU1+0WTELIGxcAjfWYrB/M
	xJwF5ATyL8mqcPn+iXoGoNLaKE945b3nNqIE+TTgT3cRmT/xeTdNohEbuqDC0v905P7I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoBA-0004wd-28;
	Fri, 14 Aug 2026 09:26:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoB8-0004wV-7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7x4V1EzeJqHFOYST66QMHosAfZTDYRBNfLLOLum1tno=; b=JN9bJO3egOnIL8hDthywb7Y0nl
 ORGlOvMreiQSlf1bsTfZvkKp2NxbiT+b06i4oEE+Nkv8+ugRP7owW2RBxPxmV2Tt9TYzeIkqC9LaI
 Jm36CkYoldb8G7PG9WoomMOjZTXDUN8+vwWkh7Br2wjDeXUz07o0DT+6D0HFWnWNu/LY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7x4V1EzeJqHFOYST66QMHosAfZTDYRBNfLLOLum1tno=; b=byXBNnZjlnlEblkEwYmUzXVN1X
 QyLKpjoxRYylHDgGa+uO3BaE7nRvYmB8+lbQZuNMvGejEsEnZDNaVTM4p9cfT0cDH4qtxg+kkYR44
 m9i9dALzM1PbjvAZ2zHRbanSDisAkzlAhdwY0o8tQCpcvlN3bvaQMSRBjUhaIqyuQ3kI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoB7-0000nR-Vq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9EC360A5D;
 Fri, 14 Aug 2026 09:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2421F00A3D;
 Fri, 14 Aug 2026 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699568;
 bh=7x4V1EzeJqHFOYST66QMHosAfZTDYRBNfLLOLum1tno=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gzDT006FxPzkocBzlfoVqGrKj2tUrWVZ6zHY/msB/osS8cpuu568Ll81UbeOzFvOb
 8plQosMHi9PRDLAbBEwSTmpgsjlqd6hkpKRndnMGbm+xx1MZAL1Rj3iJ/R0xkMGE7y
 Ib5UnsNbYuPuCH/c4g2HsRXSur79qQRyBiC8J1K0mFVrNuvGRL1PhWihpubw09Jqht
 jxquVPV7FGJ+UbmqIIKvIsveTyWdKnSdfezycuObJF8N2tppnIiN82vH1dnLuMa/nc
 wC+CUBY7ktGp+64DejfOT6wM4YubuCAWX+gnmyNEp9BxmtLGv6p1XzsWGUZnxhTBcg
 lqlGAM0m8YrvQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:24 +0200
Message-ID: <20260814092448.1818082-8-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoB7-0000nR-Vq
Subject: [f2fs-dev] [PATCH v15 07/25] block: add task-context bio completion
 infrastructure
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Tal Zussman <tz2294@columbia.edu>

Some bio completion handlers need to run from preemptible task context,
but bio_endio() may be called from IRQ context (e.g., buffer_head
writeback). Callers need a way to ensure their callback eventually runs
from a sleepable context. Add infrastructure for that, in two forms:

  1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
     in advance that its callback needs task context (e.g., dropbehind
     writeback). bio_endio() sees the flag and offloads completion to a
     worker automatically.

  2. bio_complete_in_task(), a helper that completion callbacks can
     invoke from within bi_end_io() when the deferral decision is
     dynamic (e.g., fserror reporting).

Both share a per-CPU batch list drained by a delayed work item on a
WQ_PERCPU workqueue. Producers push the bio onto the local CPU's batch
and schedule the work item, which then dispatches each bio's bi_end_io()
from task context. The delayed work item uses a 1-jiffie delay to allow
batches of completions to accumulate before processing.

Both methods are gated on bio_in_atomic(), which returns true in any
context where a sleeping bi_end_io() is unsafe, including
non-preemptible task context. This logic is copied from commit
c99fab6e80b7 ("erofs: fix atomic context detection when
!CONFIG_DEBUG_LOCK_ALLOC").

Two CPU hotplug callbacks are used to drain remaining bios from the
departing CPU's batch, while maintaining the per-CPU behavior. The
CPUHP_AP_ONLINE_DYN callback disables the per-CPU delayed work while the
CPU is still online, preventing it from running on an unbound worker
later. CPUHP_BP_PREPARE_DYN then drains any bios added between disabling
the work item and CPU offline.

Link: https://lore.kernel.org/all/20260409160243.1008358-1-hch@lst.de/
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c               | 147 +++++++++++++++++++++++++++++++++++++-
 include/linux/bio.h       |  32 +++++++++
 include/linux/blk_types.h |   1 +
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 6a2f6fc3413e..f228940d6b42 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -19,6 +19,7 @@
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
 #include <linux/kmemleak.h>
+#include <linux/local_lock.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1741,6 +1742,79 @@ void bio_check_pages_dirty(struct bio *bio)
 	schedule_work(&bio_dirty_work);
 }
 
+/*
+ * Infrastructure for deferring bio completions to task-context via a per-CPU
+ * workqueue. Triggered either by the BIO_COMPLETE_IN_TASK bio flag (static
+ * decision at submit time) or by calling bio_complete_in_task() from
+ * bi_end_io() (dynamic decision at completion time).
+ */
+
+struct bio_complete_batch {
+	local_lock_t lock;
+	struct bio_list list;
+	struct delayed_work work;
+	int cpu;
+};
+
+static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
+static struct workqueue_struct *bio_complete_wq;
+
+static void bio_complete_work_fn(struct work_struct *w)
+{
+	struct delayed_work *dw = to_delayed_work(w);
+	struct bio_complete_batch *batch =
+		container_of(dw, struct bio_complete_batch, work);
+
+	while (1) {
+		struct bio_list list;
+		struct bio *bio;
+
+		local_lock_irq(&bio_complete_batch.lock);
+		list = batch->list;
+		bio_list_init(&batch->list);
+		local_unlock_irq(&bio_complete_batch.lock);
+
+		if (bio_list_empty(&list))
+			break;
+
+		while ((bio = bio_list_pop(&list)))
+			bio->bi_end_io(bio);
+
+		if (need_resched()) {
+			bool is_empty;
+
+			local_lock_irq(&bio_complete_batch.lock);
+			is_empty = bio_list_empty(&batch->list);
+			local_unlock_irq(&bio_complete_batch.lock);
+			if (!is_empty)
+				mod_delayed_work_on(batch->cpu,
+						    bio_complete_wq,
+						    &batch->work, 0);
+			break;
+		}
+	}
+}
+
+void __bio_complete_in_task(struct bio *bio)
+{
+	struct bio_complete_batch *batch;
+	unsigned long flags;
+	bool was_empty;
+
+	local_lock_irqsave(&bio_complete_batch.lock, flags);
+	batch = this_cpu_ptr(&bio_complete_batch);
+	was_empty = bio_list_empty(&batch->list);
+	bio_list_add(&batch->list, bio);
+	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
+
+	if (was_empty)
+		mod_delayed_work_on(batch->cpu, bio_complete_wq,
+				    &batch->work, 1);
+}
+EXPORT_SYMBOL_GPL(__bio_complete_in_task);
+
 static inline bool bio_remaining_done(struct bio *bio)
 {
 	/*
@@ -1815,7 +1889,9 @@ void bio_endio(struct bio *bio)
 	}
 #endif
 
-	if (bio->bi_end_io)
+	if (bio_flagged(bio, BIO_COMPLETE_IN_TASK) && bio_in_atomic())
+		__bio_complete_in_task(bio);
+	else if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
 EXPORT_SYMBOL(bio_endio);
@@ -2001,6 +2077,51 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+static int bio_complete_batch_cpu_online(unsigned int cpu)
+{
+	enable_delayed_work(&per_cpu(bio_complete_batch, cpu).work);
+	return 0;
+}
+
+/*
+ * Disable this CPU's delayed work so that it cannot run on an unbound worker
+ * after the CPU is offlined.
+ */
+static int bio_complete_batch_cpu_down_prep(unsigned int cpu)
+{
+	disable_delayed_work_sync(&per_cpu(bio_complete_batch, cpu).work);
+	return 0;
+}
+
+/*
+ * Drain a dead CPU's deferred bio completions. The CPU is dead and the worker
+ * is canceled so no locking is needed.
+ */
+static int bio_complete_batch_cpu_dead(unsigned int cpu)
+{
+	struct bio_complete_batch *batch =
+		per_cpu_ptr(&bio_complete_batch, cpu);
+	struct bio *bio;
+
+	while ((bio = bio_list_pop(&batch->list)))
+		bio->bi_end_io(bio);
+
+	return 0;
+}
+
+static void __init bio_complete_batch_init(int cpu)
+{
+	struct bio_complete_batch *batch =
+		per_cpu_ptr(&bio_complete_batch, cpu);
+
+	bio_list_init(&batch->list);
+	INIT_DELAYED_WORK(&batch->work, bio_complete_work_fn);
+	batch->cpu = cpu;
+
+	if (!cpu_online(cpu))
+		disable_delayed_work_sync(&batch->work);
+}
+
 static int __init init_bio(void)
 {
 	int i;
@@ -2015,6 +2136,30 @@ static int __init init_bio(void)
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
 	}
 
+	for_each_possible_cpu(i)
+		bio_complete_batch_init(i);
+
+	bio_complete_wq = alloc_workqueue("bio_complete",
+					   WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+	if (!bio_complete_wq)
+		panic("bio: can't allocate bio_complete workqueue\n");
+
+	/*
+	 * bio task-context completion draining on hot-unplugged CPUs:
+	 *
+	 *   1. Stop the per-CPU delayed work while the CPU is still online, so
+	 *      that it cannot run on an unbound worker later.
+	 *   2. Drain leftover bios added between worker disabling and CPU
+	 *      offlining.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				  "block/bio:complete:online",
+				  bio_complete_batch_cpu_online,
+				  bio_complete_batch_cpu_down_prep);
+	cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+				  "block/bio:complete:dead",
+				  NULL, bio_complete_batch_cpu_dead);
+
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..501847105aa8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -368,6 +368,38 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
 void submit_bio(struct bio *bio);
 
+/**
+ * bio_in_atomic - check if the current context is unsafe for bio completion
+ *
+ * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
+ * %false when a bio can be safely completed in the current context.
+ */
+static inline bool bio_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
+void __bio_complete_in_task(struct bio *bio);
+
+/**
+ * bio_complete_in_task - ensure a bio is completed in preemptible task context
+ * @bio: bio to complete
+ *
+ * If called from non-task context, offload the bio completion to a worker
+ * thread and return %true. Else return %false and do nothing.
+ */
+static inline bool bio_complete_in_task(struct bio *bio)
+{
+	if (!bio_in_atomic())
+		return false;
+	__bio_complete_in_task(bio);
+	return true;
+}
+
 extern void bio_endio(struct bio *);
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..d49d97a050d0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -322,6 +322,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
 	BIO_FLAG_LAST
 };
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
