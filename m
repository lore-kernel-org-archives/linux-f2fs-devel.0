Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A88CA5FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DA65srNO6j5/urjZL2LjpGKnYPcdId1LwE0Zf4Pv2kM=; b=OBzceJO8zbTQVKZLM8S51sV/n8
	XHLcQ4or8JiQlPb6kaWmfC/ksndavjQyjYnVuipjGPMp804pUYTUm30hIYI8wo2IWTA6CVxktDS2y
	XtuGV/nfzrcV48qRfNqhWuC8C8XVnDZ/GvvBw8/cw7l+bec70t/A3thYPQ2lyhMf+jjU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHk-00064C-TI;
	Tue, 29 Sep 2026 07:29:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHj-000641-QP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aE1I0/rXduvVzNcY/5FqcjDdhs61coC5W9rRheefP40=; b=eEub7rYwxAQZ8ERofTUZH2XBfV
 WssuW6xTpBOaD0y4+XFs0UPpNceCg8kWOmgUZ3bmjBvyDaEUXKBXacnXXbdAYM4l+HQVsbTkWn2PK
 J+jn67knvJ6yMbKwmMblBYkqtoPgV4X+Y8j9iAzRwjdSEPgLfkFUvX2v2N8GNB7Buppo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aE1I0/rXduvVzNcY/5FqcjDdhs61coC5W9rRheefP40=; b=DPwFJemvFLhd02MN0WuPhfodBo
 qwxtpNz5C6yWB7mHuOW36vgvMdfmn0FL/c2S8JyNN74aXevChPaDB/LTcZXAC6YQUJRUcnWt5hmH3
 HV5e4slxL/5z1wPQwzm08kB0RkSzQxNbYvrX8InjdJTetOcU+urjvSoWJ2SOt4pGixj0=;
Received: from mail-pj2-f42.google.com ([74.125.227.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHi-0000Ee-NP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:56 +0000
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso2001553a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666989; x=1791271789; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aE1I0/rXduvVzNcY/5FqcjDdhs61coC5W9rRheefP40=;
 b=UvLLzEHQoWGw6PYmYoGL9u/12ouzyUi8Ey6QswheXouUqWdmyl6NExDwgd0Jci1jiw
 6UoymbInY3h3Xz6ZUObFn3rXbtfG/Pvp+EgQ8dfQ6Z0FSoYedGfKRrkwhnFssSnEqvs/
 8bIoRrtQumUsBgbK425z1qkZmF2WAb+aqlTjNxOVerZsB24giHHylC+ehfoDcnL3i9l1
 Hta4kX9uvCSF8gkM5DrjnDN9C/2vZsby2z8MOOHKbuj2ZxgXr06B0RnGcTM9AqgUaDez
 sF1FWlenM0weeKlbBQlNO2sBdSi8pHz3eBhi4Hfxa0bHa9+NX6mx7GBm121ezfmkWTHU
 v4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666989; x=1791271789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aE1I0/rXduvVzNcY/5FqcjDdhs61coC5W9rRheefP40=;
 b=suRyaXkflL0f+f9cWIVOpfCl932qSIyjakuCp0evADjAVF8KgMnKe2lBW9FV8SvKCX
 xtigq3FbAb6nx4fZnFN9lNL7Nm3N/YLa4OANhsoFVG1zAF+z6ToMVKPaw6g7WHOypE/l
 sd2QPa2dipvNewhd07l/YUVNLInNIsX5OmMK+mR7/7gB/RaeSTrx4ySsEa3RVNEx+YIB
 C2VdZdCu85bc0yD9bH5+n+2z5WHMa+PfJ1V74uNz7GJ4Gy8CFz+S8OVKfNtonsX/UMtb
 QCK/E9ibnmQkAfyM+pA9cVuLA2lwdw4f13izsbDi2ssva3CujkVTEbnA2nFru/gT0cb4
 ozLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByg9Pf8zZowikLBb+ZAe8xr/1xPEGnU90MRrCXJNH2TWbQPXFkStRfh9JmMmKeBKH89NWif1nL7BBF1uCl8w6X1@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLOODCPWx7Co9LBNwY7BA7LQvTiTbJ/nBQcqCgzuktlEnpYm836
 KQ6n1bVbpwpJnrEfO5gKHJQiRRLOu3vrotbL+65TY7iqI+qfm4swMfu+
X-Gm-Gg: AYBFou0cqKtLqpkOrAfdLY0bC+8E000vUOIUnV3uX+SyMKmFSj/9ba3CRzE3ZOSRKVm
 vCiW2VJ6w716/RG/VqA1XNujTmBc/8lqNU1E3CQpvJ/xL5Z9y5+UGmuGFOwRVd17owQ9OrXOXWg
 maXjXm4C3SHHM70L+Pv9Z2EkU4j4WpOcFXhPknupn3k/Kzn6kwYfhYX07NMbsa0lP/fOcEEYLye
 q/mvQKg7iwYVpmsHLoezETAS1D0G8/W7fJ3a4VZe1eerPEgHTr0eNf/KidRMdQvg0o5o7pr7BBj
 RJzLp1JaY7WdBSnNaSSVqwIjFoeInsbToD469jiGfaGz+vTZEwNzkFiVj6KS26ETFsND4/ZMvOh
 Gv/6H6ziBR2xgdWkwdARpduGTqaVv68FP2GT1fbFgaJZuZmHyfkdnZ48gNrTpsk390VUgpSnHWM
 k/AyyEbtHb22jp/oNBydSc5aLNYZRdCNawHm7RXcDWwLeHnMnnRCBr6YDyReYQag4ZIDPtkpH74
 fWlJXAqWql9PQITDpyZr5RV9HhhgdFyAoY=
X-Received: by 2002:a17:90b:440e:b0:3a0:bf0a:c9d0 with SMTP id
 98e67ed59e1d1-3a0bf0ad1bcmr7182042a91.16.1790666988800; 
 Tue, 29 Sep 2026 00:29:48 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:18 +0800
Message-ID: <2c7341e18d942d1643e0ce17f134e22765cd4e0b.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790665952.git.qiwenjie@xiaomi.com>
References: <cover.1790665952.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xBSHi-0000Ee-NP
Subject: [f2fs-dev] [RFC PATCH 5/6] f2fs: compress clean node cache entries
 in background
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
Cc: Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

With the compressed representation, restore path and reclaim policy in
place, add background conversion of cold clean node-cache entries.

Reuse the per-superblock cache thread. Writeback and compression keep
separate due times but execute serially. Each compression pass scans at
most 1024 raw entries, retains at most 256 candidates and reschedules after
every 32 candidates.

Compress outside the cache list and radix-tree locks, then revalidate the
entry before replacing its raw block. Expose only the compression threshold
and worker interval through sysfs.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  22 ++
 fs/f2fs/cache.c                         |  61 +++-
 fs/f2fs/cache.h                         |  15 +
 fs/f2fs/debug.c                         |  37 +++
 fs/f2fs/node_cache_compress.c           | 407 +++++++++++++++++++++++-
 fs/f2fs/node_cache_compress.h           |  37 +++
 fs/f2fs/node_cache_policy.c             |  48 +++
 fs/f2fs/node_cache_policy.h             |  24 +-
 fs/f2fs/sysfs.c                         |  59 ++++
 9 files changed, 691 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index c4746c416ac2..485d4231855f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1027,3 +1027,25 @@ Contact:	"Chao Yu" <chao@kernel.org>
 Description:	This is a writable entry to control writeback interval of
 		f2fs_writeback-x:y, the range is [100, 30000], by default the value
 		is 5000, unit is ms.
+
+What:		/sys/fs/f2fs/<disk>/node_compress_interval
+Date:		September 2026
+Contact:	"Wenjie Qi" <qiwenjie@xiaomi.com>
+Description:	This is a writable entry to control how often the background
+		node-cache compression worker runs. The range is [100, 30000],
+		default value is 1000, and the unit is ms. Updating the value
+		reschedules the next worker deadline but does not synchronously
+		cancel a cycle that is already running. This entry is present only
+		when CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION is enabled.
+
+What:		/sys/fs/f2fs/<disk>/node_compress_threshold
+Date:		September 2026
+Contact:	"Wenjie Qi" <qiwenjie@xiaomi.com>
+Description:	This is a writable entry to set the maximum compressed payload
+		length as a percentage of the filesystem block size. The range is
+		[0, 100], default value is 0, which disables background node-cache
+		compression. The effective payload limit is also capped at 1024 bytes.
+		Updating the value affects subsequent worker scheduling and cycles;
+		it does not synchronously cancel a cycle that is already running.
+		This entry is present only when
+		CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION is enabled.
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 9cb541dd5cea..b3158f4ab45c 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -686,6 +686,19 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 	return freed;
 }
 
+static void f2fs_try_write_caches(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_readonly(sbi->sb) || f2fs_cp_error(sbi) ||
+	    unlikely(freezing(current)))
+		return;
+	if (!sb_start_write_trylock(sbi->sb))
+		return;
+
+	f2fs_write_meta_caches(sbi);
+	f2fs_write_node_caches(sbi);
+	sb_end_write(sbi->sb);
+}
+
 static int f2fs_cache_writeback_kthread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
