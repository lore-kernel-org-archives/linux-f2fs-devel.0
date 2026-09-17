Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CB6C982D2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1V81BiO0NFf2j6vG775KhDt7OgZnS6v2/32mxVu5do=; b=l/6AEh4v/a2gpvYzJ6+OtzXDzJ
	AKTIVWXGi2iDXVpo6c7Dza4YxAQBLVNYM84m0ZhM1O7j14J51hJrB2K57xxpB4zyCepNItqLfFUCZ
	HutC0Vt0mxvqfbjNN3qt+hoaq56M3o3/+I8BEIb7Caa5vYjmKPthR7/YRbRXTVGe4Ay8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x76dK-0008P4-EM;
	Thu, 17 Sep 2026 07:34:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x76d7-0008O8-7u
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xJdiCXmSZu0mSK82DCg08juc5Gs/XTox6riUy+FrJWI=; b=bUUXi0XalAQvs/O1EBBCOWlw/o
 0PrIwixiYlhNXF5/wK6IyvucLuaAGijav2IiYSV9P/p7Feljic0oW5NTlcj+ZwiYGlquIalyOfXYA
 sVbEMVjwwUshTAJfsYqyeEHW8JzwhIzGNE5F8gwOMXdLh/e7JtIjo7gzyzwgB5myN1G8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xJdiCXmSZu0mSK82DCg08juc5Gs/XTox6riUy+FrJWI=; b=mAVksllFuDPjkq+Q9EZ8Rsk1kd
 /saToKxka/3oxEhmj3oPFnSVSNjXAfo7P7zyZj91l/UVK96wxw3edsOuMiorqGP8b3/1dKnzkX5VO
 RVU6sWQB1+p+HxH7gaE4cRpVXHPGJN/C5J1VDkHRLz7AVfkpWOM9/jJxO/ywZWc6yOgE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x76d3-0004RL-So for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:33:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A0E860211;
 Thu, 17 Sep 2026 07:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4111F00899;
 Thu, 17 Sep 2026 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630432;
 bh=xJdiCXmSZu0mSK82DCg08juc5Gs/XTox6riUy+FrJWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KqTajJI3kmHg3Xd8Sa83+4XnkgRi+Oq70NiMzsC5gCE0EF231DUJVMQKuxbfS2uTK
 N9kuw++c1+2nk+0adMy/VbunT4INQCUn9Mw4C048Z3DPKMkmH7f8xjP7NBhrLVfsrW
 snBOYOz8W71TmoT6QyCIY9krKK6W5eFJIwKZVz6tm+r73pEXatWiGTCNJdAYqOP8Yo
 EiCMEkZGKpVVq+sDnCn5f4v2bT5pugcJ9NlgWl42SA/6KAshaaRo1laebfSquFO9RM
 sJNUBWXLMHX6HZd1BXR43g3wvvnVVWff8oj/MiEs1Z5ijPHhYJ2DmrAgseHewwBPbm
 aYQp5Deu89KBA==
To: jaegeuk@kernel.org
Date: Thu, 17 Sep 2026 15:33:34 +0800
Message-ID: <20260917073343.2823157-4-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
References: <20260917073343.2823157-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x76d3-0004RL-So
Subject: [f2fs-dev] [PATCH v9 03/12] f2fs: cache: introduce shrinker
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch integrates the metadata cache into the F2FS memory shrinker
subsystem to reclaim clean, unreferenced cached blocks under memory
pressure.

It implements f2fs_shrink_cache() using a 3-phase cache reclamin method:
1. isolate clean entries from lru list
2. truncate from radix tree under lock
3. splice un-reclaimed entries back

And hooks the new interface into f2fs_shrink_count() and f2fs_shrink_scan().

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h    |  3 ++
 fs/f2fs/shrinker.c | 12 +++++++
 3 files changed, 104 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 4818e6077114..e571080ab266 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -539,3 +539,92 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
 	f2fs_put_cache(entry, true);
 	goto next;
 }
