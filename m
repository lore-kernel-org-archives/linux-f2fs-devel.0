Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D28BC76186
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Mar 2023 21:05:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pajvK-0003aZ-2w;
	Fri, 10 Mar 2023 21:05:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pajvJ-0003aS-59
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 21:05:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=51Td0jA1XCYykR6692aX2li2ho3EuvSRNjNUHGeNp+Y=; b=QkElLUHpOBuGxoOLuIZhLjHX0D
 azcVcxR+AE8aIYIBE6q1L0sleDn0f4PYzYPw/KRgLvBuhmdVOGLBSWEKuvDiJQhI92MZwtGiyqYDz
 5qC5pyIhXoAusz1k3KyvuVAp9KGlSZenYqKZHeei7nHC0WGQP0UhwUEq4lm2S4aJxWlc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=51Td0jA1XCYykR6692aX2li2ho3EuvSRNjNUHGeNp+Y=; b=B5lRkw8hnwi2Cflg+QtlNT3bs3
 nYoI/HxAgxa/byq/l+F8qfS0l61aqVv4c3TrX5CFQwfFKb38/IvR5dlzG4vO0hnqYF74UNcyqF0jP
 GupaIZIi3ZrKr0545Vr5euOtaJl4pbH5X8aOFmG45o/9XoGJ61YuPLsVYP8XpzyD8OAo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pajvI-003xxS-PD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 21:05:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 360F761D5B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Mar 2023 21:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B464C433A0;
 Fri, 10 Mar 2023 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678482302;
 bh=iM9qaWzIqxrzdc/XXmThEnslQOCj5cY4u+vy2Q+AUrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LhmJqbAdQl2Xj6wz7K/+PK2znIvxAkynNyhXUX7j2z0tW7ZWvpHwJH8oxEGFu6q2O
 C+56/WnRp05PYWalL02j2qRlJhFW5ZN/m1hyU63d2tI98+waVnILqSlx12mNWltzi/
 Jm+A3TQSKnC3t4I9DkrIpOyuHx6caSI9+Azn5QYjgdecoZoHE2pX98wQtMvcu/2q4r
 jRyA+uvD0FiqkarjEss/hDz7IqhWD1S2jDxhT3vs6RO7BrwbcJ1kZP84jZA7oyNFDC
 ols7WZag8DF8vZkcTODbLYhb7FVzG8DraZ1Anmzg+npIg5t5f9SxFn/RWm2rWr5MM/
 ZDD1v73AYingQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 10 Mar 2023 13:04:54 -0800
Message-Id: <20230310210454.2350881-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230310210454.2350881-1-jaegeuk@kernel.org>
References: <20230310210454.2350881-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pajvI-003xxS-PD
Subject: [f2fs-dev] [PATCH 3/3] f2fs: remove entire rb_entry sharing
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is a last part to remove the memory sharing for rb_tree in extent_cache.

This should also fix arm32 memory alignment issue.

[struct extent_node]               [struct rb_entry]
[0] struct rb_node rb_node;        [0] struct rb_node rb_node;
  union {                              union {
    struct {                             struct {
[16]  unsigned int fofs;           [12]    unsigned int ofs;
      unsigned int len;                    unsigned int len;
                                         };
                                         unsigned long long key;
                                       } __packed;

Cc: <stable@vger.kernel.org>
Fixes: 13054c548a1c ("f2fs: introduce infra macro and data structure of rb-tree extent cache")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 177 +++++++++++++++++------------------------
 fs/f2fs/f2fs.h         |   6 --
 2 files changed, 71 insertions(+), 112 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5c206f941aac..9a8153895d20 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -161,95 +161,52 @@ static bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front, type);
 }
 
-static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
-							unsigned int ofs)
-{
-	if (cached_re) {
-		if (cached_re->ofs <= ofs &&
-				cached_re->ofs + cached_re->len > ofs) {
-			return cached_re;
-		}
-	}
-	return NULL;
-}
-
-static struct rb_entry *__lookup_rb_tree_slow(struct rb_root_cached *root,
-							unsigned int ofs)
+static struct extent_node *__lookup_extent_node(struct rb_root_cached *root,
+			struct extent_node *cached_en, unsigned int fofs)
 {
 	struct rb_node *node = root->rb_root.rb_node;
-	struct rb_entry *re;
+	struct extent_node *en;
+
+	/* check a cached entry */
+	if (cached_en && cached_en->ei.fofs <= fofs &&
+			cached_en->ei.fofs + cached_en->ei.len > fofs)
+		return cached_en;
 
+	/* check rb_tree */
 	while (node) {
-		re = rb_entry(node, struct rb_entry, rb_node);
+		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (ofs < re->ofs)
+		if (fofs < en->ei.fofs)
 			node = node->rb_left;
-		else if (ofs >= re->ofs + re->len)
+		else if (fofs >= en->ei.fofs + en->ei.len)
 			node = node->rb_right;
 		else
-			return re;
+			return en;
 	}
 	return NULL;
 }
 