@@ -694,6 +707,32 @@ static int f2fs_cache_writeback_kthread(void *data)
 
 	set_freezable();
 
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	if (sbi->node_compress) {
+		while (!kthread_should_stop()) {
+			u64 now = ktime_to_ms(ktime_get());
+			u64 due = min(cache_thread->next_wb_ms,
+					f2fs_nc_next_deadline(sbi));
+
+			wait_event_freezable_timeout(*wq,
+						     kthread_should_stop(),
+				msecs_to_jiffies(due > now ? due - now : 0));
+			if (kthread_should_stop())
+				break;
+			now = ktime_to_ms(ktime_get());
+			if (now >= cache_thread->next_wb_ms) {
+				f2fs_try_write_caches(sbi);
+				WRITE_ONCE(cache_thread->next_wb_ms,
+					   ktime_to_ms(ktime_get()) +
+					   cache_thread->cache_wb_interval);
+			}
+			if (!freezing(current) &&
+			    ktime_to_ms(ktime_get()) >= f2fs_nc_next_deadline(sbi))
+				f2fs_nc_run(sbi);
+		}
+		return 0;
+	}
+#endif
 	while (!kthread_should_stop()) {
 		unsigned int interval = cache_thread->cache_wb_interval;
 
@@ -704,22 +743,7 @@ static int f2fs_cache_writeback_kthread(void *data)
 		if (kthread_should_stop())
 			break;
 
-		if (f2fs_readonly(sbi->sb))
-			continue;
-
-		if (f2fs_cp_error(sbi))
-			continue;
-
-		if (unlikely(freezing(current)))
-			continue;
-
-		if (!sb_start_write_trylock(sbi->sb))
-			continue;
-
-		f2fs_write_meta_caches(sbi);
-		f2fs_write_node_caches(sbi);
-
-		sb_end_write(sbi->sb);
+		f2fs_try_write_caches(sbi);
 	}
 	return 0;
 }
@@ -736,6 +760,11 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi)
 
 	init_waitqueue_head(&cache_thread->cache_wb_wq);
 	cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	cache_thread->next_wb_ms = ktime_to_ms(ktime_get()) +
+					cache_thread->cache_wb_interval;
+	f2fs_nc_schedule_start(sbi, ktime_to_ms(ktime_get()));
+#endif
 	snprintf(name, sizeof(name), "f2fs_writeback-%u:%u",
 			MAJOR(dev), MINOR(dev));
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 603c5f7203b7..3c1fdc7894b7 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -67,6 +67,7 @@ enum f2fs_cached_state {
 #ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
 	F2FS_BLOCK_COMPRESSED,
 	F2FS_BLOCK_RESTORED,
+	F2FS_BLOCK_INCOMPRESSIBLE,
 #endif
 };
 
@@ -155,6 +156,9 @@ F2FS_CACHE_FLAG_CLEAR_FUNC(compressed, COMPRESSED);
 F2FS_CACHE_FLAG_TEST_FUNC(restored, RESTORED);
 F2FS_CACHE_FLAG_SET_FUNC(restored, RESTORED);
 F2FS_CACHE_FLAG_CLEAR_FUNC(restored, RESTORED);
