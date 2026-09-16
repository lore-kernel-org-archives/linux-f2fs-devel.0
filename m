Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3350C982C5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhMugsXt0+wMxR69oCG01TIu7kArBo0ge8DNmh7ku6g=; b=EyAXR/cLqwvAt16ZMh7uiCk39Q
	X736A3H4BnsXtbK9702ZJFCWCxd9D/Vkk+PweKCTlYviU9ocNfgqnnxxgERUwldRhQDO1GZMrdrEh
	pgkmucaNW/p0GPVefaXJliCcW9BnjoDXK7byQtphdWGuCFAFtQ6F6yvFzhfHfbwGfxSg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6erf-0002AY-EB;
	Wed, 16 Sep 2026 01:55:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6erY-0002A3-Ln
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+j9yWl8La9A19iYgRDqa/saO+ZRZSts/TuIkoS8lyys=; b=KQe7Db18Glhmas8e5flhQfDRve
 lNhGJih4Y/f6/01c36F8esFialkLjwZPaxmA0BvWJluUkzTGpNX8gtt87NV9FqOjrs0Ofyo5DKcnE
 io6yXMfIFPT2oRbTYRouoL205kfnqWgmTJWl1kZHaUVt8B1iyTzq2OI8/RogDRUSEyhU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+j9yWl8La9A19iYgRDqa/saO+ZRZSts/TuIkoS8lyys=; b=DZ/nA/yPiSLXnCc5Eb/GrJoKmW
 9YKl+WCPHYALZX6R5uB/Ywo17WKtuIlNeTm7FLQMBmHM69/uWguuMVPYFH63UkYkyZFGfgY0qykZM
 A6egqBZ9GUYPpLffLRdC2uGmRJk8RGxNc5ytuDQdqmz+f12zItPL7bY7d3dGy8uzV5tk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6erW-0004wO-PJ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D20F60142
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D0A1F0089F;
 Wed, 16 Sep 2026 01:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789523696;
 bh=+j9yWl8La9A19iYgRDqa/saO+ZRZSts/TuIkoS8lyys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MoyC4MP5lIRywNIzmXR+ACXJ9K1UGKVthtsqw3eWZiR5SDugH0VZHNSJyqDWJ5lzu
 WJAWrJbdZSfsutL+ajblI68kVftU355drcRTM/H6qEfl6hcDzF4WWKMVvfx0AGl+NK
 tDpiAivQbgSG9N1Un9H2k9UikBrpzBA4xDJrWkiAs15QqZiEEOTlBpLqEY78NdLkcU
 lDuOSkSodbUfRg1pYuBYa4eNdTBYx6EifQTUF7xeODSGr1AX1rt9eu0itxMhvpbC4M
 hPT7J5JgoOE/OQcXLDr6pZ0agilbxCtkG5L+pF9n9Go9FP4TVhuygvt4fruSU5kvGg
 0r2h8DifU0wHA==
To: jaegeuk@kernel.org
Date: Wed, 16 Sep 2026 09:54:36 +0800
Message-ID: <20260916015440.2232938-9-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916015440.2232938-1-chao@kernel.org>
References: <20260916015440.2232938-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x6erW-0004wO-PJ
Subject: [f2fs-dev] [PATCH v8 08/12] f2fs: cache: initialize compress cache
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
 fs/f2fs/super.c |  7 +++++--
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 3abd469dc011..3e6a198ef3b3 100644
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
@@ -631,6 +634,10 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 		return freed;
 
 	freed += f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan - freed);
+	if (freed >= nr_to_scan)
+		return freed;
+
+	freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi), nr_to_scan - freed);
 	return freed;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index a36ee57adb1a..a8c24f5282fa 100644
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
 
 #define IS_META_CACHE(cache) ((cache)->type == F2FS_META_CACHE)
 #define IS_NODE_CACHE(cache) ((cache)->type == F2FS_NODE_CACHE)
+#define IS_COMPRESS_CACHE(cache) ((cache)->type == F2FS_COMPRESS_CACHE)
 
 /* Flags for f2fs_cached_block state */
 enum f2fs_cached_state {
@@ -196,6 +201,7 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
 #define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
+#define COMPRESS_CACHE(sbi)	(&(sbi)->compress_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6681276708e..1e23e02cac8b 100644
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
index bf42fbffa348..47259e8172fc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2071,6 +2071,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 
@@ -5263,11 +5264,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
 	f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
+	f2fs_init_cache(sbi, COMPRESS_CACHE(sbi), F2FS_COMPRESS_CACHE);
 
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
-		goto free_node_cache;
+		goto free_compress_cache;
 	}
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
@@ -5582,7 +5584,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
-free_node_cache:
+free_compress_cache:
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 	f2fs_destroy_page_array_cache(sbi);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
