Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FF5C9832A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIcmRPFiuVzS1KEONhvoxWqh1BaLOndRffgQm1px6DI=; b=ezFIjjk67DuALzH7pRDNWDCIz9
	Cfpuoq4xNRYbPTcqsh27VwMmiHZ1JJygnAmBDU1WL+iYlFL4nLm2yREP7MKrAwOzpL11QUSnxhUj3
	sH4fhQLoO1Lcx5vS0GKAWabjZVVaNBBtyLAh0fne7ODbtZywpqNJrX/TWywy9e2Kz9x8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHe-0001cT-23;
	Tue, 29 Sep 2026 07:29:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHc-0001cL-DS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GnEfE1pe6kxoyichRQ4zL3yWerWQ5FxxofpTTQKI/p8=; b=PITvRRpb+J24uBWfzoAAUS2L8/
 91K8y1G3rSOWJYbPMTOUNMBUR6Opq6j4Nzaqp1PgB0QkZoAfX7VrBLpJcXKUeue8OI92JWaZYNe3x
 xD+kcmNj6e99sGtz0junb26a0BEIDWq52lu7Yd3NOacW0ti9HCrfI8xXaHZYb8+hDU8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GnEfE1pe6kxoyichRQ4zL3yWerWQ5FxxofpTTQKI/p8=; b=lN6I8cx0HuaGDGDkcT9V3clgUi
 UgIsQeUkmx3d3KBwfPCq79O2JrXwaXGMZrg0C8eApqGqIAEHtrnBVjo+/2UVeTadNOxQzQTWAFfrR
 ylHsJayuivjDIeCjTvUanqI4IVp/t3zVvtz5mppyVSEeiUWLSHUPFOuSLhGtIVpmgiyw=;
Received: from mail-pj2-f39.google.com ([74.125.227.167])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHW-0006PS-5m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:45 +0000
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a4805e15cfso816633a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666976; x=1791271776; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GnEfE1pe6kxoyichRQ4zL3yWerWQ5FxxofpTTQKI/p8=;
 b=jZBMaOVmajmYT8Wm4tt9U+riaZN5mCORbO4laiObjLUnDTW3yFva1343svPZpziYTl
 KYZAhsFwDkZTjEZY23C2YmIyuzh+BxuaxO0S8NOv7XzrrLnpv7SXPm+3sb56Nx3Bm7z+
 aHUhq1lsMi96qFIItAQ9DOCbr6RsVeERb53yZ8+QyYHuu+wIv34/k7G9CXTaZ8piGmv+
 +k4rnbgXuTnWsn3L21s1S8pfnbzX8LJ04gS9xLM0//ImXgEMD4LcDgh/JdM3Az6T7mcK
 /Xy+bOkoa70Y5kYnUJRXCtglbAsoPx3X11boch3fuzZT4FF341qJaUXUG5N7NfS7RlR/
 Vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666976; x=1791271776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GnEfE1pe6kxoyichRQ4zL3yWerWQ5FxxofpTTQKI/p8=;
 b=y104LbzbJVGP4aiZiZINL40+LgU/EvN522xvFlCb5cCgh+27edXMkCP/C9BlHwLKki
 6ODakJ/NWkDTXYp+1gG8MeeTrq1Er8G2UFkDAJL+QnPm0+OPmtYm7UXy56OOReGQGU9a
 fBKiJA1M3NHzig2J+Ko5yVCh/ONXyXUUT/hEpbZtl7zDmDFheFiWfvLCVawrn2uE8Kw3
 AQv4B31diyhvO0qZw91+3aIdKaEqTBYNTaUwM+rKd9SfvfilVWzdpZgWtTujyRG5fGqk
 trhd8SQHuWDgrD000WR1IVFfeLcV046mTuTDBsPqUokKpvEH4O8/3aeUOUj2EhpqPi7Z
 3TkA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZxU0Rve3oqJZvbaACANuw1tNVjbqTczpVfgkYfu4L1cTA80bOmklkkBV0ZVOY8iE43AAGkUvID9Vc/ec/LHLL@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKnsr4dISh6x3XiOlBf0asa4GmEEvn0FsfvJlMAJgB8TUTNo2pM
 hhdgdQQorRBSUvSb+Vl8ioG8CiKcX8WVnHzdlMdC1Zt2gPS4HnwCtiJA
