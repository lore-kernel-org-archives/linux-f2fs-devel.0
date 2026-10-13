Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDFCCC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCsXdbZG0NjwKNqWdG0YmPEP+VZY69QVQw4JRSIEf/U=; b=HNeDBYOZ1hUcFcnuEZEiKc1MTH
	e0nb0JQPzW06uAsIM7MsH1z63Yw/q3Xz2xbhD2P0yytce3CfflA/YmNG68q4nnH+uoE14WjiwlDBP
	lDDDuE0j1fxFetkgRuv+F7BfplpXtvArDYnmmIwHmME+IKKBcPA1JKjqZ+7vvURcs7Bc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb7q-0007jr-R3;
	Tue, 13 Oct 2026 11:56:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb7o-0007jg-Tj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fT98QeEusQPAtEV+tcJJOyyGh0DjLA2f//tdJ4ehWp8=; b=PvrnUeGyDxMTbbixZpXVkpZwxi
 9cyC5sXZ2raoY0ccqitYuwGeBOgkBy14TL9vt07MDWIw9QZQ4qYgigbNx8KMrnWLHLJIdYOjMBQNV
 TBLYFZnOtMYm4ifpfIPltSrxpVXAlrnrszGS0PCjr6eHR/vNdo+R8QiD3qxE205Wx8rM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fT98QeEusQPAtEV+tcJJOyyGh0DjLA2f//tdJ4ehWp8=; b=cdCU3iyuj4COcynO53LE9bRRGb
 Y01Y3KBCQPo1UtQxBMfTPezQlcanHK5BBDcvfjKTLK0YN6wcH61KG2w+6cruos9814HghmXuHu2P/
 EX8pkJIkNitnx5HRa4ftpFXmtlVPnpqf47IKzXhRig3Eny7a6c6WtRsrXeU9gJazOzLc=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb7i-0001T6-MW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:54 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1376213a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892605; x=1792497405; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fT98QeEusQPAtEV+tcJJOyyGh0DjLA2f//tdJ4ehWp8=;
 b=ctAkTAYkYwWADVEABhGB/OE+ucBEHeyfaCWulp5RdmAAJgADoRaq0AB7joMhwCJlWu
 qUCSggYS5PaeEyJ38VC2QXycn5yvAniIrvsD1SfEfQzvE3xAJcMnZu1zhSLw/BfN0q+g
 ivvveDSLzkhXY/pP1b3y3ZESfPdzYmFWM/XYt2HVH1jt+5dq5zNNb2DB1SZuqpvbHtTk
 jpqky1HlrOF/mjXzyIBj/dmdOgqbnibk+r4NcQx8AlJFT+aIhx4jXjie/cylITWMl0pk
 hkyF/sre5s9X0pHvlgac6ao1cqszhVCbGS1zhCEHWyFXv3FqUQfyanwUlCYFYEkWKDG5
 Z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892605; x=1792497405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fT98QeEusQPAtEV+tcJJOyyGh0DjLA2f//tdJ4ehWp8=;
 b=fftsrLfDRwUDJC3uIeLsCEHGv29UtSg3zEUJOYO2aIouhN8m85VUMoMBf7zmKJvJvw
 ZgaA6eOP48DM+gxlL1hmvhdbTcBiX0tXJE6Ef6erjkIfTMhczEthcEo/NK4ThCtlj+yX
 dsXyMmB0T1+qvgO4M8ilKxb7Ru8bhBwRnlu2H8TgQELKqSjx4PE8Bu6z6x0hBP9ykPYU
 WGpoiHmNY43UelfPn8pTm0pXxcSEfjNytQILA/a3b8jMq3iQdbaI1ZAdbvYezTaKM7hP
 IJjM1/wX6xK8fjN8oIm9vqTqpfxvfp8Fyjojf15GZEjOYJvBJ0+ttvYMQ59G5rfD6ASn
 pfcQ==
X-Gm-Message-State: AFq9FYIwrl+NfC+Jd8k8OKq1+D8Lsr/Shh9z8CX+F9WPOgj10rjqOG+y
 1UlXeipZTjMddqx7YHS1Bmt5XSScKaAfVpPx6jhV+p6jRZAxGX4hZCHmFq8G8XWLRno=
