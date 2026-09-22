Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB6BC982F1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErvqBhsxcUAsuhpBKb4VY8GQfpMpLoK0XXTETobu6VQ=; b=HY6EXOvDB6i2ylINPo/epc/oVz
	AGR8BdPrU2fb3V951kn5F0o37LjzkB1YgUXbRED4bEdzTJU5QNjgdTzM6F+1pecBeChkezJUsb1gP
	UIwVoQpNy+UyJDe442cSWQBdSAUVQLkQPWNHtJoWA9Qf3F17p4ArkLAmckKITY+7cpn0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8sGT-0002n9-DF;
	Tue, 22 Sep 2026 04:37:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1x8sGS-0002mx-B7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K0Sw228Cihp0VPJl4lhopC6Np3CQYCAfu/HTn3gh2Io=; b=LFYUxzlj32vK84cKdAXTU9QHwC
 KP2jw2QgFGqc2D8LIyh76SaUFmiI78Cc2UT83EBaoqICJJFntMdWJWusFBGhpTqvNknDVGPycxxaV
 X0pK4hY9Wt8HoCADxCmYLBQ98VeLt2FrzUXU2LXL2uLdfo8ncNJxcxd6trR9M7sVJw+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K0Sw228Cihp0VPJl4lhopC6Np3CQYCAfu/HTn3gh2Io=; b=MMExg4KrWVyAXwQC7r3Va/bI2o
 n66LnVH7qBsXaJ711ZhXeoGZ+hzHQPQFrp7+DmVu2i2BlkgkOqbCEEMut0hQHln7jM+qoMEmET4QT
 XsPz7p4xfdJYcXkmxE/ZLcczkHSnovwY9Vhqx9X3dkcXx6rXiIXJJ1oh60VHhtVH0dNY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8sGS-0000Ui-6d for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:37:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id CBE1C43DD6;
 Tue, 22 Sep 2026 04:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A03271F000FF;
 Tue, 22 Sep 2026 04:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790051870;
 bh=K0Sw228Cihp0VPJl4lhopC6Np3CQYCAfu/HTn3gh2Io=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IR2+PNNX1L6gIXyKF6HzpRSCtNuwnNHr5cRslALF2iNrHeLYri27zFnUTntGWki8I
 ekcheGNRBVqm1HNWVr5yCgOvt2s1ocoaMviRnAxS5sH2iEUbt1vazDwGcASakfFBiq
 G3w0Gt6oAuaDhYJ2koSsYsa/R1Q2SyViyML/sSqAz1Rj0ksb6QyO+uTwlbxZxBNIJy
 z/dqMvndgNxUaw158hFT1x5uh2+OV7/zt20rhQUbXDJdL6yvhy2eUUL/nFhaT6/ke4
 Ch974KPiHQL7S/rZYr7jz/ovq9J12PgcTUFobTAe6HjlofjEzucehkwx0X1C/iFwZr
 cSsBTGdCKonvw==
Date: Mon, 21 Sep 2026 21:37:50 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260922043750.GN2705364@frogsfrogsfrogs>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-15-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-15-aalbersh@kernel.org>
X-Headers-End: 1x8sGS-0000Ui-6d
Subject: Re: [f2fs-dev] [PATCH v16 14/21] xfs: don't remove written extents
 past EOF on fsverity inodes
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:26PM +0200, Andrey Albershteyn wrote:
> xfs_free_eofblocks() removes all extents past EOF unless the
> XFS_DIFLAG_PREALLOC or XFS_DIFLAG_APPEND flags are set. This is
> undesired for fsverity as it stores metadata beyond EOF. However, while
> merkle tree is being built, delayed preallocation and unwritten extents
> are used. After metadata construction is done, fsverity inodes becomes
> read-only and won't be changed anymore, none of these unwritten extents
> or preallocations in post EOF region will be used.
> 
> Let xfs_free_eofblocks() be called on fsverity inode as usual to remove
> anything which is not written extent. However, inodes which are
> undergoing merkle tree construction need to be skipped in case reclaim
> takes place.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_bmap_util.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 268d159339d0..7fd951992557 100644
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

This ought to have a comment explaining where post-eof unwritten extents
might come from:

	/*
	 * If fs-verity fails to write the full metadata, it can leave
	 * unwritten preallocations after EOF.  Clear all that out.
	 */
	if (has_verity)
		bmapi_flags |= XFS_BMAPI_UNWRITTEN;


With that documented,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
