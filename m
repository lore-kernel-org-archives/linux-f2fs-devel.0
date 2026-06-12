Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A8CD98DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9rioOfSFqCj4G6/QhR5pKulB2ogBSMSlVlObxhXd4E=; b=GAFB0Z6H0XmpK6L3yueTS7ZztF
	h35P4CLQbQhN4z8UNvskXu0Mo6KvGov+X4aJmBWZn6qY7e8PnUlb1faPyqC+fLNK0qnjYoXeEfi/W
	SfIdAXoYkV2z88W0CWGqw+qOjWTG/ufb0bwfXKXQ8Yk6flK0Rn/EBJ2PGMdu8IS3B4To=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wY0Xt-00010u-Ot;
	Fri, 12 Jun 2026 11:59:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wY0Xs-00010n-Vm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4JOgYcx/leA9aR7GnbpqM/e+ri34YUjlHn5gUa0w/zE=; b=KlsaD+ygTZEN+rZjlYgDXchOM5
 Grg8TrYc7BgLT6G3TEzvq2q8HCy/8i1+Kcg/1K1VY8LFJCtWSi+nZJ2pLHHnuDIGv52CtxNqrUGsC
 DfxCTyYWXtIAFH2OGJV1NbfGHGnO4oRE3gSE7/55jhCzXrMAEblFh2+JCl7uJEMRFFbM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4JOgYcx/leA9aR7GnbpqM/e+ri34YUjlHn5gUa0w/zE=; b=G4WNS/oSGAPp3rTCcx3PhgCixX
 B+HZe1p+e/BNVXqAv52PaIPLf8VtZebO0aQvoMB8XGtnNQRsyTI9Rm0jg4vYo8IVRgxPUZDq67btl
 fi2qintx5yZY2CsKwwDAU40CMh+5bjaFGX2QYEi+LBdMQfE4mprTY0IsXNVs1vnj2Mco=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY0Xo-0001lA-Kf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:30 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84236f9b638so517944b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781265558; x=1781870358; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JOgYcx/leA9aR7GnbpqM/e+ri34YUjlHn5gUa0w/zE=;
 b=Vcq0k0K2md2GMrJXs+L5Yqd7l/qNq2ZIlU/xHWbEYqEeXnhrdYf7hVaMV0ja/4lcrP
 EbnZOlhJ4Y1dDrwZqT3PQfiiyTdbT/lYomJ12RmR08DFlO3hMIIi7LzY/F7KpXPAQtTI
 /QnfL2mZnwlzR59IVFtmuRprzW8Dp+11/rtowUkID7Qa8OMc0PMNrIGTNaS54PuBGyWL
 ZUue3jFbVySnI4izsTn8xurGBpFHfQxhWyEPF8Udu3422wzkQeCPvjrTvwaMoTxIL3KF
 hJjlSIABw8W7UgeV9lQvcM0a9O5oOSAF2HucvrrMA0k6FH+LFZbIGzjeC0K28wyFPRtt
 gLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781265558; x=1781870358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4JOgYcx/leA9aR7GnbpqM/e+ri34YUjlHn5gUa0w/zE=;
 b=UwLlP+dEc4wGDKdgwUt0Zh807WsHtq2C5YtWf5RjMChMVnmfwopx+QLCsGWZrAVcYi
 O8L2HclxmWVfvuQ5nrt3hGa0RpyhhMukQFD8GrsTmeEeJVWsHElRub7r/fzveWmloTo9
 1UyjvibX8fx5ilCHH60ezq2izdTUhbdicvVjIcEhmy+bQwUpz3tki9xNID5fgxYQoKBV
 AkXSVCJATb/aHGtjIIb+j+U47dKV7/zDaXjHd7Gz2eygSaNr0p6jCCqiHhItNdlqj2Ji
 JNph3+fAkGqh1h8FlIzZoe4KZk8LVAU35UbjDhCnGZ4nPdA0CSkJaRSGgsj821inbupK
 849w==
X-Gm-Message-State: AOJu0YzK1t5O5k4PJ3mcazlnBqvNKSpbqTHFi8uob7dSwIU5LrUWdQtj
 n09V0L30aH/BKRI22jtSExpj+jNtGCaGgJMLxlgskBHmciRPo66/GkfD
X-Gm-Gg: Acq92OEWk8c7LRk0fGIJhpyem9ywebll4GyDSByTNGPPI2kVICp+syboB9uPHtCoknB
 SbUPcEqM/22s4qqidcHBZ9CdN7QpvjOZwPY6GgKbVlurKdQ1fEo4wjkDo7NGRGKzW8nfk9zR5zd
 bMm8pc7bXt2TE3BCtsJu5qbtmQBMBtNmUERLuQdQtShGDXgpEfYd0dJWQh/AmFge67N56vhjSzm
 e5OZeQZUqDCxueskeXeSmNualIu3iAA0EN2mtZ1hNqWw4LGdIb4yIFcjd3ylCE5vsaQnXY76eWm
 La9I4aPwHySokrjtZYm9oSxAUhMxewp4By+YQPwRUMwmFY4NF5k4cpD+34Vtgsp2Gi6rXFHaXHh
 StF6P+uLOGe3rtqm9HZk8N55eH1HDe4L+38ftnPC+4znA+uLoN7TooazLS3tq2Q6ZNQE7n5zbul
 trW64Oe0ad72OYFt+61SXPlA0M/OJmikYPUMTdWUla2S/0KHyiQKL+IsWocE/Vbd0JUTqgCKFV8
 aKgP2m6
X-Received: by 2002:a05:6a00:4207:b0:842:5a8d:3036 with SMTP id
 d2e1a72fcca58-8434ced1de3mr2867373b3a.35.1781265558340; 
 Fri, 12 Jun 2026 04:59:18 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf2ac9sm2131197b3a.21.2026.06.12.04.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:59:18 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 12 Jun 2026 19:58:39 +0800
Message-ID: <20260612115839.2065903-5-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wY0Xo-0001lA-Kf
Subject: [f2fs-dev] [PATCH RESEND 4/5] f2fs: add extent_access_mode to track
 extent cache access patterns
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
index 9c6440a7db0e..2d38135005fe 100644
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
index fffb516b78f4..1588b64d04a3 100644
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
@@ -4577,7 +4588,8 @@ bool f2fs_lookup_read_extent_cache_block(struct inode *inode, pgoff_t index,
 			block_t *blkaddr);
 void f2fs_update_read_extent_cache(struct dnode_of_data *dn);
 void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
-			pgoff_t fofs, block_t blkaddr, unsigned int len);
+				pgoff_t fofs, block_t blkaddr, unsigned int len,
+				enum extent_access_mode access_mode);
 unsigned int f2fs_shrink_read_extent_tree(struct f2fs_sb_info *sbi,
 			int nr_shrink);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 633e9ade654f..a3a5d499eadf 100644
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
