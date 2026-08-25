Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7CAC61DCA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jUCqe8knATFZuylIPj9T3nr+u7KT/rmmmin32a+3ltc=; b=cbyjmfNOiS523+218Ah4DMuE3V
	r5ZrQTL3gMnn1F238yg2bEkrPxhNcvhL0W6XpsJSnito0ujgsKvh5zeat9sScN6l9Hh9nDmCn7mGA
	j34Xk7p5Fk8/7mu+5tww+6Y3NxJ7zEPNPGjFMwFvrGaG02IPA6Bs2xzVGfo7SUP4wLdc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyqn5-0001pa-5Y;
	Tue, 25 Aug 2026 13:02:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyqmx-0001nz-MI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sC7d34Puvn1uzaZd223gdyJg26VUGrinZyi4Ak6w7gI=; b=TyAoRvjSflYJNRfst8RvHNyDwn
 wolpbRat/ZHPLiG33JN1llisxG8MgK5VtDuB2iSzPwnbnqTef4lS3lnqAR2bABMoFD/vx+XajSaSj
 V8hgKMlJRUeHE05eecQsxmmpE6vv2El1NiE4XDSvQ9uZIYpwJVzQlrAduv+GgmGSaOP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sC7d34Puvn1uzaZd223gdyJg26VUGrinZyi4Ak6w7gI=; b=lvx2FzM4bCCoVfeVlf4hFrFGj2
 qbposeqR97Gup8viNQivu1xAnXk6LM5baENQbMlM0kK2wds6JWyWRNp6GFYXhBCNTvlA3zG/O4fN7
 0DZ+5YYtbW5vWPP2u/f7UAvUwQRoe8pR76d3ob0F14cvK1p5iAv4wZuyXbZsBplLks3Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyqmp-0005lA-MW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:01:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 237E060A5C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 13:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5E31F00A3F;
 Tue, 25 Aug 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662909;
 bh=sC7d34Puvn1uzaZd223gdyJg26VUGrinZyi4Ak6w7gI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f3GHN4Ge4mlDFKcyhzbqarO4U4OJCzsQDYq4q/qjhsxuRiEuXj2O0Q1ifnQUvOIhL
 AdsEjqEbMD63/PVCCkxp6F9acIrgzAKrqJgqhMJUeO2L0KAYRbtx/OJMTmkwMmcbXG
 NeSkL+de7gIj0pss89qIzOY/26Orqs2uFUXc72JtjMTfMewunnbOGWDfFHJwA94XwK
 2vqONlVYfDTaSsX4mn80SGOM/WehfJhAo1Ui8w/pNe4Xg/wPgd6QjuPwJy1pZJ//mi
 0QsVuQQBqkV9ZmPD5/EraVtmorr+pvJTCexOc3jmjhZMrfxqcjYjgMycw5fnoCc6+T
 b6U1Vzh0q6dHA==
To: jaegeuk@kernel.org
Date: Tue, 25 Aug 2026 21:01:16 +0800
Message-ID: <20260825130126.2078627-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825130126.2078627-1-chao@kernel.org>
References: <20260825130126.2078627-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyqmp-0005lA-MW
Subject: [f2fs-dev] [PATCH v3 02/12] f2fs: cache: initialize meta cache
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

This patch introduces meta_blocks in f2fs_sb_info structure, initializes
and destroys the meta cache during filesystem mount and unmount.

It also introduces helper wrappers for meta cache operation.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.h | 12 ++++++++++++
 fs/f2fs/data.c  |  3 +++
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 10 +++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index c336d5f13418..7ee98d276938 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -172,4 +172,16 @@ struct f2fs_cached_block *f2fs_grab_cache(struct f2fs_cached_block_list *cache,
 void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 		unsigned long start, unsigned long len, bool drop_dirty);
 
+int f2fs_start_cache_wb_thread(struct f2fs_sb_info *sbi);
+void f2fs_stop_cache_wb_thread(struct f2fs_sb_info *sbi);
+
+#define META_CACHE(sbi)		(&(sbi)->meta_blocks)
+
+#define f2fs_find_meta_cache(sbi, blkaddr)		\
+	f2fs_find_cache(META_CACHE(sbi), blkaddr)
+#define f2fs_invalidate_meta_caches(sbi, start, len)	\
+	f2fs_drop_cache_range(META_CACHE(sbi), start, len, false)
+#define f2fs_truncate_meta_caches(sbi, start, len)	\
+	f2fs_drop_cache_range(META_CACHE(sbi), start, len, true)
+
 #endif /* _LINUX_F2FS_CACHE_H */
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 75ab768bb4f7..2c91382ffc3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -695,6 +695,9 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 	if (!inode && !folio && !ino)
 		return true;
 
+	if (f2fs_is_cache_bio(bio))
+		return false;
+
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *target = fi.folio;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 84ee4601126d..0f855ac7d1e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2108,6 +2108,9 @@ struct f2fs_sb_info {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key cp_global_sem_key;
 #endif
+
+	/* f2fs internal cache */
+	struct f2fs_cached_block_list meta_blocks;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1e315282ec6..32e80c70e141 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2075,6 +2075,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	f2fs_destroy_cache(META_CACHE(sbi));
+
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		if (!get_pages(sbi, i))
@@ -5225,12 +5227,16 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_percpu;
 
+	err = f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
+	if (err)
+		goto free_page_array_cache;
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_err(sbi, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
-		goto free_page_array_cache;
+		goto free_meta_cache;
 	}
 
 	err = f2fs_get_valid_checkpoint(sbi);
@@ -5564,6 +5570,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
+free_meta_cache:
+	f2fs_destroy_cache(META_CACHE(sbi));
 free_page_array_cache:
 	f2fs_destroy_page_array_cache(sbi);
 free_percpu:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