+F2FS_CACHE_FLAG_TEST_FUNC(incompressible, INCOMPRESSIBLE);
+F2FS_CACHE_FLAG_SET_FUNC(incompressible, INCOMPRESSIBLE);
+F2FS_CACHE_FLAG_CLEAR_FUNC(incompressible, INCOMPRESSIBLE);
 #else
 static inline bool f2fs_cache_test_compressed(const struct f2fs_cached_block *entry)
 {
@@ -171,6 +175,14 @@ static inline bool f2fs_cache_test_restored(const struct f2fs_cached_block *entr
 
 static inline void f2fs_cache_set_restored(struct f2fs_cached_block *entry) { }
 static inline void f2fs_cache_clear_restored(struct f2fs_cached_block *entry) { }
+static inline bool
+f2fs_cache_test_incompressible(const struct f2fs_cached_block *entry)
+{
+	return false;
+}
+
+static inline void f2fs_cache_set_incompressible(struct f2fs_cached_block *entry) { }
+static inline void f2fs_cache_clear_incompressible(struct f2fs_cached_block *entry) { }
 #endif
 
 static inline void *cache_address(const struct f2fs_cached_block *entry)
@@ -264,6 +276,9 @@ struct f2fs_cache_kthread {
 	struct task_struct *cache_wb_task;
 	wait_queue_head_t cache_wb_wq;
 	unsigned int cache_wb_interval;
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	u64 next_wb_ms;
+#endif
 };
 
 int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a6096537b495..984fed727a48 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -713,6 +713,43 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - compress: %4d, hit:%8d\n", si->compress_pages, si->compress_page_hit);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_caches);
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+		{
+			struct f2fs_nc_stats nc;
+
+			f2fs_nc_get_stats(sbi, &nc);
+			seq_printf(s,
+				   "NodeCacheCompress: initialized=%u threshold=%u interval=%u\n",
+				nc.initialized, nc.threshold_pct, nc.interval_ms);
+			seq_printf(s,
+				   "NCQueues: raw=%llu 256=%llu 512=%llu 1024=%llu payload=%llu/%llu/%llu slots=%llu/%llu/%llu\n",
+				nc.attached[F2FS_NC_RAW], nc.attached[F2FS_NC_256],
+				nc.attached[F2FS_NC_512], nc.attached[F2FS_NC_1024],
+				nc.payload[0], nc.payload[1], nc.payload[2],
+				nc.slots[0], nc.slots[1], nc.slots[2]);
+			seq_printf(s,
+				   "NCWorker: cycles=%llu visited=%llu candidates=%llu attempts=%llu converted=%llu candidate_refs=%llu transient=%llu alloc_fail=%llu\n",
+				nc.cycles, nc.visited, nc.candidates, nc.attempts,
+				nc.converted, nc.candidate_refs,
+				nc.transient_extra_bytes, nc.allocation_failures);
+			seq_printf(s,
+				   "NCRestore: compressed_to_raw=%llu restored_hits=%llu restore_failures=%llu\n",
+				nc.compressed_to_raw, nc.restored_hits,
+				nc.restore_failures);
+			seq_printf(s,
+				   "NCReclaim: scanned=%llu/%llu/%llu/%llu freed=%llu/%llu/%llu/%llu detached=%llu/%llu/%llu/%llu\n",
+				nc.shrink_scanned[F2FS_NC_RAW],
+				nc.shrink_scanned[F2FS_NC_256],
+				nc.shrink_scanned[F2FS_NC_512],
+				nc.shrink_scanned[F2FS_NC_1024],
+				nc.shrink_freed[F2FS_NC_RAW],
+				nc.shrink_freed[F2FS_NC_256],
+				nc.shrink_freed[F2FS_NC_512],
+				nc.shrink_freed[F2FS_NC_1024],
+				nc.detached[F2FS_NC_RAW], nc.detached[F2FS_NC_256],
+				nc.detached[F2FS_NC_512], nc.detached[F2FS_NC_1024]);
+		}
+#endif
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
 			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
 		seq_printf(s, "  - data: %4d in files:%4d\n",
diff --git a/fs/f2fs/node_cache_compress.c b/fs/f2fs/node_cache_compress.c
index 9c2d19e5e821..6e474fea7241 100644
--- a/fs/f2fs/node_cache_compress.c
+++ b/fs/f2fs/node_cache_compress.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/atomic.h>
 #include <linux/f2fs_fs.h>
+#include <linux/kthread.h>
 #include <linux/lz4.h>
 #include <linux/refcount.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
 #include "f2fs.h"
 #include "node_cache_compress.h"
 
+#define F2FS_NC_ALLOC_BACKOFF_MS		1000U
+#define F2FS_NC_PROCESS_BATCH		32U
+
 static const u32 f2fs_nc_bucket_sizes[] = {
 	F2FS_NC_BUCKET_256_SIZE,
 	F2FS_NC_BUCKET_512_SIZE,
@@ -20,6 +25,18 @@ struct f2fs_nc_store {
 	atomic_long_t objects[ARRAY_SIZE(f2fs_nc_bucket_sizes)];
 };
 
+static int f2fs_nc_store_bucket(u32 len)
+{
+	int i;
+
+	if (!len)
+		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(f2fs_nc_bucket_sizes); i++)
+		if (len <= f2fs_nc_bucket_sizes[i])
+			return i;
+	return -E2BIG;
+}
+
 static int f2fs_nc_store_bucket_from_size(u32 alloc_size)
 {
 	int i;
@@ -72,6 +89,22 @@ static void f2fs_nc_store_destroy(struct f2fs_nc_store *store)
 	kfree(store);
 }
 
+static void *f2fs_nc_store_alloc(struct f2fs_nc_store *store, u32 len,
+				 gfp_t gfp, u32 *alloc_size)
+{
+	void *object;
+	int bucket = f2fs_nc_store_bucket(len);
+
+	if (!store || !alloc_size || bucket < 0)
+		return NULL;
+	object = kmem_cache_alloc(store->caches[bucket], gfp);
+	if (!object)
+		return NULL;
+	atomic_long_inc(&store->objects[bucket]);
+	*alloc_size = f2fs_nc_bucket_sizes[bucket];
+	return object;
+}
+
 static void f2fs_nc_store_free(struct f2fs_nc_store *store, void *object,
 			       u32 alloc_size)
 {
@@ -90,20 +123,35 @@ static void f2fs_nc_store_free(struct f2fs_nc_store *store, void *object,
 struct f2fs_nc_ctx {
 	struct f2fs_sb_info *sbi;
 	struct f2fs_nc_store *store;
+	/* Per-mount workspace used only by the cache thread. */
+	void *workmem;
+	void *scratch;
+	struct f2fs_cached_block **candidates;
+	spinlock_t config_lock;		/* protect config and next deadline */
+	struct f2fs_nc_config config;
 	/* Compressed queues only; raw entries use NODE_CACHE()->lru_list. */
 	struct list_head queues[F2FS_NC_NR_QUEUES - 1];
 	/* Current population and compressed bytes by queue. */
 	atomic_long_t attached[F2FS_NC_NR_QUEUES];
 	atomic64_t attached_payload[F2FS_NC_NR_QUEUES - 1];
 	atomic64_t attached_slot_bytes[F2FS_NC_NR_QUEUES - 1];
-	/* Cumulative reclaim and detach statistics since mount. */
+	/* Cumulative reclaim, detach, restore and worker statistics. */
 	atomic64_t shrink_scanned[F2FS_NC_NR_QUEUES];
 	atomic64_t shrink_freed[F2FS_NC_NR_QUEUES];
 	atomic64_t detached[F2FS_NC_NR_QUEUES];
-	/* Cumulative restore statistics since mount. */
 	atomic64_t compressed_to_raw;
 	atomic64_t restored_hits;
 	atomic64_t restore_failures;
+	atomic64_t cycles;
+	atomic64_t visited;
+	atomic64_t candidate_count;
+	atomic64_t attempts;
+	atomic64_t converted;
+	atomic64_t candidate_refs;
+	atomic64_t transient_extra_bytes;
+	atomic64_t allocation_failures;
+	/* Absolute CLOCK_MONOTONIC deadline; U64_MAX disables scheduling. */
+	u64 next_compress_ms;
 	/* Signed quota history carried between shrinker calls. */
 	s64 shrink_credit[F2FS_NC_NR_QUEUES];
 	/* Mount reference plus references held by compressed objects. */
@@ -121,6 +169,11 @@ static void f2fs_nc_ctx_release(struct f2fs_nc_ctx *ctx)
 
 	for (i = 0; i < F2FS_NC_NR_QUEUES; i++)
 		WARN_ON_ONCE(atomic_long_read(&ctx->attached[i]));
+	WARN_ON_ONCE(atomic64_read(&ctx->candidate_refs));
+	WARN_ON_ONCE(atomic64_read(&ctx->transient_extra_bytes));
+	kfree(ctx->candidates);
+	kfree(ctx->scratch);
+	kfree(ctx->workmem);
 	f2fs_nc_store_destroy(ctx->store);
 	kfree(ctx);
 }
@@ -131,6 +184,11 @@ static void f2fs_nc_ctx_put(struct f2fs_nc_ctx *ctx)
 		f2fs_nc_ctx_release(ctx);
 }
 
+static void f2fs_nc_ctx_get(struct f2fs_nc_ctx *ctx)
+{
+	refcount_inc(&ctx->refs);
+}
+
 static void f2fs_nc_account_add(struct f2fs_nc_ctx *ctx, unsigned int queue,
 				u32 len, u32 alloc_size)
 {
@@ -174,6 +232,18 @@ void f2fs_nc_init(struct f2fs_sb_info *sbi)
 	ctx->store = f2fs_nc_store_create(sbi);
 	if (!ctx->store)
 		goto fail_open;
+	ctx->workmem = kmalloc(LZ4_MEM_COMPRESS, GFP_NOFS);
+	if (!ctx->workmem)
+		goto fail_open;
+	ctx->scratch = kmalloc(F2FS_NC_MAX_OBJECT_SIZE, GFP_NOFS);
+	if (!ctx->scratch)
+		goto fail_open;
+	ctx->candidates = kcalloc(F2FS_NC_MAX_CANDIDATES,
+				  sizeof(*ctx->candidates), GFP_NOFS);
+	if (!ctx->candidates)
+		goto fail_open;
+	spin_lock_init(&ctx->config_lock);
+	f2fs_nc_config_defaults(&ctx->config);
 	for (i = 0; i < ARRAY_SIZE(ctx->queues); i++)
 		INIT_LIST_HEAD(&ctx->queues[i]);
 	refcount_set(&ctx->refs, 1);
@@ -197,6 +267,91 @@ void f2fs_nc_destroy(struct f2fs_sb_info *sbi)
 	f2fs_nc_ctx_put(ctx);
 }
 
+static void f2fs_nc_config_snapshot(struct f2fs_nc_ctx *ctx,
+				    struct f2fs_nc_config *cfg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->config_lock, flags);
+	*cfg = ctx->config;
+	spin_unlock_irqrestore(&ctx->config_lock, flags);
+}
+
+static u64 f2fs_nc_compress_deadline(const struct f2fs_nc_config *cfg,
+				     u64 now_ms)
+{
+	if (!cfg->compression_threshold_pct)
+		return U64_MAX;
+	return now_ms + cfg->compression_interval_ms;
+}
+
+u64 f2fs_nc_config_value(struct f2fs_sb_info *sbi, enum f2fs_nc_param id)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	struct f2fs_nc_config cfg;
+
+	if (!ctx) {
+		f2fs_nc_config_defaults(&cfg);
+		return f2fs_nc_config_get(&cfg, id);
+	}
+	f2fs_nc_config_snapshot(ctx, &cfg);
+	return f2fs_nc_config_get(&cfg, id);
+}
+
+int f2fs_nc_config_update(struct f2fs_sb_info *sbi,
+			  enum f2fs_nc_param id, u64 value)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	struct f2fs_nc_config old, new;
+	unsigned long flags;
+	int ret;
+
+	if (!ctx) {
+		f2fs_nc_config_defaults(&old);
+		ret = f2fs_nc_config_set(&new, &old, id, value);
+		if (ret)
+			return ret;
+		return f2fs_nc_config_get(&old, id) == value ? 0 : -EOPNOTSUPP;
+	}
+
+	spin_lock_irqsave(&ctx->config_lock, flags);
+	old = ctx->config;
+	ret = f2fs_nc_config_set(&new, &old, id, value);
+	if (ret)
+		goto out_unlock;
+	ctx->config = new;
+	ctx->next_compress_ms =
+		f2fs_nc_compress_deadline(&new, ktime_to_ms(ktime_get()));
+out_unlock:
+	spin_unlock_irqrestore(&ctx->config_lock, flags);
+	return ret;
+}
+
+u64 f2fs_nc_next_deadline(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	unsigned long flags;
+	u64 deadline;
+
+	if (!ctx)
+		return U64_MAX;
+	spin_lock_irqsave(&ctx->config_lock, flags);
+	deadline = ctx->next_compress_ms;
+	spin_unlock_irqrestore(&ctx->config_lock, flags);
+	return deadline;
+}
+
+void f2fs_nc_schedule_start(struct f2fs_sb_info *sbi, u64 now_ms)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	unsigned long flags;
+
+	if (!ctx)
+		return;
+	spin_lock_irqsave(&ctx->config_lock, flags);
+	ctx->next_compress_ms = f2fs_nc_compress_deadline(&ctx->config, now_ms);
+	spin_unlock_irqrestore(&ctx->config_lock, flags);
+}
 struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
 				     unsigned int queue)
 {
@@ -407,6 +562,214 @@ void f2fs_nc_content_changed(struct f2fs_cached_block *entry)
 		return;
 	WARN_ON_ONCE(f2fs_cache_test_compressed(entry));
 	f2fs_cache_clear_restored(entry);
+	f2fs_cache_clear_incompressible(entry);
+}
+
+static bool f2fs_nc_candidate(struct f2fs_cached_block *entry,
+			      struct f2fs_cached_block_list *cache, int refs)
+{
+	return entry->cache == cache && entry->data &&
+		!f2fs_cache_test_compressed(entry) &&
+		f2fs_cache_test_uptodate(entry) &&
+		!f2fs_cache_test_dirty(entry) &&
+		!f2fs_cache_test_writeback(entry) &&
+		!f2fs_cache_test_locked(entry) &&
+		!f2fs_cache_test_referenced(entry) &&
+		!f2fs_cache_test_incompressible(entry) &&
+		atomic_read(&entry->refcount) == refs;
+}
+
+enum f2fs_nc_compress_result {
+	F2FS_NC_COMPRESS_SKIPPED,
+	F2FS_NC_COMPRESS_CONVERTED,
+	F2FS_NC_COMPRESS_NO_MEMORY,
+};
+
+static enum f2fs_nc_compress_result
+f2fs_nc_compress(struct f2fs_cached_block *entry,
+		 const struct f2fs_nc_config *cfg)
+{
+	struct f2fs_cached_block_list *cache = entry->cache;
+	struct f2fs_node_cached_block *node;
+	struct f2fs_nc_ctx *ctx;
+	struct f2fs_sb_info *sbi;
+	unsigned long flags;
+	unsigned int max_len;
+	void *object;
+	void *raw;
+	u32 alloc_size;
+	u32 crc;
+	int bucket;
+	int len;
+
+	if (!cache || !IS_NODE_CACHE(cache) || !cfg ||
+	    f2fs_cache_test_compressed(entry))
+		return F2FS_NC_COMPRESS_SKIPPED;
+	if (WARN_ON_ONCE(!f2fs_cache_test_locked(entry)))
+		return F2FS_NC_COMPRESS_SKIPPED;
+	if (!f2fs_cache_test_uptodate(entry) || f2fs_cache_test_dirty(entry) ||
+	    f2fs_cache_test_writeback(entry) ||
+	    f2fs_cache_test_referenced(entry) ||
+	    f2fs_cache_test_incompressible(entry) || !entry->data ||
+	    atomic_read(&entry->refcount) != 2)
+		return F2FS_NC_COMPRESS_SKIPPED;
+
+	sbi = cache->sbi;
+	ctx = sbi->node_compress;
+	if (!ctx || !cfg->compression_threshold_pct)
+		return F2FS_NC_COMPRESS_SKIPPED;
+	max_len = min_t(u64,
+			(u64)sbi->blocksize * cfg->compression_threshold_pct /
+			F2FS_NC_PERCENT_MAX,
+			F2FS_NC_MAX_OBJECT_SIZE);
+	if (!max_len)
+		return F2FS_NC_COMPRESS_SKIPPED;
+
+	atomic64_inc(&ctx->attempts);
+	len = LZ4_compress_default(entry->data, ctx->scratch, sbi->blocksize,
+				   max_len, ctx->workmem);
+	if (len <= 0) {
+		if (max_len == F2FS_NC_MAX_OBJECT_SIZE)
+			f2fs_cache_set_incompressible(entry);
+		return F2FS_NC_COMPRESS_SKIPPED;
+	}
+	object = f2fs_nc_store_alloc(ctx->store, len, GFP_NOFS, &alloc_size);
+	if (!object) {
+		atomic64_inc(&ctx->allocation_failures);
+		return F2FS_NC_COMPRESS_NO_MEMORY;
+	}
+	bucket = f2fs_nc_store_bucket_from_size(alloc_size);
+	if (WARN_ON_ONCE(bucket < 0)) {
+		f2fs_nc_store_free(ctx->store, object, alloc_size);
+		return F2FS_NC_COMPRESS_SKIPPED;
+	}
+	/*
+	 * Before publication only the new slot is extra.  After publication,
+	 * the old raw block remains the extra allocation until it is freed.
+	 */
+	atomic64_add(alloc_size, &ctx->transient_extra_bytes);
+	memcpy(object, ctx->scratch, len);
+	raw = entry->data;
+	crc = f2fs_crc32(raw, sbi->blocksize);
+
+	spin_lock(&cache->list_lock);
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	if (entry->cache != cache || entry->data != raw ||
+	    atomic_read(&entry->refcount) != 2 || f2fs_cp_error(sbi) ||
+	    f2fs_cache_test_referenced(entry) ||
+	    !f2fs_cache_test_uptodate(entry) || f2fs_cache_test_dirty(entry) ||
+	    f2fs_cache_test_writeback(entry) ||
+	    f2fs_cache_test_incompressible(entry)) {
+		spin_unlock_irqrestore(&cache->tree_lock, flags);
+		spin_unlock(&cache->list_lock);
+		f2fs_nc_store_free(ctx->store, object, alloc_size);
+		atomic64_sub(alloc_size, &ctx->transient_extra_bytes);
+		return F2FS_NC_COMPRESS_SKIPPED;
+	}
+	node = f2fs_nc_node_entry(entry);
+	f2fs_nc_ctx_get(ctx);
+	node->owner = ctx;
+	node->compressed_len = len;
+	node->compressed_alloc_size = alloc_size;
+	node->compressed_crc = crc;
+	entry->data = object;
+	f2fs_cache_set_compressed(entry);
+	list_move_tail(&entry->list, &ctx->queues[bucket]);
+	f2fs_nc_account_del(ctx, F2FS_NC_RAW, 0, 0);
+	f2fs_nc_account_add(ctx, bucket + 1, len, alloc_size);
+	atomic64_add((s64)sbi->blocksize - alloc_size,
+		     &ctx->transient_extra_bytes);
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	spin_unlock(&cache->list_lock);
+
+	kfree(raw);
+	atomic64_sub(sbi->blocksize, &ctx->transient_extra_bytes);
+	atomic64_inc(&ctx->converted);
+	return F2FS_NC_COMPRESS_CONVERTED;
+}
+
+void f2fs_nc_run(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	struct f2fs_cached_block_list *cache = NODE_CACHE(sbi);
+	struct f2fs_nc_config cfg;
+	struct f2fs_cached_block *entry;
+	unsigned long flags;
+	u64 now_ms;
+	unsigned long raw_population;
+	unsigned int goal, visited = 0, count = 0, i;
+	bool allocation_failed = false;
+
+	if (!ctx)
+		return;
+	f2fs_nc_config_snapshot(ctx, &cfg);
+	if (!cfg.compression_threshold_pct || f2fs_cp_error(sbi) ||
+	    f2fs_readonly(sbi->sb))
+		goto out;
+	/* Count enabled worker passes, including passes with no candidates. */
+	atomic64_inc(&ctx->cycles);
+	raw_population = atomic_long_read(&ctx->attached[F2FS_NC_RAW]);
+	goal = min_t(unsigned long, raw_population, F2FS_NC_SCAN_MAX);
+	if (!goal)
+		goto out;
+
+	spin_lock(&cache->list_lock);
+	list_for_each_entry(entry, &cache->lru_list, list) {
+		if (visited == goal || count == F2FS_NC_MAX_CANDIDATES)
+			break;
+		visited++;
+		if (!f2fs_nc_candidate(entry, cache, 1))
+			continue;
+		f2fs_cache_get(entry);
+		ctx->candidates[count++] = entry;
+		atomic64_inc(&ctx->candidate_refs);
+	}
+	spin_unlock(&cache->list_lock);
+	atomic64_add(visited, &ctx->visited);
+	atomic64_add(count, &ctx->candidate_count);
+
+	for (i = 0; i < count; i++) {
+		enum f2fs_nc_compress_result compress_result =
+			F2FS_NC_COMPRESS_SKIPPED;
+
+		entry = ctx->candidates[i];
+		if (f2fs_trylock_cache(entry)) {
+			compress_result = f2fs_nc_compress(entry, &cfg);
+			f2fs_unlock_cache(entry);
+		}
+		f2fs_put_cache(entry, false);
+		atomic64_dec(&ctx->candidate_refs);
+		ctx->candidates[i] = NULL;
+		switch (compress_result) {
+		case F2FS_NC_COMPRESS_CONVERTED:
+			break;
+		case F2FS_NC_COMPRESS_NO_MEMORY:
+			allocation_failed = true;
+			i++;
+			goto put_remaining;
+		case F2FS_NC_COMPRESS_SKIPPED:
+			break;
+		}
+		if ((i + 1) % F2FS_NC_PROCESS_BATCH == 0)
+			cond_resched();
+	}
+put_remaining:
+	for (; i < count; i++) {
+		f2fs_put_cache(ctx->candidates[i], false);
+		atomic64_dec(&ctx->candidate_refs);
+		ctx->candidates[i] = NULL;
+	}
+out:
+	now_ms = ktime_to_ms(ktime_get());
+	spin_lock_irqsave(&ctx->config_lock, flags);
+	if (allocation_failed && ctx->config.compression_threshold_pct)
+		WRITE_ONCE(ctx->next_compress_ms, now_ms +
+			   max_t(u32, ctx->config.compression_interval_ms,
+				 F2FS_NC_ALLOC_BACKOFF_MS));
+	else
+		WRITE_ONCE(ctx->next_compress_ms,
+			   f2fs_nc_compress_deadline(&ctx->config, now_ms));
+	spin_unlock_irqrestore(&ctx->config_lock, flags);
 }
 
 static void f2fs_nc_population_snapshot(struct f2fs_nc_ctx *ctx,
@@ -492,3 +855,43 @@ void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
 	memory->entry_bytes = entries * sizeof(struct f2fs_node_cached_block);
 	memory->data_bytes = data;
 }
