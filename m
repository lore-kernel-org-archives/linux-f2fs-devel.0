Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13DBC9832A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3f5hk9cGo9IhIFYVU1+Knth2/ZtqijuyobQc6eLUJWI=; b=KT04xffx1MN3LwlvIzNwyFHIqs
	yoHTsPtjPw6qLE3gZjqqXUVCLcvKvIjjo/EueQYyovEGoiQV8LxLhvAV+jTCCR0faU6QBzQK2V+37
	V+f2b3HjulQsWqQNXrlPCCb/L2Vq1Rm+VFNkh5lzU3wHRfvvZSQweNEaKvoFQ+NQRy+4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHs-0006ZC-Pn;
	Tue, 29 Sep 2026 07:30:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHr-0006Z0-82
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HkVEvCwBFSD+W3euASn7zHWOE+J/lSbgnnUAa5Z+5iw=; b=GMayHNl4BiOIHh9NYMjXQ1hymP
 qsEisZRw0ZrgJUiqaIS108QauL4M+TSl+FslS+iIjf8Bdrh/+Es7EqNXD2V2YZ9F9OmtWsg8BFKpE
 kF9FRHo0rlXOSlMm1znfun3jluQiROMv6xBgVSPiCKaAzq9Ye20N6ix/lqy9Kzl/4Dsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HkVEvCwBFSD+W3euASn7zHWOE+J/lSbgnnUAa5Z+5iw=; b=JzaWbAa3gVSisd+QKh4ckVQYO8
 6u8graJEkJPDg3BJa5axz1is8R2WhlTpArp+/HAIcAf0z4NDdbizKBIfftcAoKEJ6clIFMy8JeyB5
 UZwTfghK+W3nLE1xyGmGvl99CQ5EGwUEQuWi5EeX3iJld83LcY3oaq+vBFlc30AViLik=;
Received: from mail-pj2-f40.google.com ([74.125.227.168])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHn-0000Er-Ox for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:30:03 +0000
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so2169044a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666994; x=1791271794; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HkVEvCwBFSD+W3euASn7zHWOE+J/lSbgnnUAa5Z+5iw=;
 b=l0KE7dfu0vLNZid8e42fhVl7L/fuldOnZ0LkHeLQHD0yRLzkgEpIdguwsHDfhFlpP1
 nhauk/XzY+Nc6YQIn+VLMlSKAHuhHzQXr6amXIG8LmbvqjOjYHSj8shIkACDGvYun6aP
 ReOpX6rEAxsLgnWFEfgzFyvUF3Orx+POyDulzhQw42DVJBbmvdCM+mXXqKuv8UOvn5EZ
 CaPQUIQQ4IUqwNOomZsw3LFflBAMLNSWgkkxIQ3duMLaXPnMHB19nNP13Y0t8bedD2hm
 aSB2urUD0Td1xcIfvejGbMPho0GQuro3YRqUBXVCDcCSeu/QRC0QlXRTvnPUPLu6d1pg
 RkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666994; x=1791271794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HkVEvCwBFSD+W3euASn7zHWOE+J/lSbgnnUAa5Z+5iw=;
 b=jSJ6lDNm+HtFDLrsjX8h0EqqmS23oA2uuuvmi2PMv2jh5Mu85rXRE82kRwzBzoLRrQ
 iFyyIGb9l5S9yWLsJql1kEZJ+P9hExtA+9v/U8kOKatFHTRCHLTSAik//f4U8VvyWJRG
 v4P7sXgSzEQfk3nxhVhD0ERV3q0nDfibYhPf+y5joFhnsuk3VH/EPrqwNT99CgTGXPkE
 xc63EhOAnqD6E9Cewa1G2G5slu+BOPRxKXksQm37/5SiSsr8rky/rdqSxEP2MC5NAA8w
 2WgPrE3T5sPMYHfGeTr4HhgM3zwlf32L4OsE5bTgU4fK9BU3PvpnyM3U9vr+LNZSRES6
 Vi6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByY1l3yrPA1iWPvLO+a7prOPZfg3+OYPavYGefpH6cox0ygcEvQHr6b4PS64XEH3JthqszayFaONzGU76JIuPgH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKMvIPX4F5b3cyFJdU7pnOZn9q6Sy4A5wswRocef4QD2H60hjfm
 MmUk8QVMDmERYbnoG0+c6bfhWUjaYIS1Y3ui3Vme7EoiQos7tUnLjigL
