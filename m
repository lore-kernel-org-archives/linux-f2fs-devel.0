Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4466C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKjEdLMRT9MzQRrX5LeLzEHs7arS3RGD2z7tPGg5080=; b=fCbpu5jyZWwLyShnZbMTSSGdDx
	M9+awHOOiU8ZO47qcWvpmXnPm1b9kek0ARf8YhmcuD1SSl1s+lHStDqzTbvwP/ogllg1avrcIhj5T
	Y9+cLpW4d1DYJW1jwAQt3sjcCfg7vxpNa+kGhnOBJy2oVdu8gn6HFH7TlthNXVHpnAFE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzU3o-0005Pw-Hm;
	Thu, 27 Aug 2026 06:58:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzU3n-0005Pp-CR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 06:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6RUNKVZP1/EjGzftBQcXeoA1qtMHIenz5b7FvyuTo1I=; b=F+CsviVmHP0kaFB4BsWQa3/nG8
 KgujsZ5U9aJ0p860u65MI2D1Fe4//YQBktiEesgcXMdAU6iJMiODpbK53a/gCeMcoHPjndsUUEHzq
 TK1GNmSfTfk/WGOfqJo2dWR1gYssylri74a9LwaTHZ4bPQa4GNlakoN5NgPlL2h26BQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6RUNKVZP1/EjGzftBQcXeoA1qtMHIenz5b7FvyuTo1I=; b=L1BsGNdTeryBeVxgz0MYOSD9/3
 uRCiVOVRYyH+effm0MZjcoYmULPElmIYa2Mwkat/qCb3icC/z1uXTNqcAqdWVZfcWi9pM+P4jl17y
 n+cnLd8UtNDHUimd+Dcc2RozS8q/MDo38FXUf5PmFjENTb/ibXetC4VviaPO+A+4Aqv0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzU3m-00049H-Ip for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 06:58:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEB7D600D0;
 Thu, 27 Aug 2026 06:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ED91F000E9;
 Thu, 27 Aug 2026 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787813876;
 bh=6RUNKVZP1/EjGzftBQcXeoA1qtMHIenz5b7FvyuTo1I=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VCDyxhTgEz3ib8XrhYPmsl8BZQblg6TBt97bEaO/+3JWvIvdQBGoHUFckxMIxC7G7
 Lddjm/8gsBWc4A5i1PNNLpzzYOyae84L0meKKyRJiRgyaE6N2VunC0QUoQHIzbKsUP
 qYZZJRgiiE8euZwf2mwQmOaoAxr1cFLgXThej9/mHup6PDS0QNzTdpkfiUAu1il/B4
 MV3gE0/3byy8Sksn2GgHUMCD8UvYRAL4pDgHItjOPcL3H5cS2RmmcrhjxeMgs3wtKy
 dnuP1aCJenON3qGB/HgvCceIzciNurUMNH/rFtWAtnwodAMagyYdFifg1P5kBnA7c2
 zlLwi3v6wOvDA==
Message-ID: <22b18f2e-70f5-4292-b83e-8f6c374a627d@kernel.org>
Date: Thu, 27 Aug 2026 14:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wzU3m-00049H-Ip
Subject: Re: [f2fs-dev] [PATCH 01/14] f2fs: extend folio state for large
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 16:26, Nanzhe Zhao wrote:
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
>  fs/f2fs/compress.c |  2 +
>  fs/f2fs/data.c     | 60 ++++++++++++++++--------------
>  fs/f2fs/f2fs.h     | 92 ++++++++++++++++++++++++++++++++++++----------
>  fs/f2fs/segment.c  |  2 +-
>  4 files changed, 108 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 91855d91bbdd..84da3e39efb4 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
>  		return false;
>  	if (folio_test_f2fs_nonpointer(folio))
>  		return false;
> +	if (f2fs_folio_has_ffs(folio))
> +		return false;

Shouldn't this be changed in "f2fs: make compressed files compatible with
large folio" or other patch? I guess in this patch we only introduce new
ffs facilities.

