Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BDDC88E4D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A440+/5hFZm7VrCi+rxZ4/1Q9eLX+HBqTO3BiYBFRek=; b=YETnnBGIG9uNxbtigrZBLY0Byq
	l3gHCdi/RK5/H42FiluHetnrhYruqJZU/V1LhDwK9UmSwguc9eqnyC5UvLEsLNI0FcPNuqs9n0QB0
	NueNL8O9atNkG4LSImacaeI/FuFCsbbJymNiU5GpvE2YrIWBcSClC9RssrZ6VU6UQU54=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5Abi-0001yK-D2;
	Fri, 11 Sep 2026 23:24:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5Abg-0001yC-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYC7tnjlMICy2285vsCu7hsIl1iQc0bcDEelCbLHpYk=; b=fDFtXd3BVM6b51c4QrlocuCSg4
 JQr+FGZLshxwG5M4pttYs/jVGjpdQs/zxUViExfhHVDulF6S8EopeWEe8vKpBw0Gj4/Jp/pCV8trI
 QbckXLQ5n+Jf5RMidvjb2+6rhzd1Pir03QMkvzCmSctWtbfNbQvZIs+WGu/bRlFy5O6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OYC7tnjlMICy2285vsCu7hsIl1iQc0bcDEelCbLHpYk=; b=jIxw5ymArZNYYg2PY9H1aqRYpL
 XzyuKihYzxXvzr+kWCDkuPBd/unSf+yL17keb7f282SKmiN5TMz6k61lWHkmLL4SJ/YtzkozhKpOY
 S7sstMAE9Zzr/rW/AyyhE5zeTgmG9nv0ZjeINmXwxHMLkuSxWewJQdGhIzyFSpJmJj7w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Abg-0007Tu-Hm for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4C17449A5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 23:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F381F0089B;
 Fri, 11 Sep 2026 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169061;
 bh=OYC7tnjlMICy2285vsCu7hsIl1iQc0bcDEelCbLHpYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SRaKneLohyPPxVge8ZqXMB88TDIDVM5eb01xO8zEGvfAZ0fAT5cqrOHbJMWYBI4L0
 hOnSd/8sy7Z9raVFZafYPmaFuPwUmq3D/zwXqmqQrQrKLqIGUg7yYokE0nRQEqfTgn
 QhbXQof1pbZUEkLPWmVCkdEveHzh2TIK9yOVh9h5Sq4PFXx2QZPeePsPQIRZV7U7HV
 BdwpV5xtlLyvzwJnS7Ijr8JZDY8RW0OzOFjHk/6o0yGJaKR9yep6mGRaCcNW0plS/+
 iBKW6TFii14XjqZJeVUVXOWyk29fSFDNYkfY8keft89tNn/ert6fK1/KAjlncW1CTQ
 ZQBiwq4A2wJAw==
To: jaegeuk@kernel.org
Date: Sat, 12 Sep 2026 07:23:59 +0800
Message-ID: <20260911232405.1815804-7-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260911232405.1815804-1-chao@kernel.org>
References: <20260911232405.1815804-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x5Abg-0007Tu-Hm
Subject: [f2fs-dev] [PATCH v7 06/12] f2fs: cache: initialize node cache
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
 fs/f2fs/super.c |  9 ++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index e99165e1c785..f265e45ee210 100644
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
index a0218c235c39..f02ea0638930 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -198,6 +198,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+#define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
@@ -206,6 +207,16 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
index 0361e4cc0e0a..d1ed5d0f5335 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2092,6 +2092,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sbi->node_inode = NULL;
 
 	f2fs_destroy_cache(META_CACHE(sbi));
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
@@ -5285,10 +5286,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_page_array_cache;
 
+	err = f2fs_init_cache(sbi, NODE_CACHE(sbi), F2FS_NODE_CACHE);
+	if (err)
+		goto free_meta_cache;
+
 	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_err(sbi, "Failed to get valid F2FS checkpoint");
-		goto free_meta_cache;
+		goto free_node_cache;
 	}
 
 	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
@@ -5614,6 +5619,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_devices:
 	destroy_device_list(sbi);
 	kvfree(sbi->ckpt);
+free_node_cache:
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 free_meta_cache:
 	f2fs_destroy_cache(META_CACHE(sbi));
 free_page_array_cache:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
