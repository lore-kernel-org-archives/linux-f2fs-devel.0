Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5005C5DF8F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHOlZHDcISdD6iIoBjy+kJEFHpqPmHyCbAMsHfx0Ttk=; b=ChrjhRxaJYS5Jv6V5dzaGOi3Gv
	SCTglXB3jY/DoYyizte94ylY0dDF70Exrt+iDO6NTS7YeMmpaCmcf6/Rwh8t/mucoMdr5h/mDBbzE
	J8HIvXF2oCxxW1GTTp+2IAFN9hKsOGUnKPib2W1NFFwZUMhUZYVGWjx1YRSLAr2d7Wr8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtIE-0002MO-JT;
	Thu, 20 Aug 2026 03:18:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHd-0002L9-PU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LFNqNqceqH6OOTHPSr51wRgxI0AqLuTMy2UvPIHhHJ0=; b=mZYBKnsYiVjDG+n6cP9Fba5Bs7
 4rSeW0q+tXYS3LNOqEs46heS+DE6QqG2O/3CyLWIGxkaideMMHI//JyztNwDRLceq/bB03+mZqRCF
 QyBzKTLSDmO8xnNbRM2cSJD2wEyuaVX+3o033D8RCSFLQsXD0mDUJO5uancwKDrbS6tQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LFNqNqceqH6OOTHPSr51wRgxI0AqLuTMy2UvPIHhHJ0=; b=YZX5xqyNCEDDeei+FEucfO0BRU
 E90Fr40NEcQdh7oXv1TuEVmZXspD/3i7g3Rcfj9O4gnbdvnOO5mSlnJmQSH9mr8SXXDCV4S9sJUT/
 56JbE31zSvgLBJaJuccwo56RRwuUftdyIWUNXcFd010z7KEleIM81T/4SoayhFxHhdUc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHd-00032i-Qi for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A5A243D54
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE01F00A3F;
 Thu, 20 Aug 2026 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195852;
 bh=LFNqNqceqH6OOTHPSr51wRgxI0AqLuTMy2UvPIHhHJ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IdQivnGiVVTJnumuSk3CNxbmSI2aDZ0fag7oF0QAwbKXjUAdyZgse9RyNeEhAvTrz
 xNDZiP5AG0xpt7drF56Y6Ya3LFygBqT2Nf4kta7qxgKqySjB5lRg3SdL1EfYUtg/HK
 7qDwtimwc79QWcxqCtT+PJ+IPsWGXWfD/tHSCh0Ag1mFUbzeIZtDIxTQhwpTviHlYw
 xp3lB8cm0mDSxxv8QscbQiSEXFOl4FQ/lQ1tqCoJn1mOU3V2wjZ86DgYrQ7hgoFtib
 qurj65M9hxMh0dsanWOp2tvQfwlu/GEeJbhXPy94QDtrNyumZ6sJWKxajWoMtZsiat
 ennS/VIGd2aJA==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:13 +0800
Message-ID: <20260820031721.12218-5-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wwtHd-00032i-Qi
Subject: [f2fs-dev] [PATCH v1 04/12] f2fs: cache: introduce writeback thread
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
 fs/f2fs/cache.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h      | 13 +++++++++++
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/f2fs.h       |  3 +++
 fs/f2fs/super.c      | 31 ++++++++++++++++++++++++-
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index c071364822c4..cb5b26046162 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -611,3 +611,57 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
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
+	cache_thread->cache_wb_task = kthread_run(f2fs_cache_writeback_kthread,
+						sbi, "%s", name);
+	if (IS_ERR(cache_thread->cache_wb_task))
+		return PTR_ERR(cache_thread->cache_wb_task);
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
index d92b6f3ed585..5e9fe8c0b15c 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -191,4 +191,17 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f81ba8cc861a..729d19680caf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1596,6 +1596,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 * sbi->node_change is used only for AIO write_begin path which produces
 	 * dirty node blocks and some checkpoint values by block allocation.
 	 */
+
 	__prepare_cp_block(sbi);
 	f2fs_up_write(&sbi->node_change);
 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b7c60bbb137..6e20b3586f26 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2108,6 +2108,9 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+
+	/* internal cache flush thread */
+	struct f2fs_cache_kthread cache_thread;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bcfb1f97850e..89affe72f4fc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1998,6 +1998,7 @@ static void f2fs_put_super(struct super_block *sb)
 	 * flush all issued checkpoints and stop checkpoint issue thread.
 	 * after then, all checkpoints should be done by each process context.
 	 */
+	f2fs_stop_cache_wb_thread(sbi);
 	f2fs_stop_ckpt_thread(sbi);
 
 	/*
@@ -2799,6 +2800,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	unsigned int flags = fc->sb_flags;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
+	bool need_restart_wb = false, need_stop_wb = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool need_restart_discard = false, need_stop_discard = false;
 	bool need_enable_checkpoint = false, need_disable_checkpoint = false;
@@ -2957,6 +2959,18 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
 
@@ -2979,7 +2993,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	} else {
 		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
-			goto restore_gc;
+			goto restore_wb;
 		need_stop_flush = true;
 	}
 
@@ -3075,6 +3089,13 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
@@ -5461,6 +5482,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5483,6 +5510,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
