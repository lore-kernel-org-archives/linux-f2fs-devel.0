Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519BDC61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Vh0xioMgcFd7C4zDjc3/T0g5TkffUCP5AuKu3emc6o=; b=lRjNoXo4H3pDg9ZfdULvDN/01T
	xreHgrgoiXgPFxImiGCQSkxxI5EISVg1wnJ5qWTFD111HAVyl9mTCKfHqQmua7kjsvUrVM7fDrb/2
	QflvXSsvs5n3ogunB8wLGAQ6lQfnKN8Q/JOMI0HKsI5IyoKQtrx6jAx2yNfxkN4gXkTQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZBG-00047S-N9;
	Thu, 27 Aug 2026 12:26:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZBF-00047J-LK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Zx++dLFAc2bUqW4qLmRSUGyrS2d6bWvWxtu9F3oozQ=; b=Vth2kHdAw1hI/zvb5iGj5+3uaJ
 6y4nRM0X7sU92IavlFoXckvhUDMlXjgdyX/mO4hvjHTKEGQBhRVXkAwusERMCidn0ZKW/OHlsiaFx
 npIv1DwdfFBCKIjlFn33+R5IjHccK/Ty9pbMt3m3kpOIqIKdiVhzm5ID7FnEEMn+M6uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9Zx++dLFAc2bUqW4qLmRSUGyrS2d6bWvWxtu9F3oozQ=; b=aSJXp0t+gFqzlknBvc7sbTLX9b
 BPOjKEiiT3uOVZ/hvzYz4keQGU3ZOdh2XrzVM4A58II+OfioD8LJCXY3FYIVOI4wCTn5ifZNlFpf3
 Z0+RhW0gAmhynDmMj520M5J5GH6ZnbfE0510MgUpyM5s0bZsnYBg50IED87q25r6m9x4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZBE-00054D-TB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:26:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59E06600D3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 12:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCEC1F00ADB;
 Thu, 27 Aug 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787833559;
 bh=9Zx++dLFAc2bUqW4qLmRSUGyrS2d6bWvWxtu9F3oozQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AM1DRlnfhejcl4jstPdz7e5x0u3U4Rfb9Dd7UoUeMTW1qmgIGangaAe616/DCtkb3
 9r6v797XUOz1nmBvhxyK5s7bJFgLAqG9CrIhzM3fEg0GZ4Hem0YpkF4I+woKu6mIAu
 L3nwCpu/dnjhYrmM9Qjp22U7kXETRSdCf+yKsSFfZa2bKezKfLZxtYGxh3mCqCflj6
 dZTbcjWcO0BtFQ1066aKXQvATEWFNSbLUD1cptSqHCayTDSob+0yoI6TEYMPlZ8e/T
 hvbQOLV2zwT9rHxD2OiJXMnt/RMaSyP8P4Q0POVG1TH58JJd07TIJpvhHdl67jukaY
 0y5ydPvghL1yg==
To: jaegeuk@kernel.org
Date: Thu, 27 Aug 2026 20:25:36 +0800
Message-ID: <20260827122541.19967-9-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827122541.19967-1-chao@kernel.org>
References: <20260827122541.19967-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wzZBE-00054D-TB
Subject: [f2fs-dev] [PATCH v4 08/12] f2fs: cache: initialize compress cache
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

This patch introduces compress_blocks in f2fs_sb_info structure, initializes
and destroys the compress cache during filesystem mount and unmount.

It adds an ino union field in struct f2fs_cached_block (sharing space
with writeback linkage for zero memory overhead) to track per-inode
cached blocks, and registers compress cache into the memory shrinker.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c |  9 ++++++++-
 fs/f2fs/cache.h | 14 ++++++++++----
 fs/f2fs/f2fs.h  |  6 ++++++
 fs/f2fs/super.c |  9 ++++++++-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index d06b046a9c25..058e62c44152 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -198,7 +198,10 @@ static struct f2fs_cached_block *f2fs_create_cache(
 	entry->index = index;
 
 	atomic_set(&entry->refcount, 0);
-	entry->next_entry = NULL;
+	if (!IS_COMPRESS_CACHE(cache))
+		entry->next_entry = NULL;
+	else
+		entry->ino = 0;
 	INIT_LIST_HEAD(&entry->list);
 
 	entry->cache = cache;
@@ -645,6 +648,10 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 		return freed;
 
 	freed += f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan - freed);