+
+void f2fs_nc_get_stats(struct f2fs_sb_info *sbi,
+		       struct f2fs_nc_stats *stats)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	struct f2fs_nc_config cfg;
+	unsigned int i;
+
+	memset(stats, 0, sizeof(*stats));
+	if (!ctx)
+		return;
+	f2fs_nc_config_snapshot(ctx, &cfg);
+	stats->initialized = true;
+	stats->threshold_pct = cfg.compression_threshold_pct;
+	stats->interval_ms = cfg.compression_interval_ms;
+	for (i = 0; i < F2FS_NC_NR_QUEUES; i++) {
+		stats->attached[i] = atomic_long_read(&ctx->attached[i]);
+		stats->shrink_scanned[i] = atomic64_read(&ctx->shrink_scanned[i]);
+		stats->shrink_freed[i] = atomic64_read(&ctx->shrink_freed[i]);
+		stats->detached[i] = atomic64_read(&ctx->detached[i]);
+		if (i != F2FS_NC_RAW) {
+			stats->payload[i - 1] =
+				atomic64_read(&ctx->attached_payload[i - 1]);
+			stats->slots[i - 1] =
+				atomic64_read(&ctx->attached_slot_bytes[i - 1]);
+		}
+	}
+	stats->compressed_to_raw = atomic64_read(&ctx->compressed_to_raw);
+	stats->restored_hits = atomic64_read(&ctx->restored_hits);
+	stats->restore_failures = atomic64_read(&ctx->restore_failures);
+	stats->cycles = atomic64_read(&ctx->cycles);
+	stats->visited = atomic64_read(&ctx->visited);
+	stats->candidates = atomic64_read(&ctx->candidate_count);
+	stats->attempts = atomic64_read(&ctx->attempts);
+	stats->converted = atomic64_read(&ctx->converted);
+	stats->candidate_refs = atomic64_read(&ctx->candidate_refs);
+	stats->transient_extra_bytes =
+		atomic64_read(&ctx->transient_extra_bytes);
+	stats->allocation_failures = atomic64_read(&ctx->allocation_failures);
+}
diff --git a/fs/f2fs/node_cache_compress.h b/fs/f2fs/node_cache_compress.h
index faeb342b9cc3..efe2eceef352 100644
--- a/fs/f2fs/node_cache_compress.h
+++ b/fs/f2fs/node_cache_compress.h
@@ -13,6 +13,33 @@ struct f2fs_nc_memory {
 	u64 data_bytes;	/* Raw buffers plus compressed slab slots. */
 };
 
