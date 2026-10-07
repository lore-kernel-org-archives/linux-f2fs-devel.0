Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F1DCA6002
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9o7vZykYVoPtvzjmzknxIzmbyxVBb4RXaZOkgaF/UBo=; b=J6TnF7xtvtqkS66cAcPWw6sP6x
	4tkaqcC3poPYOH2XzHBWPKwnuTsGPIMQCCrg91DbWqpIa4ehbJB6e9m2KIMkAqoq7B2KMIf0g/Bw1
	z4IqliH2QpgS38E9yG1ZXZktZTeFuQwBEZ9ZXt6Rh0t2boUdztANcv07XgZG9JG6x+rY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEXMk-0005H4-4Z;
	Wed, 07 Oct 2026 19:31:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xEXMf-0005Gw-SX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 19:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+a6G9l8U8LHfxZ8VgLGKsGq7UAi+F+l/ig1DUT9bFV4=; b=FJt/wCdsSq7Vq3ivZzlriIXZ1G
 5jUvE3u85IIhwkhLoAVQRYcbhkM62DFlTpdhMmkRWly2BCnY55ilVsV+eCAkKM4OV8UXx3+x+OmZ6
 DrbX/cquw50utslNmfBnlJJA2Bza2S81uoASJm6RrJw+bEzY5dCvuUBNM2kD/Ez02AUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+a6G9l8U8LHfxZ8VgLGKsGq7UAi+F+l/ig1DUT9bFV4=; b=d
 XlSN76pqqwR89VtQvYyXe2qrHC134ZVLZ1x/FlbTopnpsL0Lx9XBFZdloZMpgisOBqfJke9Jwhnk3
 p/QMGvcdHkI/j4pii2yI/A0Dz9/8Q6BObd6y6oaOW9ulPi1A2ZqACbo3Y+29dwgUyq7x13InLncq4
 GLYIa6m4cgAO3pf4=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEXMf-0007mM-G6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 19:31:46 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e2c837fa12so11187625ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791401500; x=1792006300; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+a6G9l8U8LHfxZ8VgLGKsGq7UAi+F+l/ig1DUT9bFV4=;
 b=Qc2x2AtQpOnVpQDS+JinWkE3PT1RxBAJZJ672RggLomLJV+R2DwPYFzpH+jJwGveGW
 FmqdTGtDlNtlf/bOyIaCbxyeb0N3xrz+tVG14ktGaxlZcPEbwEMF2JWYNQEpJAfDpL45
 9MNa2Z4/nDavFbdEkCyAcUCDq/5fqnI3PCc5ZGsvukxWDXcOG8ub9XyZGkzepTZy55Bt
 LlY3f8QnNqJzhMAxrlpEBLXtulfD4lApilqySlO1j9hwUUqXaCIuInFsU5VR8FSa+eum
 Qswr32YaZfuKcpIFHi0/CtdUBc+WT3wYMpsoKkFtcw6iyTdu4iUAVGTXJtzl4tnOTa4j
 WN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791401500; x=1792006300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+a6G9l8U8LHfxZ8VgLGKsGq7UAi+F+l/ig1DUT9bFV4=;
 b=JdW4M21fEXPfYHx2k0GkH4s+S+leUQRP19cbJEe7JqjxaraDC4BreCGFXx4HeO6VF+
 pW3AfNPewb+aLYUKuoybnQrCkZy/z2muVLGwxJNNbFi8n4aKXlbi+iqs53pWxXp1xecT
 8YLoeWx3s9uemtuPisfPo6+kFcnjQ2gkReRlHLapaWlAvAYStJP/Q+tAEm8iPQELEBQk
 3T3/NScBN1/sSOVrISH57X0dDwDXwfNKAWvrGYM1kA9NvxbExjIPJj1Ezgh++26Ipbnk
 6j7r3C7kB9McC36yH3xsJorUUL2ryIYibALSKSTtfddEqk79ugrUDH5uUjipVH6YhuKw
 FpNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztny8sVtCqO8QmSz1tXrfmVZ9FJkqgbn51vkR4opPDEV/Pe0vDgSd3XBKoJUFstSbZ6GJy4g8t4Tz3C7nxtxgs@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVpjPtq1R4sQaKXdUJvMPVyQDFNJilI0pKgAgZY30CQj5DErlO
 +6LuEFr/nOhVbrrpM2GdVUG6SKqB1ttA4dxxdXZ+Emb22zo9/BoydRnL