X-Gm-Gg: AYBFou0OENmg95rzGD2Fp7LxR0T4sIQocxUd+HCFb5LpZtHqZH7hQTbc/zLXHBp+6Ui
 8JFZx+FOqlQeZ6C8Tz6aPM2orBqxyJ1yX40mvQcRuXo9SZsvfJXC6KtSkAmCQKIoXnds70xlPRW
 nr1IlPX9QCpiJH18UxEuzaErpYSfJku3EjyT8fzu52dIitNbRpKDqwwgk43jo8Ndx5g4AlyyBF0
 bktVdEZgajcWa/2bxorNdSXwqTusZtlwNvW8EEd41DtewmjB3csgATZ6YVwVxnmB1qg2Wp7q4zL
 YcErl1BkXgN7b1EAFoD2lKgF4FN8XtbxcmFrrTxlD8lb1ClWiqF6hNWfEUUGUIvmAj8grp3TdW3
 ozWdIfeVYYzHV4rkoY/HnPPL8v621iCZl7uokHGR7Y4HNIaDGhdAm2cMeZsOXRLuEo+WoGCM62U
 SAtu9i7LGMV+sVaRxlznJ4kQIJBTDvVCPGVIN103/RnuoK0VLAJ4bT3Y3wcVdNHZIRMc4fNiqgA
 fBCvNw5Bgx26pXaUFwvJ/9ikcdcvNk1CMk=
X-Received: by 2002:a17:90b:5705:b0:3a2:ae7f:4f07 with SMTP id
 98e67ed59e1d1-3a2ae7f51abmr4935319a91.55.1790666993964; 
 Tue, 29 Sep 2026 00:29:53 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:53 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:19 +0800
Message-ID: <2c3b08138728fb341b4f91ea128cb43975e6ee0a.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790665952.git.qiwenjie@xiaomi.com>
References: <cover.1790665952.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xBSHn-0000Er-Ox
Subject: [f2fs-dev] [RFC PATCH 6/6] f2fs: give referenced node cache entries
 a shared second chance
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

The shrinker already gives a referenced cache entry a second chance by
clearing REFERENCED and moving it to the queue tail. The compression worker
only skips such entries, so it can revisit the same referenced prefix on
every pass.

Use the same clear-and-move rule in both paths. The worker records the
original raw-list tail so entries moved during a pass are not visited again
in that pass.

If an access races with compression after candidate collection, discard
the temporary compressed object and give the raw entry the same second
chance.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/cache.c               | 15 ++++++++++++---
 fs/f2fs/cache.h               |  3 +++
 fs/f2fs/debug.c               |  4 ++--
 fs/f2fs/node_cache_compress.c | 36 ++++++++++++++++++++++++++---------
 fs/f2fs/node_cache_compress.h |  1 +
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index b3158f4ab45c..2b0a6eccd3af 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -60,6 +60,17 @@ void f2fs_cache_update_tag(struct f2fs_cached_block *entry,
 	spin_unlock_irqrestore(&cache->tree_lock, flags);
 }
 
