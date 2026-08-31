Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CC4C624D2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nl7LgpEHZxLQT3sIXkzaohwmy/UEmWolj10hs3aRYy4=; b=DtQiIB/twGYZjDOgQzDDSDWnkc
	tpkF0AXCN1Z94dn6jNz3B5FFDoe39PBDIIq54IUZaMw54KFAEU7g8KwvEMuUKuKIcCYruh19yGt8b
	e/Hi9zn3AbQzsk/ok/rAMr4ewpj/fvdID0ZcgOuyzH+O7+I5YH6XjmTqyQze/LV9CCxw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0yEO-000456-Cp;
	Mon, 31 Aug 2026 09:23:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0yED-00044C-IM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ubk3PHi0BZy5ZpAbFMOSsqRAM27d1tYPYZDXjATdhNs=; b=YoOQiotfbf6JU2SkxuBnUzKE/A
 BHaZIVXqNSohqjZ64b8A/pmibQefeIKtEL4Uqz1rTqcApLphd+cq9wi7BBItZzuFnqlU6QVd9JvtH
 4iSyTWucxgAW/Igp9gA1gA5RCbGOdD9ovmzcE9OvpVvT+fmNxiUBhimLIY5Utpbr/8pc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ubk3PHi0BZy5ZpAbFMOSsqRAM27d1tYPYZDXjATdhNs=; b=VVrBWt9rYmDyv0Ntx7lp9i+tjf
 JMcg1f4p8In59MOC7sOAhf/2O0+yXGhwVfagJ+tYu6wkFjrq/TfP+rZT8Pga0zZMjFqkFMnolyX/9
 tnuTIWAby5LWycuJD30ZB5KhHfa+TE9zTdpQWaosH1T8wjbJDsIwLUAp316u25CrUITk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0yE9-0005ud-Me for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2072060120
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BCC1F00A3D;
 Mon, 31 Aug 2026 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168167;
 bh=Ubk3PHi0BZy5ZpAbFMOSsqRAM27d1tYPYZDXjATdhNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h2FR9jGZGN3+se5kncnTG0hMVsrDdlE/1B6Prr+P51pZmqf43O734KvC+1zl4C/Bp
 EGDRvwxjDJm5KnBNe9Mmhn+N1FQxjZqAR5qloFYrJ+l1prmledG27G1Yd8hI2FNFsz
 5hSvbLC1/XJHT2mE8jWsYimq10tLIf1AqK4oDMteGKOlPJ/0VC0h3WYHzK4vldCacV
 N85RRBfl5kwcXVDFE9ld79YGvLa7d+0om8vsy6jWR4cygi9PMHq90ebWJ38iu2HgJk
 RY4XKx8Y9jhyWw/ZU0VuPWWI2uS1rFsoMl8TilCQEPt+dty5BITY0TRA61F2qC9X32
 9yhbRooQZfOJg==
To: jaegeuk@kernel.org
Date: Mon, 31 Aug 2026 17:22:21 +0800
Message-ID: <20260831092227.739737-7-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831092227.739737-1-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x0yE9-0005ud-Me
Subject: [f2fs-dev] [PATCH v5 06/12] f2fs: cache: initialize node cache
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
index fd45ef075562..e0e220e91db8 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -629,7 +629,14 @@ static unsigned long f2fs_do_shrink_cache(struct f2fs_cached_block_list *cache,
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
index 933770c893ce..590b0d2d71e7 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -195,6 +195,7 @@ int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
 void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
 
 #define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+#define NODE_CACHE(sbi)		(&(sbi)->node_blocks)
 
 #define f2fs_find_meta_cache(sbi, blkaddr)		\
 	f2fs_find_cache(META_CACHE(sbi), blkaddr, 0)
@@ -203,6 +204,16 @@ void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
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
index aceea2e8cdd5..10ef90c675f5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2108,6 +2108,7 @@ struct f2fs_sb_info {
 
 	/* f2fs internal cache */
 	struct f2fs_cached_block_list meta_blocks;
+	struct f2fs_cached_block_list node_blocks;
 
 	/* internal cache flush thread */
 	struct f2fs_cache_kthread cache_thread;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 755d80b2a312..4d468c8d258c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2079,6 +2079,7 @@ static void f2fs_put_super(struct super_block *sb)
 	sbi->node_inode = NULL;
 
 	f2fs_destroy_cache(META_CACHE(sbi));
+	f2fs_destroy_cache(NODE_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
@@ -5253,10 +5254,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