X-Gm-Gg: AYBFou2SsK5H8+3jchMzwQwErvsVqtD/YWWLFL9u0vn0XQn+dF053Moqi+70Yh00zwO
 78vrblbwZx49pBFIhuaKJNjhtPoUbrd+7wSdUnoS2W3friVqnqsW6ClrGZLLagQ7j7jCJZ4WB1e
 TaauHZxtI5vGcDXfb0h2zCFxfVF8DkqrOMBP30Uleje2SvvQ4rMkYr823FOnkFawDY6cgrxAy4v
 oUX9cdjpyCgjNbE0YdA3F1vSu2uvfN0oh1psWMQLmYjVtqBHUw/azuX+MvDdDudhHRBX8e0MoNu
 6S2r2OOtby+yS5/XHZPL+inXLbiFTNCTI5Mun7e0PifpnSUYWR+1jQUM9VY4A5obOAAfiOi7lYO
 Tfhg7Am7qZHEttRotSpCVqyTIHsi85hZB4r53o/vmWZE4Wy5Pe0PasFISAnEzJ5LKm9JUd1xbUO
 Q4tHskCEAYcOBZsgKPBdesrXcyI1VFcj2Cl/yWkXHo/pDcyC5a3Bnw9nEOzfnJQLAlDzIb4gCfP
 vSu4nTcJjHY56t7myQMC3ASaaF0OET0QHFj8wpCsgGZ0WMLhP1AgJ5uodzCT4PLtNcwQSfgHs6m
 36agpymENcrc/M8=
X-Received: by 2002:a17:903:3846:b0:2df:a4d8:57ad with SMTP id
 d9443c01a7336-2e60057831dmr28952575ad.72.1791401499570; 
 Wed, 07 Oct 2026 12:31:39 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60482d316sm16125975ad.49.2026.10.07.12.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:31:38 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed,  7 Oct 2026 19:31:31 +0000
Message-ID: <20261007193131.1785199-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
MIME-Version: 1.0
X-Headers-End: 1xEXMf-0007mM-G6
Subject: [f2fs-dev] [PATCH] f2fs: cache: wake up the writeback thread while
 checkpoint is disabled
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Dirty node and meta caches are written back by the cache writeback
thread and by checkpoint. The thread wakes up every cache_wb_interval
(5 seconds by default) and writes at most 512 node caches and one
contiguous run of meta caches. Checkpoint, which f2fs_balance_fs_bg()
triggers when there are too many dirty caches, writes the rest.

While checkpoint is disabled, checkpoint does not run: f2fs_sync_fs()
returns early and f2fs_balance_fs() returns before doing anything. So
dirty node caches pile up without a limit. They are kmalloc'd, and the
shrinker skips dirty entries, so this memory cannot be reclaimed. When
node and meta blocks were in the page cache, the dirty pages were
counted as dirty page cache, and the flusher threads wrote them back in
the background.

A checkpoint=disable test that remounts the filesystem with
checkpoint=disable and runs fsstress -p 32 for 300 seconds left about
160K dirty node caches (2.7GB of kmalloc-16k) with 16KB blocks and
about 226K with 4KB blocks in QEMU, and drop_caches freed none of them.

While checkpoint is disabled, wake up the thread from
f2fs_mark_cache_dirty() once there are as many dirty node or meta
caches as f2fs_write_node_caches() and f2fs_write_meta_caches() collect
before writing, and let the thread go on without waiting while that is
still true and each round writes some of them. Each round writes the
same number of caches as before. Split nr_caches_to_collect() out of
nr_caches_to_skip() to share these numbers without the dirty_exceeded
check.

With this, the same test keeps about 4K dirty node caches with both
4KB and 16KB blocks. Nothing changes while checkpoint is enabled.

Fixes: 7a1cf2a76b71 ("f2fs: cache: use meta cache")
Fixes: 493b9dc8b52c ("f2fs: cache: use node cache")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/cache.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/cache.h   |  1 +
 fs/f2fs/segment.h | 13 +++++++----
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 04b5408cbc5..6b6f49fae25 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -61,6 +61,42 @@ void f2fs_cache_update_tag(struct f2fs_cached_block *entry,
 	spin_unlock_irqrestore(&cache->tree_lock, flags);
 }
 
