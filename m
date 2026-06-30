Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722AFC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eObSOBwYaKcgi1rVa9Qbu7p3Gek6VNvnUrTr/QnP7A=; b=emXc4KUw+2EB+xh6urpBiHjA3L
	a1+ulrKAy81PIXEZhUXdNlhoDLfn4m62yOyaLvaKvZNAPXylRbCOZ32g0QG76AD5M2hNYTzD8lb75
	IX6FtGRXGWDlLVEdXQzNfwrbu5AeQ0ugGft/abZvtmUhmDQHXRzV/nb0Qz+B3jV7b/eY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weT2q-0001Mw-LX;
	Tue, 30 Jun 2026 07:38:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weT2p-0001Mh-AW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x1jC54PzF/F4uOMvoowBaR3ySGT8vXIPNFJPlFN4gUQ=; b=GRyHgWgmxjtXbp7OzM3CbhseL8
 N+1q/FZ2PxyXKkWA2Cr/kw3/80aA8H4WMEsrN5xAltnU9kyOajF3fhWF7VQhYDcv2jvzvfpbnsdfK
 1ClttjOtq4qmbk9bNuRzetcMuL+A1HBnUYwjDgrSrUxdoKO1HKLdcBrTddbuEOZIu0+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x1jC54PzF/F4uOMvoowBaR3ySGT8vXIPNFJPlFN4gUQ=; b=LnOBML96AeYCyPlPCxUkI5iLi6
 09fhZgrXtvk6aW2iYaC++u4MYp1nEA9Ay75OWJ9Lh7clPzgeHZ+CnOkyypRY/WJ90ectE52sp/KlI
 UzvIPziiwdEDSx9sFmQe0MydDTEzPF4wHM5Q8TZuUS60mJAkS8NImtMixaRySP2WSGvM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weT2m-0005xU-Iv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:38:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A811E40B7E;
 Tue, 30 Jun 2026 07:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18021F000E9;
 Tue, 30 Jun 2026 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782805083;
 bh=x1jC54PzF/F4uOMvoowBaR3ySGT8vXIPNFJPlFN4gUQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZaepFvs+UVbbEk4YlHhPZ5UiDbHudsXpDC0tHPNqHlLUdR+bHZUDmiUptBA53zom8
 QrbYBrWtG5h2diO3ovfK6Faq4FrwRs4GZ/2p3Lz1PZy2eAq7DTwqY5rMYQEaqYNP++
 kjmMa4bnqJgFVDh6T/bEp3d/4m/daY35htIoQIUx6KzmPOmAOcDVu0+T2xo9P9Qzuf
 wND8az0HW+ok+eom3a+Jfs+XTnJffl9N/cyHOIaq3b1x+3aoTN0hkzvftqtlmLG6tc
 YiVgdp+lUwN0xBGVQMbO1QYEUHoVS/sE9MBx8pvfGHm22hACpPkRHlzLHRHDMMHB3h
 yNKgTIbGlDuGg==
Message-ID: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
Date: Tue, 30 Jun 2026 15:37:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
 <20260622160830.324455-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260622160830.324455-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1weT2m-0005xU-Iv
Subject: Re: [f2fs-dev] [RFC PATCH v2 01/10] f2fs: extend folio state for
 large folio write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/23/26 00:08, Nanzhe Zhao wrote:
