Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432A4C5AE5D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uqg7yzafD0N5lYq3rIh2gcRfxO83Ggeak2nwRL8/JU4=; b=gb4a9EnoIeFsYKIpjS4uWzFhrC
	GY/bwgLdBfnnBt8sWl7erY2Pi8CHCYKzKqzucumszqVUOWKAn6PrzAl6pOn/wjJWJmaxUmHxBbMY3
	RFXnVCvzPii5VrdVaZtFf42Bgk2lrTn4Ook4chiDDFQkH0/pJCy12jdzTtnIGSvRjPI4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtNhS-0004W9-4K;
	Mon, 10 Aug 2026 10:57:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wtNhQ-0004W2-8i
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 10:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=evQZ0QBvfnZQ55OKOqMXlq84jQBALaOZA6w84yFv36I=; b=XtdCGScheCuNpjKBju9/Ounm0X
 264MZm+FLgF6AMQiRubjcnrS7JWfseNtXnDk9ByUBr72lx5ROXtbsnSnjrY82Q4kxHA6YBIqUVckI
 OuAEK1FojEzBlAH9sCDDbopXcisH/wIku0VopPeobJms38kszyLiPj+LRQX+cezzgyco=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=evQZ0QBvfnZQ55OKOqMXlq84jQBALaOZA6w84yFv36I=; b=Bv0beRTcESiqHcp0etZnqRgIPR
 hVWMCU5ekNoqygCjyeYWglyY8cvwWx2BJV1DMGaAPI5L3ULtdA+knJsuUwlmfXEwPu15efbqbgPzK
 +b4hfL+THcsjKmrG4jEm19JJLB5qNnrJek7YOnpthsh+yM6x3ltPfOZ82StmXT8XxUGg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtNhT-0007CU-R9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 10:57:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B325D43A49;
 Mon, 10 Aug 2026 10:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6501F00A3D;
 Mon, 10 Aug 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786359458;
 bh=evQZ0QBvfnZQ55OKOqMXlq84jQBALaOZA6w84yFv36I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hvpoEMh52cuo/1S06wtVjrLA5YAe/QrjH8i1zDsro/w7gJldb3yzJMtmh6ANl2pMn
 lp53jtZgt5kUajBCmSLru28GtY3hipZCeXJBTtUVVZS5y/XQGs7iLiHwKn2Qua2V0J
 0CBq+qLV7JsOKb1iS67oLo3DmVKQ29nzzSz9jtiuh542/f6WCvYgnPB6kUnK6QjOL5
 q3T2iARjWXs2HQpzt6yhYR8d9tVYCKfMEDMNm/QkTvrFjXZrxlgG00RYh4GvykNVfn
 sB78E3i6+aIeKcIvbL4TctgK1/iIU1HsoJp+09KFr9dxEjBSEA4rMoSPelEcSYI022
 b8TxK+fJBd9FQ==
Date: Mon, 10 Aug 2026 12:57:33 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <anmrNOVcXRsZenqj@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-15-aalbersh@kernel.org>
 <20260804181848.GM3556460@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804181848.GM3556460@frogsfrogsfrogs>
X-Headers-End: 1wtNhT-0007CU-R9
Subject: Re: [f2fs-dev] [PATCH v14 14/21] xfs: add flags to
 xfs_free_eofblocks() to pass down to block processing
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-04 11:18:48, Darrick J. Wong wrote:
> On Mon, Aug 03, 2026 at 10:08:04PM +0200, Andrey Albershteyn wrote:
> > Add a flags parameter to xfs_free_eofblocks() to support selective
> > extent unmapping. Add two flags for unmapping all extents (unwritten and
> > normal) and fsverity leftover extents (only unwritten ones, leaving
> > normal in place).
> 
> Er, why do we need this?  Is this to clear out unwritten merkle tree
> blocks after a failed fsverity enrollment or something?  The commit
> message should say a little bit more about why anyone needs this.

Ok sure I will extend the message