+/* Snapshot used by debugfs; queue arrays use enum f2fs_nc_queue. */
+struct f2fs_nc_stats {
+	/* Current queue state; payload and slots start at F2FS_NC_256. */
+	u64 attached[F2FS_NC_NR_QUEUES];
+	u64 payload[F2FS_NC_NR_QUEUES - 1];
+	u64 slots[F2FS_NC_NR_QUEUES - 1];
+	/* Cumulative statistics since mount. */
+	u64 shrink_scanned[F2FS_NC_NR_QUEUES];
+	u64 shrink_freed[F2FS_NC_NR_QUEUES];
+	u64 detached[F2FS_NC_NR_QUEUES];
+	u64 compressed_to_raw;
+	u64 restored_hits;
+	u64 restore_failures;
+	u64 cycles;
+	u64 visited;
+	u64 candidates;
+	u64 attempts;
+	u64 converted;
+	u64 candidate_refs;		/* Worker-held references right now. */
+	u64 transient_extra_bytes;	/* Temporary raw/compressed overlap. */
+	u64 allocation_failures;
+	/* Current configuration snapshot. */
+	u32 threshold_pct;
+	u32 interval_ms;
+	bool initialized;		/* A compression context is available. */
+};
+
 #ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
 /* Extended NODE_CACHE entry; base must remain the first member. */
 struct f2fs_node_cached_block {
@@ -28,6 +55,13 @@ static_assert(offsetof(struct f2fs_node_cached_block, base) == 0);
 size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache);
 void f2fs_nc_init(struct f2fs_sb_info *sbi);
 void f2fs_nc_destroy(struct f2fs_sb_info *sbi);
