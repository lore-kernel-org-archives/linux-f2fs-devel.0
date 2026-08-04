Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B6C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73SoA63e3YxkbV2mXM656FVIwuIfCElnlfu9+9FIFQg=; b=iAKkF3dx2TZMyof0FOn9q8jHcG
	mjdpfMnEHf7T7txGW35N7+riR/6uc9AYqPihNaTqyIM8u7ubSx54+Aek4jc1NMBa3Sd3eeTttNAvw
	0TzZvfpd8qRjwjO94Yf5H7ATEG31eFfcvDIcuBjVyd2xZhhBIUdFKdz+f7g/3apIZOwc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJrk-0001Nn-0n;
	Tue, 04 Aug 2026 18:27:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrJri-0001Nh-Qx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZS/GlYTnQK5yougZZrLqepAErNkwEUMIDq85OusLBZo=; b=PIxb043r7tiMbWkiEFY7SmPII+
 Mz+efSD60+hrp/ksMlcLxdB8W3GforKv04/9I+sWjJsrqydmods3KCtbdLqUKwRD2nFrWjguDTJ8+
 aX8DuwUbFmdXXKmgZkxE8L7ILnPoIK+1dHNDE+H5zlAMLk4e48XqsSCwKw5S41XnsdaQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZS/GlYTnQK5yougZZrLqepAErNkwEUMIDq85OusLBZo=; b=BkKYe35zEIoX1gXSDJETDEMvMi
 xxcBB+C+RhXVNnTaaOSAkBSuMy14frwX5xng3lRFerH2UB6iXt7TqPGNTUW4C9ZA1qLJHNGMqwLFN
 tTNIGpiU76iVg7bUCRnkYpM2bjY9pl6rUNrpU7loCcOpbVFOX4K04OjnPJcbVo8tiQU8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJre-0002Zl-QM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:27:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 3265B433FC;
 Tue,  4 Aug 2026 18:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 074181F000E9;
 Tue,  4 Aug 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785868061;
 bh=ZS/GlYTnQK5yougZZrLqepAErNkwEUMIDq85OusLBZo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PRfa3OCaA2/f74uUOp4i7hwZH5bvALHMcMadVxdRtZ6d57nV2Jwu80R8tW4esmb0s
 TJTjRCA7tDVp3hGt5rb12T3gr4+pRJhIysuFMhdPNLVVAp9IDhN0tZ5YBbYMjNj+tm
 BTFUDGzSMlNRIg4lb7Zewo7zLxIt7ueaSgki6AY5OmajV/CtsTsjdNUu7hbF2gtM11
 B3+Ud5tPmOUG1DmCExF6BD4YO5lG7PFZuHdEcPbhObAmCLw0H1vfy0yVhjeJJwe30W
 M6822BgcNGsiIlyf68JFqdgBKVD+ZneaiYLloiM2JPwUUh/lu32OoLzu7MkjHbiaxh
 u7UYlmrLptrng==