> 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_bmap.c | 56 +++++++++++++++++++++++++++++-----------
> >  fs/xfs/libxfs/xfs_bmap.h |  6 ++++-
> >  fs/xfs/xfs_bmap_util.c   | 20 ++++++++++----
> >  fs/xfs/xfs_bmap_util.h   | 13 +++++++++-
> >  fs/xfs/xfs_file.c        |  2 +-
> >  fs/xfs/xfs_icache.c      |  2 +-
> >  fs/xfs/xfs_inode.c       |  2 +-
> >  7 files changed, 76 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index cc48f6e20e80..1d8d157a9dfa 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -6144,15 +6144,12 @@ xfs_bmap_validate_extent(
> >  			XFS_IS_REALTIME_INODE(ip), whichfork, irec);
> >  }
> >  
> > -/*
> > - * Used in xfs_itruncate_extents().  This is the maximum number of extents
> > - * freed from a file in a single transaction.
> > - */
> > -#define	XFS_ITRUNC_MAX_EXTENTS	2
> > -
> >  /*
> >   * Unmap every extent in part of an inode's fork.  We don't do any higher level
> >   * invalidation work at all.
> > + *
> > + * The XFS_BMAPI_UNWRITTEN could be passed to remove only unwritten extents,
> > + * leaving out normal extents in place.
> 
> What flags do we support here?  ATTRFORK, NODISCARD, and UNWRITTEN?  Can
> that be documented in the comment or turned into asserts?

The xfs_bmapi_read has read_flags and ASSERT inside, the other flags
are then passed to xfs_bunmapi which probably be a better place for
an assert.

> 
> >   */
> >  int
> >  xfs_bunmapi_range(
> > @@ -6162,23 +6159,52 @@ xfs_bunmapi_range(
> >  	xfs_fileoff_t		startoff,
> >  	xfs_fileoff_t		endoff)
> >  {
> > -	xfs_filblks_t		unmap_len = endoff - startoff + 1;
> >  	int			error = 0;
> > +	int			nimaps = 1;
> > +	int			done = 0;
> > +	struct xfs_bmbt_irec	imap;
> > +	int			read_flags =
> > +			flags & (XFS_BMAPI_ATTRFORK | XFS_BMAPI_ENTIRE);
> 
> Why BMAPI_ENTIRE?
> 

These two flags is what xfs_bmapi_read() takes (assert inside).

> > +	xfs_exntst_t		exntst = XFS_EXT_NORM;
> >  
> >  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> >  
> > -	while (unmap_len > 0) {
> > -		ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> > -		error = __xfs_bunmapi(*tpp, ip, startoff, &unmap_len, flags,
> > -				XFS_ITRUNC_MAX_EXTENTS);
> > +	if (flags & XFS_BMAPI_UNWRITTEN)
> > +		exntst = XFS_EXT_UNWRITTEN;
> > +
> > +	while (startoff < endoff) {
> > +		nimaps = 1;
> > +
> > +		error = xfs_bmapi_read(ip, startoff, endoff - startoff + 1,
> > +				&imap, &nimaps, read_flags);
> >  		if (error)
> >  			goto out;
> >  
> > -		/* free the just unmapped extents */
> > -		error = xfs_defer_finish(tpp);
> > -		if (error)
> > +		if (nimaps == 0)
> >  			goto out;
> > -		cond_resched();
> > +
> > +		if ((exntst == XFS_EXT_UNWRITTEN) &&
> > +				(imap.br_state != exntst)) {
> 
> No need for parentheses around these condition checks.
> 
> Would it be clearer if this was:
> 
> 		/* caller only wants to unmap unwritten extents */
> 		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> 		    imap.br_state != XFS_EXT_UNWRITTEN) {
> 			...
> 		}

Thanks, sure will change it

> 
> > +			startoff = imap.br_startoff + imap.br_blockcount;
> > +			continue;
> > +		}
> > +
> > +		done = 0;
> > +		while (!done) {
> > +			ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> > +			error = xfs_bunmapi(*tpp, ip, imap.br_startoff,
> > +					imap.br_blockcount, flags, 0, &done);
> > +			if (error)
> > +				goto out;
> > +
> > +			/* free the just unmapped extent */
> > +			error = xfs_defer_finish(tpp);
> > +			if (error)
> > +				goto out;
> > +			cond_resched();
> > +		}
> > +
> > +		startoff = imap.br_startoff + imap.br_blockcount;
> >  	}
> >  out:
> >  	return error;
> > diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> > index d5f2729305fa..0f36431d9936 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.h
> > +++ b/fs/xfs/libxfs/xfs_bmap.h
> > @@ -90,6 +90,9 @@ struct xfs_bmalloca {
> >  /* Try to align allocations to the extent size hint */
> >  #define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> >  
> > +/* Process unwritten extents only. Used for unmapping */
> > +#define XFS_BMAPI_UNWRITTEN	(1u << 12)
> > +
> >  #define XFS_BMAPI_FLAGS \
> >  	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
> >  	{ XFS_BMAPI_METADATA,	"METADATA" }, \
> > @@ -102,7 +105,8 @@ struct xfs_bmalloca {
> >  	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
> >  	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
> >  	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
> > -	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
> > +	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }, \
> > +	{ XFS_BMAPI_UNWRITTEN,	"UNWRITTEN" }
> >  
> >  
> >  static inline int xfs_bmapi_aflag(int w)
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index c88b9ade7389..6323eac48fc8 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -574,11 +574,13 @@ xfs_can_free_eofblocks(
> >   */
> >  int
> >  xfs_free_eofblocks(
> > -	struct xfs_inode	*ip)
> > +	struct xfs_inode	*ip,
> > +	int			flags)
> >  {
> >  	struct xfs_trans	*tp;
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	int			error;
> > +	int			bmapi_flags = XFS_BMAPI_NODISCARD;
> >  
> >  	/* Attach the dquots to the inode up front. */
> >  	error = xfs_qm_dqattach(ip);
> > @@ -593,15 +595,20 @@ xfs_free_eofblocks(
> >  	 *
> >  	 * Note that this means we also leave speculative preallocations in
> >  	 * place for preallocated files.
> > +	 *
> > +	 * Clean up delalloc reservations for fsverity too as those won't be
> > +	 * used
> >  	 */
> > -	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
> > +	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
> > +			(flags & XFS_FREE_FSVERITY)) {
> 
> Oh, this patch keeps going after adding new flags to xfs_bunmapi.
> 
> Uh, this part should be a separate patch then.

Ok, sure, I will split it

> 
> >  		if (ip->i_delayed_blks) {
> >  			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
> >  				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
> >  				LLONG_MAX, NULL);
> >  		}
> >  		xfs_inode_clear_eofblocks_tag(ip);
> > -		return 0;
> > +		if (!(flags & XFS_FREE_FSVERITY))
> > +			return 0;
> >  	}
> >  
> >  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > @@ -613,6 +620,9 @@ xfs_free_eofblocks(
> >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> >  	xfs_trans_ijoin(tp, ip, 0);
> >  
> > +	if (flags & XFS_FREE_FSVERITY)
> > +		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> > +
> >  	/*
> >  	 * Do not update the on-disk file size.  If we update the on-disk file
> >  	 * size and then the system crashes before the contents of the file are
> > @@ -620,7 +630,7 @@ xfs_free_eofblocks(
> >  	 * bug).
> >  	 */
> >  	error = xfs_itruncate_extents_flags(&tp, ip, XFS_DATA_FORK,
> > -				XFS_ISIZE(ip), XFS_BMAPI_NODISCARD);
> > +				XFS_ISIZE(ip), bmapi_flags);
> >  	if (error)
> >  		goto err_cancel;
> >  
> > @@ -928,7 +938,7 @@ xfs_prepare_shift(
> >  	 * into the accessible region of the file.
> >  	 */
> >  	if (xfs_can_free_eofblocks(ip)) {
> > -		error = xfs_free_eofblocks(ip);
> > +		error = xfs_free_eofblocks(ip, XFS_FREE_ALL);
> >  		if (error)
> >  			return error;
> >  	}
> > diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
> > index eaaf094154b9..9ea3000466cc 100644
> > --- a/fs/xfs/xfs_bmap_util.h
> > +++ b/fs/xfs/xfs_bmap_util.h
> > @@ -64,9 +64,20 @@ int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
> >  int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
> >  		xfs_off_t len);
> >  
> > +/*
> > + * Remove all extents and reservations beyond EOF
> > + */
> > +#define XFS_FREE_ALL		0
> > +
> > +/*
> > + * Do the normal post EOF cleaning except don't remove normal extents, in other
> > + * words, remove unwritten, delayed allocation and cow reservations
> 
> IOWs it preserves written blocks storing a merkle tree?

yes

> 
> > + */
> > +#define XFS_FREE_FSVERITY	1
> 
> /me wonders if this should be XFS_FREE_EOF_{ALL,PRESERVE_MERKLE} ?
> 
> Also, can we decide this from the XFS_DIFLAG2_VERITY state?

I suppose we can, then these XFS_FREE_* flags aren't necessary

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
