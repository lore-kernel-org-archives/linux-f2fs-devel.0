Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1747C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w24yS0Wa2jYS1AMO0E0Uq/+YEyVF3+uyJjdK0Agrh2g=; b=FZ7Kk0ZtuFuBuawYIze7UG5161
	IJ4KfHyszrgtWHmITY9gPR53A6x8DPwwHflZCpZE9NccpRiRfripR75G9p/FsfBkyfjpPzH5HSH6x
	bB0XVCPmZKC9nvtOlNgT99i1HeU2x6k2I1fQHIyXQ0pMXpeYct6x8vsTh4i+SmchIGa0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyqn1-0002cO-FA;
	Tue, 25 Aug 2026 13:02:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyqmy-0002c7-Ll
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=renN+MNKpzxgJ8WaFoWhISs11FjftApRPUc3lEvxCEY=; b=V6uro4dIuX9Nc/qDb3S2vwwgLn
 8GHoMT0AHd/DVC/+rcdtP++McP5amVfg9o28kyCcE8eTi9EwkJqe/Rv85Wl8Udfqt/jMBOz0FIIdf
 ZqaschWqYsZ62UZ0LvaMmqg65dsTQx0fziDFp3qfkP9S/aa5T/hNNy2E63KNDEMVLWkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=renN+MNKpzxgJ8WaFoWhISs11FjftApRPUc3lEvxCEY=; b=FNQl48nbHSvz5YYOWROeiKTRUW
 FfzWelBbjfDKfxwo7A/xWHvd7Qpu9zn5IBFyiMi7fJoBh2/8OvnPQIytgHB7phLG4YbQZj2dCN04X
 H6FXbJOu6AWduguDdHzM2Sep/QG5zB3ze9MKswRX+JtGr0QIy3026l8iQUUYuYjp1LCA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyqmu-0004YL-F9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 327FA43EC7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 13:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EFD1F00A3D;
 Tue, 25 Aug 2026 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662915;
 bh=renN+MNKpzxgJ8WaFoWhISs11FjftApRPUc3lEvxCEY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MioZ7f9HMi6Q0p8koHs11Jm1F9b7xkqBPXgpOYRcLOzI0oYY1ySD8DVzx4XhLypC6
 KgUApVo/2imiTtmd+Q/XPNIh+UKQeS1B4yoaPS6AegMAHbffCIvj5oj7yBsbndpuZQ
 ojrsFdN5uigp/Ituo3gOqzq5dnh79f4qYneg/kdlBPPDdRJRoFL9xiJ+an7gZrY+E7
 El9X5lxjeV7NJ61r0qx+yoTkL4vSL1GmWVgyXQoXgQWV9H3vhSznBsLwULgFR15gzH
 l18aw74tWdWibjHLjZcE8m8yW8uC6sUqlVc+3MaiE6oxdasmESBTRjP3pmtj0UHiXB
 OtQ4TyzwLsOyQ==
To: jaegeuk@kernel.org
Date: Tue, 25 Aug 2026 21:01:20 +0800
Message-ID: <20260825130126.2078627-7-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825130126.2078627-1-chao@kernel.org>
References: <20260825130126.2078627-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyqmu-0004YL-F9
Subject: [f2fs-dev] [PATCH v3 06/12] f2fs: cache: initialize node cache
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
index 16c6dab2e498..27ce67091349 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -613,7 +613,14 @@ static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
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
index ff3d8781119c..e34a7877b13d 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -176,6 +176,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+#define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr)
@@ -184,6 +185,16 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
index 5115c0c0b47d..4d322926462d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2109,6 +2109,7 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+	struct f2fs_cached_block_list node_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 36f73ff3343c..f2086ca590f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2073,6 +2073,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sbi->node_inode = NULL;
 
 	f2fs_destroy_cache(META_CACHE(sbi));
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
@@ -5247,10 +5248,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5582,6 +5587,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
