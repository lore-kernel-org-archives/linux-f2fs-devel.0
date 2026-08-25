Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2445BC61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cN75b9SvUqHJ2kcBswGQll4Io7mzp7DIz2Q5pt/g5DI=; b=MIE40YDeSnii4gF0ZHmTtEdROA
	cbVNU9YlbJUVQzmf/GMPp5/zkXZ3wW+/FGN3emXd97HuLfkAPemfifYFkiBBPvP7znPA1XZd/gECK
	2ib64uBEq25f7U/BJhkVo4UZ+rFmrBhaz4XH+X+t/wCVlC8TL3DUEj2XCF5s+eN3MUis=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyqn1-0002jN-VP;
	Tue, 25 Aug 2026 13:02:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyqmx-0002iu-V9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8lft3QqwKFaEiHQCQwfjgLYyLk1XT0/1bLJS/zGD69I=; b=Ouig2gAdln5ZzvZBcFAWNSHw9k
 SpfL1kqTa4vm+A0uS0IdisyKfpQ7dGBjd6F+HZ+wEsRYeQN9XXWXYL2vCxpb652LVA/p7psEmZSjB
 AwpYXoLp1PmxSXNqViy4prf6bv8UGk1P+zvaZkPwj803UZTsc+05nB9He+jdMlG1XhdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8lft3QqwKFaEiHQCQwfjgLYyLk1XT0/1bLJS/zGD69I=; b=TvqPek4+qCSAc9/UUtJ0GJpqQB
 Zxqe/qtyeiN7S/jE8CV9QaIs7nMBHR7hAq8BOZX/P9wY5wymn4udqM2aDtlydLEhD7xBK3SzckZ0A
 6N/qyO/amd6mfSdkx61ASUOxmCNr7aZaK7P6rLRYsI7kkm1znhdA1N13h93LkF32kI3c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyqmr-0004Y0-S5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:01:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A04E439D1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 13:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D48A1F00ACA;
 Tue, 25 Aug 2026 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662912;
 bh=8lft3QqwKFaEiHQCQwfjgLYyLk1XT0/1bLJS/zGD69I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a1iy0Hx7OSt+frwpJqKbf1Px7ih2Yea0MEfWA0ikbC2C9TFXbCuv+GhlGTj9PwmtB
 HkaM1WD+DVHDo5RGFp8m5bFIgpRRP+Wp0z5+Z5bIm/liLsA+zYvFhRflTtgbYlvCtj
 Zc3LyOXjVlVryU+AQb42yit97b+nbT2uTHwjuirgphIakgM7oPVOCpmixOmtI6NJcp
 aINTDzIw+S8+X0tHqpUidGB/+/M+F5cgV1PqLGgAyitgRR/Up1W3wFB1Pf03cOPPfA
 hIouqd9MDIjZ2t+Mr2ax6Ta7R0CfzjTppnw4grMAJtEiSvBjKYea8PeexkLPbCdydH
 L6QvCLovhTV2A==
To: jaegeuk@kernel.org
Date: Tue, 25 Aug 2026 21:01:18 +0800
Message-ID: <20260825130126.2078627-5-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825130126.2078627-1-chao@kernel.org>
References: <20260825130126.2078627-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyqmr-0004Y0-S5
Subject: [f2fs-dev] [PATCH v3 04/12] f2fs: cache: introduce writeback thread
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

This patch introduces a background writeback kthread (f2fs_writeback-x:y)
to periodically flush dirty metadata cache entries with a default
interval of 5 seconds.

It manages thread lifecycle across mount, unmount, and remount (rw/ro)
transitions, and hooks synchronous flushing into checkpoint commits.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h | 13 ++++++++++++
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 31 ++++++++++++++++++++++++++-
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 3cee33c69880..dcfea6c2e1bb 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -615,3 +615,59 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 {
 	return f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
 }
+
+static int f2fs_cache_writeback_kthread(void *data)
+{
+	struct f2fs_sb_info *sbi = data;
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+	wait_queue_head_t *wq = &cache_thread->cache_wb_wq;
+	unsigned int interval = DEF_DIRTY_CACHE_TIMEOUT;
+
+	set_freezable();
+
+	while (!kthread_should_stop()) {
+		wait_event_freezable_timeout(*wq,
+				kthread_should_stop() ||
+				cache_thread->cache_wb_task == NULL,
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
index 618b377590da..ff3d8781119c 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -187,4 +187,17 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 				unsigned long nr_to_scan);
 
+#define DEF_DIRTY_CACHE_TIMEOUT 5000
+
+struct f2fs_cache_kthread {
+	struct task_struct *cache_wb_task;
+	wait_queue_head_t cache_wb_wq;
+	atomic_t cache_wb_trigger;
+	unsigned int cache_wb_interval_ms;
+};
+
+int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_sync_cache_wb(struct f2fs_sb_info *sbi);
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f855ac7d1e8..9fe9fadbb810 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2111,6 +2111,9 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+
+	/* internal cache flush thread */
+	struct f2fs_cache_kthread cache_thread;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 32e80c70e141..9bb19f4c5fd2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2020,6 +2020,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * flush all issued checkpoints and stop checkpoint issue thread.
 	 * after then, all checkpoints should be done by each process context.
 	 */
+	f2fs_stop_cache_wb_thread(sbi);
 	f2fs_stop_ckpt_thread(sbi);
 
 	/*
@@ -2826,6 +2827,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	unsigned int flags = fc->sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
+	bool need_restart_wb = false, need_stop_wb = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool need_restart_discard = false, need_stop_discard = false;
 	bool need_enable_checkpoint = false, need_disable_checkpoint = false;
@@ -2984,6 +2986,18 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
 
@@ -3006,7 +3020,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	} else {
 		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
-			goto restore_gc;
+			goto restore_wb;
 		need_stop_flush = true;
 	}
 
@@ -3103,6 +3117,13 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
@@ -5497,6 +5518,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5519,6 +5546,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->umount_lock_holder = NULL;
 	return 0;
 
+stop_gc_thread:
+	f2fs_stop_gc_thread(sbi);
 sync_free_meta:
 	/* safe to flush all the data */
 	sync_filesystem(sbi->sb);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
