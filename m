Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00E9CA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sA0CDuLlNBOe1ee8nLaqeRiUR0fnqxvgbzOF+pZ91+4=; b=Rg2g2fLj+OC/63sfr/MtD7zXfl
	DZg4AD5wEUpxtwf2bc+gByaklN5A+kW/jzb4t0rMp37u/zGnhhZcOdW+btNNS295MGFkaZnESlFwy
	eaRuj2Wlj1H6EVRAqzyCY8XdNwR1cAZxqonlGJdhkzGBwmJ0Qa5zI10QHs8C+RUhtXxM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF6lC-0003Gd-DY;
	Fri, 09 Oct 2026 09:19:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF6kz-0003GO-6O
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:19:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lmRsxzJpvFpXZtvtc8++BiVUKIRqaS/6hlFfbzTGoiU=; b=gUqF9dKvqmACIiG6ggBWsmx7xL
 hF2a3Dc54qZYPea+60ju/WVjDlae5QUwJ4oo9OF+XuhCAYNPX+FG/gnUXifYhF/p28LTzy+GCwTQ6
 ptex9Rr4+ufuGDuzTjTY0k5a/MTIPbcxr/xMEt8ga/iSFtiKE5IG3cZsxiLWjyNmw6aE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lmRsxzJpvFpXZtvtc8++BiVUKIRqaS/6hlFfbzTGoiU=; b=U
 diEA4MWJfSip0Rl+ABNdCdKHtxJrj3LnHUwYSd9hTroc+SumzBRYMDjxyD51jIQqkHN8mCge5gmeq
 JKzYgonfs5WfeBbQ9dPJzy4ZCsm+mPUfZQM1NcaxdRFGJsNw3atYfRUfJVmhptUJgco/47NSNgIpr
 lMpvzLcMGaNzDLHg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF6ky-0004is-Do for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 09:19:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CCF78602CA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  9 Oct 2026 09:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D091F000FF;
 Fri,  9 Oct 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791537546;
 bh=lmRsxzJpvFpXZtvtc8++BiVUKIRqaS/6hlFfbzTGoiU=;
 h=From:To:Cc:Subject:Date;
 b=VInPo4GuDlPuhjJf1epsdemGR3ejYwIvuJUga9DPNk8s8/Fw/n7Vd54MRES5f1rKi
 tIzentf7BFa7gYFC5c+Vgmt23XXBuAIVZJPj+QK8Z8DptJb4B9EuenP2tGehbVfWFv
 j3XrV1Z2Lo+jX0IGm2h6VGz702aOoZ+7LciBOBBu6j8h4E8sfkKB2GeHwyAWoE0pd0
 9kQ6boNnaSl7GnJp3WNtWLdsCG8cRnF6TPSZh0zFDQ1f3re345ksuSB3zj6KnAcIkI
 XHvf4JlOuELJvTkmJWyxlWhHaIjlhmGhYrIRFp+XKYsmEHiVzq64tv9TYqdLoNVpwY
 p2X64+NB7Y88A==
To: jaegeuk@kernel.org
Date: Fri,  9 Oct 2026 17:18:57 +0800
Message-ID: <20261009091857.1326197-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xF6ky-0004is-Do
Subject: [f2fs-dev] [PATCH v2 3/5] f2fs: cache: wake up f2fs_writeback when
 exceeding threshold
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

This patch introduces cache_wb_dirty_threshold and cache_wb_total_threshold
sysfs nodes under /sys/fs/f2fs/<disk>/, and allows waking up the
f2fs_writeback kthread when both thresholds are exceeded.

By default, cache_wb_total_threshold is zero, so if dirty cache number exceeds
cache_wb_dirty_threshold, it will trigger writebacking.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- don't wake up f2fs_writeback if both thresholds are zero.
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++
 fs/f2fs/cache.c                         | 55 ++++++++++++++++++++++++-
 fs/f2fs/cache.h                         |  5 +++
 fs/f2fs/sysfs.c                         |  8 +++-
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 5b196806b3bc..f50739f90ae9 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1027,3 +1027,17 @@ Contact:	"Chao Yu" <chao@kernel.org>
 Description:	This is a writable entry to control writeback interval of
 		f2fs_writeback-x:y, the range is [100, 30000], by default the value
 		is 5000, unit is ms.
+
+What:		/sys/fs/f2fs/<disk>/cache_wb_dirty_threshold
+Date:		October 2026
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	This is a writable entry for metadata cache, it is used to control
+		dirty cache threshold of to wake up f2fs_writeback-x:y for writeback,
+		by default the value is 8192, unit is blocks.
+
+What:		/sys/fs/f2fs/<disk>/cache_wb_total_threshold
+Date:		October 2026
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	This is a writable entry for metadata cache, it is used to control
+		total cache threshold to wake up f2fs_writeback-x:y for writeback,
+		by default the value is 0, unit is blocks.
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index f385fe928b5b..986e679f2d16 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -81,6 +81,7 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_NONE,
 						F2FS_CACHE_TAG_DIRTY);
 		inc_cache_count(cache->sbi, type);
