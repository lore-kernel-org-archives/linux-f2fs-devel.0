Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2036CC6B27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPAyyOpMTGDCQK4sMdK3rNeQycWzA59GBUr0ownuBms=; b=Y1c9G6CvnCc36zH9OItnhT9O+7
	JJxN3sjz3AyVwuvmbyF46TSLFxrLunfVLEK2LuNI7uWgItx+LgcKzVo7i04k9STlCPDdZgzncDniC
	lyM30qOOaO0ffgS0i9HkxiHTzwJRb/olaoSlGWPy1Ji05T748wADTOmT5UuyEoaihuok=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskP-0000jf-St;
	Wed, 14 Oct 2026 06:45:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGsjs-0000j6-OZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+BUhD3fQf5K+7NUxshahehqiYa7rtRUVM0JFI9Oq50=; b=gYiAdpzdinoo6jShOysAx1jwIE
 VfsGeRweHQ7/TfLp0qVwEpApafPlsmskl2eXl8dKfQ7s6s7uEFT/D6oBmb2Dq1EtyaU9WiuT1d0LA
 qkXrQ7EaJf6tE4rHeDM6IOuPblYCRxMuZiTxeIzGS4qKSuG3ZpA4++JxaTnmqBL+O0CE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I+BUhD3fQf5K+7NUxshahehqiYa7rtRUVM0JFI9Oq50=; b=W82x5dWEF3KdjI/Odltb2XhOSA
 rxZeNxpEq5a+6cZrfnJMyaS6FHbHhkbdk8YOHGpsR2YLon0o8rI8GjDfJRCkL7SGxRP0DBMKmjK2P
 xmEgcK4ihOF1xpMB/bwg/OKGzQEHGUTvG+YdsuVilJadGogI0aTB5jS0YX8QlmmKyjf4=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGsjs-0000vZ-2Y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:24 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab37ea4798so1405414a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960318; x=1792565118; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+BUhD3fQf5K+7NUxshahehqiYa7rtRUVM0JFI9Oq50=;
 b=XidCYXuM/f25LLg3oMZBUB5N8bnPsMbFJ91OMdLzOV/ZGngUnnYYZGJlRewCWVNSUU
 M0e65Us7h3RfCcB3subUYFwoh10LjY8ANg7kXKvNnMfmsUTBVS8LfDn9WO4Y+2RStQuE
 bKP9VHzdzbJv/WRt8Ww6qn7bi7XN3TQmR2WsybpLX5CtBOZLOVCoXOwP2r5bax3gCiP/
 RbBkMSFGWSTCCvApHDrFrrO1avW755QP6FqirD+3d0ZM9ImuVgv4g13RsqPb/2mgBjG6
 10I1hx7kGw3eRV92IcVDsqmXdS9AG2DB5tJEPLYu9bh07nL2V9ns9XNMTuiKPYzqhhWZ
 wBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960318; x=1792565118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I+BUhD3fQf5K+7NUxshahehqiYa7rtRUVM0JFI9Oq50=;
 b=hhBjv2mmpJ5Ryvs2TrSHUc2Q6Bf3WFT7Z+BbHox/qrcTW/zcfxZ37vhBhOQp+otFk9
 Ei9mXpiF+m1lL9lVZixErgqDlRUcnnsztFP0Z+Tp4TG8Ns0xnfoL/sHLIQdVoXzwFt0W
 kcnHa+7fJUqOvU3k0HicbeNZUD5/Jm8gn9IQEq3PQvHH0gkcPzWim8n3WGokk95Gzpeq
 RBGKvu1/T4Wxu8c4w/aWLei6AUeXdpNkYcAUxkWUQDW4tP5rXgDCIOp+s3PHYKFyJdFC
 LhKrmDsYDeo6ST6GiJKbd/hPBJilM8vz+LJqkuxbkzWZySFyrD/J2d4RDZBiq0AK+0gR
 EP0w==
X-Gm-Message-State: AFq9FYLJ73OphptIY+ELqoxIZldTrDFRA0qWYtAGR5Ti4oynTxAFEayz
 EDYMz7ssCzOmYWoRAlJNHiy84U3OykuJr4Veb5YpqTg6hoTe//cENy3vsiA0BVLwPjo=
