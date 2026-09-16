Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10DAC88E77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hz1184n7iNC6PbIeMqVGq7Gfy+sqQQfu52tCRNj2zVc=; b=OI8HmE4O6MzvoianGj58za54XU
	BdW1WapaqvX19dT+SG2hD5cJnznDc+Tfjookk+5HnEJoo/7yd785P3JUourNXJ1te5giZoIzhxTYl
	j8Ihx4CW+ydZCEALyf+nQ41//N9GpDFRJrSsxOQzEBYGxEVXhgg+ZUxwvbHm13hBE8sY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6erh-0003mn-1k;
	Wed, 16 Sep 2026 01:55:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6erZ-0003lV-3P
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C2qXbCXOvB+oOzsp2Ye3/Pf02W4LIXShyTM3wm8AzOU=; b=nNZyQzvMFMOds4RblkWrwMJ90l
 SE5Mm3l3YVv+TC6MoNNCMwWJ87Ij9OlxYVwGNcEsS3LW0yHU/alFG+fYB3WS1wGOp6LBghvBlDXLT
 m70TLB5tmmp8hkpUEV0YjTN1wcm8Nppw4BpMvjFOJGaPV48Ir7exS0Rs9KjqNFPP6W9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C2qXbCXOvB+oOzsp2Ye3/Pf02W4LIXShyTM3wm8AzOU=; b=X1SR+RlPeY1b2guvbXRZVQG1u4
 5vA3hrLYCS04nwst/N8gSTZCGbCSsm4o7q8HvL9al4V3yy6JlYlp2UTSgVCcqVZ1kEGLXOo6Eh3+a
 cFA0OL1whFwpHaXZXzaML6jgeqenfJmfXWkE70BjOuG9U7A8ZkeU5/UDypC9oa88PlG8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6erX-0004wR-Jq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 550544389B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572071F00898;
 Wed, 16 Sep 2026 01:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789523698;
 bh=C2qXbCXOvB+oOzsp2Ye3/Pf02W4LIXShyTM3wm8AzOU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ATHR4CyPmqxjkwNgq+18NveWTmA1ibvr24NJSLNfoYc4lltynNJayQv9RVfEX77YG
 AlRD95NXg6O/Q/kPNnh/UxT4cCVrNGpht+zDOjeOhwNSe4UpvjKqQJEkz8BVEEldHi
 6DIkC/nEgGgblJBgIbPZJzb5rfDB9/NvleXZe7Y3iks39hPnDEwL1pHAWH/nj4Ie37
 1t0Z/lTZMoFJ/FMVffie4HCePqCANFKa7L74udODpo+hqsxHEfxrzfWmrs8WFnbz2q
 v1cSiwx8bzbdCIQN2Jc7Ayj8wEa18VvKTsw12vWOJ0CT2KoJr1v4Pe9OQGDhqazU5o
 612H9su01MO9Q==
To: jaegeuk@kernel.org
Date: Wed, 16 Sep 2026 09:54:37 +0800
Message-ID: <20260916015440.2232938-10-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916015440.2232938-1-chao@kernel.org>
References: <20260916015440.2232938-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x6erX-0004wR-Jq
Subject: [f2fs-dev] [PATCH v8 09/12] f2fs: cache: use compress cache
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

This patch migrates compressed cluster caching from the fake VFS inode
page cache (sbi->compress_inode) to compress cache (sbi->compress_blocks).

It converts compression caching and decompression paths to use
compress cache APIs, uses entry->ino for per-inode invalidation, and
removes sbi->compress_inode.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c      | 143 +++++++++++++++-------------------------
 fs/f2fs/debug.c         |   9 +--
 fs/f2fs/f2fs.h          |   8 +--
 fs/f2fs/inode.c         |  49 ++------------
 fs/f2fs/node.c          |   4 +-
 fs/f2fs/node.h          |   2 +-
 fs/f2fs/shrinker.c      |   3 +-
 fs/f2fs/super.c         |  15 ++---
 include/linux/f2fs_fs.h |   1 -
 9 files changed, 74 insertions(+), 160 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d7f7c35e710f..55931fbcb0d1 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1893,30 +1893,19 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
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
@@ -1924,52 +1913,48 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
 		return;
 