+		f2fs_wake_up_cache_wb(cache->sbi);
 		return true;
 	}
 
@@ -681,6 +682,44 @@ unsigned long f2fs_shrink_node_cache(struct f2fs_sb_info *sbi,
 	return f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan);
 }
 
+static inline unsigned long f2fs_total_cached_entries(struct f2fs_sb_info *sbi)
+{
+	unsigned long total = META_CACHE(sbi)->num_entries +
+			      NODE_CACHE(sbi)->num_entries;
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+	if (test_opt(sbi, COMPRESS_CACHE))
+		total += COMPRESS_CACHE(sbi)->num_entries;
+#endif
+	return total;
+}
+
+static inline bool f2fs_should_wake_up_cache_wb(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+	unsigned int total_threshold;
+	unsigned int dirty_threshold;
+	s64 nr_dirty;
+
+	if (!cache_thread->cache_wb_task)
+		return false;
+
+	total_threshold = cache_thread->cache_wb_total_threshold;
+	dirty_threshold = cache_thread->cache_wb_dirty_threshold;
+
+	if (total_threshold &&
+		f2fs_total_cached_entries(sbi) < total_threshold)
+		return false;
+
+	nr_dirty = get_nr_caches(sbi, F2FS_DIRTY_META) +
+		   get_nr_caches(sbi, F2FS_DIRTY_NODES);
+
+	if (dirty_threshold && nr_dirty < dirty_threshold)
+		return false;
+
+	/* don't wake up f2fs_writeback if both thresholds are zero */
+	return total_threshold || dirty_threshold;
+}
+
 static int f2fs_cache_writeback_kthread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
@@ -693,7 +732,8 @@ static int f2fs_cache_writeback_kthread(void *data)
 		unsigned int interval = cache_thread->cache_wb_interval;
 
 		wait_event_freezable_timeout(*wq,
-				kthread_should_stop(),
+				kthread_should_stop() ||
+				f2fs_should_wake_up_cache_wb(sbi),
 				msecs_to_jiffies(interval));
 
 		if (kthread_should_stop())
@@ -719,6 +759,17 @@ static int f2fs_cache_writeback_kthread(void *data)
 	return 0;
 }
 
+void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
+
+	if (!f2fs_should_wake_up_cache_wb(sbi))
+		return;
+
+	if (wq_has_sleeper(&cache_thread->cache_wb_wq))
+		wake_up(&cache_thread->cache_wb_wq);
+}
+
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_cache_kthread *cache_thread = &sbi->cache_thread;
@@ -731,6 +782,8 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 
 	init_waitqueue_head(&cache_thread->cache_wb_wq);
 	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+	cache_thread->cache_wb_dirty_threshold = DEF_CACHE_WB_DIRTY_THRESH;
+	cache_thread->cache_wb_total_threshold = 0;
 	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
 			MAJOR(dev), MINOR(dev));
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 3df3a562c46f..7a94fb8139d3 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -234,13 +234,18 @@ unsigned long f2fs_shrink_node_cache(struct f2fs_sb_info *sbi,
 #define MIN_DIRTY_CACHE_TIMEOUT 100
 #define MAX_DIRTY_CACHE_TIMEOUT 30000
 
+#define DEF_CACHE_WB_DIRTY_THRESH	(8192)
+
 struct f2fs_cache_kthread {
 	struct task_struct *cache_wb_task;
 	wait_queue_head_t cache_wb_wq;
 	unsigned int cache_wb_interval;
+	unsigned int cache_wb_dirty_threshold;
+	unsigned int cache_wb_total_threshold;
 };
 
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_wake_up_cache_wb(struct f2fs_sb_info *sbi);
 
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index afce74744d4d..95f8dc0c4218 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1019,7 +1019,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 					a->struct_type == GC_THREAD);
 	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
 			!strcmp(a->attr.name, "critical_task_priority") ||
-			!strcmp(a->attr.name, "cache_wb_interval");
+			!strcmp(a->attr.name, "cache_wb_interval") ||
+			!strcmp(a->attr.name, "cache_wb_dirty_threshold") ||
+			!strcmp(a->attr.name, "cache_wb_total_threshold");
 
 	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
@@ -1363,6 +1365,8 @@ ATGC_INFO_RW_ATTR(atgc_age_threshold, age_threshold);
 
 /* WB_THREAD ATTR */
 WB_THREAD_RW_ATTR(cache_wb_interval, cache_wb_interval);
+WB_THREAD_RW_ATTR(cache_wb_dirty_threshold, cache_wb_dirty_threshold);
+WB_THREAD_RW_ATTR(cache_wb_total_threshold, cache_wb_total_threshold);
 
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
@@ -1552,6 +1556,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(adjust_lock_priority),
 	ATTR_LIST(critical_task_priority),
 	ATTR_LIST(cache_wb_interval),
+	ATTR_LIST(cache_wb_dirty_threshold),
+	ATTR_LIST(cache_wb_total_threshold),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