> Large folio write path needs a subpage status bitmap and write
> pages pending counter, while keeping compatible with f2fs private
> flags.
> 
> Move struct f2fs_folio_state to f2fs.h, add private_flags and
> subpage state bitmap, and change PAGE_PRIVATE functions to be
> compatible with f2fs_folio_state. Allocate f2fs_folio_state via kzalloc
> instead of kmem_cache, since the state size depends on the folio order.
> 
> Note: Now if a path wants to use f2fs_folio_state, it must call
> `folio_has_ffs` instead of `folio_test_large`` to make check.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/compress.c |  2 ++
>  fs/f2fs/data.c     | 46 ++++++++++++++++----------------
>  fs/f2fs/f2fs.h     | 66 ++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 80 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 91855d91bbdd..de1305fcc6c1 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -76,6 +76,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
>  {
>  	if (!folio->private)
>  		return false;
> +	if (folio_has_ffs(folio))
> +		return false;
>  	if (folio_test_f2fs_nonpointer(folio))
>  		return false;

private is a pointer for compressed page, so it will be better to
check folio_test_f2fs_nonpointer() first, and then folio_has_ffs().

if (folio_test_f2fs_nonpointer(folio))
	return false;
if (folio_has_ffs(folio))
	return false;

>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ac1cf4de3d62..23758c00758d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -32,20 +32,13 @@
>  
>  static struct kmem_cache *bio_post_read_ctx_cache;
>  static struct kmem_cache *bio_entry_slab;
> -static struct kmem_cache *ffs_entry_slab;
>  static mempool_t *bio_post_read_ctx_pool;
>  static struct bio_set f2fs_bioset;
>  
> -struct f2fs_folio_state {
> -	spinlock_t		state_lock;
> -	unsigned int		read_pages_pending;
> -};
> -
>  struct f2fs_bio {
>  	struct work_struct work;
>  	struct bio bio;
>  };
> -
>  #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
>  
>  int __init f2fs_init_bioset(void)
> @@ -2514,15 +2507,30 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  
>  static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
>  {
> -	struct f2fs_folio_state *ffs = folio->private;
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +	unsigned long private_flags = 0;
>  
> -	if (ffs)
> -		return ffs;
> +	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
>  
> -	ffs = f2fs_kmem_cache_alloc(ffs_entry_slab,
> -			GFP_NOIO | __GFP_ZERO, true, NULL);
> +	if (folio_has_ffs(folio))
> +		return (struct f2fs_folio_state *)folio->private;
> +
> +	if (folio_test_private(folio) && folio_test_f2fs_nonpointer(folio))

Why this can happen? allocating large folio from other paths?

> +		private_flags = (unsigned long)folio->private;
> +
> +	ffs = kzalloc(struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
> +			GFP_NOIO | __GFP_NOFAIL);
>  
>  	spin_lock_init(&ffs->state_lock);
> +	ffs->private_flags = private_flags;
> +	if (folio_test_uptodate(folio))
> +		bitmap_set(ffs->state, 0, nr_subpages);
> +	if (folio_test_dirty(folio))
> +		bitmap_set(ffs->state, nr_subpages, nr_subpages);

Can you describe ffs->state layout in its definition?

> +
> +	if (folio_test_private(folio))
> +		folio_detach_private(folio);
>  	folio_attach_private(folio, ffs);
>  	return ffs;
>  }
> @@ -2531,7 +2539,7 @@ static void ffs_detach_free(struct folio *folio)
>  {
>  	struct f2fs_folio_state *ffs;
>  
> -	if (!folio_test_large(folio)) {
> +	if (!folio_has_ffs(folio)) {
>  		folio_detach_private(folio);
>  		return;
>  	}
> @@ -2541,7 +2549,8 @@ static void ffs_detach_free(struct folio *folio)
>  		return;
>  
>  	WARN_ON_ONCE(ffs->read_pages_pending != 0);
> -	kmem_cache_free(ffs_entry_slab, ffs);
> +	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
> +	kfree(ffs);
>  }
>  
>  static int f2fs_read_data_large_folio(struct inode *inode,
> @@ -4571,21 +4580,12 @@ int __init f2fs_init_bio_entry_cache(void)
>  	if (!bio_entry_slab)
>  		return -ENOMEM;
>  
> -	ffs_entry_slab = f2fs_kmem_cache_create("f2fs_ffs_slab",
> -			sizeof(struct f2fs_folio_state));
> -
> -	if (!ffs_entry_slab) {
> -		kmem_cache_destroy(bio_entry_slab);
> -		return -ENOMEM;
> -	}
> -
>  	return 0;
>  }
>  
>  void f2fs_destroy_bio_entry_cache(void)
>  {
>  	kmem_cache_destroy(bio_entry_slab);
> -	kmem_cache_destroy(ffs_entry_slab);
>  }
>  
>  static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1774d4e18d2..e4778c17394e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1620,6 +1620,15 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
>   * Layout B: lowest bit should be 0
>   * page.private is a wrapped pointer.
>   */
> +
> +struct f2fs_folio_state {
> +	spinlock_t		state_lock;
> +	unsigned int		read_pages_pending;
> +	atomic_t		write_pages_pending;
> +	unsigned long		private_flags;
> +	unsigned long		state[];
> +};
> +
>  enum {
>  	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
>  	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
> @@ -1629,6 +1638,14 @@ enum {
>  	PAGE_PRIVATE_MAX
>  };
>  
> +static inline bool folio_has_ffs(const struct folio *folio)
> +{
> +	unsigned long private = (unsigned long)folio->private;
> +
> +	return folio_test_large(folio) && private &&
> +		!(private & BIT(PAGE_PRIVATE_NOT_POINTER));
> +}
> +
>  /* For compression */
>  enum compress_algorithm_type {
>  	COMPRESS_LZO,
> @@ -2638,9 +2655,15 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
>  static inline bool folio_test_f2fs_##name(const struct folio *folio)	\

Seems there are redundant codes below, let's have a try to wrap them w/ a macro for cleanup?

>  {									\
> -	unsigned long priv = (unsigned long)folio->private;		\
> +	unsigned long priv;						\
>  	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
>  			     (1UL << PAGE_PRIVATE_##flagname);		\
> +	if (folio_has_ffs(folio)) {					\
> +		struct f2fs_folio_state *ffs = folio->private;		\
> +		priv = ffs->private_flags;				\
> +	} else {							\
> +		priv = (unsigned long)folio->private;			\
> +	}								\
>  	return (priv & v) == v;						\
>  }									\
>  static inline bool page_private_##name(struct page *page) \
> @@ -2655,7 +2678,10 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  {									\
>  	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
>  			     (1UL << PAGE_PRIVATE_##flagname);		\
> -	if (!folio->private)						\
> +	if (folio_has_ffs(folio)) {					\
> +		struct f2fs_folio_state *ffs = folio->private;		\
> +		ffs->private_flags |= v;				\
> +	} else if (!folio->private)					\
>  		folio_attach_private(folio, (void *)v);			\

Ditto?

>  	else {								\
>  		v |= (unsigned long)folio->private;			\
> @@ -2673,13 +2699,18 @@ static inline void set_page_private_##name(struct page *page) \
>  #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
>  static inline void folio_clear_f2fs_##name(struct folio *folio)		\
>  {									\
> -	unsigned long v = (unsigned long)folio->private;		\
> +	if (folio_has_ffs(folio)) {					\
> +		struct f2fs_folio_state *ffs = folio->private;		\
> +		ffs->private_flags &= ~(1UL << PAGE_PRIVATE_##flagname); \
> +	} else {							\
> +		unsigned long v = (unsigned long)folio->private;	\
>  									\
> -	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
> -	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
> -		folio_detach_private(folio);				\
> -	else								\
> -		folio->private = (void *)v;				\
> +		v &= ~(1UL << PAGE_PRIVATE_##flagname);		\
> +		if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))	\
> +			folio_detach_private(folio);			\
> +		else							\
> +			folio->private = (void *)v;			\
> +	}								\
>  }									\
>  static inline void clear_page_private_##name(struct page *page) \
>  { \
> @@ -2705,7 +2736,15 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
>  
>  static inline unsigned long folio_get_f2fs_data(struct folio *folio)
>  {
> -	unsigned long data = (unsigned long)folio->private;
> +	unsigned long data;
> +
> +	if (folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +
> +		data = ffs->private_flags;
> +	} else {
> +		data = (unsigned long)folio->private;
> +	}

Ditto?

>  
>  	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
>  		return 0;
> @@ -2716,10 +2755,15 @@ static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
>  {
>  	data = (1UL << PAGE_PRIVATE_NOT_POINTER) | (data << PAGE_PRIVATE_MAX);
>  
> -	if (!folio_test_private(folio))
> +	if (folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +
> +		ffs->private_flags |= data;
> +	} else if (!folio_test_private(folio)) {
>  		folio_attach_private(folio, (void *)data);

Ditto?

Thanks,

> -	else
> +	} else {
>  		folio->private = (void *)((unsigned long)folio->private | data);
> +	}
>  }
>  
>  static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