-static struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
-				struct rb_entry *cached_re, unsigned int ofs)
-{
-	struct rb_entry *re;
-
-	re = __lookup_rb_tree_fast(cached_re, ofs);
-	if (!re)
-		return __lookup_rb_tree_slow(root, ofs);
-
-	return re;
-}
-
-static struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
-				struct rb_root_cached *root,
-				struct rb_node **parent,
-				unsigned int ofs, bool *leftmost)
-{
-	struct rb_node **p = &root->rb_root.rb_node;
-	struct rb_entry *re;
-
-	while (*p) {
-		*parent = *p;
-		re = rb_entry(*parent, struct rb_entry, rb_node);
-
-		if (ofs < re->ofs) {
-			p = &(*p)->rb_left;
-		} else if (ofs >= re->ofs + re->len) {
-			p = &(*p)->rb_right;
-			*leftmost = false;
-		} else {
-			f2fs_bug_on(sbi, 1);
-		}
-	}
-
-	return p;
-}
-
 /*
- * lookup rb entry in position of @ofs in rb-tree,
+ * lookup rb entry in position of @fofs in rb-tree,
  * if hit, return the entry, otherwise, return NULL
- * @prev_ex: extent before ofs
- * @next_ex: extent after ofs
- * @insert_p: insert point for new extent at ofs
+ * @prev_ex: extent before fofs
+ * @next_ex: extent after fofs
+ * @insert_p: insert point for new extent at fofs
  * in order to simplify the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
-static struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
-				struct rb_entry *cached_re,
-				unsigned int ofs,
-				struct rb_entry **prev_entry,
-				struct rb_entry **next_entry,
+static struct extent_node *__lookup_extent_node_ret(struct rb_root_cached *root,
+				struct extent_node *cached_en,
+				unsigned int fofs,
+				struct extent_node **prev_entry,
+				struct extent_node **next_entry,
 				struct rb_node ***insert_p,
 				struct rb_node **insert_parent,
-				bool force, bool *leftmost)
+				bool *leftmost)
 {
 	struct rb_node **pnode = &root->rb_root.rb_node;
 	struct rb_node *parent = NULL, *tmp_node;
-	struct rb_entry *re = cached_re;
+	struct extent_node *en = cached_en;
 
 	*insert_p = NULL;
 	*insert_parent = NULL;
@@ -259,24 +216,20 @@ static struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 	if (RB_EMPTY_ROOT(&root->rb_root))
 		return NULL;
 
-	if (re) {
-		if (re->ofs <= ofs && re->ofs + re->len > ofs)
-			goto lookup_neighbors;
-	}
+	if (en && en->ei.fofs <= fofs && en->ei.fofs + en->ei.len > fofs)
+		goto lookup_neighbors;
 
-	if (leftmost)
-		*leftmost = true;
+	*leftmost = true;
 
 	while (*pnode) {
 		parent = *pnode;
-		re = rb_entry(*pnode, struct rb_entry, rb_node);
+		en = rb_entry(*pnode, struct extent_node, rb_node);
 
-		if (ofs < re->ofs) {
+		if (fofs < en->ei.fofs) {
 			pnode = &(*pnode)->rb_left;
-		} else if (ofs >= re->ofs + re->len) {
+		} else if (fofs >= en->ei.fofs + en->ei.len) {
 			pnode = &(*pnode)->rb_right;
-			if (leftmost)
-				*leftmost = false;
+			*leftmost = false;
 		} else {
 			goto lookup_neighbors;
 		}
@@ -285,30 +238,32 @@ static struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 	*insert_p = pnode;
 	*insert_parent = parent;
 
-	re = rb_entry(parent, struct rb_entry, rb_node);
+	en = rb_entry(parent, struct extent_node, rb_node);
 	tmp_node = parent;
-	if (parent && ofs > re->ofs)
+	if (parent && fofs > en->ei.fofs)
 		tmp_node = rb_next(parent);
-	*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+	*next_entry = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 
 	tmp_node = parent;
-	if (parent && ofs < re->ofs)
+	if (parent && fofs < en->ei.fofs)
 		tmp_node = rb_prev(parent);
-	*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+	*prev_entry = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 	return NULL;
 
 lookup_neighbors:
-	if (ofs == re->ofs || force) {
+	if (fofs == en->ei.fofs) {
 		/* lookup prev node for merging backward later */
