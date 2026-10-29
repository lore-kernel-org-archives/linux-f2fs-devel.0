Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD08606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d7A6Bxaw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SuevnwWQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aZ/nkkzy;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuoJ1K9f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wwVI1HG5JQpKWtwhqN3jDFNRvUyvnk/iZZMMTHtfn0c=; b=d7A6BxawVsixSVIHGs9pedKAk5
	rEAhQ6Z5dG34bDxED7Qy2hY8QTyPhqV3EcM2SxT/UCLQcgpHETWQW7tD5ugBOAyuLtKRsQdouqhKO
	hVI+Ayj0ktQWhEmc49SvkPQjpF7c1ArtZFIa0khtzMtcJAi5EjX/cYi/NfpPxKJQiRgE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMRtL-000000005iz-2UYi;
	Thu, 29 Oct 2026 15:18:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xMRtC-000000005in-1gvn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ge93C1RewWf+EmgQPjq99nIgRg5xPU6pKnukx22zcKc=; b=SuevnwWQCzOuNJ4eLbibLG7jqF
 uA6Tskhske2QIQzDdPz1B9BbgZxKcfKjz6OgD83Qn7YKAWZy+SJxy5EXenw9IJ0rYaqApL0IzZvNd
 9w2cvWK0U6jS5vWyzmyRJZXBG36R1q83V2ivuzL908F1HyheXYEsIYILju0jsVZNuHEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ge93C1RewWf+EmgQPjq99nIgRg5xPU6pKnukx22zcKc=; b=aZ/nkkzyMW/Dlj70Y6cyAFUJI3
 GOA/UFsFpEfA8pYfQLX5lDGFyyQMykSR709+Zgtr+XPoDZgtHWvnSTygOnRaJqu1ZkXObMgRuh8gr
 XFeM7SpUdDgsNm7p9ufV73diZvQpHPUHGH+Dsk6/iBdvCJoizQuW+2lnzZtlq7rsxOx0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMRtA-000000005oG-3qPd
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:18:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BAC240059;
 Thu, 29 Oct 2026 15:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A31F01825;
 Thu, 29 Oct 2026 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793287075;
 bh=Ge93C1RewWf+EmgQPjq99nIgRg5xPU6pKnukx22zcKc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MuoJ1K9f8LXP1eAxsLkwtMSGbYRUXNgpQqPqnYTKEJCsIWYVARl+4YvAcYiGfX0ND
 T2ulwsD10UnQaj3xsocr5Qw5QbCpBU97BvAreu7rrwdNl1f5M+v6akalZvwEyfgCDs
 qOpF+uHRk63eIi4bPcBzn+zqEGWqQKRq/ySh6/5RtRSXUluYFbdjwgANmnPengykA2
 34wmrvQ8bCU/p27bhINFpSk/cz2dvXcBVGJxOjSZJLbzCgAwLC/IqAIACw7XvBlxGx
 aQDszx2Az76Qnq8LKDHq+kIAmyckLwCGXwMAAddbczkCJsvtDsWPzRnWBrkk9snH8g
 U+tqLhukqAEqg==
Date: Thu, 29 Oct 2026 15:17:53 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <auNjoREIU-cHswyw@google.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-16-nzzhao.sigma@gmail.com>
 <54cbfb8a-c87e-4fea-9448-175706e22ac2@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54cbfb8a-c87e-4fea-9448-175706e22ac2@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMRtA-000000005oG-3qPd
Subject: Re: [f2fs-dev] [PATCH v8 15/15] f2fs: make compressed files
 compatible with large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ok, I applied all including the below change in dev-test. Please take a look.

