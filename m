Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541BC001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Jul 2023 01:37:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qO6z3-0003RV-18;
	Tue, 25 Jul 2023 01:37:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chaoliu719@gmail.com>) id 1qO6z1-0003RP-RW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Jul 2023 01:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1MUcyR27lsnAPH03DYgaTAElkpMdwyHtzt9K9Z4HiWc=; b=PJiNVJV1PE+yeGkULAFDD8Isee
 SB3HniNAbusou7oR+n3S0Cpsg6JHMzda8CjPhDeLL3kcSzrBbXkSuERjeGFCDAF2PTPcRfBgVre2z
 bjLpfU/WZHSKtiWAV96nXZ53gW45UtD908pR2n3hQd5KEf/BgONJUXgvSTb2tlP3TGzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1MUcyR27lsnAPH03DYgaTAElkpMdwyHtzt9K9Z4HiWc=; b=R
 m9kWEkjuDaymAtrQJMLjduT3E/J/hKJvvMiHBOnDFsoFOtI65ISDOkghQu1fqnrIuwtu4lUCTycwk
 GArjE+sCJtuxKiH3kZ6bvpmlaTMCXGgwTEOxXnMT9iOWY/snu0plTPYv3+PZrsKTwsAy77c1bRGh+
 vnccUkTZsJLWFQqs=;
Received: from mail-vk1-f179.google.com ([209.85.221.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qO6z0-001HsZ-Mb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Jul 2023 01:37:04 +0000
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-48138949fb4so1534537e0c.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Jul 2023 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690249017; x=1690853817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MUcyR27lsnAPH03DYgaTAElkpMdwyHtzt9K9Z4HiWc=;
 b=Bex30q252y1P7IrQ8sRrwcsyfInis6KqFEHqisSnSi7LjoTcE9baPxv62GS4lpasTX
 eyW/GxyscK6QNZHX1imKsGHxakCOSD8bHU+TCp1+ckgymAvkh90Cu8taneUSJssPccW+
 FDfeA0xsbvTGWV2Ua9AY//AlcILIumXtQMAM/+WS0wQi3J+b9cI6BtEAhkshsJJdyFsz
 bX5SBHlRxscgu6v2wJyrNjIX1ygUpel8+Jr3BzTZ4avdwsYAY8xOtFddDxiPT8VpAPc5
 W/8mkg1T51QqUq3/fwaE1jS6ZhLQ3ZwYiYp/2qfSuOrRWIc8hwPVwtuOjgU+dCzyn5qe
 4ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690249017; x=1690853817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MUcyR27lsnAPH03DYgaTAElkpMdwyHtzt9K9Z4HiWc=;
 b=kx1WpEeCra5GmaFG7CE81vyvbgOXRlQEfRFYkNluTmL4Tokf2LNoE5e/heGiHd29OD
 MP4HtL3grUUp4lgHQ6wZD8UavkYzEicXQXKPVMMUgU8PXf3cRKseyouTpnVzzJGSgJXo
 yK0weKOrGxVxE4IBu+ocDsghhHXn+0M14pkh4NmCTZWaET509bQcbo5tHyVMzjGEzWPI
 +PpaEhhxfAlRBkgRj0/6x3GSQ00TePSjqfqODFqBRz8Htkd5R9BjEEogOg9psfUjvqaG
 NtwtdafPZtkm47rHot9pYYWhBYw5/tMwGPpgfenDC7NOMnVIQGO1FifO1sifInlNMx0V
 dnbw==
X-Gm-Message-State: ABy/qLb9D9lzpk2JG7sM2V7jNu1MDE/Vgcvj/FSyaA3HRYVoZsuk0IBM
 0x7ou0/sF56PxMeJw4WN7RjUXGfeBmI=
X-Google-Smtp-Source: APBJJlEMZAx4quaYubUevOxdtHBh8KjTFb3QFyoR8OAd735GkCWyiW+B5oI1ebsYLAnSwFrM05OSTA==
X-Received: by 2002:a1f:c406:0:b0:471:1785:e838 with SMTP id
 u6-20020a1fc406000000b004711785e838mr4898823vkf.2.1690249016584; 
 Mon, 24 Jul 2023 18:36:56 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
 by smtp.gmail.com with ESMTPSA id
 e23-20020a17090ab39700b002609cadc56esm6904282pjr.11.2023.07.24.18.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 18:36:56 -0700 (PDT)
From: Chao Liu <chaoliu719@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 25 Jul 2023 09:36:07 +0800
Message-Id: <20230725013607.4134123-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1qO6z0-001HsZ-Mb
Subject: [f2fs-dev] [PATCH v2] f2fs: introduce two helper functions for the
 largest cached extent
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
Cc: Chao Liu <liuchao@coolpad.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Liu <liuchao@coolpad.com>

This patch is a cleanup:
1. Merge __drop_largest_extent() since it has only one caller.
2. Introduce __unlock_tree_with_checking_largest() and
   __drop_largest_extent() to help manage largest and largest_update
   in extent_tree.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
v2: Make sure et->largest_updated gets updated within &et->lock.
    Thanks to Chao Yu for pointing out.
---
 fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
 fs/f2fs/f2fs.h         |  4 +--
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 0e2d49140c07f..cfc69621a8a26 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -19,6 +19,12 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+static void __drop_largest_extent(struct extent_tree *et)
+{
+	et->largest.len = 0;
+	et->largest_updated = true;
+}
+
 bool sanity_check_extent_cache(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -35,8 +41,7 @@ bool sanity_check_extent_cache(struct inode *inode)
 
 	/* Let's drop, if checkpoint got corrupted. */
 	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
-		ei->len = 0;
-		et->largest_updated = true;
+		__drop_largest_extent(et);
 		return true;
 	}
 
@@ -310,6 +315,8 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 
 	if (et->cached_en == en)
 		et->cached_en = NULL;
+
+	/* keep the largest as we can still use it */
 	kmem_cache_free(extent_node_slab, en);
 }
 
@@ -385,15 +392,6 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - atomic_read(&et->node_cnt);
 }
 
