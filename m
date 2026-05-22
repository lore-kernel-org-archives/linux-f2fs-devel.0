Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B62ACD5BB1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V82LYq4m9pHrLlNeiPKD5TuEKZcnAoDo5ISqoeE57kw=; b=Vr3+NjKJXc7POZs843f3TYV4QQ
	GfPT05Ew1IFgwZK5SceQt1Cduy5rmE7NudQ3BrsuCqNOTZEGfg5ufOMn/p6jRDJ5IpdDO4BHl5r4V
	OEbtl6AMbJaLsbpbGDQfrJjNXfYMzpeTk5LqBZdSNpvfvr45qX0QNSssuTSJGQyEdijA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQL9m-0001mU-Uj;
	Fri, 22 May 2026 08:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wQL9m-0001mM-9r
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ii3z+3xe2He2rOfQmFKnsc7vKRkoRm6tAjkPk32wmt0=; b=AcMmd4b6qOXIPnhw6Ms7Yl/WWz
 hxcqPKyhwn5SSNxvbGonCAi10aW0pQ+Q54U3B8PetG9oosQpxn1HkqopQvECbo5IKHjTtdC/N9+Qx
 9/76ZxwCfGSFV/tQazs9HTyI4OpnjAlVcW7BuZJA1bCm0cdPusA27v7w9z/l2vmBhL/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ii3z+3xe2He2rOfQmFKnsc7vKRkoRm6tAjkPk32wmt0=; b=GexYaEs9pF1YmhPoqCjfAYvqYd
 xC9pzYDhjjuxbjPzD4kMZi6YuerFKirS2jGTXEZEkCpwfPdUwL4yNOv4hOa9ENbs0/xiZLZbbPEjx
 PPhOYCvm+tThFs+bniVrnnJ2rsjLzc72PRu5x9HOGTSjZWLuntGdX9V8O4jY1L6N0J4U=;
Received: from r3-19.sinamail.sina.com.cn ([202.108.3.19])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQL9k-0007Pe-St for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 08:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1779438177; bh=Ii3z+3xe2He2rOfQmFKnsc7vKRkoRm6tAjkPk32wmt0=;
 h=From:Subject:Date:Message-ID;
 b=xMfFZvFmrjFqkdH9sKI2RcKwZNg8MbFxhcCxp/X6pZqKuX23bNp/MdN4I5+6BynBA
 YqLuBMh59SzMWI/83hKuwau0+95xfDRQJYMDt5E40hECJfvngz/N/ha43hrOVC5RHh
 aXk7p09C4agUMwJV4xgktXRDkeW5ERB0nbJQsqbg=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 6A101246000002AE; Fri, 22 May 2026 16:22:45 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 755864456638
X-SMAIL-UIID: 910A9E080ACA40BF8941301824E1C2B6-20260522-162245-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 22 May 2026 16:22:16 +0800
Message-ID: <20260522082213.3725976-5-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522082013.3716237-2-monty_pavel@sina.com>
References: <20260522082013.3716237-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wQL9k-0007Pe-St
Subject: [f2fs-dev] [PATCH 4/5] f2fs: add extent_access_mode to track extent
 cache access patterns
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Introduce enum extent_access_mode to classify how each extent node
is accessed or created (READ, WRITE, PRECACHE, TRUNCATE, LARGEST).
This metadata optimize LRU eviction decisions:

1. Extents only accessed as the largest extent (never read-hit) are
deprioritized in the LRU list since reads can still use the largest
extent directly.

2. Sparse single-block write extents that were never merged are moved
to the head of LRU for earlier reclaim, preserving extents with
better continuity and higher read-hit probability.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/data.c         |  4 ++--
 fs/f2fs/extent_cache.c | 29 ++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h         | 14 +++++++++++++-
 fs/f2fs/file.c         |  6 ++++--
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bdcf396038f8..bd2ee53b4010 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1873,7 +1873,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 			f2fs_update_read_extent_cache_range(&dn,
 				start_pgofs, map->m_pblk + ofs,
-				map->m_len - ofs);
+				map->m_len - ofs, EX_ACCESS_PRECACHE);
 		}
 	}
 
@@ -1919,7 +1919,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 			if (map->m_len > ofs)
 				f2fs_update_read_extent_cache_range(&dn,
 					start_pgofs, map->m_pblk + ofs,
-					map->m_len - ofs);
+					map->m_len - ofs, EX_ACCESS_PRECACHE);
 		}
 		if (map->m_next_extent)
 			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 82d84c4e98b2..e141ffb64e5f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -142,6 +142,7 @@ static void __try_update_largest_extent(struct extent_tree *et,
 	if (en->ei.len <= et->largest.len)
 		return;
 
+	en->ei.last_access_mode = EX_ACCESS_LARGEST;
 	et->largest = en->ei;
 	et->largest_updated = true;
 }
@@ -518,6 +519,7 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		stat_inc_rbtree_node_hit(sbi, type);
 
 	*ei = en->ei;