On 10/29, Chao Yu via Linux-f2fs-devel wrote:
> On 10/28/26 23:44, Nanzhe Zhao wrote:
> > From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> > 
> > The compression flag is the hint indicates that the inode can be
> > compressed, when the inode is using large folio, we expected it keeps
> > using the large folio read/write paths and its data stays uncompressed
> > on disk until the inode is evicted and re-read
> > 
> > Let f2fs_write_begin() skip the compression overwrite preparation for
> > such inodes and remove the compressed-file gate in
> > f2fs_read_data_large_folio() so the data is simply read/written as
> > regular blocks.
> > 
> > For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
> > once the inode mapping is switched to large folios.
> > 
> > Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> > ---
> >  Documentation/filesystems/f2fs.rst | 10 ++++++++
> >  fs/f2fs/compress.c                 |  2 ++
> >  fs/f2fs/data.c                     |  9 ++-----
> >  fs/f2fs/file.c                     | 38 ++++++++++++++++++++++++++++++
> >  4 files changed, 52 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > index 55798421f2c4..b79bb67ee78e 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -942,6 +942,16 @@ Compression implementation
> >    reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
> >    truncated to zero.
> >  
> > +- Compression and large folios are not effective at the same time on a file:
> > +  a compressed inode does not use large folios, while an inode which is
> > +  using large folios keeps its data uncompressed on disk.  If the compression
> > +  flag is set on an inode that is already using large folios, the flag works
> > +  as a hint until the inode is evicted: the inode keeps using the large folio
> > +  read/write paths, f2fs_write_begin() skips the compression overwrite
> > +  preparation, and ioctl(F2FS_IOC_COMPRESS_FILE) fails with -EOPNOTSUPP.
> > +  Once the inode is evicted and read back, it uses order-0 folios again and
> > +  compression is applied as usual.
> > +
> >  Compress metadata layout::
> >  
> >  				[Dnode Structure]
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 162bd8ef822a..721b01dd0d24 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
> >  		return false;
> >  	if (folio_test_f2fs_nonpointer(folio))
> >  		return false;
> > +	if (f2fs_folio_has_ffs(folio))
> > +		return false;
> >  
> >  	f2fs_bug_on(F2FS_F_SB(folio),
> >  		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index cc3c9e51db9c..ab8f5b44d63a 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3288,12 +3288,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
> >  	int ret = 0;
> >  	bool folio_in_bio = false;
> >  
> > -	if (f2fs_compressed_file(inode)) {
> > -		if (folio)
> > -			folio_unlock(folio);
> > -		return -EOPNOTSUPP;
> > -	}
> > -
> >  	map.m_seg_type = NO_CHECK_TYPE;
> >  
> >  	if (rac)
> > @@ -5331,7 +5325,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
> >  	}
> >  
> >  #ifdef CONFIG_F2FS_FS_COMPRESSION
> > -	if (f2fs_compressed_file(inode)) {
> > +	if (f2fs_compressed_file(inode) &&
> > +	    !mapping_large_folio_support(inode->i_mapping)) {
> >  		int ret;
> >  		struct page *page;
> >  
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 15bea642e986..cb7a9d4227f4 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4907,6 +4907,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
> >  	struct address_space *mapping = inode->i_mapping;
> >  	struct folio *folio;
> >  	pgoff_t redirty_idx = page_idx;
> > +	pgoff_t end_idx = page_idx + len;
> >  	int page_len = 0, ret = 0;
> >  
> >  	filemap_invalidate_lock_shared(mapping);
> > @@ -4924,6 +4925,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
> >  	} while (page_len < len);
> >  
> >  	while (redirty_idx < page_idx) {
> > +		pgoff_t next_idx;
> > +		size_t off, dlen;
> > +
> >  		folio = filemap_lock_folio(mapping, redirty_idx);
> >  
> >  		/* It will never fail, when folio has pinned above */
> > @@ -4931,6 +4935,33 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
> >  
> >  		f2fs_folio_wait_writeback(folio, true, true);
> >  
> > +		/*
> > +		 * Only this cluster is rewritten, while a large folio can
> > +		 * cover more than one cluster, so mark the intersection of
> > +		 * the folio and [redirty_idx, end_idx).
> > +		 */
> > +		next_idx = min_t(pgoff_t, folio_next_index(folio), end_idx);
> > +		off = offset_in_folio(folio, (loff_t)redirty_idx << PAGE_SHIFT);
> > +		dlen = (size_t)(next_idx - redirty_idx) << PAGE_SHIFT;
> > +
> > +		if (folio_test_large(folio)) {
> > +			/*
> > +			 * A compressed inode can keep using large folios, in
> > +			 * which case the compression flag only works as a hint
> > +			 * until the inode is evicted.  Update the subpage dirty
> > +			 * bitmap as well, otherwise f2fs_write_cache_folios()
> > +			 * finds no dirty range and skips the whole folio.
> > +			 */
> > +			if (!f2fs_ffs_find_or_alloc(folio)) {
> > +				ret = -ENOMEM;
> > +				folio_unlock(folio);
> > +				folio_put_refs(folio, 2);
> > +				redirty_idx = folio_next_index(folio);
> 
> Jaegeuk, Nanzhe,
> 
> I missed this potential UAF, please fix this.
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 162b7f7aa6d4..3de67522beef 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4941,16 +4941,14 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>                          */
>                         if (!f2fs_ffs_find_or_alloc(folio)) {
>                                 ret = -ENOMEM;
> -                               folio_unlock(folio);
> -                               folio_put_refs(folio, 2);
> -                               redirty_idx = folio_next_index(folio);
> -                               continue;
> +                               goto next;
>                         }
>                         f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
>                 }
> 
>                 folio_mark_dirty(folio);
>                 folio_set_f2fs_gcing(folio);
> +next:
>                 redirty_idx = folio_next_index(folio);
>                 folio_unlock(folio);
>                 folio_put_refs(folio, 2);
> 
> Thanks,
> 
> > +				continue;
> > +			}
> > +			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
> > +		}
> > +
> >  		folio_mark_dirty(folio);
> >  		folio_set_f2fs_gcing(folio);
> >  		redirty_idx = folio_next_index(folio);
> > @@ -5037,6 +5068,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
> >  	if (!(filp->f_mode & FMODE_WRITE))
> >  		return -EBADF;
> >  
> > +	/*
> > +	 * The mapping is already using large folios, where the data is kept
> > +	 * uncompressed, so refuse to start compressing the file.
> > +	 */
> > +	if (mapping_large_folio_support(inode->i_mapping))
> > +		return -EOPNOTSUPP;
> > +
> >  	f2fs_balance_fs(sbi, true);
> >  
> >  	ret = mnt_want_write_file(filp);
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