X-Gm-Gg: AYBFou2zFoksHqG1mMXXmLu385IYj/QvvFrh/zJizYsEFh62LlheAFRW/RmKqYYWM0D
 0LJFXgiPkYlz7kj9uFF/Egw3S1SRHaAZM3lxlfju7/W1Abz7iW6lAbhlP6s3vp4qGOtYXZZJ7Bp
 JU95gPKVyqAHFsMMvxdl28wbNkkTTmM76Xfm4EaIaRJ58HTwKEuLyVwszcuzKdsGbqL1LWoPekK
 6IEG/JY7J55yXhC5OLIdWPjyJRsZUTsRcKgjmPszTf1T53zZn/u6XKT96UekpcSwO7+zwdf9cA0
 Hyw/5xoXoL0E250k2BvVxXQKQjfps6iMybZb6+k7w0MfO+9mYNYQ3cpFVxyv7FZTJShQZRZ3TZI
 LA1MaQmNOYJ1Qoxug4w088L3ICLmP1to/4UK/vhATLXH1hk1A08rWy57AeO+lKWi0/hHXXNdH7M
 CuOTUMoX47Wn9dcsB3kzbVURUxkoqBO8rI0H3k49lct5xc1qD8aD6ZttlddzLdggHnUaYtr+blD
 mVQxNUJuhWK2cJeHT1OZezTZKYuCwkOLgYc
X-Received: by 2002:a17:90b:1d52:b0:3aa:fc22:8ab1 with SMTP id
 98e67ed59e1d1-3ab3a8a1ad5mr10676812a91.35.1791892604799; 
 Tue, 13 Oct 2026 04:56:44 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:56:44 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:06 +0800
Message-ID: <20261013115621.968742-4-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb7i-0001T6-MW
Subject: [f2fs-dev] [PATCH v4 03/18] f2fs: extend folio state for large
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
index f2d2f0106..29df36d93 100644
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
@@ -2703,17 +2697,31 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
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
+		    test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private));
 
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
@@ -2722,7 +2730,7 @@ static void ffs_detach_free(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 
-	if (!folio_test_large(folio)) {
+	if (!f2fs_folio_has_ffs(folio)) {
 		folio_detach_private(folio);
 		return;
 	}
@@ -2732,7 +2740,8 @@ static void ffs_detach_free(struct folio *folio)
 		return;
 
 	WARN_ON_ONCE(ffs->read_pages_pending != 0);
-	kmem_cache_free(ffs_entry_slab, ffs);
+	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
+	kfree(ffs);
 }
 
 static int f2fs_read_data_large_folio(struct inode *inode,
@@ -2821,7 +2830,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -4732,21 +4745,12 @@ int __init f2fs_init_bio_entry_cache(void)
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
index dd9b4e4a8..90da387f4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1618,6 +1618,18 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * Layout B: lowest bit should be 0
  * folio->private is a wrapped pointer.
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
 	F2FS_FOLIO_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
 	F2FS_FOLIO_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
@@ -1626,6 +1638,13 @@ enum {
 	F2FS_FOLIO_PRIVATE_MAX
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
@@ -2753,38 +2772,53 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
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
+	if (test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private))
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
 #define F2FS_FOLIO_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 {									\
-	unsigned long priv = (unsigned long)folio->private;		\
-	unsigned long v = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |	\
-			     (1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
-	return (priv & v) == v;						\
+	return f2fs_folio_get_private_flags(folio) &			\
+				(1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
 }
 
 #define F2FS_FOLIO_PRIVATE_SET_FUNC(name, flagname) \
 static inline void folio_set_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER) |	\
-			     (1UL << F2FS_FOLIO_PRIVATE_##flagname);	\
 	if (!folio->private)						\
-		folio_attach_private(folio, (void *)v);			\
-	else {								\
-		v |= (unsigned long)folio->private;			\
-		folio->private = (void *)v;				\
-	}								\
+		folio_attach_private(folio,				\
+				(void *)BIT(F2FS_FOLIO_PRIVATE_NOT_POINTER));	\
+	set_bit(F2FS_FOLIO_PRIVATE_##flagname, f2fs_folio_flags_addr(folio));	\
 }
 
 #define F2FS_FOLIO_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void folio_clear_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (unsigned long)folio->private;		\
-									\
-	v &= ~(1UL << F2FS_FOLIO_PRIVATE_##flagname);			\
-	if (v == (1UL << F2FS_FOLIO_PRIVATE_NOT_POINTER))		\
+	clear_bit(F2FS_FOLIO_PRIVATE_##flagname,				\
+		  f2fs_folio_flags_addr(folio));			\
+	if (folio->private == (void *)BIT(F2FS_FOLIO_PRIVATE_NOT_POINTER))	\
 		folio_detach_private(folio);				\
-	else								\
-		folio->private = (void *)v;				\
 }
 
 F2FS_FOLIO_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
@@ -2801,7 +2835,7 @@ F2FS_FOLIO_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
 static inline unsigned long folio_get_f2fs_data(struct folio *folio)
 {
-	unsigned long data = (unsigned long)folio->private;
+	unsigned long data = f2fs_folio_get_private_flags(folio);
 
 	if (!test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &data))
 		return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