+u64 f2fs_nc_next_deadline(struct f2fs_sb_info *sbi);
+void f2fs_nc_schedule_start(struct f2fs_sb_info *sbi, u64 now_ms);
+void f2fs_nc_run(struct f2fs_sb_info *sbi);
+u64 f2fs_nc_config_value(struct f2fs_sb_info *sbi,
+			 enum f2fs_nc_param id);
+int f2fs_nc_config_update(struct f2fs_sb_info *sbi,
+			  enum f2fs_nc_param id, u64 value);
 void f2fs_nc_free_data(struct f2fs_cached_block *entry);
 int f2fs_nc_restore(struct f2fs_cached_block *entry);
 void f2fs_nc_validation_failed(struct f2fs_cached_block *entry);
@@ -43,6 +77,8 @@ unsigned long f2fs_nc_shrink_nodes(struct f2fs_sb_info *sbi,
 				   unsigned long nr_to_scan);
 void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
 			  struct f2fs_nc_memory *memory);
+void f2fs_nc_get_stats(struct f2fs_sb_info *sbi,
+		       struct f2fs_nc_stats *stats);
 #else
 static inline size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache)
 {
@@ -101,6 +137,7 @@ static inline void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
 			sizeof(struct f2fs_cached_block);
 	memory->data_bytes = (u64)NODE_CACHE(sbi)->num_entries * sbi->blocksize;
 }