X-Gm-Gg: AYBFou0xp2uM814oE4BzfhuUnGuectqv5vg73dcYZPZQLIaSG/bd2cMW47VhxnE8TpR
 COt3JRk99imJbYJB5cgjp+wT21D+/P9EC+Go5v9u6gCFBWzbQzU/rX08n74ekz8ric7zjo7LNsk
 oiI5N+Mowgdf61dFpeSR/I/Wt3D5sjF/XNfh7B/r3hRSct8iNncOrDxdk47+ERZYboL2F3zfCAJ
 RcXQxOx3bniXhS5aBmWKknoKnaxZilX9Dmw+rCc049eI72ncIRHY7+NWOeKH+t8VXziUL4cARry
 28sGG6ryTPDQm0uscg2zY4Pf9sas4QNJgWBBB6X2FOZgjgx32OGylKFDP2XVKoXq+Fi4O8D4EQ2
 b7ZLH43yc3+Kj/d5SlH4MaxWW4A5F07vuhccHuYgrIGJbxuNBUHStekcZFqxA2pS47HZ8ZNBE5r
 PnxMq7tAE6lZhfXvO1Xtr8HibMCLLV7Eytldjn+zDvsusDiX18NPvIIRgg4PeN870a+VaK4yHth
 kjN6m8nuGinFgJW5+F5Iv9D23ngH9ywmnk=
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c80:f67f with SMTP id
 98e67ed59e1d1-3a098983faemr12981101a91.30.1790666976228; 
 Tue, 29 Sep 2026 00:29:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:35 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:15 +0800
Message-ID: <233c44340813cb2186ee187c00f2522e6ad578cb.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790665952.git.qiwenjie@xiaomi.com>
References: <cover.1790665952.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xBSHW-0006PS-5m
Subject: [f2fs-dev] [RFC PATCH 2/6] f2fs: add compressed clean node cache
 representation
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

A clean node-cache entry currently retains a full block until it is
reclaimed. Add an optional compressed representation that keeps the entry
and its NID in memory with a smaller payload.

Use an extended NODE_CACHE entry and per-mount 256, 512 and 1024-byte
private slabs. Raw entries remain on the existing LRU, while compressed
entries use one queue per allocation size.

Keep raw and compressed ownership exclusive, and make detach and teardown
aware of the compressed queues. If the compression resources cannot be
initialized, leave node compression disabled instead of failing the mount.
The generic entry layout remains unchanged when the feature is disabled.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/Kconfig               |  12 ++
 fs/f2fs/Makefile              |   1 +
 fs/f2fs/cache.c               |  27 ++-
 fs/f2fs/cache.h               |   8 +
 fs/f2fs/debug.c               |  10 +-
 fs/f2fs/f2fs.h                |   7 +
 fs/f2fs/node_cache_compress.c | 303 ++++++++++++++++++++++++++++++++++
 fs/f2fs/node_cache_compress.h |  78 +++++++++
 fs/f2fs/node_cache_policy.h   |  23 +++
 fs/f2fs/super.c               |   4 +
 10 files changed, 462 insertions(+), 11 deletions(-)
 create mode 100644 fs/f2fs/node_cache_compress.c
 create mode 100644 fs/f2fs/node_cache_compress.h
 create mode 100644 fs/f2fs/node_cache_policy.h

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 5916a02fb46d..5aa54916e594 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -99,6 +99,18 @@ config F2FS_FS_COMPRESSION
 	  Enable filesystem-level compression on f2fs regular files,
 	  multiple back-end compression algorithms are supported.
 
+config F2FS_FS_NODE_CACHE_COMPRESSION
+	bool "F2FS clean node cache compression"
+	depends on F2FS_FS
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+	default n
+	help
+	  Retain clean node-cache blocks in a private compressed store.
+	  This is independent of file-data compression and COMPRESS_CACHE.
+	  The store uses 256, 512 and 1024 byte slab buckets.
+	  Compression is disabled at runtime until a nonzero threshold is set.
+
 config F2FS_FS_LZO
 	bool "LZO compression support"
 	depends on F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index fbf49c30b066..e1e4b98707e9 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -9,4 +9,5 @@ f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_FS_VERITY) += verity.o
 f2fs-$(CONFIG_F2FS_FS_COMPRESSION) += compress.o
