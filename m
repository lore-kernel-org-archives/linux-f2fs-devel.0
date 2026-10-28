Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F760A6F65
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S8pVWWGf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b+TL3H1z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KF4D0ivm;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FarlQBlQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=+FtyQVsl2rKPx3UNiZurtbcKoiUCbqFPvWv2cqj8uLY=; b=S8pVWWGffCROK9qC3Pc13sR18w
	0/Vth8lRjeJwqBcZKBWU1Gpnwey0zWen4WNlvb001++qerQwa+sxlx128FDJbGjvM4VvaPOh2ewDu
	kf8Zd5UpOWZF4l/BfIAzD8w9bZSZ9ThaMpAj9rOlN1dxzL99z4rOU4fK1j39KyS9neG4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pH-000000002j3-2fnr;
	Wed, 28 Oct 2026 15:44:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pF-000000002is-1XLJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8fjzAlkHQ+spZ9OJDYnZxfXyBlmpj3vSy9ru7UJT1o=; b=b+TL3H1zMVq/5Xt6tU67CDqRVE
 un8POromLsHDXnRSma1b4QvGYIO+e0zezW+Z10GsihRzcetGgINh9ulj+T+9/DMDzguUMjUnUAtJK
 HA1w0/xrY0VDTuY7XRXNtf4aYs01Q9WRjgHJkhNoajtTpsD8w3VJxGN+CyaoUJlc7Nd8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8fjzAlkHQ+spZ9OJDYnZxfXyBlmpj3vSy9ru7UJT1o=; b=KF4D0ivm65Hjb15IDyvK7stTqA
 ylKMpmW4dWSOQkt9mknF+hIUp6yk55oVHt23KaDhGN2rFsP4pd16H/Y4Ii+oEM8pMhdhNHuPIlYE4
 GxI4pLDW0Nn/k0Do80f4BZibFl40WM8sDUYgpusZCWmSlwp/2AABRISYix2buNshkkVU=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pE-000000002Lb-2LM1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:29 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e651c30dcbso3648085ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202263; x=1793807063; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X8fjzAlkHQ+spZ9OJDYnZxfXyBlmpj3vSy9ru7UJT1o=;
 b=FarlQBlQ5GH/A64WzX8l3Yzkh3VR1UlZoaZnSeqZ42SW0NDHhSRZVxTv48Ty+URPW4
 vTt+ncAQqmIDXSUuES4qO65m/9PmMdJbEq8gcC+p/I+JTzmEQSCzCd1JM/BrwFYZvSWs
 QZkW5Vntc7zwML1+2W/HKL+/yC37r4gDrzNopX8xgcLHUWSLSt65PIrgC6eulPaXncVo
 ydFFFcTLXW3VpKKxtOSohBY9kzlvngG4ACgz+LiPdHW7ZsEIYNBFuzol6EyrLZsir23t
 JlMVR9qs7ylaWUfO/a2EDzWawzHllOoe9a7dvV5aKPPcCvZuqhVeNb0al9wjTkESWeYx
 ywKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202263; x=1793807063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X8fjzAlkHQ+spZ9OJDYnZxfXyBlmpj3vSy9ru7UJT1o=;
 b=Aho0tXjsnCKy5sp2w8wZd4Ok5k90KJZNPtBierT+tFBblha1EcVIrKecVKXT8hvu5U
 MXbQ2iputRm520bmuJgC8mAkn720Khkow9cmW5m1YPMYY3ri2QQqMIQWW7gKdPFziMBG
 UoD9jBuVTdikINj3KhICjHJ+lFQa9Dhp8/bz9tO2FwlnOcSzKJkXlm0ngPo3K6UYWmkE
 ucVXIoz5CEChcYYfmS5MdTNoHm+lq8kNjywlZ3Pef+O/VKYY3/FuyG3E41UDevAO4SrS
 dQGqsM8QYSPTztjrc0SMFqrcYRU77z/yStc8CCGnOoe+VgnaFNV7sxnVhV0TBEzqfss6
 ezGg==
X-Gm-Message-State: AFq9FYL7Y4xLNEpNIGgoliCW6WLtkhB1T3eJ/YWGaWP9GIFtnWMe5Y8L
 Lie6gZTLHrHZT54iMKS0lZ2dJS1uEtwl98XMvEAvhq7kD8mYG8TehX5CI9OQiDGPAjk=
