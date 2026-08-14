Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6086C5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CENQZ/b6Ndc9cVOsGPN6t+qPTmqOaOnHS3o48wjIDZw=; b=WOuPn5HLXSDydFJXQlDTZ7/4Jy
	P6I4iV3LJ970tN9t8VOAe1/hOnWxq1Y7qHaaE/nYjmG+Jzyvm9kLeagwFKTuoVSbapF4CafW2nv8t
	VZHmmirUZECnHF1ZRzC8andzJzD8xRmcRl+aTTh9AU4UiZOVtSxoRGfc5iUM9p/o0hGw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuth4-0000gD-Pu;
	Fri, 14 Aug 2026 15:19:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wuth2-0000g3-M6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0klogLjyyrJ7xYZT2XeSv/GSN01RIwWoJwmz22NNlKY=; b=iMs8DZLpubBrjdEHw8ohoaHfcQ
 68U/cTHq+Gyz0Wj3cfo4v+uCPpc5K8J0RRUXYth7cUOzzyoqWSgnCUyg/NWAdQaFS6/7f8o1VfQ6B
 RHdoEUY3pBm0MLLOTAt46dyJxwMf5/3vS5QEf1LfWLdpiUAremH34+az9mf53v99jYGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0klogLjyyrJ7xYZT2XeSv/GSN01RIwWoJwmz22NNlKY=; b=Zc8WUcXa7PtJjeSkw3UtQHRbUr
 sE0H28M8DlWY8keNa+msHESRF5YfmsAdMPRsvgmHLIdlceTmLKfrwLuaa72LDWdCrNIxdml6mYHDQ
 C/83HYcOj8/RP+csvc0j+31WK4pBwFWoTRC0LTkNEQypP8Tjg221Yj5bauflgCjkjviU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuth1-0004OZ-QK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:19:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 6A2FA40D92;
 Fri, 14 Aug 2026 15:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3CBF01F000E9;
 Fri, 14 Aug 2026 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720770;
 bh=0klogLjyyrJ7xYZT2XeSv/GSN01RIwWoJwmz22NNlKY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Sh6Ix6p8w0rMY21l/SyGhDH/Puiq3KCD2ZfqRtXlwaGKVe6mzlRjCAHUhwv2CbZSF
 gzTExqrBONIkQS0VqKcDbn/v5Uq9qR1dZsaaGWz+H1CbqcVlW2/bIFDRhUr6v0febU
 oDlzCW2QCbye8SdY7FhtKp6nk+DofT/YnjdAOntIlEW62h07hjCttKo00tEvILyd7q
 aayX+e8EXQS9E4WypU/Peskdb/uQTtLVWZ5Ti6nSF9HZ2fWHt+r0NpFkI0SyFR4kxh
 BVdlsVK8QglbY3yG2ZuijNh7PjXezokYiIS3BCeT7TQeQ63mVKl51d/g6uKpkiefMd
 xVswMRUtWLDSA==
Date: Fri, 14 Aug 2026 08:19:29 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260814151929.GH3556460@frogsfrogsfrogs>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260814092448.1818082-19-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-19-aalbersh@kernel.org>
X-Headers-End: 1wuth1-0004OZ-QK
Subject: Re: [f2fs-dev] [PATCH v15 18/25] xfs: make xfs_free_eofblocks()
 work with fsverity inodes
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, fsverity@lists.linux.dev,
 linux-ext4@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 14, 2026 at 11:24:35AM +0200, Andrey Albershteyn wrote:
> xfs_free_eofblocks() removes any preallocations and unwritten extents
> beyond EOF. This is undesired for fsverity as it stores metadata beyond
> EOF. However, while merkle tree is being built delayed preallocation and

grammar nit: "... is being built, delayed preallocations..."