+f2fs-$(CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION) += node_cache_compress.o
 f2fs-$(CONFIG_F2FS_IOSTAT) += iostat.o
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 8f81aed132ed..3d1d530cdd82 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -17,6 +17,7 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 #include "segment.h"
+#include "node_cache_compress.h"
 
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
 					enum page_type type)
@@ -127,7 +128,7 @@ static int f2fs_cache_refcount(struct f2fs_cached_block *entry)
 
 static void f2fs_do_free_cache(struct f2fs_cached_block *entry)
 {
-	kfree(entry->data);
+	f2fs_nc_free_data(entry);
 	kfree(entry);
 }
 
@@ -159,6 +160,7 @@ static struct f2fs_cached_block *f2fs_create_cache(
 {
 	struct f2fs_sb_info *sbi = cache->sbi;
 	struct f2fs_cached_block *entry;
+	size_t entry_size = f2fs_nc_entry_alloc_size(cache);
 	unsigned int flags = GFP_NOFS;
 
 	if (index == ULONG_MAX)
@@ -166,10 +168,10 @@ static struct f2fs_cached_block *f2fs_create_cache(
 
 	if (nofail) {
 		flags |= __GFP_NOFAIL;
-		entry = kzalloc_obj(*entry, flags);
+		entry = kzalloc(entry_size, flags);
 		entry->data = kmalloc(sbi->blocksize, flags);
 	} else {
-		entry = f2fs_kzalloc(sbi, sizeof(*entry), flags);
+		entry = f2fs_kzalloc(sbi, entry_size, flags);
 		if (!entry)
 			return ERR_PTR(-ENOMEM);
 
@@ -220,6 +222,7 @@ static struct f2fs_cached_block *f2fs_insert_cache(
 		f2fs_bug_on(cache->sbi, !list_empty(&e->list));
 		list_add_tail(&e->list, &cache->lru_list);
 		cache->num_entries++;
+		f2fs_nc_entry_attached(e);
 	}
 	f2fs_cache_get(e);
 	spin_unlock_irqrestore(&cache->tree_lock, flags);
@@ -429,8 +432,9 @@ static void f2fs_do_truncate_cache(struct f2fs_cached_block *entry,
 	if (!radix_tree_delete(&cache->root, entry->index))
 		f2fs_bug_on(cache->sbi, !entry->cache);
 
-	entry->cache = NULL;
 	cache->num_entries--;
+	f2fs_nc_entry_detached(entry);
+	entry->cache = NULL;
 
 	atomic_dec(&entry->refcount);
 	f2fs_bug_on(cache->sbi, !f2fs_cache_refcount(entry));
@@ -514,14 +518,24 @@ int f2fs_init_cache(struct f2fs_sb_info *sbi,
 
 void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
 {
-	struct list_head *head = &cache->lru_list;
+	struct list_head *head;
 	struct f2fs_cached_block *entry;
 	unsigned long flags;
+	unsigned int queue;
 
 	f2fs_cache_wait_on_all_writeback(cache);
 next:
 	spin_lock(&cache->list_lock);
-	if (list_empty(head)) {
+	head = NULL;
+	for (queue = 0; queue < F2FS_NC_NR_QUEUES; queue++) {
+		struct list_head *candidate = f2fs_nc_queue_head(cache, queue);
+
+		if (candidate && !list_empty(candidate)) {
+			head = candidate;
+			break;
+		}
+	}
+	if (!head) {
 		spin_unlock(&cache->list_lock);
 		return;
 	}
@@ -530,6 +544,7 @@ void f2fs_destroy_cache(struct f2fs_cached_block_list *cache)
 	spin_lock_irqsave(&cache->tree_lock, flags);
 	radix_tree_delete(&cache->root, entry->index);
 	cache->num_entries--;
+	f2fs_nc_entry_detached(entry);
 	list_del_init(&entry->list);
 	spin_unlock_irqrestore(&cache->tree_lock, flags);
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index c4c3d09a0008..8a1eab71b1ae 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -64,6 +64,9 @@ enum f2fs_cached_state {
 	F2FS_BLOCK_WRITEBACK,		/* cache data is writeback state */
 	F2FS_BLOCK_REFERENCED,		/* cache was accessed recently, shrinker will skip it for once */
 	F2FS_BLOCK_INLINE_DATA,		/* indicate inline data */
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	F2FS_BLOCK_COMPRESSED,
+#endif
 };
 
 enum {
@@ -144,6 +147,11 @@ F2FS_CACHE_FLAG_CLEAR_FUNC(inline, INLINE_DATA);
 F2FS_CACHE_FLAG_TEST_FUNC(referenced, REFERENCED);
 F2FS_CACHE_FLAG_SET_FUNC(referenced, REFERENCED);
 F2FS_CACHE_FLAG_TEST_AND_CLEAR_FUNC(referenced, REFERENCED);
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+F2FS_CACHE_FLAG_TEST_FUNC(compressed, COMPRESSED);
+F2FS_CACHE_FLAG_SET_FUNC(compressed, COMPRESSED);
+F2FS_CACHE_FLAG_CLEAR_FUNC(compressed, COMPRESSED);
+#endif
 
 static inline void *cache_address(const struct f2fs_cached_block *entry)
 {
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6fe606e2c70d..a6096537b495 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -19,6 +19,7 @@
 #include "node.h"
 #include "segment.h"
 #include "gc.h"
+#include "node_cache_compress.h"
 
 static LIST_HEAD(f2fs_stat_list);
 static DEFINE_SPINLOCK(f2fs_stat_lock);
@@ -297,6 +298,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 static void update_mem_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	struct f2fs_nc_memory node_memory;
 	int i;
 
 	if (si->base_mem)
@@ -386,11 +388,9 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->cache_data_mem[F2FS_META_CACHE] =
 		(unsigned long long)META_CACHE(sbi)->num_entries * sbi->blocksize;
 
-	si->cache_entry_mem[F2FS_NODE_CACHE] =
-		(unsigned long long)NODE_CACHE(sbi)->num_entries *
-		sizeof(struct f2fs_cached_block);
-	si->cache_data_mem[F2FS_NODE_CACHE] =
-		(unsigned long long)NODE_CACHE(sbi)->num_entries * sbi->blocksize;
+	f2fs_nc_memory_usage(sbi, &node_memory);
+	si->cache_entry_mem[F2FS_NODE_CACHE] = node_memory.entry_bytes;
+	si->cache_data_mem[F2FS_NODE_CACHE] = node_memory.data_bytes;
 
 	si->cache_mem += si->cache_entry_mem[F2FS_META_CACHE] +
 			 si->cache_entry_mem[F2FS_NODE_CACHE];
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054ea..16cc050124dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -26,6 +26,10 @@
 #include <linux/part_stat.h>
 #include <linux/rw_hint.h>
 
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+struct f2fs_nc_ctx;
+#endif
+
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 
@@ -2106,6 +2110,9 @@ struct f2fs_sb_info {
 	struct f2fs_cached_block_list meta_blocks;
 	struct f2fs_cached_block_list node_blocks;
 	struct f2fs_cached_block_list compress_blocks;
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+	struct f2fs_nc_ctx *node_compress;
+#endif
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
diff --git a/fs/f2fs/node_cache_compress.c b/fs/f2fs/node_cache_compress.c
new file mode 100644
index 000000000000..486da4ed6082
--- /dev/null
+++ b/fs/f2fs/node_cache_compress.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/atomic.h>
+#include <linux/f2fs_fs.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+
+#include "f2fs.h"
+#include "node_cache_compress.h"
+
+static const u32 f2fs_nc_bucket_sizes[] = {
+	F2FS_NC_BUCKET_256_SIZE,
+	F2FS_NC_BUCKET_512_SIZE,
+	F2FS_NC_BUCKET_1024_SIZE,
+};
+
+/* One private slab and active-object count for each compressed bucket. */
+struct f2fs_nc_store {
+	struct kmem_cache *caches[ARRAY_SIZE(f2fs_nc_bucket_sizes)];
+	atomic_long_t objects[ARRAY_SIZE(f2fs_nc_bucket_sizes)];
+};
+
+static int f2fs_nc_store_bucket_from_size(u32 alloc_size)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f2fs_nc_bucket_sizes); i++)
+		if (alloc_size == f2fs_nc_bucket_sizes[i])
+			return i;
+	return -EINVAL;
+}
+
+static struct f2fs_nc_store *f2fs_nc_store_create(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nc_store *store;
+	char name[64];
+	int i;
+
+	store = kzalloc_obj(*store, GFP_NOFS);
+	if (!store)
+		return NULL;
+	for (i = 0; i < ARRAY_SIZE(f2fs_nc_bucket_sizes); i++) {
+		if (snprintf(name, sizeof(name), "f2fs-nc-%u-%u-%u",
+			     MAJOR(sbi->sb->s_dev), MINOR(sbi->sb->s_dev),
+			     f2fs_nc_bucket_sizes[i]) >= sizeof(name))
+			goto fail;
+		store->caches[i] = kmem_cache_create(name,
+						     f2fs_nc_bucket_sizes[i], 0,
+				SLAB_RECLAIM_ACCOUNT | SLAB_NO_MERGE, NULL);
+		if (!store->caches[i])
+			goto fail;
+	}
+	return store;
+
+fail:
+	while (i--)
+		kmem_cache_destroy(store->caches[i]);
+	kfree(store);
+	return NULL;
+}
+
+static void f2fs_nc_store_destroy(struct f2fs_nc_store *store)
+{
+	int i;
+
+	if (!store)
+		return;
+	for (i = ARRAY_SIZE(f2fs_nc_bucket_sizes); i-- > 0;) {
+		WARN_ON_ONCE(atomic_long_read(&store->objects[i]));
+		kmem_cache_destroy(store->caches[i]);
+	}
+	kfree(store);
+}
+
+static void f2fs_nc_store_free(struct f2fs_nc_store *store, void *object,
+			       u32 alloc_size)
+{
+	int bucket = f2fs_nc_store_bucket_from_size(alloc_size);
+
+	if (WARN_ON_ONCE(!store || !object || bucket < 0))
+		return;
+	kmem_cache_free(store->caches[bucket], object);
+	atomic_long_dec(&store->objects[bucket]);
+}
+
+/*
+ * Per-superblock compression state.  Compressed objects hold references, so
+ * the context can outlive its mount until every detached object is freed.
+ */
+struct f2fs_nc_ctx {
+	struct f2fs_sb_info *sbi;
+	struct f2fs_nc_store *store;
+	/* Compressed queues only; raw entries use NODE_CACHE()->lru_list. */
+	struct list_head queues[F2FS_NC_NR_QUEUES - 1];
+	/* Current population and compressed bytes by queue. */
+	atomic_long_t attached[F2FS_NC_NR_QUEUES];
+	atomic64_t attached_payload[F2FS_NC_NR_QUEUES - 1];
+	atomic64_t attached_slot_bytes[F2FS_NC_NR_QUEUES - 1];
+	/* Cumulative detach statistics since mount. */
+	atomic64_t detached[F2FS_NC_NR_QUEUES];
+	/* Mount reference plus references held by compressed objects. */
+	refcount_t refs;
+};
+
+static struct f2fs_node_cached_block *f2fs_nc_node_entry(struct f2fs_cached_block *entry)
+{
+	return container_of(entry, struct f2fs_node_cached_block, base);
+}
+
+static void f2fs_nc_ctx_release(struct f2fs_nc_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < F2FS_NC_NR_QUEUES; i++)
+		WARN_ON_ONCE(atomic_long_read(&ctx->attached[i]));
+	f2fs_nc_store_destroy(ctx->store);
+	kfree(ctx);
+}
+
+static void f2fs_nc_ctx_put(struct f2fs_nc_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->refs))
+		f2fs_nc_ctx_release(ctx);
+}
+
+static void f2fs_nc_account_add(struct f2fs_nc_ctx *ctx, unsigned int queue,
+				u32 len, u32 alloc_size)
+{
+	atomic_long_inc(&ctx->attached[queue]);
+	if (queue == F2FS_NC_RAW)
+		return;
+	atomic64_add(len, &ctx->attached_payload[queue - 1]);
+	atomic64_add(alloc_size, &ctx->attached_slot_bytes[queue - 1]);
+}
+
+static void f2fs_nc_account_del(struct f2fs_nc_ctx *ctx, unsigned int queue,
+				u32 len, u32 alloc_size)
+{
+	WARN_ON_ONCE(atomic_long_read(&ctx->attached[queue]) <= 0);
+	atomic_long_dec(&ctx->attached[queue]);
+	if (queue == F2FS_NC_RAW)
+		return;
+	WARN_ON_ONCE(atomic64_read(&ctx->attached_payload[queue - 1]) < len);
+	WARN_ON_ONCE(atomic64_read(&ctx->attached_slot_bytes[queue - 1]) <
+			alloc_size);
+	atomic64_sub(len, &ctx->attached_payload[queue - 1]);
+	atomic64_sub(alloc_size, &ctx->attached_slot_bytes[queue - 1]);
+}
+
+size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache)
+{
+	if (IS_NODE_CACHE(cache) && cache->sbi->node_compress)
+		return sizeof(struct f2fs_node_cached_block);
+	return sizeof(struct f2fs_cached_block);
+}
+
+void f2fs_nc_init(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nc_ctx *ctx;
+	int i;
+
+	ctx = kzalloc_obj(*ctx, GFP_NOFS);
+	if (!ctx)
+		goto fail_open;
+	ctx->sbi = sbi;
+	ctx->store = f2fs_nc_store_create(sbi);
+	if (!ctx->store)
+		goto fail_open;
+	for (i = 0; i < ARRAY_SIZE(ctx->queues); i++)
+		INIT_LIST_HEAD(&ctx->queues[i]);
+	refcount_set(&ctx->refs, 1);
+	sbi->node_compress = ctx;
+	return;
+
+fail_open:
+	if (ctx)
+		f2fs_nc_ctx_release(ctx);
+	f2fs_warn_ratelimited(sbi,
+			      "node cache compression resources are unavailable");
+}
+
+void f2fs_nc_destroy(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+
+	if (!ctx)
+		return;
+	sbi->node_compress = NULL;
+	f2fs_nc_ctx_put(ctx);
+}
+
+struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
+				     unsigned int queue)
+{
+	struct f2fs_nc_ctx *ctx;
+
+	if (queue == F2FS_NC_RAW)
+		return &cache->lru_list;
+	if (!IS_NODE_CACHE(cache) || queue >= F2FS_NC_NR_QUEUES)
+		return NULL;
+	ctx = cache->sbi->node_compress;
+	return ctx ? &ctx->queues[queue - 1] : NULL;
+}
+
+unsigned int f2fs_nc_entry_queue(const struct f2fs_cached_block *entry)
+{
+	const struct f2fs_node_cached_block *node;
+	int bucket;
+
+	if (!f2fs_cache_test_compressed(entry))
+		return F2FS_NC_RAW;
+	node = container_of(entry, struct f2fs_node_cached_block, base);
+	bucket = f2fs_nc_store_bucket_from_size(node->compressed_alloc_size);
+	if (WARN_ON_ONCE(bucket < 0))
+		return F2FS_NC_RAW;
+	return bucket + 1;
+}
+
+void f2fs_nc_entry_attached(struct f2fs_cached_block *entry)
+{
+	struct f2fs_nc_ctx *ctx;
+
+	if (!entry->cache || !IS_NODE_CACHE(entry->cache))
+		return;
+	ctx = entry->cache->sbi->node_compress;
+	if (ctx)
+		f2fs_nc_account_add(ctx, F2FS_NC_RAW, 0, 0);
+}
+
+void f2fs_nc_entry_detached(struct f2fs_cached_block *entry)
+{
+	struct f2fs_node_cached_block *node;
+	struct f2fs_nc_ctx *ctx;
+	unsigned int queue;
+	u32 len = 0, alloc_size = 0;
+
+	if (!entry->cache || !IS_NODE_CACHE(entry->cache))
+		return;
+	ctx = entry->cache->sbi->node_compress;
+	if (!ctx)
+		return;
+	queue = f2fs_nc_entry_queue(entry);
+	if (queue != F2FS_NC_RAW) {
+		node = f2fs_nc_node_entry(entry);
+		len = node->compressed_len;
+		alloc_size = node->compressed_alloc_size;
+	}
+	atomic64_inc(&ctx->detached[queue]);
+	f2fs_nc_account_del(ctx, queue, len, alloc_size);
+}
+
+void f2fs_nc_free_data(struct f2fs_cached_block *entry)
+{
+	struct f2fs_node_cached_block *node;
+	struct f2fs_nc_ctx *ctx;
+	void *object;
+	u32 alloc_size;
+
+	if (!f2fs_cache_test_compressed(entry)) {
+		kfree(entry->data);
+		return;
+	}
+	node = f2fs_nc_node_entry(entry);
+	ctx = node->owner;
+	object = entry->data;
+	alloc_size = node->compressed_alloc_size;
+	if (WARN_ON_ONCE(!ctx || !object ||
+			 f2fs_nc_store_bucket_from_size(alloc_size) < 0))
+		return;
+	f2fs_cache_clear_compressed(entry);
+	entry->data = NULL;
+	node->owner = NULL;
+	node->compressed_len = 0;
+	node->compressed_alloc_size = 0;
+	node->compressed_crc = 0;
+	f2fs_nc_store_free(ctx->store, object, alloc_size);
+	f2fs_nc_ctx_put(ctx);
+}
+
+void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
+			  struct f2fs_nc_memory *memory)
+{
+	struct f2fs_nc_ctx *ctx = sbi->node_compress;
+	u64 entries = 0, data = 0;
+	unsigned int i;
+
+	if (!ctx) {
+		memory->entry_bytes = (u64)NODE_CACHE(sbi)->num_entries *
+				sizeof(struct f2fs_cached_block);
+		memory->data_bytes = (u64)NODE_CACHE(sbi)->num_entries *
+				sbi->blocksize;
+		return;
+	}
+	spin_lock(&NODE_CACHE(sbi)->list_lock);
+	for (i = 0; i < F2FS_NC_NR_QUEUES; i++)
+		entries += atomic_long_read(&ctx->attached[i]);
+	data = (u64)atomic_long_read(&ctx->attached[F2FS_NC_RAW]) *
+			sbi->blocksize;
+	for (i = 0; i < F2FS_NC_NR_QUEUES - 1; i++)
+		data += atomic64_read(&ctx->attached_slot_bytes[i]);
+	spin_unlock(&NODE_CACHE(sbi)->list_lock);
+	memory->entry_bytes = entries * sizeof(struct f2fs_node_cached_block);
+	memory->data_bytes = data;
+}
diff --git a/fs/f2fs/node_cache_compress.h b/fs/f2fs/node_cache_compress.h
new file mode 100644
index 000000000000..e1a9b45d67e3
--- /dev/null
+++ b/fs/f2fs/node_cache_compress.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __F2FS_NODE_CACHE_COMPRESS_H__
+#define __F2FS_NODE_CACHE_COMPRESS_H__
+
+#include "cache.h"
+#include "node_cache_policy.h"
+
+struct f2fs_nc_ctx;
+
+/* Attributed cache memory, excluding worker workspace and slab metadata. */
+struct f2fs_nc_memory {
+	u64 entry_bytes;	/* Cache-entry storage. */
+	u64 data_bytes;	/* Raw buffers plus compressed slab slots. */
+};
+
+#ifdef CONFIG_F2FS_FS_NODE_CACHE_COMPRESSION
+/* Extended NODE_CACHE entry; base must remain the first member. */
+struct f2fs_node_cached_block {
+	struct f2fs_cached_block base;
+	struct f2fs_nc_ctx *owner;	/* Context owning compressed data. */
+	u32 compressed_len;		/* Valid compressed payload bytes. */
+	u32 compressed_alloc_size;	/* Private-slab slot size. */
+	u32 compressed_crc;		/* CRC of the original node block. */
+};
+
+static_assert(offsetof(struct f2fs_node_cached_block, base) == 0);
+
+size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache);
+void f2fs_nc_init(struct f2fs_sb_info *sbi);
+void f2fs_nc_destroy(struct f2fs_sb_info *sbi);
+void f2fs_nc_free_data(struct f2fs_cached_block *entry);
+struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
+				     unsigned int queue);
+unsigned int f2fs_nc_entry_queue(const struct f2fs_cached_block *entry);
+void f2fs_nc_entry_attached(struct f2fs_cached_block *entry);
+void f2fs_nc_entry_detached(struct f2fs_cached_block *entry);
+void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
+			  struct f2fs_nc_memory *memory);
+#else
+static inline size_t f2fs_nc_entry_alloc_size(struct f2fs_cached_block_list *cache)
+{
+	return sizeof(struct f2fs_cached_block);
+}
+
+static inline void f2fs_nc_init(struct f2fs_sb_info *sbi) { }
+
+static inline void f2fs_nc_destroy(struct f2fs_sb_info *sbi) { }
+
+static inline void f2fs_nc_free_data(struct f2fs_cached_block *entry)
+{
+	kfree(entry->data);
+}
+
+static inline struct list_head *f2fs_nc_queue_head(struct f2fs_cached_block_list *cache,
+						   unsigned int queue)
+{
+	return queue == F2FS_NC_RAW ? &cache->lru_list : NULL;
+}
+
+static inline unsigned int
+f2fs_nc_entry_queue(const struct f2fs_cached_block *entry)
+{
+	return F2FS_NC_RAW;
+}
+
+static inline void f2fs_nc_entry_attached(struct f2fs_cached_block *entry) { }
+static inline void f2fs_nc_entry_detached(struct f2fs_cached_block *entry) { }
+
+static inline void f2fs_nc_memory_usage(struct f2fs_sb_info *sbi,
+					struct f2fs_nc_memory *memory)
+{
+	memory->entry_bytes = (u64)NODE_CACHE(sbi)->num_entries *
+			sizeof(struct f2fs_cached_block);
+	memory->data_bytes = (u64)NODE_CACHE(sbi)->num_entries * sbi->blocksize;
+}
+#endif
+
+#endif /* __F2FS_NODE_CACHE_COMPRESS_H__ */
diff --git a/fs/f2fs/node_cache_policy.h b/fs/f2fs/node_cache_policy.h
new file mode 100644
index 000000000000..efe906bfcc58
--- /dev/null
+++ b/fs/f2fs/node_cache_policy.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __F2FS_NODE_CACHE_POLICY_H__
+#define __F2FS_NODE_CACHE_POLICY_H__
+
+#include <linux/types.h>
+
+#define F2FS_NC_BUCKET_256_SIZE		256U
+#define F2FS_NC_BUCKET_512_SIZE		512U
+#define F2FS_NC_BUCKET_1024_SIZE	1024U
+#define F2FS_NC_MAX_OBJECT_SIZE		F2FS_NC_BUCKET_1024_SIZE
+
+/*
+ * Keep compressed queues in the same order as f2fs_nc_bucket_sizes[].
+ * Raw entries remain on NODE_CACHE(sbi)->lru_list.
+ */
+enum f2fs_nc_queue {
+	F2FS_NC_RAW,
+	F2FS_NC_256,
+	F2FS_NC_512,
+	F2FS_NC_1024,
+	F2FS_NC_NR_QUEUES,
+};
+#endif /* __F2FS_NODE_CACHE_POLICY_H__ */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 294f6f2c28a5..461209293dba 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -32,6 +32,7 @@
 #include <linux/fserror.h>
 
 #include "f2fs.h"
+#include "node_cache_compress.h"
 #include "node.h"
 #include "segment.h"
 #include "xattr.h"
@@ -2071,6 +2072,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
+	f2fs_nc_destroy(sbi);
 	f2fs_destroy_cache(META_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
@@ -5263,6 +5265,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
 	f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
 	f2fs_init_cache(sbi, COMPRESS_CACHE(sbi), F2FS_COMPRESS_CACHE);
+	f2fs_nc_init(sbi);
 
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
@@ -5581,6 +5584,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_compress_cache:
 	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
+	f2fs_nc_destroy(sbi);
 	f2fs_destroy_cache(META_CACHE(sbi));
 	f2fs_destroy_page_array_cache(sbi);
 free_percpu:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
