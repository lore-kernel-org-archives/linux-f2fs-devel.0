Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68728C5DF89
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DvP9YHedv1fZPTv7qmrO/YBdEqO6nnzYTtlIb1yGm0c=; b=X9ljTWiu4ETkzxV79uUF3V+deX
	aDDpUYFrcWnTJH6Z5eW/1Ft9p2tcUbOnZORBOaNKUanaeirp4qcyJzPhIlCHXPkENBayrfK4lOl5i
	LFitZJH6yLArZXVYqQq67SMcYK4ZQtpK6iwnBdhwnlfFNp3bzDw8xs5abknYXi4+S9yc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtIE-00053J-Of;
	Thu, 20 Aug 2026 03:18:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHp-000528-Ah
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N/BtV9H/sF3qOtNe+iAZqNi78GxMKHbO1nsvInzTyaA=; b=dqkjZ3I6zDCYiAYJ3aJNgJgixg
 mR95O4m9EeKidtM+N8ZHTW3I3GjiijTWW6ArWcTfph47e1yw7/YKHf+9GsTDODpSJONxy3Pgf6wEZ
 6vSGAIwUM696Skyi4IvxlxcWAxJw9859MRhft5tZG+zMpgOhXIh8xsAnjqaX3LbJArwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N/BtV9H/sF3qOtNe+iAZqNi78GxMKHbO1nsvInzTyaA=; b=ZwA5yblfMAGcgCyy8hzNaidDm3
 z0L6VyW0WL5tB0aSVtC4SmCfamAAyY/OuZNU8InAfgisiz0GVqM6BCI/RWqUakQNQ/scX9/PalUP1
 fZ9R79K1r48m7ux6yHbPkv71LihWlo5OjW3e1BKQbUYK1Z+baLOru8ag96/cnYywMrWc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHk-000337-9v for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A809C6188D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987151F00A3F;
 Thu, 20 Aug 2026 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195858;
 bh=N/BtV9H/sF3qOtNe+iAZqNi78GxMKHbO1nsvInzTyaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BQu17gbiAdKYisdQa6VEzX9q7Y80TDckFkcMxj+8vMG8CLHb/CqE8T6YN6mzX72Tp
 cmoJDJaX/zss67Ie1sNl+doQeEXVMbC19MpbC1Mv+6EyGfYqfvwicDzlnqbdAxms3H
 1WgugibBNMh2C8lbdZwWadDPRl4tdi6I7Yae2L5+5/+pq3m66AdFKOT3cKV6V4TAy+
 Q2xYkJ74LcOlfz2pnrhRelOeSp492lr6Hwqw+V4KdOwkGK+cf+XdSM1w8SkpToWxdX
 9EWSOgRNrAC3J6SaXfR7iZTWgopVG9rvAWphdswKyv7S2M+PA12LxMNje30uqsLSOI
 bQXUjJkohLt6Q==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:18 +0800
Message-ID: <20260820031721.12218-10-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wwtHk-000337-9v
Subject: [f2fs-dev] [PATCH v1 09/12] f2fs: cache: use compress cache
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

This patch migrates compressed cluster caching from the fake VFS inode
page cache (sbi->compress_inode) to compress cache (sbi->compress_blocks).

It converts compression caching and decompression paths to use
compress cache APIs, uses entry->ino for per-inode invalidation, and
removes sbi->compress_inode.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c         |   2 +-
 fs/f2fs/cache.h         |   1 +
 fs/f2fs/compress.c      | 149 ++++++++++++++++------------------------
 fs/f2fs/debug.c         |   9 +--
 fs/f2fs/f2fs.h          |   8 +--
 fs/f2fs/inode.c         |  49 ++-----------
 fs/f2fs/node.c          |   2 +-
 fs/f2fs/super.c         |  15 ++--
 include/linux/f2fs_fs.h |   1 -
 9 files changed, 79 insertions(+), 157 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 2cecf6287207..173bbf3aa94c 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -414,7 +414,7 @@ static void f2fs_do_truncate_cache(struct f2fs_cached_block *entry,
 	spin_unlock(&cache->list_lock);
 }
 
-static void f2fs_truncate_cache(struct f2fs_cached_block *entry,
+void f2fs_truncate_cache(struct f2fs_cached_block *entry,
 					bool drop_dirty)
 {
 	f2fs_lock_cache(entry);
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 23583a52b8f8..12c061d28d23 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -169,6 +169,7 @@ unsigned int f2fs_cache_gang_lookup_tag(struct f2fs_cached_block_list *cache,
 		unsigned int max_items, int tag);
 void f2fs_cache_gang_release(struct f2fs_cached_block **entries,
 				unsigned int nr_entries);
+void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty);
 int f2fs_writeback_cache(struct f2fs_cached_block_list *cache, bool sync);
 void f2fs_cache_wait_on_all_writeback(struct f2fs_cached_block_list *cache);
 void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 676a5559357f..2eb7614d3610 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1918,30 +1918,19 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
 	return compressed ? i - 1 : i;
 }
 
