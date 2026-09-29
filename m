Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4D4C9832A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cjqY0XXkKpnxZ8ikJglSF3bCUq/nPRhvFz2zl/Wdo44=; b=KOGj1Nqr8/xXWAzV5bCq1nnJBF
	Ns/GO7CEHW6nIIXhYo886NwrntqK1BtjrmWGuhShtxiF20rXumZ+7qjzR4emEzDzCQITP79v6SsIb
	FmHUc5k3Gg98Vd3tGOL0IXSAAJO/XG5v8EnvMJrEbUN1uKyOkd1UZdFDmz+VRWgPUPDA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHU-0004h9-Q7;
	Tue, 29 Sep 2026 07:29:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHT-0004h2-K4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fvhgplSZpkv24SdFucedZ8K8vw+xrsVtOmMflZvHgWM=; b=ZgoIHTODn0Qp0vVGGM48lNKEzL
 spDkUzUhxpxwMiYKAXyLOm2putL2sE8qgZvPQVYG9Pb97zVE1dbBpFgJbY0+8RDJNrtD0xmvDGFZL
 Jd8cQVxbsYMksk39lE+nXnArPzsRP2voF2OSR/P+5coG1sox8tN58ZwZG6N1/fozXgJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fvhgplSZpkv24SdFucedZ8K8vw+xrsVtOmMflZvHgWM=; b=KV1vwgDtxjSi7zRoElkYDMHvZ9
 FdFsVT3hy+20su+EPnHNEJdPuRjWA1ti6fhdjW9HAl2C2LYcsigeaDuJqK6lSZaf02eiJtjL4RRhS
 bRIB5AB+5jP1gnv/9xWmMpDGB1sovYMBDWqeofTt8Ou8h5kqT0wO6J8xV8l34obOymUY=;