>  
>  	f2fs_bug_on(F2FS_F_SB(folio),
>  		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6ae0eb37d20f..578a90d427e2 100644
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

Unnecessary change.

>  #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
>  
>  int __init f2fs_init_bioset(void)
> @@ -133,6 +126,9 @@ struct bio_post_read_ctx {
>  	block_t fs_blkaddr;
>  };
>  
> +static bool __ffs_mark_subrange_uptodate(struct folio *folio,
> +		struct f2fs_folio_state *ffs, size_t offset, size_t len);
> +
>  /*
>   * Update and unlock a bio's pages, and free the bio.
>   *
> @@ -155,7 +151,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> -		unsigned nr_pages = fi.length >> PAGE_SHIFT;
> +		unsigned int nr_pages = fi.length >> PAGE_SHIFT;

No need to change in this patch?

>  		bool finished = true;
>  
>  		if (!folio_test_large(folio) &&
> @@ -360,6 +356,7 @@ static void f2fs_write_end_bio(struct bio *bio)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> +		unsigned int nr_pages = fi.length >> PAGE_SHIFT;

No need to change in this patch?

>  		enum count_type type;
>  
>  		if (fscrypt_is_bounce_folio(folio)) {
> @@ -2516,17 +2513,32 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  }
>  #endif
>  
> -static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
> +struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
>  {
> -	struct f2fs_folio_state *ffs = folio->private;
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +	unsigned long private_flags = 0;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
>  
> -	if (ffs)
> -		return ffs;
> +	if (f2fs_folio_has_ffs(folio))
> +		return (struct f2fs_folio_state *)folio->private;
>  
> -	ffs = f2fs_kmem_cache_alloc(ffs_entry_slab,
> -			GFP_NOIO | __GFP_ZERO, true, NULL);
> +	if (folio_test_private(folio) && folio_test_f2fs_nonpointer(folio))
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
> +
> +	if (folio_test_private(folio))
> +		folio_detach_private(folio);
>  	folio_attach_private(folio, ffs);
>  	return ffs;
>  }
> @@ -2535,7 +2547,7 @@ static void ffs_detach_free(struct folio *folio)
>  {
>  	struct f2fs_folio_state *ffs;
>  
> -	if (!folio_test_large(folio)) {
> +	if (!f2fs_folio_has_ffs(folio)) {
>  		folio_detach_private(folio);
>  		return;
>  	}
> @@ -2545,7 +2557,8 @@ static void ffs_detach_free(struct folio *folio)
>  		return;
>  
>  	WARN_ON_ONCE(ffs->read_pages_pending != 0);
> -	kmem_cache_free(ffs_entry_slab, ffs);
> +	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
> +	kfree(ffs);
>  }
>  
>  static int f2fs_read_data_large_folio(struct inode *inode,
> @@ -2558,7 +2571,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	pgoff_t index, offset, next_pgofs = 0;
>  	unsigned max_nr_pages = rac ? readahead_count(rac) :
>  				folio_nr_pages(folio);
> -	unsigned nrpages;
> +	unsigned int nrpages, len_blks;
>  	struct f2fs_folio_state *ffs;
>  	int ret = 0;
>  	bool folio_in_bio = false;
> @@ -2634,7 +2647,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * to prevent from premature folio_end_read() call on folio
>  		 */
>  		if (folio_test_large(folio)) {
> -			ffs = ffs_find_or_alloc(folio);
> +			ffs = f2fs_ffs_find_or_alloc(folio);
>  
>  			/* set the bitmap to wait */
>  			spin_lock_irq(&ffs->state_lock);
> @@ -2987,7 +3000,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return true;
>  
>  	if (fio) {
> -		if (page_private_gcing(fio->page))
> +		if (folio_test_f2fs_gcing(fio->folio))

Shouldn't this be changed in "f2fs: make GC migration large-folio aware"?

>  			return true;
>  		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>  			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
> @@ -4586,21 +4599,12 @@ int __init f2fs_init_bio_entry_cache(void)
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
> index 16720f1f0a9c..2e8f85cea6d0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1628,6 +1628,18 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
>   * Layout B: lowest bit should be 0
>   * page.private is a wrapped pointer.
>   */
> +
> +struct f2fs_folio_state {
> +	spinlock_t		state_lock;
> +	unsigned int		read_pages_pending;
> +	atomic_t		write_pages_pending;
> +	unsigned long		private_flags;
> +	/* state[0..nr_subpages - 1] tracks uptodate subpages.
> +	 * state[nr_subpages..2 * nr_subpages - 1] tracks dirty subpages.
> +	 */
> +	unsigned long		state[];
> +};
> +
>  enum {
>  	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
>  	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
> @@ -1637,6 +1649,14 @@ enum {
>  	PAGE_PRIVATE_MAX
>  };
>  
> +static inline bool f2fs_folio_has_ffs(const struct folio *folio)
> +{
> +	unsigned long private = (unsigned long)folio->private;
> +
> +	return folio_test_large(folio) && private &&
> +		!(private & BIT(PAGE_PRIVATE_NOT_POINTER));

Is this a bug? in which case we will set PAGE_PRIVATE_NOT_POINTER in
a large folio? maybe I missed some cases...

folio_test_large(folio) && private is true and
(private & BIT(PAGE_PRIVATE_NOT_POINTER) is true?

> +}
> +
>  /* For compression */
>  enum compress_algorithm_type {
>  	COMPRESS_LZO,
> @@ -2682,10 +2702,57 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  	return -ENOSPC;
>  }
>  
> +static inline unsigned long f2fs_folio_get_private_flags(const struct folio *folio)
> +{
> +	if (f2fs_folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +
> +		return ffs->private_flags;
> +	}
> +
> +	return (unsigned long)folio->private;
> +}
> +
> +static inline void f2fs_folio_set_private_flags(struct folio *folio,
> +						unsigned long flags)
> +{
> +	if (f2fs_folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +
> +		ffs->private_flags |= flags;
> +		return;
> +	}
> +
> +	if (!folio_test_private(folio))
> +		folio_attach_private(folio, (void *)flags);
> +	else
> +		folio->private = (void *)((unsigned long)folio->private | flags);
> +}
> +
> +static inline void f2fs_folio_clear_private_flags(struct folio *folio,
> +						 unsigned long flags)
> +{
> +	unsigned long private;
> +
> +	if (f2fs_folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +
> +		ffs->private_flags &= ~flags;
> +		return;
> +	}
> +
> +	private = (unsigned long)folio->private;
> +	private &= ~flags;
> +	if (private == BIT(PAGE_PRIVATE_NOT_POINTER))
> +		folio_detach_private(folio);
> +	else
> +		folio->private = (void *)private;
> +}
> +
>  #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
>  static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>  {									\
> -	unsigned long priv = (unsigned long)folio->private;		\
> +	unsigned long priv = f2fs_folio_get_private_flags(folio);		\
>  	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
>  			     (1UL << PAGE_PRIVATE_##flagname);		\
>  	return (priv & v) == v;						\
> @@ -2702,12 +2769,7 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  {									\
>  	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
>  			     (1UL << PAGE_PRIVATE_##flagname);		\
> -	if (!folio->private)						\
> -		folio_attach_private(folio, (void *)v);			\
> -	else {								\
> -		v |= (unsigned long)folio->private;			\
> -		folio->private = (void *)v;				\
> -	}								\
> +	f2fs_folio_set_private_flags(folio, v);				\
>  }									\
>  static inline void set_page_private_##name(struct page *page) \
>  { \
> @@ -2720,13 +2782,8 @@ static inline void set_page_private_##name(struct page *page) \
>  #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
>  static inline void folio_clear_f2fs_##name(struct folio *folio)		\
>  {									\
> -	unsigned long v = (unsigned long)folio->private;		\
> -									\
> -	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
> -	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
> -		folio_detach_private(folio);				\
> -	else								\
> -		folio->private = (void *)v;				\
> +	f2fs_folio_clear_private_flags(folio,				\
> +			1UL << PAGE_PRIVATE_##flagname);			\
>  }									\
>  static inline void clear_page_private_##name(struct page *page) \
>  { \
> @@ -2752,7 +2809,7 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
>  
>  static inline unsigned long folio_get_f2fs_data(struct folio *folio)
>  {
> -	unsigned long data = (unsigned long)folio->private;
> +	unsigned long data = f2fs_folio_get_private_flags(folio);
>  
>  	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
>  		return 0;
> @@ -2763,10 +2820,7 @@ static inline void folio_set_f2fs_data(struct folio *folio, unsigned long data)
>  {
>  	data = (1UL << PAGE_PRIVATE_NOT_POINTER) | (data << PAGE_PRIVATE_MAX);
>  
> -	if (!folio_test_private(folio))
> -		folio_attach_private(folio, (void *)data);
> -	else
> -		folio->private = (void *)((unsigned long)folio->private | data);
> +	f2fs_folio_set_private_flags(folio, data);
>  }
>  
>  static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ed6f2947210b..df10119d94ad 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3803,7 +3803,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
>  			return CURSEG_COLD_DATA_PINNED;
>  
> -		if (page_private_gcing(fio->page)) {
> +		if (folio_test_f2fs_gcing(fio->folio)) {

Shouldn't this be changed in "f2fs: make GC migration large-folio aware"?

Thanks,

>  			if (fio->sbi->am.atgc_enabled &&
>  				(fio->io_type == FS_DATA_IO) &&
>  				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
