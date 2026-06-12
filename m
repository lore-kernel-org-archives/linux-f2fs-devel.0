Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA685CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4oB5nXUNuOgOvL313gjrjFW88m6DQBQQNpV8TB7yE0=; b=GTiJgklCwo4ZYmGVDmYi3h84yW
	xiPRKCGhdmJCgGXf69XgMCHLVnmj1oXKlz8iOIQCzLCatlsetgc/pjUgjruAQOsMiXdvdrkCU73GT
	nMoqsFJzYo2UPdEs8HftFTe1Q5GIVwiUIiV9JcO9vbFY7ELupuDwMN8PC+dNtyUvjl+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXwsK-0003aw-EY;
	Fri, 12 Jun 2026 08:04:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wXwsC-0003Zz-Si
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17wNcH2B0giT4cjrrr2RMxOqgSaclfg9v0Jiy7/Mm2k=; b=fjNRp5gXJPpNf/efqEeWiCU8DY
 RQd5LnhQ2O/5mTOobIjrk/Uz05zP993y0JEGLtQBi9Pp+SO7tncMIvk8qPLFX9TgidQvIbOx6YR73
 y5H1Xd03aW1dyrlQEpeP0mOqGHWtcPMIOyCH1wXyesOVeq2hHT2dKMZNyscCRVWpxyXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=17wNcH2B0giT4cjrrr2RMxOqgSaclfg9v0Jiy7/Mm2k=; b=OBt+yzhOYdwqAqAGFroJwEc3Ip
 YjZEcWW4EAmXwcdw2CO31OA4hCPczeN06rl+eSZJlY7os8usatkZfv8Iky9M72dhC1Dkg10w5AABY
 ispvTWvemkunp0EuXyuFs+nDAHApWiZH+RfN0+/q3l+Ux/KPeyVyT6zmcHayG5LKrxiE=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXws8-0004Ir-25 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=17
 wNcH2B0giT4cjrrr2RMxOqgSaclfg9v0Jiy7/Mm2k=; b=Poi5Qs7BkkYsg9w5MX
 RuMGuJpqhQiT8BbWsMU+/FWhwhUx1Y0yrznDuxzNlA4GBI/1fPfHHXsczJt+ASJ7
 attNTvdEweGUiP70hpwKGPcT2N4zVHYYkycxBP6CwBki1cSpsVWIBjFFcfbhDp58
 TQ/ewXHNeAKhHLYJcebvMKiG4=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDX_ytWvStqyXqrBQ--.43664S3; 
 Fri, 12 Jun 2026 16:03:37 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 16:03:26 +0800
Message-Id: <20260612080334.70657-2-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
References: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDX_ytWvStqyXqrBQ--.43664S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4fKr45uw45CrW3CF4DJwb_yoW3trWUpr
 Z5Grn8trWrXr17W3W7JF1rZr1Skr97Xa1UAFWxG34fX3Wav3WrWF1kt34jqF43JrykZFna
 ya1rCr1rWF4YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5-B_UUUUU=
X-Originating-IP: [223.104.43.40]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRnqumorvVmwWQAA30
X-Headers-End: 1wXws8-0004Ir-25
Subject: [f2fs-dev] [RFC PATCH 1/9] f2fs: extend folio state for large folio
 write path
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe <zhaonanzhe@xiaomi.com>

Large folio write path needs a subpage status bitmap and write
pages pending counter, while keeping compatible with f2fs private
flags.

Move struct f2fs_folio_state to f2fs.h, add private_flags and
subpage state bitmap, and change PAGE_PRIVATE functions to be
compatible with f2fs_folio_state. Allocate f2fs_folio_state via kzalloc
instead of kmem_cache, since the state size depends on the folio order.