+/*
+ * While checkpoint is disabled, checkpoint does not write back dirty node and
+ * meta caches, and the writeback thread is the only one that writes them. Tell
+ * whether there are as many dirty caches as f2fs_write_node_caches() and
+ * f2fs_write_meta_caches() collect before writing, so that the thread should
+ * write them now instead of every cache_wb_interval.
+ */
+static bool f2fs_cache_wb_needed(struct f2fs_sb_info *sbi)
+{
+	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		return false;
+
+	return get_nr_caches(sbi, F2FS_DIRTY_NODES) >=
+				nr_caches_to_collect(sbi, NODE) ||
+		get_nr_caches(sbi, F2FS_DIRTY_META) >=
+				nr_caches_to_collect(sbi, META);
+}
+
+static void f2fs_wake_cache_wb_thread(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+
+	if (!f2fs_cache_wb_needed(sbi))
+		return;
+
+	/* pairs with smp_store_release() in f2fs_start_cache_wb_thread() */
+	if (!smp_load_acquire(&cache_thread->cache_wb_task))
+		return;
+
+	if (READ_ONCE(cache_thread->cache_wb_urgent))
+		return;
+
+	WRITE_ONCE(cache_thread->cache_wb_urgent, true);
+	wake_up(&cache_thread->cache_wb_wq);
+}
+
 bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 {
 	struct f2fs_cached_block_list *cache = entry->cache;
@@ -81,6 +117,7 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
 						F2FS_CACHE_TAG_DIRTY);
 		inc_cache_count(cache->sbi, type);
+		f2fs_wake_cache_wb_thread(cache->sbi);
 		return true;
 	}
 
@@ -679,10 +716,13 @@ static int f2fs_cache_writeback_kthread(void *data)
 
 	while (!kthread_should_stop()) {
 		unsigned int interval = cache_thread->cache_wb_interval;
+		s64 nr_dirty;
 
 		wait_event_freezable_timeout(*wq,
-				kthread_should_stop(),
+				kthread_should_stop() ||
+				READ_ONCE(cache_thread->cache_wb_urgent),
 				msecs_to_jiffies(interval));
+		WRITE_ONCE(cache_thread->cache_wb_urgent, false);
 
 		if (kthread_should_stop())
 			break;
@@ -699,10 +739,23 @@ static int f2fs_cache_writeback_kthread(void *data)
 		if (!sb_start_write_trylock(sbi->sb))
 			continue;
 
+		nr_dirty = get_nr_caches(sbi, F2FS_DIRTY_NODES) +
+				get_nr_caches(sbi, F2FS_DIRTY_META);
+
 		f2fs_write_meta_caches(sbi);
 		f2fs_write_node_caches(sbi);
 
 		sb_end_write(sbi->sb);
+
+		/*
+		 * Each round writes a limited number of caches. Go on without
+		 * waiting while there are still many dirty caches, as long as
+		 * this round wrote some of them.
+		 */
+		if (f2fs_cache_wb_needed(sbi) &&
+			get_nr_caches(sbi, F2FS_DIRTY_NODES) +
+			get_nr_caches(sbi, F2FS_DIRTY_META) < nr_dirty)
+			WRITE_ONCE(cache_thread->cache_wb_urgent, true);
 	}
 	return 0;
 }
@@ -719,6 +772,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 
 	init_waitqueue_head(&cache_thread->cache_wb_wq);
 	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+	cache_thread->cache_wb_urgent = false;
 	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
 			MAJOR(dev), MINOR(dev));
 
@@ -726,7 +780,8 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 
-	cache_thread->cache_wb_task = task;
+	/* pairs with smp_load_acquire() in f2fs_wake_cache_wb_thread() */
+	smp_store_release(&cache_thread->cache_wb_task, task);
 	return 0;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 6c4db910d76..1d0216d2128 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -232,6 +232,7 @@ struct f2fs_cache_kthread {
 	struct task_struct *cache_wb_task;
 	wait_queue_head_t cache_wb_wq;
 	unsigned int cache_wb_interval;
+	bool cache_wb_urgent;		/* write back without waiting */
 };
 
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 526764ba31a..58804e9cc29 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -983,11 +983,8 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  * 512 blocks (2MB) * 8 for nodes, and
  * 256 blocks * 8 for meta are set.
  */
-static inline int nr_caches_to_skip(struct f2fs_sb_info *sbi, int type)
+static inline int nr_caches_to_collect(struct f2fs_sb_info *sbi, int type)
 {
-	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
-		return 0;
-
 	if (type == DATA)
 		return BLKS_PER_SEG(sbi);
 	else if (type == NODE)
@@ -998,6 +995,14 @@ static inline int nr_caches_to_skip(struct f2fs_sb_info *sbi, int type)
 		return 0;
 }
 
+static inline int nr_caches_to_skip(struct f2fs_sb_info *sbi, int type)
+{
+	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
+		return 0;
+
+	return nr_caches_to_collect(sbi, type);
+}
+
 /*
  * When writing cache asynchronously, align nr_to_write to BIO_MAX_VECS.
  */
-- 
2.56.0.360.g66cac248cb-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
