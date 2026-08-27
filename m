Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E397C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5aB243foSDfWdgyBByse3ueNQXAqQdhOesWdFEXWV00=; b=e073Dj6chKlArEf2ENc4QaHmYu
	T4jj2kfmXIAakh0xtkHjxjbx4Lal+6Ct/dju8Y+AunfEV9w3Svv1sOtzev262g4uGvqthAgmstJpw
	qnMclpZ5vgH52KO25McRc+ULQskUKXkFNs1H4nQAHHMNeFq822hdCt8lKR0c5KvpOlcM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZBC-00046t-Bo;
	Thu, 27 Aug 2026 12:26:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZB7-00046c-NS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1rDvh5omJ1P80S+w+/I4psAk/R31yuaCneN5y8ReDlg=; b=EMIfPlh1OcsGXJQbI6oxZcmJEM
 /KyjWvZ0GhDrDx1iXiybI7gG+SFPljfiQ5cn2k5BlFdyjGdtPYh13YrQutbqbsikw2j9omDdTnY/J
 4bKiymI2jT4E4GUqnyT5nSL1ZWxod8Kv0VLHhRKSwQG9X1CmpZb/Ec+OMU5oHpx+shIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1rDvh5omJ1P80S+w+/I4psAk/R31yuaCneN5y8ReDlg=; b=RjvUpUKQPDB8wClNFWNIBRUwVJ
 F0rMYC0fDtSvzlPeff+3k7eCIyAn6wKEb2jhcLdRs/s28V13B213lrOy0KiZ1KvyNTPpJNEGpolMx
 ulzupRQ3XgoyLnxPSJWky0bpUj1rN22VnlIwpREA2Gs1baM19n0A79vgnkPwN11X9Tro=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZB7-0006CA-Q1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:25:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 743C442DF7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 12:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A241F00A3D;
 Thu, 27 Aug 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787833552;
 bh=1rDvh5omJ1P80S+w+/I4psAk/R31yuaCneN5y8ReDlg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mm8++Yy+4h/8iCyf2VGfULMfq9r3Asavz3ndiYvkc3uckKxTSGMDdFCDKT4Wy/7jE
 7ibN8Xwe450Y6TD/PqFRzsxd1vw4Y5NrdUB8ncAcifnICWt1UUS7HFLfG0brr26KXq
 oOyLoBlbJnsVasfDhUpZr35lAJexxNgrV0X+OjJUqt89VZIdrkfelxeiUD+4BFRKSz
 YKCTd7k6BpM6ZDQ1wtLbCJ34Mq+GKvc9IK6FtP5OgZFdtzFMCE/rQfWs+hXF4Nmk9E
 SRMM6fIAniifHLAJzEGjtW16T/MtzS5+andQ+g3sDo2CzrRjIx/8ZJsMiF6sIMf1tO
 Qh9yHuShZ3mRA==
To: jaegeuk@kernel.org
Date: Thu, 27 Aug 2026 20:25:31 +0800
Message-ID: <20260827122541.19967-4-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827122541.19967-1-chao@kernel.org>
References: <20260827122541.19967-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wzZB7-0006CA-Q1
Subject: [f2fs-dev] [PATCH v4 03/12] f2fs: cache: introduce shrinker
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
 fs/f2fs/cache.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/cache.h    |  3 ++
 fs/f2fs/shrinker.c | 12 +++++++
 3 files changed, 95 insertions(+)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index a1a73fa84320..0cb8622ef580 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -560,3 +560,83 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
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
+
+	/* Phase 1: Isolate candidate entries from LRU list into dispose_list */
+	spin_lock(&cache->list_lock);
+	list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
+		if (nr_to_scan-- == 0)
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
index cb5a466526fc..5f7e74f0c873 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -191,4 +191,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 #define f2fs_truncate_meta_caches(sbi, start, len)	\
 	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
 
+unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
+				unsigned long nr_to_scan);
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 4f6bf5926de4..8ef3aa5eb110 100644
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
