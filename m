Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86A4C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Tj6Bys3iqMRWsxQErSzF5K0OG2pYlV+dtBkivfhARo=; b=BLJwH5ECpn5QDoTSsa9QpgrwvF
	2nhDKTm93GvHVCkWy9bubjkygX08MMHuOxzF6CbA7zZdf3FFlGfCBLYPw4rT+PeS/CdTXRa49ddx7
	9lr6Skz5VYtY5tUL3BhevLzcqqE4UgCPHa0lzY6nJ3QVAxs/2EpAtg4e7dMXzp58YQ+8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0yEH-0007DP-IW;
	Mon, 31 Aug 2026 09:23:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0yE6-0007Cq-4F
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n4a+Rmw7OyCgDc+ssPabYOmdo6Oy7BLAhFKE3yiudc8=; b=Abmo9ix1ejFACA/u/yaOhP8awc
 YATpzn8hhb11Wpc6W29wdyojXleN5ARPYcNtLcPqzSJmzmiQu9M1uPAFS3w7ucAWX3WBfGhjZ1XMR
 pUSc5PqnT3BdqAckQWwK0y9wkXiSHhCqp1u52HvtoUlg1VFnKIbsf9RAyY4ydA7CSdZk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n4a+Rmw7OyCgDc+ssPabYOmdo6Oy7BLAhFKE3yiudc8=; b=JNTmR5mSFT3UQvjmB5rqrrcEc5
 V8e/gj1HFfZ3JQW8UkQJl6wRZu3xGW4ZYHQlM1tKK2UHELzWQS6O1CTMXV6635CBEBBNDhVCEiW37
 2/4TQ2XGoeEpeJjnvKd4JtHtLWivWLGBio9ag2iKpiAwySs0dO/q0ADmbUmU+KPWqisA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0yE4-0005uV-M9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12DB36020A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47831F00A3F;
 Mon, 31 Aug 2026 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168162;
 bh=n4a+Rmw7OyCgDc+ssPabYOmdo6Oy7BLAhFKE3yiudc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SJ9i/lGCmhDhYNcfwuB3G0LxA2MwzgW1Oi211e61sIwDEPmBgIDcmb6mBH+DDnn06
 kHpZtf1dVe+MUSbBpKt4FpAP+FqOntzDwY6uGjU5pSH/3UUvN7RZcSUQ7ecdZ2J6oB
 kKl+yvB3dGv8t3+03EGJA7F+Ujxt9AMoj9/wOM/VoegNnEMVw/o1CQuV+Zcr0LOxgL
 nibL/BtpqbjbO9X4jxEuTtWEWERKkV42BNPFon6PjpDArEULzf6dePwQ767uNOAMdU
 Go8AD4aBQGauF/O5jF4GRgCUxd/5gZTcwM7RsZO2CCPmCj21iEe3iZCm9vnuxkgHHz
 xxju761xJWHig==
To: jaegeuk@kernel.org
Date: Mon, 31 Aug 2026 17:22:17 +0800
Message-ID: <20260831092227.739737-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831092227.739737-1-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x0yE4-0005uV-M9
Subject: [f2fs-dev] [PATCH v5 02/12] f2fs: cache: initialize meta cache
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
index e2f39ff42510..74b88ef2f6b5 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -191,4 +191,16 @@ void f2fs_truncate_cache(struct f2fs_cached_block *entry, bool drop_dirty);
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
index 7114e24756e3..ce76871ac68c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -668,6 +668,9 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 	if (!inode && !folio && !ino)
 		return true;
 
+	if (f2fs_is_cache_bio(bio))
+		return false;
+
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *target = fi.folio;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 353decad2c62..38027711f2f8 100644
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
index 1314b6ccced9..858bd36f5f1b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2081,6 +2081,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 	sbi->meta_inode = NULL;
 
+	f2fs_destroy_cache(META_CACHE(sbi));
+
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
 		if (!get_pages(sbi, i))
@@ -5231,12 +5233,16 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