X-Gm-Gg: AYBFou0o8zfsrUszQGStsLe1oAHvh8aTPL85zDWsAduPffSqSEh+Q4kM4vBKfWIkSne
 9lP2dk2bs/+QGQqJ7T6yIUm0R8Das1deTCVwTS/QTcAFtPI8YriHI4wzNn7npIcGUBiLqJ4zZhZ
 e4RgkGQgq0OkaRp53DQoEbU9yQo772tdtNP/dphNU12JBHa5yT5xBaoy0/b07CFlH+k7s4ZyAvp
 fgrh++sug0H4Yfa2uCH+pfFZpc/K8VptyswkxGpxOY3B6exYGtGPojcCAjiGZ/mTCWzeB4Sev3a
 53dlN862xJ1Po1/MwGCRHNjowpbqSmY3x1uESaTjcYqjNG6gnpT2Ar/NaTAwFS2W6CdN/gX1UMN
 UsyQGQfvFS364/pIclebedOnqW0gVwnQMAjqE8O5wPTAZGLzFyFndsbQYdNPNbLhHcnXHLBU0i2
 SETcwXxWUxSdQtPlNvdhhX3oZy7zZFL+R2ehgNeqckxu8icfxAJP3lKrxEX1KOJ+krbVtvqZ9Hf
 fdfC4c24FFmkuvDz3f5Tycnl/7ZCGOjP2Ln
X-Received: by 2002:a17:90b:3d81:b0:3a8:5f61:1bd4 with SMTP id
 98e67ed59e1d1-3ab3ab5cfa5mr10806298a91.51.1791960318261; 
 Tue, 13 Oct 2026 23:45:18 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:15 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:30 +0800
Message-ID: <20261014064445.2835813-2-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGsjs-0000vZ-2Y
Subject: [f2fs-dev] [PATCH v5 01/16] f2fs: extend folio state for large
 folio write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Large folio write path needs a subpage status bitmap and write
pages pending counter, while keeping compatible with f2fs private
flags.

Move struct f2fs_folio_state to f2fs.h, add private_flags and
subpage state bitmap, and change PAGE_PRIVATE functions to be
compatible with f2fs_folio_state. Allocate f2fs_folio_state via kzalloc
instead of kmem_cache, since the state size depends on the folio order.