-	if (!f2fs_available_free_memory(sbi, COMPRESS_PAGE))
+	if (!f2fs_available_free_memory(sbi, COMPRESS_BLOCK))
 		return;
 
-	cfolio = filemap_get_folio(COMPRESS_MAPPING(sbi), blkaddr);
-	if (!IS_ERR(cfolio)) {
-		f2fs_folio_put(cfolio, false);
+	entry = f2fs_find_cache(COMPRESS_CACHE(sbi), blkaddr,
+						F2FS_CACHE_ACCESS);
+	if (!IS_ERR(entry)) {
+		f2fs_put_cache(entry, false);
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
-	if (!cfolio)
+	entry = f2fs_grab_cache(COMPRESS_CACHE(sbi), blkaddr,
+					F2FS_CACHE_LOCK_CREATE);
+	if (IS_ERR(entry))
 		return;
 
-	ret = filemap_add_folio(COMPRESS_MAPPING(sbi), cfolio,
-						blkaddr, GFP_NOFS);
-	if (ret) {
-		f2fs_folio_put(cfolio, false);
-		return;
-	}
-
-	folio_set_f2fs_data(cfolio, ino);
-
-	memcpy(folio_address(cfolio), folio_address(folio), PAGE_SIZE);
-	folio_mark_uptodate(cfolio);
-	f2fs_folio_put(cfolio, true);
+	entry->ino = ino;
+	memcpy(cache_address(entry), folio_address(folio), sbi->blocksize);
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
+	entry = f2fs_find_cache(COMPRESS_CACHE(sbi), blkaddr,
+						F2FS_CACHE_ACCESS);
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
@@ -1977,71 +1962,49 @@ bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct address_space *mapping = COMPRESS_MAPPING(sbi);
-	struct folio_batch fbatch;
-	pgoff_t index = 0;
-	pgoff_t end = MAX_BLKADDR(sbi);
+	struct f2fs_cached_block_list *cache = COMPRESS_CACHE(sbi);
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	pgoff_t index = 0, end = ULONG_MAX;
+	int nr;
+	int i;
 
-	if (!mapping->nrpages)
+	if (!cache->num_entries)
 		return;
+next:
+	nr = f2fs_cache_gang_lookup(cache, entries, &index, end);
+	if (!nr)
+		return;
+	for (i = 0; i < nr; i++) {
+		struct f2fs_cached_block *entry = entries[i];
 
-	folio_batch_init(&fbatch);
-
-	do {
-		unsigned int nr, i;
-
-		nr = filemap_get_folios(mapping, &index, end - 1, &fbatch);
-		if (!nr)
-			break;
-
-		for (i = 0; i < nr; i++) {
-			struct folio *folio = fbatch.folios[i];
+		index = entry->index + 1;
 
-			folio_lock(folio);
-			if (folio->mapping != mapping) {
-				folio_unlock(folio);
-				continue;
-			}
+		f2fs_lock_cache(entry);
+		if (unlikely(!f2fs_is_compress_cache(entry)))
+			goto unlock;
+		if (entry->ino != ino)
+			goto unlock;
 
-			if (ino != folio_get_f2fs_data(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		f2fs_truncate_locked_cache(entry, false);
+unlock:
+		f2fs_unlock_cache(entry);
+	}
+	f2fs_cache_gang_release(entries, nr);
 
-			generic_error_remove_folio(mapping, folio);
-			folio_unlock(folio);
-		}
-		folio_batch_release(&fbatch);
+	if (index < end) {
 		cond_resched();
-	} while (index < end);
+		goto next;
+	}
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
index c09c5f700c89..4ed5c271dba3 100644
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
index 1e23e02cac8b..69690b061236 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2077,7 +2077,6 @@ struct f2fs_sb_info {
 	u32 compr_new_inode;
 
 	/* For compressed block cache */
-	struct inode *compress_inode;		/* cache compressed blocks */
 	unsigned int compress_percent;		/* cache page percentage */
 	unsigned int compress_watermark;	/* cache page watermark */
 	atomic_t compress_page_hit;		/* cache hit count */
@@ -4889,13 +4888,11 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
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
@@ -4944,8 +4941,7 @@ static inline void f2fs_put_folio_dic(struct folio *folio, bool in_task)
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
index c822ca2dce20..9164a2b5d9f0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -574,15 +574,6 @@ static int do_read_inode(struct inode *inode)
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
@@ -594,42 +585,17 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
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
@@ -882,7 +848,7 @@ static void f2fs_evict_inode_work(struct work_struct *work)
 /*
  * Return true, if we shouldn't go through post_evict_inode.
  */
-static bool f2fs_pre_evict_inode(struct inode *inode)
+static void f2fs_pre_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -908,17 +874,12 @@ static bool f2fs_pre_evict_inode(struct inode *inode)
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
@@ -1080,15 +1041,13 @@ static void f2fs_post_evict_inode(struct inode *inode)
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
index 1af118858fd1..fe5e4c4eff23 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -109,7 +109,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		mem_size = (atomic_read(&dcc->discard_cmd_cnt) *
 				sizeof(struct discard_cmd)) >> PAGE_SHIFT;
 		res = mem_size < (avail_ram * nm_i->ram_thresh / 100);
-	} else if (type == COMPRESS_PAGE) {
+	} else if (type == COMPRESS_BLOCK) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		unsigned long free_ram = val.freeram;
 
@@ -118,7 +118,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		 * exceed threshold, deny caching compress page.
 		 */
 		res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
-			(COMPRESS_MAPPING(sbi)->nrpages <
+			(COMPRESS_CACHE(sbi)->num_entries <
 			 free_ram * sbi->compress_percent / 100);
 #else
 		res = false;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index c8d66ca54e94..2704a5c6a54d 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -157,7 +157,7 @@ enum mem_type {
 	READ_EXTENT_CACHE,	/* indicates read extent cache */
 	AGE_EXTENT_CACHE,	/* indicates age extent cache */
 	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
-	COMPRESS_PAGE,	/* indicates memory of cached compressed pages */
+	COMPRESS_BLOCK,	/* indicates memory of cached compressed blocks */
 	BASE_CHECK,	/* check kernel status */
 };
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 499717cd693c..29f488531492 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -40,7 +40,8 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
 static unsigned long __count_cache(struct f2fs_sb_info *sbi)
 {
 	return META_CACHE(sbi)->num_entries +
-		NODE_CACHE(sbi)->num_entries;
+		NODE_CACHE(sbi)->num_entries +
+		COMPRESS_CACHE(sbi)->num_entries;
 }
 
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 47259e8172fc..6873bad73d7a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2069,8 +2069,6 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
-	f2fs_destroy_compress_inode(sbi);
-
 	f2fs_destroy_cache(COMPRESS_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
@@ -5315,6 +5313,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_init_fsync_node_info(sbi);
 
+	f2fs_init_compress_cache_context(sbi);
+
 	/* setup checkpoint request control and start checkpoint issue thread */
 	f2fs_init_ckpt_req_control(sbi);
 	if (!f2fs_readonly(sb) && !test_opt(sbi, DISABLE_CHECKPOINT) &&
@@ -5387,13 +5387,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5561,8 +5557,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* evict some inodes being cached by GC */
 	evict_inodes(sb);
 	f2fs_unregister_sysfs(sbi);
-free_compress_inode:
-	f2fs_destroy_compress_inode(sbi);
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
@@ -5676,7 +5670,8 @@ static void kill_f2fs_super(struct super_block *sb)
 		 * compress inode cache.
 		 */
 		if (test_opt(sbi, COMPRESS_CACHE))
-			truncate_inode_pages_final(COMPRESS_MAPPING(sbi));
+			f2fs_invalidate_compress_pages_range(sbi,
+					0, UINT_MAX);
 #endif
 
 		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ac87446cc086..3081702b1ddb 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -43,7 +43,6 @@
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