X-Gm-Gg: AYBFou0itx7/XZvPdWssRW1KlSeZEk8aCilPzfyjERZBqx83IK5nJByAOUxj3odtzIL
 dMq46KwdY4ldxtzCUX5IivCz18FtnZnR/VVTx28Qix0AdCs07GJYLkhYFsxB0w0zta7sM5lwlmy
 +wwC1ctbNOgHKQeUhpQ/h9D8K96qN8W/7jD2HfW41sn+PzoB9sN8pA75VBFGtLYmT9lsNoWbrcg
 JpdyQSseEc3NcER1OL9XPZbcU3zAP0/5YT65yjHYn+GSEtbHZGYTdmJBmIheiEy5dIfgCSHXqLd
 Nt0YkZDtDXmwhQpGBuNwOcBK26bA12tdFZfp6E8yy4c84mMYACtX+3wG30eatL8LwT82AZBj+Ug
 nlXOobtot1vFg5WaOQAsy+M0XMGpGDzPJyFGmgLf3sFrbVVJzl1/shB1wIePpBDlrv2fSJKZ3kS
 pi08UFGpOSybRh2OQQbzKWdcXSoxVAt+lZRIaiov9WEhBC/ZJwJe/KJikn4XhyYpMIvGCwGDMeK
 GlByo0Rdm3Pu1W2nnIJjPz7/oskiw7CMhse+gv/CK1CVufabN+ziLlVDMbIhR8wmU3sXEbQH6La
 Oi80MVGTpFPUXCfkSBoHt2TCgRqIMalylg56lBRMY7aigxqc5z6BkX4p91BJ7MgJpRNB
X-Received: by 2002:a17:902:d4c4:b0:2e6:4e5:b399 with SMTP id
 d9443c01a7336-2eb003763c3mr26501805ad.26.1793202262780; 
 Wed, 28 Oct 2026 08:44:22 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:44:22 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:43:52 +0800
Message-ID: <20261028154407.1601430-2-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pE-000000002Lb-2LM1
Subject: [f2fs-dev] [PATCH v8 01/15] f2fs: extend folio state for large
 folio write path
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 fs/f2fs/data.c | 72 ++++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h | 81 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 110 insertions(+), 43 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a8d39add5cbe..603a7a570f2a 100644
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
@@ -1656,7 +1650,25 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 
 	/* wait for read completion */
 	folio_lock(folio);
-	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
+
+	if (unlikely(folio->mapping != mapping)) {
+		f2fs_folio_put(folio, true);
+		return ERR_PTR(-EIO);
+	}
+
+	/*
+	 * ffs can be released while the folio was unlocked above.  Rebuild it
+	 * for a fully uptodate folio; a partially uptodate one cannot be
+	 * rebuilt and will fail the uptodate check below.
+	 */
+	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
+		if (!f2fs_ffs_find_or_alloc(folio)) {
+			f2fs_folio_put(folio, true);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	if (unlikely(!folio_test_uptodate(folio))) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
@@ -2717,17 +2729,31 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
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
@@ -2736,7 +2762,7 @@ static void ffs_detach_free(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 
-	if (!folio_test_large(folio)) {
+	if (!f2fs_folio_has_ffs(folio)) {
 		folio_detach_private(folio);
 		return;
 	}
@@ -2746,7 +2772,8 @@ static void ffs_detach_free(struct folio *folio)
 		return;
 
 	WARN_ON_ONCE(ffs->read_pages_pending != 0);
-	kmem_cache_free(ffs_entry_slab, ffs);
+	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
+	kfree(ffs);
 }
 
 static int f2fs_read_data_large_folio(struct inode *inode,
@@ -2835,7 +2862,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -4750,21 +4781,12 @@ int __init f2fs_init_bio_entry_cache(void)
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
index aedba8b79baa..116c36a37f30 100644
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
@@ -2419,6 +2431,24 @@ do {							\
 		f2fs_fault_report(sbi->sb, REPORT_FAULT_NEED_FSCK, __func__, __LINE__);	\
 } while (0)
 
+static inline bool f2fs_folio_has_ffs(const struct folio *folio)
+{
+	unsigned long private = (unsigned long)folio->private;
+
+	if (!folio_test_large(folio) || !private)
+		return false;
+
+	/*
+	 * A large folio should always carry f2fs_folio_state rather than
+	 * non-pointer private flags at its folio->private.
+	 */
+	if (unlikely(test_bit(PAGE_PRIVATE_NOT_POINTER, &private))) {
+		f2fs_bug_on(F2FS_F_SB(folio), 1);
+		return false;
+	}
+	return true;
+}
+
 static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
 	clear_bit(type, &sbi->s_flag);
@@ -2759,13 +2789,35 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
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
@@ -2777,14 +2829,10 @@ static inline bool page_private_##name(struct page *page) \
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
@@ -2797,13 +2845,10 @@ static inline void set_page_private_##name(struct page *page) \
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
@@ -2826,7 +2871,7 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
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
