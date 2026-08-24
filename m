Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F7AC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MbIkKak8kW3f7F4UD/SF7Trj+lFnP+5+7MEksMBO2pk=; b=IHWubrywtBBWb6znWudNWtd3Z2
	a2BBS6EaWRo3xlweIJbinSAXQKn9MwDdPdMxBp9RHq76z6IlEGuofqJgmS2RebCw+4A3HOFKA6mfL
	1e8u6Xpccwayx8RVpoOwCuSnPHAjkUvnBf8w1C9cQ5g1hp8NsXfBvaBpxvrJVFNC01Hk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyV1p-0004Kk-3Z;
	Mon, 24 Aug 2026 13:47:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyV1l-0004KJ-Rk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCF2mHWBBz4fQ6CeBlNh24BqP0JBaJP21FKhLiySRQ8=; b=eGsfgADSH5DC4YyXUSY089m0O1
 SJHqSydN104lz7iQ8BAI7sxybWldHgCfksTkVcLXexonqcTDGzHrufE0+4drQiWRlbniGfqF8QN1v
 7y+wdF/rf6znDgls8Ua7rLYewCxMhlMEFJ9S1BhH2qE63WxWrGomHCEy8aj5RGpfJIiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vCF2mHWBBz4fQ6CeBlNh24BqP0JBaJP21FKhLiySRQ8=; b=my/8K1L+f5nXevNzOrrVxIf6Z7
 H2g89ouqPkVWI8znxqJc8j+JSjNI92s02zfw0BuLtVPWdSYIndW4j19mh0tEJjoHQAoiWJsibvhyE
 G0vNWVWhxsvbKRkycUqESIfAbt/AzvmqOk2VUyjmJaPUNJM9lL694Xktjt1AqYO7m74U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyV1j-0000b6-Rj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E2D540634
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 13:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1561F00A3E;
 Mon, 24 Aug 2026 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787579266;
 bh=vCF2mHWBBz4fQ6CeBlNh24BqP0JBaJP21FKhLiySRQ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XQefUq6le8LIeVwN78K0m6fsDBNAvemE94Ro+5Wlg1keTz3DulM4cEIWyooUgDeqz
 uuTInn9jySZdP4FTSmzD6JYq/muu3nD95iCY6gVcFj5btim5oiC5GOTpdH1fc9CnA/
 bYXa93LKNIscePPJvuH98ShZdHfiN7YxVsaLqwngDasYp1diiI8EKCEjThsH1DTwSx
 ET4aRbmV8l+u9zRBRdqWKUzKyKuO0KW/irACnaQiCubHjTPjTt4OaM2OFxnqwfXZcU
 66jc9gmXM1pWQ6xgJTt3fTC38hz4hBBnpsRtJ702wbM5GXE+Km1vray0kO/09SFZZH
 rA/rAZ53drucw==
To: jaegeuk@kernel.org
Date: Mon, 24 Aug 2026 21:47:22 +0800
Message-ID: <20260824134731.3704352-4-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <20260824134731.3704352-1-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyV1j-0000b6-Rj
Subject: [f2fs-dev] [PATCH v2 03/12] f2fs: cache: introduce shrinker
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
 fs/f2fs/cache.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h    |  3 ++
 fs/f2fs/shrinker.c | 12 +++++++
 3 files changed, 97 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 1eec5e9e5dbe..379f75599bef 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -530,3 +530,85 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
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
+	unsigned long isolated = 0;
+
+	/* Phase 1: Isolate candidate entries from LRU list into dispose_list */
+	spin_lock(&cache->list_lock);
+	list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
+		if (isolated >= nr_to_scan)
+			break;
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
+		isolated++;
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
index 7ee98d276938..618b377590da 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -184,4 +184,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 #define f2fs_truncate_meta_caches(sbi, start, len)	\
 	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
 
+unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
+				unsigned long nr_to_scan);
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 4f6bf5926de4..1755c85849e4 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -37,6 +37,11 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
 				atomic_read(&eti->total_ext_node);
 }
 
+static unsigned long __count_cache(struct f2fs_sb_info *sbi)
+{
+	return sbi->meta_blocks.num_entries;
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
