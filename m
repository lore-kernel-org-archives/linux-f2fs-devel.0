Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8954DC79FB8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgH6dgKV1vf3EGWQvhYqOWl61lpLLEclF7nNIlwJ6dg=; b=hyLdUHZjyDnLkdZSa8T7mdf4jj
	ejcT0mfQbi4ugKNyHpcCmp3H/vUnkxxoZ5pCMOEY/Q9Eef8HndpB5MJn6z4bWHtSK5xbCH7NQMvut
	8K96p8wSxAxPxhDxIHTt9y+LVIODEAH4tdb4SCh5fQSHGBwzq5ckMjnEUNMGtxsZ4JrM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FG-0006Ai-6L;
	Wed, 09 Sep 2026 01:37:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FE-0006A3-KK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VqrSty/rC/CZuUYHoIpebZiHcc6iWv0QKiPUX/dW0cc=; b=Ybrqv+zMK1oFpwD2xFP1VoMzN3
 hnJw4yhfM9LdPeydijhU9Gy2LCBUoBZl6I2cBKoo9l5olZ39T42CRARLf4w1bxk8H1xEHNdxfBRxi
 yruh7mEtTfBEW4mX59L+IErBwQ7nvJnh5W1qkPA4b19jofEeTsZ2ztpwf4EShiPuWAsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VqrSty/rC/CZuUYHoIpebZiHcc6iWv0QKiPUX/dW0cc=; b=m9N08nBiW0ro4Th4Iuz3oZ19j8
 VQAOeyxGcoyy3SxmzxAFyI1i4TA8zIhmrR3AqE6anPBOx1AFTclDEwyjYf3WLKK+c04hVgcfvxcfJ
 6L5QWMHXOZoAJQk2WhOr2IBotJ13mGyS0/AyiSXXUfqlsN/rBc8OV2Vk1kjwoGAKN2qE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47F1-0000XO-4b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95D91601FD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894311F00A3E;
 Wed,  9 Sep 2026 01:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917801;
 bh=VqrSty/rC/CZuUYHoIpebZiHcc6iWv0QKiPUX/dW0cc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CoBnrnaAd4pN+wLxR6f4KlgMy8b5nFbAege7JD1LNPi8HtSdaCJ4FMZjkf773im6o
 kkoZWT9zyiH0QpUOAuLFF+jDNoOp94HWcGMb2khsy2gYD6wRrJdcFQWU+eoHVEN1xI
 vneFd/GGYTx2Q88t+2IqPl8sx1mbRzpcIAj83ySbmiTfMMVLrP/dlx5qTps1SxAXA6
 w7PfN3Rjb0iY6cD5Fbk1QoSfEKY5ymNeSbk99v5G7MorUpqemToTKUKaDyWjNuNBtb
 vt1Xwu13ATYx5HdCbfVRJYUe/4osAo+qbGeVHVRSwLG5v6+raigjNOFnKR56Iha0Hw
 oIKPfgfaAa+Dw==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:07 +0800
Message-ID: <20260909013611.3418568-9-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47F1-0000XO-4b
Subject: [f2fs-dev] [PATCH v6 08/12] f2fs: cache: initialize compress cache
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
index d7349d481dbd..e52e73d76700 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -176,7 +176,10 @@ static struct f2fs_cached_block *f2fs_create_cache(
 	entry->index = index;
 
 	atomic_set(&entry->refcount, 0);
-	entry->next_entry = NULL;
+	if (!IS_COMPRESS_CACHE(cache))
+		entry->next_entry = NULL;
+	else
+		entry->ino = 0;
 	INIT_LIST_HEAD(&entry->list);
 
 	entry->cache = cache;
@@ -627,6 +630,10 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 		return freed;
 
 	freed += f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan - freed);
+	if (freed >= nr_to_scan)
+		return freed;
+
+	freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi), nr_to_scan - freed);
 	return freed;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index dfe898df6aa8..a81524755dad 100644
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
@@ -199,6 +204,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
 #define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
+#define COMPRESS_CACHE(sbi)	(&(sbi)->compress_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e5489564194f..1376a6f2e9e2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2106,6 +2106,7 @@ struct f2fs_sb_info {
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
 	struct f2fs_cached_block_list node_blocks;
+	struct f2fs_cached_block_list compress_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
@@ -2384,6 +2385,11 @@ static inline bool f2fs_is_node_cache(struct f2fs_cached_block *entry)
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
index 9446e82d3de7..e1a455573d34 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2071,6 +2071,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 
@@ -5267,10 +5268,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5585,6 +5590,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