Note: Now if a path wants to use f2fs_folio_state, it must call
`folio_has_ffs` instead of `folio_test_large`` to make check.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 52 ++++++++++++++++++++-----------------
 fs/f2fs/f2fs.h | 70 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a8d39add5cbe..95212e60f09d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -32,15 +32,9 @@
 
 static struct kmem_cache *bio_post_read_ctx_cache;
 static struct kmem_cache *bio_entry_slab;
-static struct kmem_cache *ffs_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
 static struct bio_set f2fs_bioset;
 
-struct f2fs_folio_state {
-	spinlock_t		state_lock;
-	unsigned int		read_pages_pending;
-};
-
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
@@ -2717,17 +2711,31 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 }
 #endif
 
-static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
+struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
 {
-	struct f2fs_folio_state *ffs = folio->private;
+	struct f2fs_folio_state *ffs;
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned long private = (unsigned long)folio->private;
 
-	if (ffs)
-		return ffs;
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
+	f2fs_bug_on(F2FS_F_SB(folio),
+		    test_bit(PAGE_PRIVATE_NOT_POINTER, &private));
 
-	ffs = f2fs_kmem_cache_alloc(ffs_entry_slab,
-			GFP_NOIO | __GFP_ZERO, true, NULL);
+	if (f2fs_folio_has_ffs(folio))
+		return (struct f2fs_folio_state *)folio->private;
+
+	ffs = f2fs_kmalloc(F2FS_F_SB(folio),
+			struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
+			GFP_NOFS | __GFP_ZERO);
+	if (!ffs)
+		return NULL;
 
 	spin_lock_init(&ffs->state_lock);
+	if (folio_test_uptodate(folio))
+		bitmap_set(ffs->state, 0, nr_subpages);
+	if (folio_test_dirty(folio))
+		bitmap_set(ffs->state, nr_subpages, nr_subpages);
+
 	folio_attach_private(folio, ffs);
 	return ffs;
 }
@@ -2736,7 +2744,7 @@ static void ffs_detach_free(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 
-	if (!folio_test_large(folio)) {
+	if (!f2fs_folio_has_ffs(folio)) {
 		folio_detach_private(folio);
 		return;
 	}
@@ -2746,7 +2754,8 @@ static void ffs_detach_free(struct folio *folio)
 		return;
 
 	WARN_ON_ONCE(ffs->read_pages_pending != 0);
-	kmem_cache_free(ffs_entry_slab, ffs);
+	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
+	kfree(ffs);
 }
 
 static int f2fs_read_data_large_folio(struct inode *inode,
@@ -2835,7 +2844,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * to prevent from premature folio_end_read() call on folio
 		 */
 		if (folio_test_large(folio)) {
-			ffs = ffs_find_or_alloc(folio);
+			ffs = f2fs_ffs_find_or_alloc(folio);
+			if (!ffs) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
 
 			/* set the bitmap to wait */
 			spin_lock_irq(&ffs->state_lock);
@@ -4750,21 +4763,12 @@ int __init f2fs_init_bio_entry_cache(void)
 	if (!bio_entry_slab)
 		return -ENOMEM;
 
-	ffs_entry_slab = f2fs_kmem_cache_create("f2fs_ffs_slab",
-			sizeof(struct f2fs_folio_state));
-
-	if (!ffs_entry_slab) {
-		kmem_cache_destroy(bio_entry_slab);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 void f2fs_destroy_bio_entry_cache(void)
 {
 	kmem_cache_destroy(bio_entry_slab);
-	kmem_cache_destroy(ffs_entry_slab);
 }
 
 static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 631d8ce15203..2fb8ebfa1303 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1621,6 +1621,18 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
  */
+
+struct f2fs_folio_state {
+	spinlock_t		state_lock;
+	unsigned int		read_pages_pending;
+	atomic_t		write_pages_pending;
+	unsigned long		private_flags;
+	/* state[0..nr_subpages - 1] tracks uptodate subpages.
+	 * state[nr_subpages..2 * nr_subpages - 1] tracks dirty subpages.
+	 */
+	unsigned long		state[];
+};
+
 enum {
 	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
@@ -1629,6 +1641,13 @@ enum {
 	PAGE_PRIVATE_MAX
 };
 
+static inline bool f2fs_folio_has_ffs(const struct folio *folio)
+{
+	unsigned long private = (unsigned long)folio->private;
+
+	return folio_test_large(folio) && private;
+}
+
 /* For compression */
 enum compress_algorithm_type {
 	COMPRESS_LZO,
@@ -2759,13 +2778,35 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
+static inline unsigned long f2fs_folio_get_private_flags(const struct folio *folio)
+{
+	unsigned long private = (unsigned long)folio->private;
+
+	if (f2fs_folio_has_ffs(folio)) {
+		struct f2fs_folio_state *ffs = (struct f2fs_folio_state *)private;
+
+		return READ_ONCE(ffs->private_flags);
+	}
+
+	if (test_bit(PAGE_PRIVATE_NOT_POINTER, &private))
+		return private;
+
+	return 0;
+}
+
+static inline unsigned long *f2fs_folio_flags_addr(struct folio *folio)
+{
+	if (f2fs_folio_has_ffs(folio))
+		return &((struct f2fs_folio_state *)folio->private)->private_flags;
+
+	return (unsigned long *)&folio->private;
+}
+
 #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 {									\
-	unsigned long priv = (unsigned long)folio->private;		\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
-	return (priv & v) == v;						\
+	return f2fs_folio_get_private_flags(folio) &			\
+				(1UL << PAGE_PRIVATE_##flagname);	\
 }									\
 static inline bool page_private_##name(struct page *page) \
 { \
@@ -2777,14 +2818,10 @@ static inline bool page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
 static inline void folio_set_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
-			     (1UL << PAGE_PRIVATE_##flagname);		\
 	if (!folio->private)						\
-		folio_attach_private(folio, (void *)v);			\
-	else {								\
-		v |= (unsigned long)folio->private;			\
-		folio->private = (void *)v;				\
-	}								\
+		folio_attach_private(folio,				\
+				(void *)BIT(PAGE_PRIVATE_NOT_POINTER));	\
+	set_bit(PAGE_PRIVATE_##flagname, f2fs_folio_flags_addr(folio));	\
 }									\
 static inline void set_page_private_##name(struct page *page) \
 { \
@@ -2797,13 +2834,10 @@ static inline void set_page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void folio_clear_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (unsigned long)folio->private;		\
-									\
-	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
-	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
+	clear_bit(PAGE_PRIVATE_##flagname,				\
+		  f2fs_folio_flags_addr(folio));			\
+	if (folio->private == (void *)BIT(PAGE_PRIVATE_NOT_POINTER))	\
 		folio_detach_private(folio);				\
-	else								\
-		folio->private = (void *)v;				\
 }									\
 static inline void clear_page_private_##name(struct page *page) \
 { \
@@ -2826,7 +2860,7 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long folio_get_f2fs_data(struct folio *folio)
 {
-	unsigned long data = (unsigned long)folio->private;
+	unsigned long data = f2fs_folio_get_private_flags(folio);
 
 	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
 		return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