+	en->ei.last_access_mode = EX_ACCESS_READ;
 	spin_lock(&eti->extent_lock);
 	if (!list_empty(&en->list)) {
 		list_move_tail(&en->list, &eti->extent_list);
@@ -624,6 +626,21 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 
 	/* update in global extent list */
 	spin_lock(&eti->extent_lock);
+	/*
+	 * 1. For the largest extent, if subsequent writes are not merged into
+	 * it, the write path will most likely not use the largest extent_node,
+	 * while read requests can still access the mapping through the largest
+	 * extent.
+	 *
+	 * 2. For sparse writes, if the extent length is 1 and no extent merging
+	 * occurs, this extent should be reclaimed with higher priority to avoid
+	 * evicting extents with better continuity and higher read-hit.
+	 */
+	if (et->type == EX_READ && et->cached_en &&
+		(et->cached_en->ei.last_access_mode == EX_ACCESS_LARGEST ||
+		 (et->cached_en->ei.len == 1 &&
+		  et->cached_en->ei.last_access_mode == EX_ACCESS_WRITE)))
+		list_move(&et->cached_en->list, &eti->extent_list);
 	list_add_tail(&en->list, &eti->extent_list);
 	et->cached_en = en;
 	spin_unlock(&eti->extent_lock);
@@ -747,6 +764,8 @@ static void __update_extent_tree_range(struct inode *inode,
 		if (fofs > dei.fofs && (type != EX_READ ||
 				fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN)) {
 			en->ei.len = fofs - en->ei.fofs;
+			if (type == EX_READ)
+				en->ei.last_access_mode = EX_ACCESS_TRUNCATE;
 			prev_en = en;
 			parts = 1;
 		}
@@ -761,6 +780,8 @@ static void __update_extent_tree_range(struct inode *inode,
 					end - dei.fofs + dei.blk, false,
 					dei.age, dei.last_blocks,
 					type);
+				if (type == EX_READ)
+					ei.last_access_mode = EX_ACCESS_TRUNCATE;
 				en1 = __insert_extent_tree(sbi, et, &ei,
 							NULL, NULL, true);
 				next_en = en1;
@@ -770,6 +791,8 @@ static void __update_extent_tree_range(struct inode *inode,
 					en->ei.blk + (end - dei.fofs), true,
 					dei.age, dei.last_blocks,
 					type);
+				if (type == EX_READ)
+					en->ei.last_access_mode = EX_ACCESS_TRUNCATE;
 				next_en = en;
 			}
 			parts++;
@@ -808,6 +831,7 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (tei->blk) {
 		__set_extent_info(&ei, fofs, len, tei->blk, false,
 				  0, 0, EX_READ);
+		ei.last_access_mode = tei->last_access_mode;
 		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
 			__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
@@ -978,6 +1002,7 @@ static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type typ
 			ei.blk = NULL_ADDR;
 		else
 			ei.blk = dn->data_blkaddr;
+		ei.last_access_mode = EX_ACCESS_WRITE;
 	} else if (type == EX_BLOCK_AGE) {
 		if (__get_new_block_age(dn->inode, &ei, dn->data_blkaddr))
 			return;
@@ -1091,12 +1116,14 @@ void f2fs_update_read_extent_cache(struct dnode_of_data *dn)
 }
 
 void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
-				pgoff_t fofs, block_t blkaddr, unsigned int len)
+				pgoff_t fofs, block_t blkaddr, unsigned int len,
+				enum extent_access_mode access_mode)
 {
 	struct extent_info ei = {
 		.fofs = fofs,
 		.len = len,
 		.blk = blkaddr,
+		.last_access_mode = access_mode,
 	};
 
 	if (!__may_extent_tree(dn->inode, EX_READ))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0a54883b882..18a862b9bafa 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -763,6 +763,15 @@ enum extent_type {
 	NR_EXTENT_CACHES,
 };
 
+/* extent acces mode for cache hit or extent add */
+enum extent_access_mode {
+	EX_ACCESS_READ,
+	EX_ACCESS_WRITE,
+	EX_ACCESS_PRECACHE,
+	EX_ACCESS_TRUNCATE,
+	EX_ACCESS_LARGEST,
+};
+
 /*
  * Reserved value to mark invalid age extents, hence valid block range
  * from 0 to ULLONG_MAX-1
@@ -781,6 +790,8 @@ struct extent_info {
 			/* physical extent length of compressed blocks */
 			unsigned int c_len;
 #endif
+			/* record last access mode */
+			enum extent_access_mode last_access_mode;
 		};
 		/* block age extent_cache */
 		struct {
@@ -4576,7 +4587,8 @@ bool f2fs_lookup_read_extent_cache_block(struct inode *inode, pgoff_t index,
 			block_t *blkaddr);
 void f2fs_update_read_extent_cache(struct dnode_of_data *dn);
 void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
-			pgoff_t fofs, block_t blkaddr, unsigned int len);
+				pgoff_t fofs, block_t blkaddr, unsigned int len,
+				enum extent_access_mode access_mode);
 unsigned int f2fs_shrink_read_extent_tree(struct f2fs_sb_info *sbi,
 			int nr_shrink);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 71385ca4163d..7d701f2b8151 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -733,7 +733,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 */
 		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_folio),
 							dn->inode) + ofs;
-		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
+		f2fs_update_read_extent_cache_range(dn, fofs, 0, len,
+							EX_ACCESS_TRUNCATE);
 		f2fs_update_age_extent_cache_range(dn, fofs, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 	}
@@ -1672,7 +1673,8 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 
 	if (index > start) {
 		f2fs_update_read_extent_cache_range(dn, start, 0,
-							index - start);
+							index - start,
+							EX_ACCESS_TRUNCATE);
 		f2fs_update_age_extent_cache_range(dn, start, index - start);
 	}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