+
 #endif
 
 #endif /* __F2FS_NODE_CACHE_COMPRESS_H__ */
diff --git a/fs/f2fs/node_cache_policy.c b/fs/f2fs/node_cache_policy.c
index 3adcbf89d37d..7c82557c05ff 100644
--- a/fs/f2fs/node_cache_policy.c
+++ b/fs/f2fs/node_cache_policy.c
@@ -9,6 +9,54 @@
 #define F2FS_NC_RECLAIM_SCALE_PCT	25U
 #define F2FS_NC_SCORE_HEADROOM		4U
 
+void f2fs_nc_config_defaults(struct f2fs_nc_config *cfg)
+{
+	*cfg = (struct f2fs_nc_config) {
+		.compression_threshold_pct = F2FS_NC_DEFAULT_THRESHOLD_PCT,
+		.compression_interval_ms = F2FS_NC_DEFAULT_INTERVAL_MS,
+	};
+}
+
+int f2fs_nc_config_set(struct f2fs_nc_config *out,
+		       const struct f2fs_nc_config *old, enum f2fs_nc_param id, u64 value)
+{
+	struct f2fs_nc_config new;
+
+	if (!out || !old)
+		return -EINVAL;
+	new = *old;
+	switch (id) {
+	case F2FS_NC_PARAM_THRESHOLD:
+		if (value > F2FS_NC_PERCENT_MAX)
+			return -ERANGE;
+		new.compression_threshold_pct = value;
+		break;
+	case F2FS_NC_PARAM_INTERVAL:
+		if (value < F2FS_NC_MIN_INTERVAL_MS ||
+		    value > F2FS_NC_MAX_INTERVAL_MS)
+			return -ERANGE;
+		new.compression_interval_ms = value;
+		break;
+	default:
+		return -EINVAL;
+	}
+	*out = new;
+	return 0;
+}
+
+u64 f2fs_nc_config_get(const struct f2fs_nc_config *cfg,
+		       enum f2fs_nc_param id)
+{
+	switch (id) {
+	case F2FS_NC_PARAM_THRESHOLD:
+		return cfg->compression_threshold_pct;
+	case F2FS_NC_PARAM_INTERVAL:
+		return cfg->compression_interval_ms;
+	default:
+		return 0;
+	}
+}
+
 static void f2fs_nc_queue_weights(u32 blocksize,
 				  u64 weight[F2FS_NC_NR_QUEUES])
 {
diff --git a/fs/f2fs/node_cache_policy.h b/fs/f2fs/node_cache_policy.h
index 42af4ad1698f..fb305413aad6 100644
--- a/fs/f2fs/node_cache_policy.h
+++ b/fs/f2fs/node_cache_policy.h
@@ -4,11 +4,17 @@
 
 #include <linux/types.h>
 
+#define F2FS_NC_PERCENT_MAX		100U
+#define F2FS_NC_DEFAULT_THRESHOLD_PCT	0U
+#define F2FS_NC_DEFAULT_INTERVAL_MS	1000U
+#define F2FS_NC_MIN_INTERVAL_MS		100U
+#define F2FS_NC_MAX_INTERVAL_MS		30000U
+#define F2FS_NC_SCAN_MAX		1024U
+#define F2FS_NC_MAX_CANDIDATES		256U
 #define F2FS_NC_BUCKET_256_SIZE		256U
 #define F2FS_NC_BUCKET_512_SIZE		512U
 #define F2FS_NC_BUCKET_1024_SIZE	1024U
 #define F2FS_NC_MAX_OBJECT_SIZE		F2FS_NC_BUCKET_1024_SIZE
-#define F2FS_NC_PERCENT_MAX		100U
 
 /*
  * Keep compressed queues in the same order as f2fs_nc_bucket_sizes[].
@@ -22,6 +28,22 @@ enum f2fs_nc_queue {
 	F2FS_NC_NR_QUEUES,
 };
 
+enum f2fs_nc_param {
+	F2FS_NC_PARAM_THRESHOLD,
+	F2FS_NC_PARAM_INTERVAL,
+};
+
+struct f2fs_nc_config {
+	u32 compression_threshold_pct;	/* Max payload percentage; 0 disables. */
+	u32 compression_interval_ms;	/* Delay between worker passes, in ms. */
+};
+
+void f2fs_nc_config_defaults(struct f2fs_nc_config *cfg);
+int f2fs_nc_config_set(struct f2fs_nc_config *out,
+		       const struct f2fs_nc_config *old, enum f2fs_nc_param id, u64 value);
+u64 f2fs_nc_config_get(const struct f2fs_nc_config *cfg,
+		       enum f2fs_nc_param id);
+
 u64 f2fs_nc_effective_count(const unsigned long nr[F2FS_NC_NR_QUEUES],
 			    u32 blocksize);
 void f2fs_nc_scan_quotas(const unsigned long nr[F2FS_NC_NR_QUEUES],
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9749da70089a..ea657b6e7419 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -18,6 +18,7 @@
 #include "segment.h"
 #include "gc.h"
 #include "iostat.h"
+#include "node_cache_compress.h"
 #include <trace/events/f2fs.h>
 
 static struct proc_dir_entry *f2fs_proc_root;
@@ -312,6 +313,52 @@ static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
 	return sysfs_emit(buf, "%llu\n", SIT_I(sbi)->mounted_time);
 }
 
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+static ssize_t node_compress_interval_show(struct f2fs_attr *a,
+					   struct f2fs_sb_info *sbi, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+			f2fs_nc_config_value(sbi, F2FS_NC_PARAM_INTERVAL));
+}
+
+static ssize_t node_compress_threshold_show(struct f2fs_attr *a,
+					    struct f2fs_sb_info *sbi, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+			f2fs_nc_config_value(sbi, F2FS_NC_PARAM_THRESHOLD));
+}
+
+static ssize_t f2fs_nc_config_store(struct f2fs_sb_info *sbi,
+				    enum f2fs_nc_param id, const char *buf,
+				    size_t count)
+{
+	u64 value;
+	int ret;
+
+	if (kstrtou64(skip_spaces(buf), 0, &value))
+		return -EINVAL;
+	if (!down_read_trylock(&sbi->sb->s_umount))
+		return -EAGAIN;
+	ret = f2fs_nc_config_update(sbi, id, value);
+	up_read(&sbi->sb->s_umount);
+	return ret ? ret : count;
+}
+
+static ssize_t node_compress_interval_store(struct f2fs_attr *a,
+					    struct f2fs_sb_info *sbi,
+					    const char *buf, size_t count)
+{
+	return f2fs_nc_config_store(sbi, F2FS_NC_PARAM_INTERVAL, buf, count);
+}
+
+static ssize_t node_compress_threshold_store(struct f2fs_attr *a,
+					     struct f2fs_sb_info *sbi,
+					     const char *buf, size_t count)
+{
+	return f2fs_nc_config_store(sbi, F2FS_NC_PARAM_THRESHOLD, buf, count);
+}
+#endif
+
 #ifdef CONFIG_F2FS_STAT_FS
 static ssize_t moved_blocks_foreground_show(struct f2fs_attr *a,
 				struct f2fs_sb_info *sbi, char *buf)
@@ -1363,6 +1410,14 @@ ATGC_INFO_RW_ATTR(atgc_age_threshold, age_threshold);
 
 /* WB_THREAD ATTR */
 WB_THREAD_RW_ATTR(cache_wb_interval, cache_wb_interval);
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+static struct f2fs_attr f2fs_attr_node_compress_interval =
+	__ATTR(node_compress_interval, 0644, node_compress_interval_show,
+	       node_compress_interval_store);
+static struct f2fs_attr f2fs_attr_node_compress_threshold =
+	__ATTR(node_compress_threshold, 0644, node_compress_threshold_show,
+	       node_compress_threshold_store);
+#endif
 
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
@@ -1551,6 +1606,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(adjust_lock_priority),
 	ATTR_LIST(critical_task_priority),
 	ATTR_LIST(cache_wb_interval),
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	ATTR_LIST(node_compress_interval),
+	ATTR_LIST(node_compress_threshold),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
