Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABFEC88E45
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tzWNE+bucdWLDejw67Xwq9oJPdRNUkw6Fmb1PAneDlA=; b=VHmI1i0fAjzSFKTF/0wUN9xPP9
	UTqbk6vpahdLEL38/qreYcUDy89SAMtN/fNJBuIY9Dgx149v4DH6XgfVtCdEmrEpT7E6zAUVSV5uH
	WObBvv7OWdSzEcP1YkHJjQuCpRUbDj1g9s4CYKqtqwMHdJBud9taI5s9Jvs8U48PFbh8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5AbY-0004Yj-BR;
	Fri, 11 Sep 2026 23:24:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5AbW-0004YY-QQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EZxDJkjdUg8TyHpg98zUCgfj2s3O/UdJGw+dovrRJAc=; b=NjwWNEcX9D8VgGa52FHEyuybiX
 xbVA63uwLXG8yAMBgBQ0KQqM1SUevfzCU7aFstkPN/DdEbcUcxUogT+sblUQIHNryQeZuer43ijuE
 sxnJ4pq21G3pH+og+kTdnqLQnYBHfhlqG910QcUMQWiRBDzHlt+E8gIbRdjRZhlP1WI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EZxDJkjdUg8TyHpg98zUCgfj2s3O/UdJGw+dovrRJAc=; b=MKLtfFLxh1DIuZoncD5RarlYUb
 DkrVTiVytotxSbhG2ocn0yMmlVv93n0/zJVbhpts8COw1qwXLPZ9JqHEWzQgPU2QXTY//GI+eHDW2
 GSThjy5bIXSo5md/4jAx1pQsryoPC0bhwbTsuzFNoQzRe3Nu8NkPDT0WntZgbGnTmQg8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5AbW-0005T5-TY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 559D160202
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 23:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFD1F000FF;
 Fri, 11 Sep 2026 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169057;
 bh=EZxDJkjdUg8TyHpg98zUCgfj2s3O/UdJGw+dovrRJAc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VxcuwtUcaSg+CezT0BoBOLGPefglthOrQAomQWMpoqG2DDuudJ1hFXFH9+m6rx3+p
 QpvDLWlvxyPQHEwPeJYb2nLSoN7CFYdLCdqlKdpqWDK+1P2o4m1P8/hxf1kte71ZPf
 AYw76Tp/NkATElU8aWPgYCq+CKqCiZpW2lvjqSPr6LRaIUMhDGqc3z5p47Cz4fmZA/
 fKUhSOnsB7LKtxcVWkVb120T0bKFp4IrX81OwUNg774gKzSPm1JwKp88iZxZwfhmL/
 uu9mwf3kc9DzkV7L/CNXppwuDgOVpZIXMCXgV1wKwv0YZ+Nlt4WJ95Bm3stSoQclwm
 jFWwKWiZAwUxA==
To: jaegeuk@kernel.org
Date: Sat, 12 Sep 2026 07:23:56 +0800
Message-ID: <20260911232405.1815804-4-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260911232405.1815804-1-chao@kernel.org>
References: <20260911232405.1815804-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x5AbW-0005T5-TY
Subject: [f2fs-dev] [PATCH v7 03/12] f2fs: cache: introduce shrinker
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

This patch integrates the metadata cache into the F2FS memory shrinker
subsystem to reclaim clean, unreferenced cached blocks under memory
pressure.

It implements f2fs_shrink_cache() using a 3-phase cache reclamin method:
1. isolate clean entries from lru list
2. truncate from radix tree under lock
3. splice un-reclaimed entries back

And hooks the new interface into f2fs_shrink_count() and f2fs_shrink_scan().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c    | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h    |  3 ++
 fs/f2fs/shrinker.c | 12 +++++++
 3 files changed, 104 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index fb0ab77d3b49..563615761d11 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -537,3 +537,92 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
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
index d5ee51691fac..5728e2225465 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -206,4 +206,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
