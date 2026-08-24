Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB4CC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oP2aZ/jcyU1PC63wRaPfIFs4WQOS7HfDDcqozcf6K0s=; b=Qjcj+fcQxgcq/0acmj5tG8o2qz
	YE2UHBSRY1TbGmMcRv5ihRGl7ETil1aTjFxGSkBEixbuoUxPAO6kU0o+PV7wI4d+ZXhYHhO3KD/ET
	8yJSh0lPaJDqrnKGB1Ww8jHpGUlO38E/i1t1EuM8nIfQE07xSKONocZNQeDw8yVD4jQM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyV1q-0004xu-Ac;
	Mon, 24 Aug 2026 13:47:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyV1m-0004xm-RB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1HwJfojdqOc1OevsX2tfsNodJpYnw16wkSWkjKbjqg4=; b=UQLKbblmFXV7FHdY9IBNWirtUy
 5pGE3raLV9A3KsixG4TQeX4xOcsnzLydyz1c7fkEwisTGoQgU4cCmkvgsWNZv7fdRB631oC/3jqth
 8FXV1J89YTArpfL/uBHFlQe9yNzBICN4k4GDnPFH6EP2gSWOpuDrhNeFEhvdfOUVV9fw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1HwJfojdqOc1OevsX2tfsNodJpYnw16wkSWkjKbjqg4=; b=ac5DCxbam1fjZvpM4WqnDlmIdm
 uPRohX+YAi0eg/pdVKXQmjYqWVO3y3Gpib/Y670l6b3cIdHjaWp+3wOUbxoNRJuKYz1hMu+EqkvUJ
 UaGfa/hF5s37j0NGDVhmrp+HGov5mqOa1T1IV7wjYg2UOy+AXM06pNZPppMwTpE4PK2g=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyV1i-0003Qu-Tl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E9DB600C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 13:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED91F00A3D;
 Mon, 24 Aug 2026 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787579264;
 bh=1HwJfojdqOc1OevsX2tfsNodJpYnw16wkSWkjKbjqg4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oWlbiIETtzb7JniGyYS2zxR8BCTqT1iMSOeRCqMyN6gr9j7daoOnVK2cnvGZ4Sffr
 X308/8vo9+RFNfPuFniqMTDA4VlmS1+WD3MdWB6OPRTwBSkMvGuqFP2V+7430QtzxC
 Mmh+2IGAMqXssmQr0qlO6VLAp3x9pjFdLocz2P/v63KnzqIippVReM6OqV0rTa2wab
 Rfa2CmgIfJJ/4QtlTmShl/FNpM+mSPdl4KzcVh6gWeoxTbB9Qscv/pOxiW3pysJksC
 9YCa3Au64dHaRPHgzj1ZVmXKcqyqL/WWxfdT9m3oOCBrPWgTLBdkpuyQBJhYsN6Zj0
 nDuLLPieGndbg==
To: jaegeuk@kernel.org
Date: Mon, 24 Aug 2026 21:47:21 +0800
Message-ID: <20260824134731.3704352-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <20260824134731.3704352-1-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyV1i-0003Qu-Tl
Subject: [f2fs-dev] [PATCH v2 02/12] f2fs: cache: initialize meta cache
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
index 87bdfa2e6ad3..994f9f9063dc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2106,6 +2106,9 @@ struct f2fs_sb_info {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key cp_global_sem_key;
 #endif
+
+	/* f2fs internal cache */
+	struct f2fs_cached_block_list meta_blocks;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3bdb0f891c35..bcfb1f97850e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2053,6 +2053,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	f2fs_destroy_cache(META_CACHE(sbi));
+
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		if (!get_pages(sbi, i))
@@ -5197,12 +5199,16 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -5528,6 +5534,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
