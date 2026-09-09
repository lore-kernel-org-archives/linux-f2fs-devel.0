Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AEBC79F82
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+M7OzzYe0+asVUua4CvYTxtTT8fu6WsuHQ0ygDmRCk=; b=FYfl7wQYHKsLQORPgfmOGCoGAT
	vOx7hBubizxdVJuNp94nujr+PXQMeuhZz1ezACno85kH0Y4DQU4ckxAmLB+TH74ZxQR0HMSSUtxbl
	waEAN0GHKWzYUhH+revQSQhdZ5TVZeXXc4jJ61tziy/sNeHbEuQwiab0B321p6JkW2DI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FI-0007Qs-NU;
	Wed, 09 Sep 2026 01:37:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FD-0007Q3-TN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ltvgpC+nMnPE/iQAztVfrc8xC7sSszBpHSlZ/oBovFQ=; b=TsSyL6+dNNRjJc3l1nvonzQfra
 WoVcJ45+uY/Pe1CqNuj+l5JYFHT+InSJ0K5s0VPzaLKWK37F7VrXJSEFZM2Mv9kxd6ldZVg726JDM
 8OSjlrQEDYKo2sORe5PJJky6JCGRt5+Z8nZHZKqj3Zb0bQ4CxXcpyKEDpN2BU3fZOVzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ltvgpC+nMnPE/iQAztVfrc8xC7sSszBpHSlZ/oBovFQ=; b=XzAXKm9MGdg+pwaK/MMQsQpZU9
 8MpC1i6MlKyjewXveV1NvwYY4MWh1Q3xRFf1xrxxRV+GmU56lWUzLVxIbHIXMjT5s2U6LfZehCaBa
 OOwlF46N2O+Sja8M8nqjkRvMSd+jzK7TGtw5qi4KttLK2ipGGN8aFDRjaj9Nk8YzInyQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47Eu-0000XA-RA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89E2D41709
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B81F00AC4;
 Wed,  9 Sep 2026 01:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917795;
 bh=ltvgpC+nMnPE/iQAztVfrc8xC7sSszBpHSlZ/oBovFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M5CK88mOZtNkELgxKn5yEO+4q0RRP5jqVciHPs4ZOwxBIJCbmEMxdRkV1//A6KGnb
 uzHstXruzzngP+o43f2HpVXyB4GynlAj+ce+QeBgyC0i2yYBblgoCtQ0VEr/hcmTsG
 eYGlbuuDW4uJ2XkKGnboWgyeBU2lvBJXnm7QGQ81sV19A/VNHFSbvjgnENyJ/9HJ15
 w74pcUwDGloR/awjWoEmVMuaw/u00yS/YvS7x/Jkw1W662ZWG0k9s1y0Q0n3cWg9cP
 lg02QQwKM5lsHYKF33n3tU4mua2hnlp2YC5cbNpQYRJhsZTdeB1xNFc4lbbPA069Fn
 dOuWSyTVaWSLA==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:02 +0800
Message-ID: <20260909013611.3418568-4-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47Eu-0000XA-RA
Subject: [f2fs-dev] [PATCH v6 03/12] f2fs: cache: introduce shrinker
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
index 473b8c272ffb..5524c0c81c83 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -533,3 +533,92 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
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
index 6408f8cb5723..d5aa89d59474 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -205,4 +205,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