Received: from mail-pz2-f40.google.com ([74.125.228.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHS-0000EB-2b for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:39 +0000
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc74520b20bso968856a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666972; x=1791271772; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvhgplSZpkv24SdFucedZ8K8vw+xrsVtOmMflZvHgWM=;
 b=WgQYkyhctKh+umlg9aTfQtR2oCnowimbxMzXy7pJNlH0X032Pr2sfuygqbG0B0Vx65
 g/5nCDQz9z77HPotQGADtYS2qv++Vskv82em1f0w3XWtFEHvs6VZRD7nxqZZQvREMa0k
 DkIZ38vZU9AHG3o0RWoegAsAJKZ9Stg13qtBiNKFMxB5oQM92CzODjbUkH2W3BHVqlqW
 ifgZA6Z01wd9chWBvQkPJ++T7XoajRSy/RwD8zn8HT3vCBrXlCGEyxeQ88xDYiCYjvSX
 3nk9JFL4TVxfOMSYNS7wuyvV98ZO6YfH8clhADnvzXuT3LkJfE96Y9l9oFm/gl7PLQIZ
 jW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666972; x=1791271772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvhgplSZpkv24SdFucedZ8K8vw+xrsVtOmMflZvHgWM=;
 b=M4UYt8uwpHdH4izyxwfErZ2kCXqxhYzQB+koFoIECrDVH0kmLP0DUB5ccWxj6KBKWY
 86RnFmlGka1liWNItpYKJvraaW6Q7ZVRI8MA4ENegQISJwBMeajOOeThtKgsHMzZE/PG
 QXageOHSLNNIl26Ujv99v4R07P5UspvBVYC1CXKTIuk22ZHonmXTsa4wprjhF+QnRihx
 vxPSmjGqatch1Bd0/gHwP/RZ3nuq+Lj8ViMXy8q10GlByxUX4cHZV0dsCgxgNC2YEAqO
 Vbgzg8aWOmSC1JjfZWLxQSYtHL42Eg9/WkaMN60NvfZ+KVHV2yt0G2GrjIhfdc2zjqqh
 Gtfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbXjrSIIi7RMg6ql9Po5/js+P6ARqYK6H4g5V7Z9mrgs/qVHcexZlJ5DCG3ISN3d4XnL/GvB2zoeUxpiwK3hKa@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJWk9lrTmKKcLAr/A/FgMF6XgpUQGzLzHWSCZfaVizrCfRnuleS
 5lw22g4ZMENL4RYRCxgYQLhO0as++JkMDFcxA9NOGDfVY1fjuEQ94lSe
X-Gm-Gg: AYBFou1Zwl74T0R7oRIL6zxpiqfvuUtOMyb3T4FMAOHZky3opTZtIwaj3O9d7h4MXs7
 F+vm3X5Cx0lpqNul3rc2Jcg3oTh2m4TuvTu7ztTAOwamLo46/B6oZEoItyf6+xQ/OX3w+LXi8XP
 PfrvkNaxoilVNFIpCAWopfoOtBXcCa2Ew5Uec/S5DEjua6awYmfVeHV4MizOBmkW1y5Y1mU3rK6
 /voc+T7SXfRimyqnE3lOJhlyedC652Q1HGKl67QadVOn8CP8XpNrkX4cMFZ2JXazjQFkqORfEV3
 4j6hKBmEEtv5LJiJ60pemmOPGhweCbLox3HWaOswCuDJ2k9zP+kDwK+JRT8IQYskw/WS5iiafkb
 WianQXZOmyzo1b6vLr91SMIG+d30Qnp/NgJUAQKEWV7mp8SQS9ijzKp9syyACN9nLX9CVFIq4e9
 FZuQciFN4OTxLU+lEyKzimGfz3bIY9QAQ/xBbvYxGRk3ixoL8Ty0SU2DqwFD5CdBcIiLylHzw9y
 52nW+ZtoB5KwrGeO4rqa/ZlpECBM/W/Luw=
X-Received: by 2002:a17:90b:280d:b0:3a0:eec6:b065 with SMTP id
 98e67ed59e1d1-3a49c11ea0amr976130a91.13.1790666972219; 
 Tue, 29 Sep 2026 00:29:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:14 +0800
Message-ID: <7dc9f012e5d75603c38891ee71132b8ca445a5a7.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790665952.git.qiwenjie@xiaomi.com>
References: <cover.1790665952.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xBSHS-0000EB-2b
Subject: [f2fs-dev] [RFC PATCH 1/6] f2fs: generalize metadata cache
 shrinking to explicit lists
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

The metadata-cache shrinker currently operates on cache->lru_list.
Node-cache compression needs separate raw and compressed queues, while
keeping the existing isolation, truncation and refcount rules.

Move the common shrink loop to f2fs_shrink_cache_list(), and pass it an
explicit list, population and scan budget. Existing caches continue to
use their current LRU lists.

Also return the number of examined entries for queue-specific reclaim
accounting.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/cache.c | 30 +++++++++++++++++++++---------
 fs/f2fs/cache.h |  6 +++++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 38fc5eb17f92..8f81aed132ed 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -547,8 +547,10 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
 	goto next;
 }
 
-static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
-						unsigned long nr_to_scan)
+unsigned long
+f2fs_shrink_cache_list(struct f2fs_cached_block_list *cache,
+		       struct list_head *head, unsigned long nr_entries,
+		       unsigned long nr_to_scan, unsigned long *nr_scanned)
 {
 	struct f2fs_cached_block *entry, *next;
 	LIST_HEAD(dispose_list);
@@ -558,15 +560,15 @@ static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
 
 	/* Phase 1: Isolate candidate entries from LRU list into dispose_list */
 	spin_lock(&cache->list_lock);
-	list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
-		if (scanned >= cache->num_entries)
-			break;
-		if (scanned++ >= nr_to_scan)
+	nr_entries = min(nr_entries, cache->num_entries);
+	list_for_each_entry_safe(entry, next, head, list) {
+		if (scanned >= nr_entries || scanned >= nr_to_scan)
 			break;
+		scanned++;
 
 		/* If accessed, give it a second chance to rotate to tail */
 		if (f2fs_cache_test_and_clear_referenced(entry)) {
-			list_move_tail(&entry->list, &cache->lru_list);
+			list_move_tail(&entry->list, head);
 			continue;
 		}
 
@@ -620,16 +622,26 @@ static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
 			freed++;
 	}
 
-	/* Phase 3: Splice un-reclaimed entries back onto cache->lru_list */
+	/* Phase 3: Splice un-reclaimed entries back onto the scanned list */
 	if (!list_empty(&keep_list)) {
 		spin_lock(&cache->list_lock);
-		list_splice_tail(&keep_list, &cache->lru_list);
+		list_splice_tail(&keep_list, head);
 		spin_unlock(&cache->list_lock);
 	}
+	if (nr_scanned)
+		*nr_scanned = scanned;
 
 	return freed;
 }
 
+static unsigned long
+f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
+		     unsigned long nr_to_scan)
+{
+	return f2fs_shrink_cache_list(cache, &cache->lru_list, ULONG_MAX,
+			nr_to_scan, NULL);
+}
+
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 					unsigned long nr_to_scan)
 {
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 6c4db910d767..c4c3d09a0008 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -222,7 +222,11 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 	f2fs_drop_cache_range(NODE_CACHE(sbi), start, len, true)
 
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
-				unsigned long nr_to_scan);
+					unsigned long nr_to_scan);
+unsigned long
+f2fs_shrink_cache_list(struct f2fs_cached_block_list *cache,
+		       struct list_head *head, unsigned long nr_entries,
+		       unsigned long nr_to_scan, unsigned long *nr_scanned);
 
 #define DEF_DIRTY_CACHE_TIMEOUT 5000
 #define MIN_DIRTY_CACHE_TIMEOUT 100
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
