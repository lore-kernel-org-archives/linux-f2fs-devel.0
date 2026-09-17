Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86864C982D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nBqPtD7WeG/E8uDonFAC0eXQTfNHIcbTv77HxpomcrE=; b=keV5r7CMJVaDyqfuG7MIXnr2HE
	QAJFvkJJQ7Nku2+b02wQcZ2gM76bc60cJlz2b2kcd22XKbw+l6Slb07aKtZKjwM2vjMzmBfAs97Sq
	6QbqTWwsJc1X4LBlPcFqd9TOD1xgEkyoYVma+x5MT0FSpGCn7n/J7pdxSudrki/8svto=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x76dJ-00061z-4s;
	Thu, 17 Sep 2026 07:34:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x76d4-00061D-FL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3YAgWOqepbRrYKYedoyAN2j63VVPP7PzkceBO8zFBo=; b=CjvuVD43kwlNodGs46ReQ+/VMn
 /e7KMxPoWM+OB1nDuIgDZv83qaIAW9+t7a2z43sjDabYa28GYiO4SAAe3S+qeXLPLN5ohFgJCP943
 dLA3b2p83kLtEHqhPbsmk4PgRa/Be3GE9u9ciIk0Ats5YKOwZpTF99gn/IpUchSJGlBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l3YAgWOqepbRrYKYedoyAN2j63VVPP7PzkceBO8zFBo=; b=T6YDofcA1WlyXUD01H/b4OZrJo
 39LEjGox7Lz/Z8ACEsv4INNhVqWi7hhLal1I8BLftrFy2f5+1U7x/SyKTyetQMQQzlntautYk3mKG
 5SYRKGFS8FjTzqZFgey9sNJl3A3jzsu7xB80Wj7Sl9RD7mJdSqXG/cFt0Ssn0vFOsd5o=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x76d2-0007Mr-JU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:33:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B50A60233;
 Thu, 17 Sep 2026 07:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE09B1F00893;
 Thu, 17 Sep 2026 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630430;
 bh=l3YAgWOqepbRrYKYedoyAN2j63VVPP7PzkceBO8zFBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KEq+5LsCQ6BEBrm8yHmOmWhVPsLSm8dbB8QGx8D0Cl9q78KwgPp/cf32e6IHlB6U2
 RNdrxqeNYTid83XXv5atGe7cnLBECKwje62WjQ0vHzbvZbmvRVdCnvXnCyQHB5UyBl
 R0ogwU2VhAPioJs0GB4wJql5OklIKTXt+Qqt+DlYFUdihK/rF4gKsKN0BQWCBF7nE/
 CPkqC0gv/z6aiCo1LRFQyimetndClNebdvxQ4H5WIyFhBFHdCnKo1trwDi138wguKd
 squqUZxN8bYmcoF2leDpU9TnYDETYKKDhSEEleEE3pj/7vwR7Zw2PStoPzC7qCXnqB
 8sV9xg6NNJEMg==
To: jaegeuk@kernel.org
Date: Thu, 17 Sep 2026 15:33:33 +0800
Message-ID: <20260917073343.2823157-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
References: <20260917073343.2823157-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x76d2-0007Mr-JU
Subject: [f2fs-dev] [PATCH v9 02/12] f2fs: cache: initialize meta cache
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch introduces meta_blocks in f2fs_sb_info structure, initializes
and destroys the meta cache during filesystem mount and unmount.

It also introduces helper wrappers for meta cache operation.

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.h | 9 +++++++++
 fs/f2fs/data.c  | 3 +++
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 9 +++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 1fa279f9d69e..d8123a86cdf8 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -193,4 +193,13 @@ void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty);
 void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 		unsigned long start, unsigned long len, bool drop_dirty);
 
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
index d868b939caee..59fef2132177 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -670,6 +670,9 @@ static bool __has_merged_page(struct f2fs_sb_info *sbi, struct bio *bio,
 	if (!inode && !folio && !ino)
 		return true;
 
+	if (f2fs_is_cache_bio(bio))
+		return false;
+
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *target = fi.folio;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c0c7d51c830f..85c4bf40b4aa 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2107,6 +2107,9 @@ struct f2fs_sb_info {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lock_class_key cp_global_sem_key;
 #endif
+
+	/* f2fs internal cache */
+	struct f2fs_cached_block_list meta_blocks;
 };
 
 /* Definitions to access f2fs_sb_info */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6a2f09c61dcd..bc3d378371e5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2094,6 +2094,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	f2fs_destroy_cache(META_CACHE(sbi));
+
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		if (!get_pages(sbi, i))
@@ -5263,12 +5265,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_percpu;
 
+	f2fs_init_cache(sbi, META_CACHE(sbi), F2FS_META_CACHE);
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
@@ -5596,7 +5600,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
-free_page_array_cache:
+free_meta_cache:
+	f2fs_destroy_cache(META_CACHE(sbi));
 	f2fs_destroy_page_array_cache(sbi);
 free_percpu:
 	destroy_percpu_info(sbi);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