-static void __drop_largest_extent(struct extent_tree *et,
-					pgoff_t fofs, unsigned int len)
-{
-	if (fofs < et->largest.fofs + et->largest.len &&
-			fofs + len > et->largest.fofs) {
-		et->largest.len = 0;
-		et->largest_updated = true;
-	}
-}
 
 void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
 {
@@ -601,6 +599,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 	return en;
 }
 
+static void __unlock_tree_with_checking_largest(struct extent_tree *et,
+						struct inode *inode)
+{
+	if (et->type == EX_READ && et->largest_updated) {
+		et->largest_updated = false;
+		write_unlock(&et->lock);
+		f2fs_mark_inode_dirty_sync(inode, true);
+		return;
+	}
+
+	write_unlock(&et->lock);
+}
+
 static void __update_extent_tree_range(struct inode *inode,
 			struct extent_info *tei, enum extent_type type)
 {
@@ -612,7 +623,6 @@ static void __update_extent_tree_range(struct inode *inode,
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int fofs = tei->fofs, len = tei->len;
 	unsigned int end = fofs + len;
-	bool updated = false;
 	bool leftmost = false;
 
 	if (!et)
@@ -636,11 +646,10 @@ static void __update_extent_tree_range(struct inode *inode,
 		prev = et->largest;
 		dei.len = 0;
 
-		/*
-		 * drop largest extent before lookup, in case it's already
-		 * been shrunk from extent tree
-		 */
-		__drop_largest_extent(et, fofs, len);
+		/* updates may cause largest extent cache to become invalid */
+		if (fofs < et->largest.fofs + et->largest.len &&
+		    fofs + len > et->largest.fofs)
+			__drop_largest_extent(et);
 	}
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
@@ -733,8 +742,7 @@ static void __update_extent_tree_range(struct inode *inode,
 		if (dei.len >= 1 &&
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
-			et->largest_updated = true;
+			__drop_largest_extent(et);
 			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
@@ -742,10 +750,6 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (is_inode_flag_set(inode, FI_NO_EXTENT))
 		__free_extent_tree(sbi, et);
 
-	if (et->largest_updated) {
-		et->largest_updated = false;
-		updated = true;
-	}
 	goto out_read_extent_cache;
 update_age_extent_cache:
 	if (!tei->last_blocks)
@@ -757,10 +761,7 @@ static void __update_extent_tree_range(struct inode *inode,
 		__insert_extent_tree(sbi, et, &ei,
 					insert_p, insert_parent, leftmost);
 out_read_extent_cache:
-	write_unlock(&et->lock);
-
-	if (updated)
-		f2fs_mark_inode_dirty_sync(inode, true);
+	__unlock_tree_with_checking_largest(et, inode);
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1092,7 +1093,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
-	bool updated = false;
 
 	if (!__may_extent_tree(inode, type))
 		return;
@@ -1101,14 +1101,10 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
 	__free_extent_tree(sbi, et);
 	if (type == EX_READ) {
 		set_inode_flag(inode, FI_NO_EXTENT);
-		if (et->largest.len) {
-			et->largest.len = 0;
-			updated = true;
-		}
+		if (et->largest.len)
+			__drop_largest_extent(et);
 	}
-	write_unlock(&et->lock);
-	if (updated)
-		f2fs_mark_inode_dirty_sync(inode, true);
+	__unlock_tree_with_checking_largest(et, inode);
 }
 
 void f2fs_drop_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d372bedb0fe4e..da02e120e5ea6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -665,7 +665,7 @@ struct extent_tree {
 
 struct extent_tree_info {
 	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
-	struct mutex extent_tree_lock;	/* locking extent radix tree */
+	struct mutex extent_tree_lock;		/* locking extent radix tree */
 	struct list_head extent_list;		/* lru list for shrinker */
 	spinlock_t extent_lock;			/* locking extent lru list */
 	atomic_t total_ext_tree;		/* extent tree count */
@@ -766,7 +766,7 @@ enum {
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
-	FI_NO_EXTENT,		/* not to use the extent cache */
+	FI_NO_EXTENT,		/* not to use the read extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 	FI_INLINE_DATA,		/* used for inline data*/
 	FI_INLINE_DENTRY,	/* used for inline dentry */
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