+bool f2fs_cache_clear_referenced_and_move(struct f2fs_cached_block_list *cache,
+					  struct list_head *head,
+					  struct f2fs_cached_block *entry)
+{
+	lockdep_assert_held(&cache->list_lock);
+	if (!f2fs_cache_test_and_clear_referenced(entry))
+		return false;
+	list_move_tail(&entry->list, head);
+	return true;
+}
+
 bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 {
 	struct f2fs_cached_block_list *cache = entry->cache;
@@ -594,10 +605,8 @@ f2fs_shrink_cache_list(struct f2fs_cached_block_list *cache,
 		scanned++;
 
 		/* If accessed, give it a second chance to rotate to tail */
-		if (f2fs_cache_test_and_clear_referenced(entry)) {
-			list_move_tail(&entry->list, head);
+		if (f2fs_cache_clear_referenced_and_move(cache, head, entry))
 			continue;
-		}
 
 		if (f2fs_cache_test_dirty(entry) ||
 		    f2fs_cache_test_writeback(entry) ||
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 3c1fdc7894b7..8acbbbaf897d 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -232,6 +232,9 @@ void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
 void f2fs_cache_wait_writeback(struct f2fs_cached_block *entry);
 void f2fs_cache_update_tag(struct f2fs_cached_block *entry,
 		unsigned int clear_from, unsigned int set_to);
+bool f2fs_cache_clear_referenced_and_move(struct f2fs_cached_block_list *cache,
+					  struct list_head *head,
+					  struct f2fs_cached_block *entry);
 struct f2fs_cached_block *f2fs_grab_cache(struct f2fs_cached_block_list *cache,
 				unsigned long index, int flags);
 void f2fs_truncate_locked_cache(struct f2fs_cached_block *entry,
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 984fed727a48..8625dccc2131 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -728,9 +728,9 @@ static int stat_show(struct seq_file *s, void *v)
 				nc.payload[0], nc.payload[1], nc.payload[2],
 				nc.slots[0], nc.slots[1], nc.slots[2]);
 			seq_printf(s,
-				   "NCWorker: cycles=%llu visited=%llu candidates=%llu attempts=%llu converted=%llu candidate_refs=%llu transient=%llu alloc_fail=%llu\n",
+				   "NCWorker: cycles=%llu visited=%llu candidates=%llu attempts=%llu converted=%llu referenced_moved=%llu candidate_refs=%llu transient=%llu alloc_fail=%llu\n",
 				nc.cycles, nc.visited, nc.candidates, nc.attempts,
-				nc.converted, nc.candidate_refs,
+				nc.converted, nc.referenced_moved, nc.candidate_refs,
 				nc.transient_extra_bytes, nc.allocation_failures);
 			seq_printf(s,
 				   "NCRestore: compressed_to_raw=%llu restored_hits=%llu restore_failures=%llu\n",
diff --git a/fs/f2fs/node_cache_compress.c b/fs/f2fs/node_cache_compress.c
index 6e474fea7241..cf13110b2961 100644
--- a/fs/f2fs/node_cache_compress.c
+++ b/fs/f2fs/node_cache_compress.c
@@ -147,6 +147,7 @@ struct f2fs_nc_ctx {
 	atomic64_t candidate_count;
 	atomic64_t attempts;
 	atomic64_t converted;
+	atomic64_t referenced_moved;
 	atomic64_t candidate_refs;
 	atomic64_t transient_extra_bytes;
 	atomic64_t allocation_failures;
@@ -574,7 +575,6 @@ static bool f2fs_nc_candidate(struct f2fs_cached_block *entry,
 		!f2fs_cache_test_dirty(entry) &&
 		!f2fs_cache_test_writeback(entry) &&
 		!f2fs_cache_test_locked(entry) &&
-		!f2fs_cache_test_referenced(entry) &&
 		!f2fs_cache_test_incompressible(entry) &&
 		atomic_read(&entry->refcount) == refs;
 }
@@ -601,6 +601,7 @@ f2fs_nc_compress(struct f2fs_cached_block *entry,
 	u32 crc;
 	int bucket;
 	int len;
+	bool referenced;
 
 	if (!cache || !IS_NODE_CACHE(cache) || !cfg ||
 	    f2fs_cache_test_compressed(entry))
@@ -654,9 +655,14 @@ f2fs_nc_compress(struct f2fs_cached_block *entry,
 
 	spin_lock(&cache->list_lock);
 	spin_lock_irqsave(&cache->tree_lock, flags);
+	referenced = f2fs_cache_test_referenced(entry);
+	/* A concurrent access wins; rotate the entry and discard this result. */
+	if (referenced && entry->cache == cache &&
+	    f2fs_cache_clear_referenced_and_move(cache, &cache->lru_list, entry))
+		atomic64_inc(&ctx->referenced_moved);
 	if (entry->cache != cache || entry->data != raw ||
 	    atomic_read(&entry->refcount) != 2 || f2fs_cp_error(sbi) ||
-	    f2fs_cache_test_referenced(entry) ||
+	    referenced ||
 	    !f2fs_cache_test_uptodate(entry) || f2fs_cache_test_dirty(entry) ||
 	    f2fs_cache_test_writeback(entry) ||
 	    f2fs_cache_test_incompressible(entry)) {
@@ -693,7 +699,7 @@ void f2fs_nc_run(struct f2fs_sb_info *sbi)
 	struct f2fs_nc_ctx *ctx = sbi->node_compress;
 	struct f2fs_cached_block_list *cache = NODE_CACHE(sbi);
 	struct f2fs_nc_config cfg;
-	struct f2fs_cached_block *entry;
+	struct f2fs_cached_block *entry, *next, *scan_tail;
 	unsigned long flags;
 	u64 now_ms;
 	unsigned long raw_population;
@@ -714,15 +720,26 @@ void f2fs_nc_run(struct f2fs_sb_info *sbi)
 		goto out;
 
 	spin_lock(&cache->list_lock);
-	list_for_each_entry(entry, &cache->lru_list, list) {
+	/* Do not revisit entries rotated to the tail during this pass. */
+	scan_tail = list_empty(&cache->lru_list) ? NULL :
+		list_last_entry(&cache->lru_list, struct f2fs_cached_block, list);
+	list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
 		if (visited == goal || count == F2FS_NC_MAX_CANDIDATES)
 			break;
 		visited++;
-		if (!f2fs_nc_candidate(entry, cache, 1))
-			continue;
-		f2fs_cache_get(entry);
-		ctx->candidates[count++] = entry;
-		atomic64_inc(&ctx->candidate_refs);
+		if (f2fs_nc_candidate(entry, cache, 1)) {
+			if (f2fs_cache_clear_referenced_and_move(cache,
+								 &cache->lru_list,
+								 entry)) {
+				atomic64_inc(&ctx->referenced_moved);
+			} else {
+				f2fs_cache_get(entry);
+				ctx->candidates[count++] = entry;
+				atomic64_inc(&ctx->candidate_refs);
+			}
+		}
+		if (entry == scan_tail)
+			break;
 	}
 	spin_unlock(&cache->list_lock);
 	atomic64_add(visited, &ctx->visited);
@@ -890,6 +907,7 @@ void f2fs_nc_get_stats(struct f2fs_sb_info *sbi,
 	stats->candidates = atomic64_read(&ctx->candidate_count);
 	stats->attempts = atomic64_read(&ctx->attempts);
 	stats->converted = atomic64_read(&ctx->converted);
+	stats->referenced_moved = atomic64_read(&ctx->referenced_moved);
 	stats->candidate_refs = atomic64_read(&ctx->candidate_refs);
 	stats->transient_extra_bytes =
 		atomic64_read(&ctx->transient_extra_bytes);
diff --git a/fs/f2fs/node_cache_compress.h b/fs/f2fs/node_cache_compress.h
index efe2eceef352..542093f2eca7 100644
--- a/fs/f2fs/node_cache_compress.h
+++ b/fs/f2fs/node_cache_compress.h
@@ -31,6 +31,7 @@ struct f2fs_nc_stats {
 	u64 candidates;
 	u64 attempts;
 	u64 converted;
+	u64 referenced_moved;
 	u64 candidate_refs;		/* Worker-held references right now. */
 	u64 transient_extra_bytes;	/* Temporary raw/compressed overlap. */
 	u64 allocation_failures;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
