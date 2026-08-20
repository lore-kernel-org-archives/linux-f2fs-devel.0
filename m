Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD38C5DF92
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Dtze2uott7TCjatNL7DbkjtRoVr6g5kcfv6+8diT6s=; b=L65eCcr7btsAPbnhJ0y5std1Ui
	6Jp3vfo9TtHDsLqqz/PDmcNWjjSVvNML6MW6/JZwdmSmp+PvGwy2kjHYmzjWKrvH1XyIVfBCFyhnP
	xUB31D7jEZSpm2q8ieps0P17yobv7xU1NID8e1j7tD85I9+cCkVVC83uubx31pgo2NO4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtIE-0002Ma-Uv;
	Thu, 20 Aug 2026 03:18:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHj-0002LK-G6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hetQH6YaAGHGGuPdQLisWNf4PhStPCZ4nCgE1al6fQ4=; b=lz103x9yoTw3QJq5jLRcmFDmgm
 aJc0LxYAxdvtaGqaPTCR/JI5Iuw7IWrc0ssUDrqAc2te6UBQJ8QMgfZg5xoVMRwJRcmT/Da2nY9LU
 9Q/fCXD2s4+VrRIBe5JToJnSfUGlYMGRwOpe0eVWMrmioCxlFNMNa4RGFbaUijbHZE3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hetQH6YaAGHGGuPdQLisWNf4PhStPCZ4nCgE1al6fQ4=; b=ECPAiWTmF2ShHmxs+D3BLptt7z
 pa/nRTPrX9qFILKq9K/u7lkoVueSywmt+Kuq0d1HEJ7lavPGL/EQOsbrLgKJX0l0iKIFrAYtzDAmy
 hIkcynxGlclyQJQXhLEPUQfqO461A2QWHu0NdtHYOxH8eDuW4pEemguUXFDHOgqF3cqk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHi-0000xP-L9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B803416A2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D6A1F000E9;
 Thu, 20 Aug 2026 03:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195857;
 bh=hetQH6YaAGHGGuPdQLisWNf4PhStPCZ4nCgE1al6fQ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WT+lmaFDL6XIAbyCLwy1gxISUyl2+5lovfCIfco2NVYMlpql9voUsxOI0N/Stkq6i
 oX4OBl0raRdMM1VF95iuw7f1lT+onhnS7ThWj8oeoW2XnYtvigFKS01WhRyzKmjOGB
 0qlMla5UHlvDeHty+88Xwne3D/+2eQNoZQim5Lv7z2ssPhFP3UvuV0FuqtEC6V6n8I
 YkOkFoBJ6fUQbdLZaY3YiTMzT03/tYi72HMbSuEmfVSyo7cP3ZZ8h9r/eJo+5Q3LP+
 zy5tx+VaDdKz4YoNYCJTikPeR/wrtq1k3YEUtDNxJoF4QE0OIt0//DBlRYyHn5o9xh
 YXvVhW3d2WXCw==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:17 +0800
Message-ID: <20260820031721.12218-9-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wwtHi-0000xP-L9
Subject: [f2fs-dev] [PATCH v1 08/12] f2fs: cache: initialize compress cache
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

This patch introduces compress_blocks in f2fs_sb_info structure, initializes
and destroys the compress cache during filesystem mount and unmount.

It adds an ino union field in struct f2fs_cached_block (sharing space
with writeback linkage for zero memory overhead) to track per-inode
cached blocks, and registers compress cache into the memory shrinker.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 9 ++++++++-
 fs/f2fs/cache.h | 5 ++++-
 fs/f2fs/f2fs.h  | 6 ++++++
 fs/f2fs/super.c | 9 ++++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 3176d62ce25b..2cecf6287207 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -194,7 +194,10 @@ static struct f2fs_cached_block *f2fs_create_cache(
 	entry->index = index;
 
 	atomic_set(&entry->refcount, 0);
-	entry->next_entry = NULL;
+	if (!IS_COMPRESS_CACHE(cache))
+		entry->next_entry = NULL;
+	else
+		entry->ino = 0;
 	INIT_LIST_HEAD(&entry->list);
 
 	entry->cache = cache;
@@ -616,6 +619,10 @@ unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 		return freed;
 
 	freed += f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan - freed);
+	if (freed >= nr_to_scan)
+		return freed;
+
+	freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi), nr_to_scan - freed);
 	return freed;
 }
 
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 397019cfb861..23583a52b8f8 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -38,6 +38,7 @@ struct f2fs_sb_info;
 enum f2fs_cache_type {
 	F2FS_META_CACHE,
 	F2FS_NODE_CACHE,
+	F2FS_COMPRESS_CACHE,
 };
 
 /* Main cache control structure (per sb_info) */
@@ -47,12 +48,13 @@ struct f2fs_cached_block_list {
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
@@ -182,6 +184,7 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
 #define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
+#define COMPRESS_CACHE(sbi)	(&(sbi)->compress_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4dd165ac05c9..36a6afbf3ba1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2104,6 +2104,7 @@ struct f2fs_sb_info {
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
 	struct f2fs_cached_block_list node_blocks;
+	struct f2fs_cached_block_list compress_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
@@ -2325,6 +2326,11 @@ static inline bool f2fs_is_node_cache(struct f2fs_cached_block *entry)
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
index bc1cff6cad0d..ac3a94736a91 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2030,6 +2030,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
+	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 
@@ -5203,10 +5204,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5519,6 +5524,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
