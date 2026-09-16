Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972B6C88E5C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AzT8fO8Xbaxzz7KAQtL5BGB/OhHpo6myCdMWjRfQHW0=; b=IhdmNu3ICe0Iml53dYgOxLXxaX
	lbibTpcMqCcfL0WoXJGoVOik9t/SM7X+2EeXZ6DjZJKz62nAGbsWcyWY4soYvEwacYXcbpQU49xBq
	fgtO2oTacBTFbD2UnPgkEs5IyFNXQOvSyRYTMyVvnxpZjuaZjd6rGq6DABP+DfdRTcBU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6mKY-0000wN-VF;
	Wed, 16 Sep 2026 09:53:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6mKX-0000wC-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oVtHS12aSYjr1jgyMmWQV/aQxb3KwkW02FDlSAlu2eA=; b=l2ejdexTR7BqR3qFVyTSwcIWL1
 X2WRySBGaW2+6DO4a05y25MUgO7/N9UMZJrR9OegoQvwDzXB3AkY4+gvoUVtOZrH5wyGHNuYrxnPV
 zYrxtFE1nVLADQG3Ln1CWzQfJ9EdyVSUqN+QVaZH/6nSUb7zlqfy0gZNM715NrX003cU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oVtHS12aSYjr1jgyMmWQV/aQxb3KwkW02FDlSAlu2eA=; b=JmX/xmqN+oYVZkPe9NfPuW1oMb
 BE8MsP03ztkj3ARYcy7728EqYZkyUzFaFud6JyXFVPNFLpqPAMtfSGnNzTw4cOlPVmsJqx+RYk85j
 ieCIFlZIiBWr79Uvo0JBtpwNQotFdvesylARplt6uYQ6yDMe/HFkv/xiClRwLTX2QRzY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6mKW-0007dt-Fw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:53:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB769602CC;
 Wed, 16 Sep 2026 09:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322041F000FF;
 Wed, 16 Sep 2026 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789552402;
 bh=oVtHS12aSYjr1jgyMmWQV/aQxb3KwkW02FDlSAlu2eA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DnrOtzrm/56/KACWOoSorzDB/MgTeIGjAotWVnWzuKP0xbRDhV7WN1GPcl+zsoqMo
 rVoTK67RsdxadaS2FCI44D6C91+ayvX0oSdbQ1zVVtw2ex1wO1yFQuBS+j88vR2HqC
 3hh3leYn5v7b4aX9vWOHbDH0DumpV/LflDPVvDkbmAbfy3o8B2GujCIbRyn2X0Lu2j
 k+Tf/5VikoiwdsrGRvngW/npj3EOnPoDm6V1PjzJ7PaSyOn4k5IAIeMCoPhubnE5B5
 IwWRMIZ9TRFAY2pkQ19h3yZ1GEzzAlTdbwFjT2LcDFSQ/kzQsznYQ4CcjH9vqOpby+
 FOlvBBeRg01rQ==
Message-ID: <27535bb7-35b1-49a1-bdd6-a6f750366f55@kernel.org>
Date: Wed, 16 Sep 2026 17:53:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x6mKW-0007dt-Fw
Subject: Re: [f2fs-dev] [PATCH v2 01/14] f2fs: extend folio state for large
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