Note: Now if a path wants to use f2fs_folio_state, it must call
`folio_has_ffs` instead of `folio_test_large`` to make check.

Signed-off-by: Nanzhe <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/compress.c |  2 ++
 fs/f2fs/data.c     | 45 +++++++++++++++----------------
 fs/f2fs/f2fs.h     | 66 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 80 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index caf522d667d6..dc042b7546e9 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -76,6 +76,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
 {
 	if (!folio->private)
 		return false;
+	if (folio_has_ffs(folio))
+		return false;
 	if (folio_test_f2fs_nonpointer(folio))
 		return false;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9c6440a7db0e..9daded9fd16a 100644
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
@@ -2486,15 +2480,30 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
 {
-	struct f2fs_folio_state *ffs = folio->private;
+	struct f2fs_folio_state *ffs;
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned long private_flags = 0;
+
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
 
-	if (ffs)
-		return ffs;
+	if (folio_has_ffs(folio))
+		return (struct f2fs_folio_state *)folio->private;
 
-	ffs = f2fs_kmem_cache_alloc(ffs_entry_slab,
-			GFP_NOIO | __GFP_ZERO, true, NULL);
+	if (folio_test_private(folio) && folio_test_f2fs_nonpointer(folio))
+		private_flags = (unsigned long)folio->private;
+
+	ffs = kzalloc(struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
+			GFP_NOIO | __GFP_NOFAIL);
 
 	spin_lock_init(&ffs->state_lock);
+	ffs->private_flags = private_flags;
+	if (folio_test_uptodate(folio))
+		bitmap_set(ffs->state, 0, nr_subpages);
+	if (folio_test_dirty(folio))
+		bitmap_set(ffs->state, nr_subpages, nr_subpages);
+
+	if (folio_test_private(folio))
+		folio_detach_private(folio);
 	folio_attach_private(folio, ffs);
 	return ffs;
 }
@@ -2503,7 +2512,7 @@ static void ffs_detach_free(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 
-	if (!folio_test_large(folio)) {
+	if (!folio_has_ffs(folio)) {
 		folio_detach_private(folio);
 		return;
 	}
@@ -2513,7 +2522,8 @@ static void ffs_detach_free(struct folio *folio)
 		return;
 
 	WARN_ON_ONCE(ffs->read_pages_pending != 0);
-	kmem_cache_free(ffs_entry_slab, ffs);
+	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
+	kfree(ffs);
 }
 
 static int f2fs_read_data_large_folio(struct inode *inode,
@@ -4532,21 +4542,12 @@ int __init f2fs_init_bio_entry_cache(void)
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
index fffb516b78f4..feedba139f4d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1620,6 +1620,15 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
  */
+
+struct f2fs_folio_state {
+	spinlock_t		state_lock;
+	unsigned int		read_pages_pending;
+	atomic_t		write_pages_pending;
+	unsigned long		private_flags;
+	unsigned long		state[];
+};
+
 enum {
 	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
@@ -1629,6 +1638,14 @@ enum {
 	PAGE_PRIVATE_MAX
 };
 
+static inline bool folio_has_ffs(const struct folio *folio)
+{
+	unsigned long private = (unsigned long)folio->private;
+
+	return folio_test_large(folio) && private &&
+		!(private & BIT(PAGE_PRIVATE_NOT_POINTER));
+}
+
 /* For compression */
 enum compress_algorithm_type {
 	COMPRESS_LZO,
@@ -2636,9 +2653,15 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 {									\
-	unsigned long priv = (unsigned long)folio->private;		\
+	unsigned long priv;						\
 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
 			     (1UL << PAGE_PRIVATE_##flagname);		\
+	if (folio_has_ffs(folio)) {					\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		priv = ffs->private_flags;				\
+	} else {							\
+		priv = (unsigned long)folio->private;			\
+	}								\
 	return (priv & v) == v;						\
 }									\
 static inline bool page_private_##name(struct page *page) \
@@ -2653,7 +2676,10 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
 {									\
 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
 			     (1UL << PAGE_PRIVATE_##flagname);		\
-	if (!folio->private)						\
+	if (folio_has_ffs(folio)) {					\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		ffs->private_flags |= v;				\
+	} else if (!folio->private)					\
 		folio_attach_private(folio, (void *)v);			\
 	else {								\
 		v |= (unsigned long)folio->private;			\
@@ -2671,13 +2697,18 @@ static inline void set_page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void folio_clear_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (unsigned long)folio->private;		\
+	if (folio_has_ffs(folio)) {					\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		ffs->private_flags &= ~(1UL << PAGE_PRIVATE_##flagname); \
+	} else {							\
+		unsigned long v = (unsigned long)folio->private;	\
 									\
-	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
-	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
-		folio_detach_private(folio);				\
-	else								\
-		folio->private = (void *)v;				\
+		v &= ~(1UL << PAGE_PRIVATE_##flagname);		\
+		if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))	\
+			folio_detach_private(folio);			\
+		else							\
+			folio->private = (void *)v;			\
+	}								\
 }									\
 static inline void clear_page_private_##name(struct page *page) \
 { \
@@ -2703,7 +2734,15 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long folio_get_f2fs_data(struct folio *folio)
 {
-	unsigned long data = (unsigned long)folio->private;
+	unsigned long data;
+
+	if (folio_has_ffs(folio)) {
+		struct f2fs_folio_state *ffs = folio->private;
+
+		data = ffs->private_flags;
+	} else {
+		data = (unsigned long)folio->private;
+	}
 
 	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
 		return 0;
@@ -2714,10 +2753,15 @@ static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
 {
 	data = (1UL << PAGE_PRIVATE_NOT_POINTER) | (data << PAGE_PRIVATE_MAX);
 
-	if (!folio_test_private(folio))
+	if (folio_has_ffs(folio)) {
+		struct f2fs_folio_state *ffs = folio->private;
+
+		ffs->private_flags |= data;
+	} else if (!folio_test_private(folio)) {
 		folio_attach_private(folio, (void *)data);
-	else
+	} else {
 		folio->private = (void *)((unsigned long)folio->private | data);
+	}
 }
 
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