Date: Tue, 4 Aug 2026 11:27:40 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804182740.GN3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-13-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-13-aalbersh@kernel.org>
X-Headers-End: 1wrJre-0002Zl-QM
Subject: Re: [f2fs-dev] [PATCH v14 12/21] xfs: handle fsverity I/O in
 write/read path
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:08:02PM +0200, Andrey Albershteyn wrote:
> For write/writeback set IOMAP_F_FSVERITY flag telling iomap to not
> update inode size and to not skip folios beyond EOF.
> 
> Initiate fsverity writeback with IOMAP_F_FSVERITY set to tell iomap
> should not skip folio that is dirty beyond EOF.
> 
> In read path let iomap know that we are reading fsverity metadata. So,
> treat holes in the tree as request to synthesize tree blocks and hole
> after descriptor as end of the fsverity region.
> 
> Introduce a new inode flag meaning that merkle tree is being build on
> the inode.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/Makefile          |  1 +
>  fs/xfs/libxfs/xfs_bmap.c | 11 +++++++++++
>  fs/xfs/xfs_aops.c        | 37 +++++++++++++++++++++++++++++++------
>  fs/xfs/xfs_fsverity.c    | 22 ++++++++++++++++++++++
>  fs/xfs/xfs_fsverity.h    | 20 ++++++++++++++++++++
>  fs/xfs/xfs_inode.h       |  6 ++++++
>  fs/xfs/xfs_iomap.c       | 29 +++++++++++++++++++++++------
>  7 files changed, 114 insertions(+), 12 deletions(-)
>  create mode 100644 fs/xfs/xfs_fsverity.c
>  create mode 100644 fs/xfs/xfs_fsverity.h
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index 399a207f2d0e..dd712c521862 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -150,6 +150,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
>  xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
>  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
>  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
> +xfs-$(CONFIG_FS_VERITY)		+= xfs_fsverity.o
>  
>  # notify failure
>  ifeq ($(CONFIG_MEMORY_FAILURE),y)
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index d64defeda645..cc48f6e20e80 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -41,6 +41,8 @@
>  #include "xfs_inode_util.h"
>  #include "xfs_rtgroup.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_fsverity.h"
> +#include <linux/fsverity.h>
>  
>  struct kmem_cache		*xfs_bmap_intent_cache;
>  
> @@ -4402,6 +4404,10 @@ xfs_bmapi_convert_one_delalloc(
>  	 * the extent.  Just return the real extent at this offset.
>  	 */
>  	if (!isnullstartblock(bma.got.br_startblock)) {
> +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION) &&
> +		    XFS_FSB_TO_B(mp, bma.got.br_startoff) >=
> +			    xfs_fsverity_metadata_offset(ip))
> +			flags |= IOMAP_F_FSVERITY;
>  		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
>  				xfs_iomap_inode_sequence(ip, flags));
>  		if (seq)
> @@ -4449,6 +4455,11 @@ xfs_bmapi_convert_one_delalloc(
>  	XFS_STATS_ADD(mp, xs_xstrat_bytes, XFS_FSB_TO_B(mp, bma.length));
>  	XFS_STATS_INC(mp, xs_xstrat_quick);
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION) &&
> +	    XFS_FSB_TO_B(mp, bma.got.br_startoff) >=
> +		    xfs_fsverity_metadata_offset(ip))
> +		flags |= IOMAP_F_FSVERITY;
> +
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
>  	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
>  				xfs_iomap_inode_sequence(ip, flags));
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 76918bd15ca8..b8813e577285 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -23,6 +23,7 @@
>  #include "xfs_ioend.h"
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
> +#include "xfs_fsverity.h"
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -172,12 +173,16 @@ xfs_map_blocks(
>  	int			retries = 0;
>  	int			error = 0;
>  	unsigned int		*seq;
> +	unsigned int		iomap_flags = 0;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
>  	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_flags |= IOMAP_F_FSVERITY;
> +
>  	/*
>  	 * COW fork blocks can overlap data fork blocks even if the blocks
>  	 * aren't shared.  COW I/O always takes precedent, so we must always
> @@ -265,7 +270,8 @@ xfs_map_blocks(
>  	    isnullstartblock(imap.br_startblock))
>  		goto allocate_blocks;
>  
> -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
> +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags,
> +			  XFS_WPC(wpc)->data_seq);
>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> @@ -412,12 +418,16 @@ xfs_zoned_map_blocks(
>  	xfs_filblks_t		count_fsb;
>  	struct xfs_bmbt_irec	imap, del;
>  	struct xfs_iext_cursor	icur;
> +	u16			iomap_flags = 0;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
>  	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_flags |= IOMAP_F_FSVERITY;
> +
>  	/*
>  	 * All dirty data must be covered by delalloc extents.  But truncate can
>  	 * remove delalloc extents underneath us or reduce their size.
> @@ -441,7 +451,7 @@ xfs_zoned_map_blocks(
>  		imap.br_startblock = HOLESTARTBLOCK;
>  		imap.br_state = XFS_EXT_NORM;
>  		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -		xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, 0);
> +		xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, 0);
>  		return 0;
>  	}
>  	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
> @@ -454,11 +464,10 @@ xfs_zoned_map_blocks(
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  
>  	wpc->iomap.type = IOMAP_MAPPED;
> -	wpc->iomap.flags = IOMAP_F_DIRTY;

Uh, what's this?

>  	wpc->iomap.bdev = mp->m_rtdev_targp->bt_bdev;
>  	wpc->iomap.offset = offset;
>  	wpc->iomap.length = XFS_FSB_TO_B(mp, count_fsb);
> -	wpc->iomap.flags = IOMAP_F_ANON_WRITE;

because we blow away IOMAP_F_DIRTY here??

This just looks wrong and in need of fixing ASAP.  Unless the DIRTY flag
truly isn't necessary?  I would think we'd need that since we're writing
to a new mapping and need a metadata flush...?

> +	wpc->iomap.flags = iomap_flags | IOMAP_F_ANON_WRITE;

Because afaict the correct post-patch code should be:

	wpc->iomap.flags = iomap_flags | IOMAP_F_ANON_WRITE |
					 IOMAP_F_DIRTY;

The rest of the patch looks ok to me.

--D

>  
>  	trace_xfs_zoned_map_blocks(ip, offset, wpc->iomap.length);
>  	return 0;
> @@ -504,6 +513,22 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>  	.writeback_submit	= xfs_zoned_writeback_submit,
>  };
>  
> +static int
> +xfs_iomap_writepages(
> +	struct xfs_inode		*ip,
> +	struct iomap_writepage_ctx	*ctx)
> +{
> +	/*
> +	 * Writeback does not work for folios past EOF, let it know that
> +	 * I/O happens for fsverity metadata and this restriction need
> +	 * to be skipped
> +	 */
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		ctx->iomap.flags |= IOMAP_F_FSVERITY;
> +
> +	return iomap_writepages(ctx);
> +}
> +
>  STATIC int
>  xfs_vm_writepages(
>  	struct address_space	*mapping,
> @@ -523,7 +548,7 @@ xfs_vm_writepages(
>  		};
>  		int				error;
>  
> -		error = iomap_writepages(&xc.ctx);
> +		error = xfs_iomap_writepages(ip, &xc.ctx);
>  		if (xc.open_zone)
>  			xfs_open_zone_put(xc.open_zone);
>  		return error;
> @@ -536,7 +561,7 @@ xfs_vm_writepages(
>  			},
>  		};
>  
> -		return iomap_writepages(&wpc.ctx);
> +		return xfs_iomap_writepages(ip, &wpc.ctx);
>  	}
>  }
>  
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> new file mode 100644
> index 000000000000..d86009629b56
> --- /dev/null
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +#include "xfs_platform.h"
> +#include "xfs_fs.h"
> +#include "xfs_shared.h"
> +#include "xfs_format.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_inode.h"
> +#include "xfs_fsverity.h"
> +#include <linux/fsverity.h>
> +#include <linux/iomap.h>
> +
> +loff_t
> +xfs_fsverity_metadata_offset(
> +	const struct xfs_inode	*ip)
> +{
> +	return round_up(i_size_read(VFS_IC(ip)), XFS_FSVERITY_START_ALIGN);
> +}
> diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> new file mode 100644
> index 000000000000..5771db2cd797
> --- /dev/null
> +++ b/fs/xfs/xfs_fsverity.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Red Hat, Inc.
> + */
> +#ifndef __XFS_FSVERITY_H__
> +#define __XFS_FSVERITY_H__
> +
> +#include "xfs_platform.h"
> +
> +#ifdef CONFIG_FS_VERITY
> +loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip);
> +#else
> +static inline loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip)
> +{
> +	WARN_ON_ONCE(1);
> +	return ULLONG_MAX;
> +}
> +#endif	/* CONFIG_FS_VERITY */
> +
> +#endif	/* __XFS_FSVERITY_H__ */
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 34c1038ebfcd..17ce083591f4 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -419,6 +419,12 @@ static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
>   */
>  #define XFS_IREMAPPING		(1U << 15)
>  
> +/*
> + * fs-verity's Merkle tree is under construction. The file is read-only, the
> + * only writes happening are for the fsverity metadata.
> + */
> +#define XFS_VERITY_CONSTRUCTION	(1U << 16)
> +
>  /* All inode state flags related to inode reclaim. */
>  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
>  				 XFS_IRECLAIM | \
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 225c3de88d03..a4d565661989 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -32,6 +32,8 @@
>  #include "xfs_rtbitmap.h"
>  #include "xfs_icache.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_fsverity.h"
> +#include <linux/fsverity.h>
>  
>  #define XFS_ALLOC_ALIGN(mp, off) \
>  	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
> @@ -883,6 +885,9 @@ xfs_direct_write_iomap_begin(
>  	if (flags & IOMAP_ATOMIC)
>  		iomap_flags |= IOMAP_F_ATOMIC_BIO;
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_flags |= IOMAP_F_FSVERITY;
> +
>  	/*
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
> @@ -1589,7 +1594,8 @@ xfs_zoned_buffered_write_iomap_begin(
>  	loff_t			count,
>  	unsigned		flags,
>  	struct iomap		*iomap,
> -	struct iomap		*srcmap)
> +	struct iomap		*srcmap,
> +	u16			iomap_flags)
>  {
>  	struct iomap_iter	*iter =
>  		container_of(iomap, struct iomap_iter, iomap);
> @@ -1599,7 +1605,6 @@ xfs_zoned_buffered_write_iomap_begin(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> -	u16			iomap_flags = IOMAP_F_SHARED;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
>  	xfs_filblks_t		count_fsb;
>  	xfs_extlen_t		indlen;
> @@ -1662,7 +1667,8 @@ xfs_zoned_buffered_write_iomap_begin(
>  				smap.br_startoff + smap.br_blockcount);
>  			xfs_trim_extent(&smap, offset_fsb,
>  					end_fsb - offset_fsb);
> -			error = xfs_bmbt_to_iomap(ip, srcmap, &smap, flags, 0,
> +			error = xfs_bmbt_to_iomap(ip, srcmap, &smap, flags,
> +					iomap_flags,
>  					xfs_iomap_inode_sequence(ip, 0));
>  			if (error)
>  				goto out_unlock;
> @@ -1672,6 +1678,8 @@ xfs_zoned_buffered_write_iomap_begin(
>  	if (!ip->i_cowfp)
>  		xfs_ifork_init_cow(ip);
>  
> +	iomap_flags |= IOMAP_F_SHARED;
> +
>  	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &got))
>  		got.br_startoff = end_fsb;
>  	if (got.br_startoff <= offset_fsb) {
> @@ -1803,9 +1811,12 @@ xfs_buffered_write_iomap_begin(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +		iomap_flags |= IOMAP_F_FSVERITY;
> +
>  	if (xfs_is_zoned_inode(ip))
>  		return xfs_zoned_buffered_write_iomap_begin(inode, offset,
> -				count, flags, iomap, srcmap);
> +				count, flags, iomap, srcmap, iomap_flags);
>  
>  	/* we can't use delayed allocations when using extent size hints */
>  	if (xfs_get_extsz_hint(ip))
> @@ -2191,12 +2202,17 @@ xfs_read_iomap_begin(
>  	bool			shared = false;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
>  	u64			seq;
> +	unsigned int		iomap_flags = 0;
>  
>  	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> +	if (fsverity_active(inode) &&
> +	    (offset >= xfs_fsverity_metadata_offset(ip)))
> +		iomap_flags |= IOMAP_F_FSVERITY;
> +
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -2210,8 +2226,9 @@ xfs_read_iomap_begin(
>  	if (error)
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> -				 shared ? IOMAP_F_SHARED : 0, seq);
> +	iomap_flags |= shared ? IOMAP_F_SHARED : 0;
> +
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  }
>  
>  const struct iomap_ops xfs_read_iomap_ops = {
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