On 9/15/26 12:18, Nanzhe Zhao wrote:
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
>  fs/f2fs/data.c | 72 ++++++++++++++++++++++++++++++++------------------
>  fs/f2fs/f2fs.h | 70 +++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 98 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a3b02c067e89..b3303109a696 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -32,15 +32,9 @@
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
> @@ -125,6 +119,9 @@ struct bio_post_read_ctx {
>  	block_t fs_blkaddr;
>  };
>  
> +static bool __ffs_mark_subrange_uptodate(struct folio *folio,
> +		struct f2fs_folio_state *ffs, size_t offset, size_t len);
> +
>  /*
>   * Update and unlock a bio's pages, and free the bio.
>   *
> @@ -139,6 +136,23 @@ struct bio_post_read_ctx {
>   * called (i.e., I/O error or decryption error, but *not* verity error), and
>   * release the bio's reference to the decompress_io_ctx of the page's cluster.
>   */
> +/*
> + * Update read_pages_pending.
> + */
> +static inline void f2fs_update_read_folio_pending(struct folio *folio, int nr)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned long flags;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	ffs->read_pages_pending += nr;
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +}
> +
>  static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  {
>  	struct folio_iter fi;
> @@ -147,7 +161,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> -		unsigned nr_pages = fi.length >> PAGE_SHIFT;
> +		unsigned int nr_pages = fi.length >> PAGE_SHIFT;

No needed? it's trivial though.

>  		bool finished = true;
>  
>  		if (!folio_test_large(folio) &&
> @@ -2487,17 +2501,31 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  }
>  #endif
>  
> -static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
> +struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
>  {
> -	struct f2fs_folio_state *ffs = folio->private;
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +	unsigned long private = (unsigned long)folio->private;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
> +	f2fs_bug_on(F2FS_F_SB(folio),
> +		    test_bit(PAGE_PRIVATE_NOT_POINTER, &private));
>  
> -	if (ffs)
> -		return ffs;
> +	if (f2fs_folio_has_ffs(folio))
> +		return (struct f2fs_folio_state *)folio->private;
>  
> -	ffs = f2fs_kmem_cache_alloc(ffs_entry_slab,
> -			GFP_NOIO | __GFP_ZERO, true, NULL);
> +	ffs = f2fs_kmalloc(F2FS_F_SB(folio),
> +			struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
> +			GFP_NOFS | __GFP_ZERO);
> +	if (!ffs)
> +		return NULL;
>  
>  	spin_lock_init(&ffs->state_lock);
> +	if (folio_test_uptodate(folio))
> +		bitmap_set(ffs->state, 0, nr_subpages);
> +	if (folio_test_dirty(folio))
> +		bitmap_set(ffs->state, nr_subpages, nr_subpages);
> +
>  	folio_attach_private(folio, ffs);
>  	return ffs;
>  }
> @@ -2506,7 +2534,7 @@ static void ffs_detach_free(struct folio *folio)
>  {
>  	struct f2fs_folio_state *ffs;
>  
> -	if (!folio_test_large(folio)) {
> +	if (!f2fs_folio_has_ffs(folio)) {
>  		folio_detach_private(folio);
>  		return;
>  	}
> @@ -2516,7 +2544,8 @@ static void ffs_detach_free(struct folio *folio)
>  		return;
>  
>  	WARN_ON_ONCE(ffs->read_pages_pending != 0);
> -	kmem_cache_free(ffs_entry_slab, ffs);
> +	WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending));
> +	kfree(ffs);
>  }
>  
>  static int f2fs_read_data_large_folio(struct inode *inode,
> @@ -2529,7 +2558,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	pgoff_t index, offset, next_pgofs = 0;
>  	unsigned max_nr_pages = rac ? readahead_count(rac) :
>  				folio_nr_pages(folio);
> -	unsigned nrpages;
> +	unsigned int nrpages;

No needed? it's trivial though.

>  	struct f2fs_folio_state *ffs;
>  	int ret = 0;
>  	bool folio_in_bio = false;
> @@ -2605,7 +2634,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * to prevent from premature folio_end_read() call on folio
>  		 */
>  		if (folio_test_large(folio)) {
> -			ffs = ffs_find_or_alloc(folio);
> +			ffs = f2fs_ffs_find_or_alloc(folio);

Do we need to handle no memory case?

Thanks,

>  
>  			/* set the bitmap to wait */
>  			spin_lock_irq(&ffs->state_lock);
> @@ -4522,21 +4551,12 @@ int __init f2fs_init_bio_entry_cache(void)
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
> index ebc621f302e1..9a2366a6c113 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1618,6 +1618,18 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
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
> @@ -1627,6 +1639,13 @@ enum {
>  	PAGE_PRIVATE_MAX
>  };
>  
> +static inline bool f2fs_folio_has_ffs(const struct folio *folio)
> +{
> +	unsigned long private = (unsigned long)folio->private;
> +
> +	return folio_test_large(folio) && private;
> +}
> +
>  /* For compression */
>  enum compress_algorithm_type {
>  	COMPRESS_LZO,
> @@ -2738,13 +2757,35 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  	return -ENOSPC;
>  }
>  
> +static inline unsigned long f2fs_folio_get_private_flags(const struct folio *folio)
> +{
> +	unsigned long private = (unsigned long)folio->private;
> +
> +	if (f2fs_folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = (struct f2fs_folio_state *)private;
> +
> +		return READ_ONCE(ffs->private_flags);
> +	}
> +
> +	if (test_bit(PAGE_PRIVATE_NOT_POINTER, &private))
> +		return private;
> +
> +	return 0;
> +}
> +
> +static inline unsigned long *f2fs_folio_flags_addr(struct folio *folio)
> +{
> +	if (f2fs_folio_has_ffs(folio))
> +		return &((struct f2fs_folio_state *)folio->private)->private_flags;
> +
> +	return (unsigned long *)&folio->private;
> +}
> +
>  #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
>  static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
>  {									\
> -	unsigned long priv = (unsigned long)folio->private;		\
> -	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
> -			     (1UL << PAGE_PRIVATE_##flagname);		\
> -	return (priv & v) == v;						\
> +	return f2fs_folio_get_private_flags(folio) &			\
> +				(1UL << PAGE_PRIVATE_##flagname);	\
>  }									\
>  static inline bool page_private_##name(struct page *page) \
>  { \
> @@ -2756,14 +2797,10 @@ static inline bool page_private_##name(struct page *page) \
>  #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
>  static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  {									\
> -	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
> -			     (1UL << PAGE_PRIVATE_##flagname);		\
>  	if (!folio->private)						\
> -		folio_attach_private(folio, (void *)v);			\
> -	else {								\
> -		v |= (unsigned long)folio->private;			\
> -		folio->private = (void *)v;				\
> -	}								\
> +		folio_attach_private(folio,				\
> +				(void *)BIT(PAGE_PRIVATE_NOT_POINTER));	\
> +	set_bit(PAGE_PRIVATE_##flagname, f2fs_folio_flags_addr(folio));	\
>  }									\
>  static inline void set_page_private_##name(struct page *page) \
>  { \
> @@ -2776,13 +2813,10 @@ static inline void set_page_private_##name(struct page *page) \
>  #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
>  static inline void folio_clear_f2fs_##name(struct folio *folio)		\
>  {									\
> -	unsigned long v = (unsigned long)folio->private;		\
> -									\
> -	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
> -	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
> +	clear_bit(PAGE_PRIVATE_##flagname,				\
> +		  f2fs_folio_flags_addr(folio));			\
> +	if (folio->private == (void *)BIT(PAGE_PRIVATE_NOT_POINTER))	\
>  		folio_detach_private(folio);				\
> -	else								\
> -		folio->private = (void *)v;				\
>  }									\
>  static inline void clear_page_private_##name(struct page *page) \
>  { \
> @@ -2808,7 +2842,7 @@ PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
>  
>  static inline unsigned long folio_get_f2fs_data(struct folio *folio)
>  {
> -	unsigned long data = (unsigned long)folio->private;
> +	unsigned long data = f2fs_folio_get_private_flags(folio);
>  
>  	if (!test_bit(PAGE_PRIVATE_NOT_POINTER, &data))
>  		return 0;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