+
+static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
+						unsigned long nr_to_scan)
+{
+	struct f2fs_cached_block *entry, *next;
+	LIST_HEAD(dispose_list);
+	LIST_HEAD(keep_list);
+	unsigned long freed = 0;
+	unsigned long scanned = 0;
+
+	/* Phase 1: Isolate candidate entries from LRU list into dispose_list */
+	spin_lock(&cache->list_lock);
+	list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
+		if (scanned >= cache->num_entries)
+			break;
+		if (scanned++ >= nr_to_scan)
+			break;
+
+		/* If accessed, give it a second chance to rotate to tail */
+		if (f2fs_cache_test_and_clear_referenced(entry)) {
+			list_move_tail(&entry->list, &cache->lru_list);
+			continue;
+		}
+
+		if (f2fs_cache_test_dirty(entry) ||
+		    f2fs_cache_test_writeback(entry) ||
+		    f2fs_cache_test_locked(entry))
+			continue;
+
+		if (f2fs_cache_refcount(entry) != 1)
+			continue;
+
+		list_move_tail(&entry->list, &dispose_list);
+	}
+	spin_unlock(&cache->list_lock);
+
+	/* Phase 2: Process isolated candidates one by one */
+	while (1) {
+		spin_lock(&cache->list_lock);
+		entry = list_first_entry_or_null(&dispose_list,
+						struct f2fs_cached_block, list);
+		if (!entry) {
+			spin_unlock(&cache->list_lock);
+			break;
+		}
+		f2fs_cache_get(entry);
+		list_move_tail(&entry->list, &keep_list);
+		spin_unlock(&cache->list_lock);
+
+		if (!f2fs_trylock_cache(entry)) {
+			f2fs_put_cache(entry, false);
+			continue;
+		}
+
+		/* the entry has been truncated */
+		if (!entry->cache) {
+			f2fs_put_cache(entry, true);
+			continue;
+		}
+		/*
+		 * at least there are shrinker, radix tree and another user
+		 * has referenced the entry.
+		 */
+		if (f2fs_cache_refcount(entry) >= 3) {
+			f2fs_put_cache(entry, true);
+			continue;
+		}
+
+		f2fs_do_truncate_cache(entry, false);
+
+		if (f2fs_put_cache(entry, true))
+			freed++;
+	}
+
+	/* Phase 3: Splice un-reclaimed entries back onto cache->lru_list */
+	if (!list_empty(&keep_list)) {
+		spin_lock(&cache->list_lock);
+		list_splice_tail(&keep_list, &cache->lru_list);
+		spin_unlock(&cache->list_lock);
+	}
+
+	return freed;
+}
+
+unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
+					unsigned long nr_to_scan)
+{
+	return f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
+}
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index d8123a86cdf8..6c38fc9e18f6 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -202,4 +202,7 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 #define f2fs_truncate_meta_caches(sbi, start, len)	\
 	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
 
+unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
+				unsigned long nr_to_scan);
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index e3e0a7e89406..baa09bc63585 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -37,6 +37,11 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
 				atomic_read(&eti->total_ext_node);
 }
 
+static unsigned long __count_cache(struct f2fs_sb_info *sbi)
+{
+	return META_CACHE(sbi)->num_entries;
+}
+
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
 				struct shrink_control *sc)
 {
@@ -68,6 +73,9 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		/* count free nids cache entries */
 		count += __count_free_nids(sbi);
 
+		/* count generic cache entries */
+		count += __count_cache(sbi);
+
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		mutex_unlock(&sbi->umount_mutex);
@@ -120,6 +128,10 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 		if (freed < nr)
 			freed += f2fs_try_to_free_nids(sbi, nr - freed);
 
+		/* shrink generic cache entries */
+		if (freed < nr)
+			freed += f2fs_shrink_cache(sbi, nr - freed);
+
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		list_move_tail(&sbi->s_list, &f2fs_list);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