-		tmp_node = rb_prev(&re->rb_node);
-		*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+		tmp_node = rb_prev(&en->rb_node);
+		*prev_entry = rb_entry_safe(tmp_node,
+					struct extent_node, rb_node);
 	}
-	if (ofs == re->ofs + re->len - 1 || force) {
+	if (fofs == en->ei.fofs + en->ei.len - 1) {
 		/* lookup next node for merging frontward later */
-		tmp_node = rb_next(&re->rb_node);
-		*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+		tmp_node = rb_next(&en->rb_node);
+		*next_entry = rb_entry_safe(tmp_node,
+					struct extent_node, rb_node);
 	}
-	return re;
+	return en;
 }
 
 static struct kmem_cache *extent_tree_slab;
@@ -523,8 +478,7 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		goto out;
 	}
 
-	en = (struct extent_node *)f2fs_lookup_rb_tree(&et->root,
-				(struct rb_entry *)et->cached_en, pgofs);
+	en = __lookup_extent_node(&et->root, et->cached_en, pgofs);
 	if (!en)
 		goto out;
 
@@ -598,7 +552,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				bool leftmost)
 {
 	struct extent_tree_info *eti = &sbi->extent_tree[et->type];
-	struct rb_node **p;
+	struct rb_node **p = &et->root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
 
@@ -610,8 +564,21 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 
 	leftmost = true;
 
-	p = f2fs_lookup_rb_tree_for_insert(sbi, &et->root, &parent,
-						ei->fofs, &leftmost);
+	/* look up extent_node in the rb tree */
+	while (*p) {
+		parent = *p;
+		en = rb_entry(parent, struct extent_node, rb_node);
+
+		if (ei->fofs < en->ei.fofs) {
+			p = &(*p)->rb_left;
+		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
+			p = &(*p)->rb_right;
+			leftmost = false;
+		} else {
+			f2fs_bug_on(sbi, 1);
+		}
+	}
+
 do_insert:
 	en = __attach_extent_node(sbi, et, ei, parent, p, leftmost);
 	if (!en)
@@ -670,11 +637,10 @@ static void __update_extent_tree_range(struct inode *inode,
 	}
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
-	en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
-					(struct rb_entry *)et->cached_en, fofs,
-					(struct rb_entry **)&prev_en,
-					(struct rb_entry **)&next_en,
-					&insert_p, &insert_parent, false,
+	en = __lookup_extent_node_ret(&et->root,
+					et->cached_en, fofs,
+					&prev_en, &next_en,
+					&insert_p, &insert_parent,
 					&leftmost);
 	if (!en)
 		en = next_en;
@@ -812,12 +778,11 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
-				(struct rb_entry *)et->cached_en, fofs,
-				(struct rb_entry **)&prev_en,
-				(struct rb_entry **)&next_en,
-				&insert_p, &insert_parent, false,
-				&leftmost);
+	en = __lookup_extent_node_ret(&et->root,
+					et->cached_en, fofs,
+					&prev_en, &next_en,
+					&insert_p, &insert_parent,
+					&leftmost);
 	if (en)
 		goto unlock_out;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6e04fea9c34f..90a67feddcdc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -620,12 +620,6 @@ enum extent_type {
 	NR_EXTENT_CACHES,
 };
 
-struct rb_entry {
-	struct rb_node rb_node;		/* rb node located in rb-tree */
-	unsigned int ofs;		/* start offset of the entry */
-	unsigned int len;		/* length of the entry */
-};
-
 struct extent_info {
 	unsigned int fofs;		/* start offset in a file */
 	unsigned int len;		/* length of the extent */
-- 
2.40.0.rc1.284.g88254d51c5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