-const struct address_space_operations f2fs_compress_aops = {
-	.release_folio = f2fs_release_folio,
-	.invalidate_folio = f2fs_invalidate_folio,
-	.migrate_folio	= filemap_migrate_folio,
-};
-
-struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
-{
-	return sbi->compress_inode->i_mapping;
-}
-
 void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 				block_t blkaddr, unsigned int len)
 {
-	if (!sbi->compress_inode)
+	if (!test_opt(sbi, COMPRESS_CACHE))
 		return;
-	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + len - 1);
+
+	f2fs_drop_cache_range(COMPRESS_CACHE(sbi), blkaddr, len, false);
 }
 
 static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 		struct folio *folio, nid_t ino, block_t blkaddr)
 {
-	struct folio *cfolio;
-	int ret;
+	struct f2fs_cached_block *entry;
 
 	if (!test_opt(sbi, COMPRESS_CACHE))
 		return;
@@ -1952,49 +1941,43 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 	if (!f2fs_available_free_memory(sbi, COMPRESS_PAGE))
 		return;
 
-	cfolio = filemap_get_folio(COMPRESS_MAPPING(sbi), blkaddr);
-	if (!IS_ERR(cfolio)) {
-		f2fs_folio_put(cfolio, false);
+	entry = f2fs_find_cache(COMPRESS_CACHE(sbi), blkaddr);
+	if (!IS_ERR(entry)) {
+		f2fs_put_cache(entry, false);
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
-	if (!cfolio)
-		return;
-
-	ret = filemap_add_folio(COMPRESS_MAPPING(sbi), cfolio,
-						blkaddr, GFP_NOFS);
-	if (ret) {
-		f2fs_folio_put(cfolio, false);
+	entry = f2fs_grab_cache(COMPRESS_CACHE(sbi), blkaddr,
+					F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(entry))
 		return;
-	}
-
-	folio_set_f2fs_data(cfolio, ino);
 
-	memcpy(folio_address(cfolio), folio_address(folio), PAGE_SIZE);
-	folio_mark_uptodate(cfolio);
-	f2fs_folio_put(cfolio, true);
+	entry->ino = ino;
+	memcpy(cache_address(entry), folio_address(folio), PAGE_SIZE);
+	f2fs_cache_set_uptodate(entry);
+	f2fs_put_cache(entry, true);
 }
 
 bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 								block_t blkaddr)
 {
-	struct folio *cfolio;
+	struct f2fs_cached_block *entry;
 	bool hitted = false;
 
 	if (!test_opt(sbi, COMPRESS_CACHE))
 		return false;
 
-	cfolio = f2fs_filemap_get_folio(COMPRESS_MAPPING(sbi),
-				blkaddr, FGP_LOCK | FGP_NOWAIT, GFP_NOFS);
-	if (!IS_ERR(cfolio)) {
-		if (folio_test_uptodate(cfolio)) {
+	entry = f2fs_find_cache(COMPRESS_CACHE(sbi), blkaddr);
+	if (!IS_ERR(entry)) {
+		f2fs_lock_cache(entry);
+		if (f2fs_is_compress_cache(entry) &&
+				f2fs_cache_test_uptodate(entry)) {
 			atomic_inc(&sbi->compress_page_hit);
 			memcpy(folio_address(folio),
-				folio_address(cfolio), folio_size(folio));
+				cache_address(entry), folio_size(folio));
 			hitted = true;
 		}
-		f2fs_folio_put(cfolio, true);
+		f2fs_put_cache(entry, true);
 	}
 
 	return hitted;
@@ -2002,71 +1985,59 @@ bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct address_space *mapping = COMPRESS_MAPPING(sbi);
-	struct folio_batch fbatch;
-	pgoff_t index = 0;
-	pgoff_t end = MAX_BLKADDR(sbi);
+	struct f2fs_cached_block_list *cache = COMPRESS_CACHE(sbi);
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	unsigned long flags;
+	pgoff_t index = 0, end = ULONG_MAX;
+	int nr;
+	int i;
 
-	if (!mapping->nrpages)
+	if (!test_opt(sbi, COMPRESS_CACHE))
 		return;
-
-	folio_batch_init(&fbatch);
-
-	do {
-		unsigned int nr, i;
-
-		nr = filemap_get_folios(mapping, &index, end - 1, &fbatch);
-		if (!nr)
+next:
+	spin_lock_irqsave(&cache->tree_lock, flags);
+	nr = radix_tree_gang_lookup(&cache->root, (void **)entries, index,
+		min((unsigned long)F2FS_ONSTACK_CACHES, end - index));
+	if (!nr)
+		goto out_unlock;
+
+	for (i = 0; i < nr; i++) {
+		struct f2fs_cached_block *entry = entries[i];
+
+		if (entry->index >= end) {
+			nr = i;
 			break;
+		}
+		f2fs_cache_get(entry);
+	}
+out_unlock:
+	spin_unlock_irqrestore(&cache->tree_lock, flags);
+	if (!nr)
+		return;
+	for (i = 0; i < nr; i++) {
+		struct f2fs_cached_block *entry = entries[i];
 
-		for (i = 0; i < nr; i++) {
-			struct folio *folio = fbatch.folios[i];
+		index = entry->index + 1;
 
-			folio_lock(folio);
-			if (folio->mapping != mapping) {
-				folio_unlock(folio);
-				continue;
-			}
+		if (IS_COMPRESS_CACHE(cache) && entry->ino != ino)
+			continue;
 
-			if (ino != folio_get_f2fs_data(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		f2fs_truncate_cache(entry, false);
+	}
+	f2fs_cache_gang_release(entries, nr);
 
-			generic_error_remove_folio(mapping, folio);
-			folio_unlock(folio);
-		}
-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (index < end);
+	if (index < end)
+		goto next;
 }
 
-int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
+void f2fs_init_compress_cache_context(struct f2fs_sb_info *sbi)
 {
-	struct inode *inode;
-
 	if (!test_opt(sbi, COMPRESS_CACHE))
-		return 0;
-
-	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-	sbi->compress_inode = inode;
+		return;
 
 	sbi->compress_percent = COMPRESS_PERCENT;
 	sbi->compress_watermark = COMPRESS_WATERMARK;
-
 	atomic_set(&sbi->compress_page_hit, 0);
-
-	return 0;
-}
-
-void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi)
-{
-	if (!sbi->compress_inode)
-		return;
-	iput(sbi->compress_inode);
-	sbi->compress_inode = NULL;
 }
 
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index bedaade92677..8cd06f7ba9e7 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -225,8 +225,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->node_caches = NODE_CACHE(sbi)->num_entries;
 	si->meta_caches = META_CACHE(sbi)->num_entries;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (sbi->compress_inode) {
-		si->compress_pages = COMPRESS_MAPPING(sbi)->nrpages;
+	if (test_opt(sbi, COMPRESS_CACHE)) {
+		si->compress_pages = COMPRESS_CACHE(sbi)->num_entries;
 		si->compress_page_hit = atomic_read(&sbi->compress_page_hit);
 	}
 #endif
@@ -386,10 +386,11 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->page_mem += (unsigned long long)NODE_CACHE(sbi)->num_entries << PAGE_SHIFT;
 	si->cache_mem += NODE_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (sbi->compress_inode) {
-		unsigned long npages = COMPRESS_MAPPING(sbi)->nrpages;
+	if (test_opt(sbi, COMPRESS_CACHE)) {
+		unsigned long npages = COMPRESS_CACHE(sbi)->num_entries;
 
 		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+		si->cache_mem += npages * sizeof(struct f2fs_cached_block);
 	}
 #endif
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 36a6afbf3ba1..0a749a59f386 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2075,7 +2075,6 @@ struct f2fs_sb_info {
 	u32 compr_new_inode;
 
 	/* For compressed block cache */
-	struct inode *compress_inode;		/* cache compressed blocks */
 	unsigned int compress_percent;		/* cache page percentage */
 	unsigned int compress_watermark;	/* cache page watermark */
 	atomic_t compress_page_hit;		/* cache hit count */
@@ -4817,13 +4816,11 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
 int f2fs_init_compress_ctx(struct compress_ctx *cc);
 void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
 void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
-int f2fs_init_compress_inode(struct f2fs_sb_info *sbi);
-void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi);
+void f2fs_init_compress_cache_context(struct f2fs_sb_info *sbi);
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
 int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
-struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
 void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 					block_t blkaddr, unsigned int len);
 bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
@@ -4872,8 +4869,7 @@ static inline void f2fs_put_folio_dic(struct folio *folio, bool in_task)
 static inline unsigned int f2fs_cluster_blocks_are_contiguous(
 			struct dnode_of_data *dn, unsigned int ofs_in_node) { return 0; }
 static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
-static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
-static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
+static inline void f2fs_init_compress_cache_context(struct f2fs_sb_info *sbi) { }
 static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
 static inline int __init f2fs_init_compress_cache(void) { return 0; }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 421788a9ea24..579da36b600d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -573,15 +573,6 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
-static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
-{
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (test_opt(sbi, COMPRESS_CACHE) && ino == F2FS_COMPRESS_INO(sbi))
-		return true;
-#endif
-	return false;
-}
-
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -593,42 +584,17 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		return ERR_PTR(-ENOMEM);
 
 	if (!(inode_state_read_once(inode) & I_NEW)) {
-		if (is_meta_ino(sbi, ino)) {
-			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			ret = -EFSCORRUPTED;
-			trace_f2fs_iget_exit(inode, ret);
-			iput(inode);
-			f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
-			fserror_report_file_metadata(inode, ret, GFP_NOFS);
-			return ERR_PTR(ret);
-		}
-
 		trace_f2fs_iget(inode);
 		return inode;
 	}
 
-	if (is_meta_ino(sbi, ino))
-		goto make_now;
-
 	ret = do_read_inode(inode);
 	if (ret)
 		goto bad_inode;
-make_now:
+
 	f2fs_set_inode_flags(inode);
 
-	if (ino == F2FS_COMPRESS_INO(sbi)) {
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-		inode->i_mapping->a_ops = &f2fs_compress_aops;
-		/*
-		 * generic_error_remove_folio only truncates pages of regular
-		 * inode
-		 */
-		inode->i_mode |= S_IFREG;
-#endif
-		mapping_set_gfp_mask(inode->i_mapping,
-			GFP_NOFS | __GFP_HIGHMEM | __GFP_MOVABLE);
-	} else if (S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
@@ -879,7 +845,7 @@ static void f2fs_evict_inode_work(struct work_struct *work)
 /*
  * Return true, if we shouldn't go through post_evict_inode.
  */
-static bool f2fs_pre_evict_inode(struct inode *inode)
+static void f2fs_pre_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -905,17 +871,12 @@ static bool f2fs_pre_evict_inode(struct inode *inode)
 	    test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
 		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
 
-	if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
-		return true;
-
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	f2fs_remove_dirty_inode(inode);
 	f2fs_remove_donate_inode(inode);
 
 	if (!IS_DEVICE_ALIASING(inode))
 		f2fs_destroy_extent_tree(inode);
-
-	return false;
 }
 
 static void f2fs_delete_inode(struct inode *inode)
@@ -1077,15 +1038,13 @@ static void f2fs_post_evict_inode(struct inode *inode)
  */
 void f2fs_evict_inode(struct inode *inode)
 {
-	if (f2fs_pre_evict_inode(inode))
-		goto clear_out;
+	f2fs_pre_evict_inode(inode);
 
 	if (!inode->i_nlink && !is_bad_inode(inode))
 		f2fs_delete_inode(inode);
 
 	f2fs_post_evict_inode(inode);
 
-clear_out:
 	fscrypt_put_encryption_info(inode);
 	clear_inode(inode);
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9482c86b5506..4b611ed3d8ef 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -119,7 +119,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		 * exceed threshold, deny caching compress page.
 		 */
 		res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
-			(COMPRESS_MAPPING(sbi)->nrpages <
+			(COMPRESS_CACHE(sbi)->num_entries <
 			 free_ram * sbi->compress_percent / 100);
 #else
 		res = false;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ac3a94736a91..64c39286486d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2028,8 +2028,6 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
-	f2fs_destroy_compress_inode(sbi);
-
 	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
@@ -5257,6 +5255,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_init_fsync_node_info(sbi);
 
+	f2fs_init_compress_cache_context(sbi);
+
 	/* setup checkpoint request control and start checkpoint issue thread */
 	f2fs_init_ckpt_req_control(sbi);
 	if (!f2fs_readonly(sb) && !test_opt(sbi, DISABLE_CHECKPOINT) &&
@@ -5327,13 +5327,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_ino_entry;
 	}
 
-	err = f2fs_init_compress_inode(sbi);
-	if (err)
-		goto free_root_inode;
-
 	err = f2fs_register_sysfs(sbi);
 	if (err)
-		goto free_compress_inode;
+		goto free_root_inode;
 
 	sbi->umount_lock_holder = current;
 #ifdef CONFIG_QUOTA
@@ -5501,8 +5497,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* evict some inodes being cached by GC */
 	evict_inodes(sb);
 	f2fs_unregister_sysfs(sbi);
-free_compress_inode:
-	f2fs_destroy_compress_inode(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -5619,7 +5613,8 @@ static void kill_f2fs_super(struct super_block *sb)
 		 * compress inode cache.
 		 */
 		if (test_opt(sbi, COMPRESS_CACHE))
-			truncate_inode_pages_final(COMPRESS_MAPPING(sbi));
+			f2fs_invalidate_compress_pages_range(sbi,
+					0, UINT_MAX);
 #endif
 
 		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 105cfeedea74..53344e1f2b44 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -34,7 +34,6 @@
 #define F2FS_RESERVED_NODE_NUM		3
 
 #define F2FS_ROOT_INO(sbi)	((sbi)->root_ino_num)
-#define F2FS_COMPRESS_INO(sbi)	(NM_I(sbi)->max_nid)
 
 #define F2FS_MAX_QUOTAS		3
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