> unwritten extents are used. After metadata construction is done,
> fsverity inodes becomes read-only and won't be changed anymore, none of
> these unwritten extents or preallocations in post EOF region will be
> used.
> 
> Add XFS_BMAPI_UNWRITTEN and change xfs_bunmapi_range to remove only
> unwritten extents sitting beyond EOF and set it for fsverity inodes.
> 
> The xfs_free_eofblocks() will be called on fsverity inode as usual.
> However, inodes which are undergoing merkle tree construction need to
> be skipped in case reclaim takes place.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good to me, thanks for revising the commit message :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 55 +++++++++++++++++++++++++++++-----------
>  fs/xfs/libxfs/xfs_bmap.h |  6 ++++-
>  fs/xfs/xfs_bmap_util.c   | 25 +++++++++++++++---
>  3 files changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index cc48f6e20e80..a2d9cef952c4 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -6144,15 +6144,12 @@ xfs_bmap_validate_extent(
>  			XFS_IS_REALTIME_INODE(ip), whichfork, irec);
>  }
>  
> -/*
> - * Used in xfs_itruncate_extents().  This is the maximum number of extents
> - * freed from a file in a single transaction.
> - */
> -#define	XFS_ITRUNC_MAX_EXTENTS	2
> -
>  /*
>   * Unmap every extent in part of an inode's fork.  We don't do any higher level
>   * invalidation work at all.
> + *
> + * The XFS_BMAPI_UNWRITTEN could be passed to remove only unwritten extents,
> + * leaving out normal extents in place.
>   */
>  int
>  xfs_bunmapi_range(
> @@ -6162,23 +6159,51 @@ xfs_bunmapi_range(
>  	xfs_fileoff_t		startoff,
>  	xfs_fileoff_t		endoff)
>  {
> -	xfs_filblks_t		unmap_len = endoff - startoff + 1;
> +	xfs_filblks_t           unmap_len;
>  	int			error = 0;
> +	int			nimaps = 1;
> +	int			done = 0;
> +	struct xfs_bmbt_irec	imap;
> +	int			read_flags =
> +			flags & (XFS_BMAPI_ATTRFORK | XFS_BMAPI_ENTIRE);
>  
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
> -	while (unmap_len > 0) {
> -		ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> -		error = __xfs_bunmapi(*tpp, ip, startoff, &unmap_len, flags,
> -				XFS_ITRUNC_MAX_EXTENTS);
> +	while (startoff < endoff) {
> +		nimaps = 1;
> +
> +		error = xfs_bmapi_read(ip, startoff, endoff - startoff + 1,
> +				&imap, &nimaps, read_flags);
>  		if (error)
>  			goto out;
>  
> -		/* free the just unmapped extents */
> -		error = xfs_defer_finish(tpp);
> -		if (error)
> +		if (nimaps == 0)
>  			goto out;
> -		cond_resched();
> +
> +		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> +				imap.br_state != XFS_EXT_UNWRITTEN) {
> +			startoff = imap.br_startoff + imap.br_blockcount;
> +			continue;
> +		}
> +
> +		unmap_len = min(endoff - imap.br_startoff + 1,
> +				imap.br_blockcount);
> +		done = 0;
> +		while (!done) {
> +			ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> +			error = xfs_bunmapi(*tpp, ip, imap.br_startoff,
> +					unmap_len, flags, nimaps, &done);
> +			if (error)
> +				goto out;
> +
> +			/* free the just unmapped extent */
> +			error = xfs_defer_finish(tpp);
> +			if (error)
> +				goto out;
> +			cond_resched();
> +		}
> +
> +		startoff = imap.br_startoff + unmap_len;
>  	}
>  out:
>  	return error;
> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> index d5f2729305fa..0f36431d9936 100644
> --- a/fs/xfs/libxfs/xfs_bmap.h
> +++ b/fs/xfs/libxfs/xfs_bmap.h
> @@ -90,6 +90,9 @@ struct xfs_bmalloca {
>  /* Try to align allocations to the extent size hint */
>  #define XFS_BMAPI_EXTSZALIGN	(1u << 11)
>  
> +/* Process unwritten extents only. Used for unmapping */
> +#define XFS_BMAPI_UNWRITTEN	(1u << 12)
> +
>  #define XFS_BMAPI_FLAGS \
>  	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
>  	{ XFS_BMAPI_METADATA,	"METADATA" }, \
> @@ -102,7 +105,8 @@ struct xfs_bmalloca {
>  	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
>  	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
>  	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
> -	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
> +	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }, \
> +	{ XFS_BMAPI_UNWRITTEN,	"UNWRITTEN" }
>  
>  
>  static inline int xfs_bmapi_aflag(int w)
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index c88b9ade7389..36ac18df5743 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -31,6 +31,7 @@
>  #include "xfs_rtbitmap.h"
>  #include "xfs_rtgroup.h"
>  #include "xfs_zone_alloc.h"
> +#include <linux/fsverity.h>
>  
>  /* Kernel only BMAP related definitions and functions */
>  
> @@ -553,6 +554,13 @@ xfs_can_free_eofblocks(
>  	if (last_fsb <= end_fsb)
>  		return false;
>  
> +	/*
> +	 * Don't clean fsverity inodes which have merkle tree being built, the
> +	 * merkle tree is written beyond EOF
> +	 */
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		return false;
> +
>  	/*
>  	 * Check if there is an post-EOF extent to free.  If there are any
>  	 * delalloc blocks attached to the inode (data fork delalloc
> @@ -579,6 +587,9 @@ xfs_free_eofblocks(
>  	struct xfs_trans	*tp;
>  	struct xfs_mount	*mp = ip->i_mount;
>  	int			error;
> +	int			bmapi_flags = XFS_BMAPI_NODISCARD;
> +	bool			has_verity =
> +			ip->i_diflags2 & XFS_DIFLAG2_VERITY;
>  
>  	/* Attach the dquots to the inode up front. */
>  	error = xfs_qm_dqattach(ip);
> @@ -593,15 +604,20 @@ xfs_free_eofblocks(
>  	 *
>  	 * Note that this means we also leave speculative preallocations in
>  	 * place for preallocated files.
> +	 *
> +	 * Clean up delalloc reservations for fsverity too as those won't be
> +	 * used
>  	 */
> -	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
> +	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
> +			has_verity) {
>  		if (ip->i_delayed_blks) {
>  			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
>  				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
>  				LLONG_MAX, NULL);
>  		}
>  		xfs_inode_clear_eofblocks_tag(ip);
> -		return 0;
> +		if (!has_verity)
> +			return 0;
>  	}
>  
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> @@ -613,6 +629,9 @@ xfs_free_eofblocks(
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	xfs_trans_ijoin(tp, ip, 0);
>  
> +	if (has_verity)
> +		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> +
>  	/*
>  	 * Do not update the on-disk file size.  If we update the on-disk file
>  	 * size and then the system crashes before the contents of the file are
> @@ -620,7 +639,7 @@ xfs_free_eofblocks(
>  	 * bug).
>  	 */
>  	error = xfs_itruncate_extents_flags(&tp, ip, XFS_DATA_FORK,
> -				XFS_ISIZE(ip), XFS_BMAPI_NODISCARD);
> +				XFS_ISIZE(ip), bmapi_flags);
>  	if (error)
>  		goto err_cancel;
>  
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