+	if (freed >= nr_to_scan)
+		return freed;
+
+	freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi), nr_to_scan - freed);
 	return freed;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 989307feec3b..474aaf5966f2 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -18,12 +18,15 @@ struct f2fs_rwsem;
 struct f2fs_io_info;
 enum page_type;
 
-/* Represents a single cached block (meta, node) */
+/* Represents a single cached block (meta, node or compress) */
 struct f2fs_cached_block {
 	struct list_head list;		/* LRU list head */
 	struct f2fs_cached_block_list *cache;	/* parent cache list */
-	struct f2fs_cached_block *next_entry;	/* chain for merged BIO */
-	unsigned long index;		/* key in radix tree, (meta: pba, node: nid) */
+	union {
+		struct f2fs_cached_block *next_entry;/* chain for merged BIO */
+		nid_t ino;		/* inode number for compress cache */
+	};
+	unsigned long index;		/* key in radix tree, (meta/compress: pba, node: nid) */
 	unsigned long state;		/* cache entry state (e.g., Dirty, UpToDate) */
 	void *data;			/* blocksize-aligned memory (4KB or 16KB) */
 	atomic_t refcount;		/* reference count */
@@ -34,6 +37,7 @@ struct f2fs_sb_info;
 enum f2fs_cache_type {
 	F2FS_META_CACHE,
 	F2FS_NODE_CACHE,
+	F2FS_COMPRESS_CACHE,
 };
 
 /* Main cache control structure (per sb_info) */
@@ -43,12 +47,13 @@ struct f2fs_cached_block_list {
 	spinlock_t tree_lock;		/* Lock for radix tree */
 	struct list_head lru_list;	/* Single global LRU list */
 	spinlock_t list_lock;		/* Lock for LRU list */
-	enum f2fs_cache_type type;	/* Cache type (Node or Meta) */
+	enum f2fs_cache_type type;	/* Cache type (Node, Meta, Compress) */
 	unsigned long num_entries;	/* Current number of entries */
 };
 
 #define IS_META_CACHE(cache) (cache->type == F2FS_META_CACHE)
 #define IS_NODE_CACHE(cache) (cache->type == F2FS_NODE_CACHE)
+#define IS_COMPRESS_CACHE(cache) (cache->type == F2FS_COMPRESS_CACHE)
 
 /* Flags for f2fs_cached_block state */
 enum f2fs_cached_state {
@@ -185,6 +190,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
 #define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
+#define COMPRESS_CACHE(sbi)	(&(sbi)->compress_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ce7885864982..5b1b3104ec20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2107,6 +2107,7 @@ struct f2fs_sb_info {
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
 	struct f2fs_cached_block_list node_blocks;
+	struct f2fs_cached_block_list compress_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
@@ -2328,6 +2329,11 @@ static inline bool f2fs_is_node_cache(struct f2fs_cached_block *entry)
 	return entry->cache && entry->cache == NODE_CACHE(entry->cache->sbi);
 }
 
+static inline bool f2fs_is_compress_cache(struct f2fs_cached_block *entry)
+{
+	return entry->cache && entry->cache == COMPRESS_CACHE(entry->cache->sbi);
+}
+
 static inline struct f2fs_bio *F2FS_BIO(struct bio *bio)
 {
 	return container_of(bio, struct f2fs_bio, bio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 60498877df88..6b42b736a662 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2052,6 +2052,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 
@@ -5231,10 +5232,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_meta_cache;
 
+	err = f2fs_init_cache(sbi, COMPRESS_CACHE(sbi), F2FS_COMPRESS_CACHE);
+	if (err)
+		goto free_node_cache;
+
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
-		goto free_node_cache;
+		goto free_compress_cache;
 	}
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
@@ -5555,6 +5560,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
+free_compress_cache:
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 free_node_cache:
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 free_meta_cache:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
