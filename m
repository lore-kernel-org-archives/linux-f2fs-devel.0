Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228C1C88E7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NNQQ+xnZ/9gS0G+qQmQoOtZqQZcyXu0n8Q7qM2lMH8=; b=jgy1ozPMkoKHiF1U6G4kvTdszr
	TOU7LPmXnztsAFF8uW0idF0nOmC7CSS8KjWGtKRbkTHvEYqttzo1Hg7BBw1Mx9HWhXIsBybkmEghw
	FSnFE3tFpHL1YycbfciHa5MvyrPRqAcZW1Wj1e3WRSk5NUIdmlSIpPKFdQgSlNn62kMo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6era-0004n4-TW;
	Wed, 16 Sep 2026 01:55:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6erV-0004lY-Po
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GinoQy/muHeKxdK6nE4tgrNECL7TsVBMYnIxA2p+zRw=; b=MMmqhNS1ddaRCKboBzQqgklNQ8
 1EHb3TTACKRBgaKT9GyYpif+InpYLVIEXmRZtB8OSytOOiIQUl4aofNY1uOQ/nQVZl775JS9j8pva
 nY89/XA4SnYdysyXvWxe5YnMHjT2xg7cMKwgmjnbxEfjHTPFaE4WaJp5HjlfWXRFTrCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GinoQy/muHeKxdK6nE4tgrNECL7TsVBMYnIxA2p+zRw=; b=hJBe0ciCOoxr2b09VkddPhTg/I
 zY4lHX3CHUDEOEhmAKC8RctS/hROHNFq/jjn++Vn9NCvhgGoeOxlEEFxbYH2Snq+U2z9zYuQH2y3A
 WRvDcnPSeZ6SYK+XPA0IVjAP9psVEbR/Zr2PoEe1pJZqOm04t8nN+YBn9QURTh1LntjI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6erT-0004wF-JS for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5253240308
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5409E1F0089C;
 Wed, 16 Sep 2026 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789523694;
 bh=GinoQy/muHeKxdK6nE4tgrNECL7TsVBMYnIxA2p+zRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VPufc22DOxzhvHXn2716wsuf2NgiGu4A4HBwPT6MhIf+U/cEh5vL8IhmmAEi28H+H
 8ip4NaxF/GqvkFLzS5Oxjk11vOMymdaXtvJc7XyoJd4BJJbBV2hQSXaoGVC1UyLMTA
 X9PqT10EguY5QshiIfErOduWtjOoE8OhFudnBCqArgrO9xdOqZHVbyWN51YVbDFWu7
 uidaxx0SPkoGHQ8cfQQGyrrf7FI1qoy2kKzbIcgBwqMBYIZBCk30fiK+8NHfjpqEow
 9qWA9QoUNUhAesgb00rnzrnkqwmwoF7svwI/+GZoUp+Dj/0OzIKkTgItFWsNmnOIAt
 Wq3tlDgj35vsw==
To: jaegeuk@kernel.org
Date: Wed, 16 Sep 2026 09:54:34 +0800
Message-ID: <20260916015440.2232938-7-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916015440.2232938-1-chao@kernel.org>
References: <20260916015440.2232938-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x6erT-0004wF-JS
Subject: [f2fs-dev] [PATCH v8 06/12] f2fs: cache: initialize node cache
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

This patch introduces node_blocks in f2fs_sb_info structure, initializes
and destroys the node cache during filesystem mount and unmount.

It also introduces helper wrappers for node cache operation, and registers
node cache into the memory shrinker and writeback kthread.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c |  9 ++++++++-
 fs/f2fs/cache.h | 11 +++++++++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  7 +++++--
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 4d82697060d0..8ab5e0e46b4e 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -624,7 +624,14 @@ static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 					unsigned long nr_to_scan)
 {
-	return f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
+	unsigned long freed;
+
+	freed = f2fs_do_shrink_cache(META_CACHE(sbi), nr_to_scan);
+	if (freed >= nr_to_scan)
+		return freed;
+
+	freed += f2fs_do_shrink_cache(NODE_CACHE(sbi), nr_to_scan - freed);
+	return freed;
 }
 
 static int f2fs_cache_writeback_kthread(void *data)
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 1e84e66eca79..1eabd787b4b7 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -194,6 +194,7 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 		unsigned long start, unsigned long len, bool drop_dirty);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+#define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
@@ -202,6 +203,16 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 #define f2fs_truncate_meta_caches(sbi, start, len)	\
 	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
 
+#define f2fs_grab_node_cache(sbi, blkaddr)		\
+	f2fs_grab_cache(NODE_CACHE(sbi), blkaddr,	\
+	F2FS_CACHE_LOCK_CREATE)
+#define f2fs_find_node_cache(sbi, blkaddr)		\
+	f2fs_find_cache(NODE_CACHE(sbi), blkaddr)
+#define f2fs_invalidate_node_cache(sbi, blkaddr)	\
+	f2fs_drop_cache_range(NODE_CACHE(sbi), blkaddr, 1, false)
+#define f2fs_truncate_node_caches(sbi, start, len)	\
+	f2fs_drop_cache_range(NODE_CACHE(sbi), start, len, true)
+
 unsigned long f2fs_shrink_cache(struct f2fs_sb_info *sbi,
 				unsigned long nr_to_scan);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2b29067eb0a..51c191c514bc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2108,6 +2108,7 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+	struct f2fs_cached_block_list node_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1e6b9374df97..fa19152cd4da 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2092,6 +2092,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sbi->node_inode = NULL;
 
 	f2fs_destroy_cache(META_CACHE(sbi));
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
@@ -5282,11 +5283,12 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto free_percpu;
 
 	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
+	f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
 
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
-		goto free_meta_cache;
+		goto free_node_cache;
 	}
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
@@ -5612,7 +5614,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
-free_meta_cache:
+free_node_cache:
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 	f2fs_destroy_cache(META_CACHE(sbi));
 	f2fs_destroy_page_array_cache(sbi);
 free_percpu:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
