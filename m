Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E1CA5FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Xie7FfwmH21pswPdadXzztgFGa17GvJ3hGveRZfkIU=; b=TlxnauH3qUYncP9GXLzBUmcTK3
	vxHoepEpTRqZ1/WzhDwTXouCVOeDW2nYm71JbdWXnMxIYnsBZkoiLUGFgQ0xz0NBn6z6MSNSUVA5+
	xsM7js1j2NABBwdy9D9aFXl1ZrpY7laAFT+cT4wrW89mgDFXulBNnGi7QibO/g0NhgnU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDmKw-0003dy-6L;
	Mon, 05 Oct 2026 17:18:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xDmKu-0003dk-T0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6msS6X1Nm9a4FfZxp/QaUWM7UJBVtBa+hinGO0mETc=; b=TGuxI92nE6GxFMPDnSkE7Eb7vc
 3ehF76x94BRIimiXrnHf0PVTxYV5hvXIdmIsbhirZTntJWlpfAbVj1/TE1TwRivUt4hMnKYa25BVV
 GK72tDm+ncWb7uyVA2p7DNq9+Sb5evJrKJ+MBSLYx5+EiejA2vVNmuTKEB/KHftocLE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g6msS6X1Nm9a4FfZxp/QaUWM7UJBVtBa+hinGO0mETc=; b=Wk711rsn48oT3axUP2nBLIqiHb
 a/p3RMp7bqJ0YlESE2IdvdBD0VSe1CmKfLjD4JrwmjhdOjwwQayJMz1TY8snphQrCjQzwnvQzVEZ6
 iFNcqh7O42tbLu5OQixX+zMzifsli88OGp3LLHbCYj6e2ZDMXtFcbzf6PfBrpOSWr5nY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDmKs-0005bg-QR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 17:18:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CE9D60204;
 Mon,  5 Oct 2026 17:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AB71F00898;
 Mon,  5 Oct 2026 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791220720;
 bh=g6msS6X1Nm9a4FfZxp/QaUWM7UJBVtBa+hinGO0mETc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VUEJgA4PKsah0xZT1lr870C9hqSqsRunnnz04WlLURfD/UJTmN2lwjvFaHrddePZ6
 AqhbxYIsXMxfNHO7b+56xgy5Zo/jCpIrLLpnxjdp0ZdCdC7E8h0G2PzWnKJr6GB0EV
 /c+uo8VabxCcfoNi/iFpE7WFI41xxZYVncIFZalb1AMdiDe3t3UosVDI5kc5UWCixe
 3dwxa8cVGNKvsWJ4Tw+5i9b/BrMGdnLCshVqHpBLaWbukNMK45WiuXKIHH2gTvPzdh
 M/GZGdStGehJ5buPe6Toee94Xfg0c7bp1TuXjTn/MhYrHixG6otjZ4wpts+PbgX4qA
 qVxVficX6gx4Q==
Date: Mon, 5 Oct 2026 19:18:35 +0200
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de, 
 Carlos Maiolino <cem@kernel.org>
Message-ID: <asPEIapeSklgcsUa@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-16-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002223705.2175542-16-aalbersh@kernel.org>
X-Headers-End: 1xDmKs-0005bg-QR
Subject: Re: [f2fs-dev] [PATCH v17 15/21] xfs: add fs-verity support
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
Cc: fsverity@lists.linux.dev, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-10-03 00:36:56, Andrey Albershteyn wrote:
> Add integration with fs-verity. XFS stores fs-verity descriptor and
> Merkle tree in the inode data fork at first block aligned to 64k past
> EOF.
> 
> The Merkle tree reading/writing is done through iomap interface. The
> data itself is read to the inode's page cache. When XFS reads from this
> region iomap doesn't call into fsverity to verify it against Merkle
> tree. For data, verification is done at ioend completion in a workqueue.
> 
> When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> flag is set meaning that the Merkle tree is being build. The
> initialization ends with storing of verity descriptor and setting
> inode on-disk flag (XFS_DIFLAG2_VERITY). Lastly, the
> XFS_IVERITY_CONSTRUCTION is dropped and I_VERITY is set on inode.
> 
> The descriptor is stored in a new block aligned to 64k after the last
> Merkle tree block. The size of the descriptor is stored at the end of
> the last descriptor block (descriptor can be multiple blocks).
> 
> Pro-actively remove any unwritten extents as we use last extent to
> locate descriptor.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_fsverity.c | 425 +++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_fsverity.h |   2 +
>  fs/xfs/xfs_message.c  |   4 +
>  fs/xfs/xfs_message.h  |   1 +
>  fs/xfs/xfs_mount.h    |   2 +
>  fs/xfs/xfs_super.c    |   7 +
>  6 files changed, 440 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index 976e05257bf9..8cffcafc19aa 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -6,13 +6,22 @@
>  #include "xfs_fs.h"
>  #include "xfs_shared.h"
>  #include "xfs_format.h"
> -#include "xfs_log_format.h"
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"
>  #include "xfs_inode.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans.h"
> +#include "xfs_trace.h"
> +#include "xfs_quota.h"
>  #include "xfs_fsverity.h"
> +#include "xfs_iomap.h"
> +#include "xfs_error.h"
> +#include "xfs_health.h"
> +#include "xfs_bmap_util.h"
> +#include "xfs_icache.h"
>  #include <linux/fsverity.h>
>  #include <linux/iomap.h>
> +#include <linux/pagemap.h>
>  
>  struct kmem_cache *xfs_fsverity_ioend_cache;
>  mempool_t xfs_fsverity_ioend_pool;
> @@ -51,3 +60,417 @@ xfs_fsverity_is_file_data(
>  	return fsverity_active(VFS_IC(ip)) &&
>  			offset < xfs_fsverity_metadata_offset(ip);
>  }
> +
> +/*
> + * Retrieve the verity descriptor.
> + */
> +static int
> +xfs_fsverity_get_descriptor(
> +	struct inode		*inode,
> +	void			*buf,
> +	size_t			buf_size)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	__be32			d_desc_size;
> +	u32			desc_size;
> +	u64			desc_size_pos;
> +	int			error;
> +	u64			desc_pos;
> +	struct xfs_bmbt_irec	rec;
> +	int			is_empty;
> +	uint32_t		blocksize = i_blocksize(VFS_I(ip));
> +	xfs_fileoff_t		last_block_offset;
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +	/*
> +	 * Serialize reading of inode->i_flags with xfs_scrub clearing of this
> +	 * flag if inode is corrupted.
> +	 */
> +	if (!(inode->i_flags & S_VERITY)) {
> +		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +		return -ENODATA;
> +	}
> +	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	if (error)
> +		return error;
> +
> +	if (is_empty)
> +		return -ENODATA;
> +
> +	last_block_offset =
> +		XFS_FSB_TO_B(mp, rec.br_startoff + rec.br_blockcount);
> +	if (last_block_offset <= xfs_fsverity_metadata_offset(ip))
> +		return -ENODATA;
> +
> +	desc_size_pos = last_block_offset - sizeof(__be32);
> +	error = fsverity_pagecache_read(inode, (char *)&d_desc_size,
> +			sizeof(d_desc_size), desc_size_pos);
> +	if (error)
> +		return error;
> +
> +	desc_size = be32_to_cpu(d_desc_size);
> +	if (XFS_IS_CORRUPT(mp, desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE))
> +		return -ERANGE;
> +	if (XFS_IS_CORRUPT(mp, desc_size > desc_size_pos))
> +		return -ERANGE;
> +
> +	if (!buf_size)
> +		return desc_size;
> +
> +	if (XFS_IS_CORRUPT(mp, desc_size > buf_size))
> +		return -ERANGE;
> +
> +	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
> +	if (desc_pos < xfs_fsverity_metadata_offset(ip))
> +		return -ERANGE;
> +
> +	error = fsverity_pagecache_read(inode, buf, desc_size, desc_pos);
> +	if (error)
> +		return error;
> +
> +	return desc_size;
> +}
> +
> +static int
> +xfs_fsverity_write_descriptor(
> +	struct file		*file,
> +	const void		*desc,
> +	u32			desc_size,
> +	u64			merkle_tree_size)
> +{
> +	int			error;
> +	struct inode		*inode = file_inode(file);
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	unsigned int		blksize = ip->i_mount->m_sb.sb_blocksize;
> +	u64			tree_last_block =
> +			xfs_fsverity_metadata_offset(ip) + merkle_tree_size;
> +	u64			desc_pos =
> +			round_up(tree_last_block, XFS_FSVERITY_START_ALIGN);
> +	u64			desc_end = desc_pos + desc_size;
> +	__be32			desc_size_disk = cpu_to_be32(desc_size);
> +	u64			desc_size_pos =
> +			round_up(desc_end + sizeof(desc_size_disk), blksize) -
> +			sizeof(desc_size_disk);
> +
> +	error = iomap_fsverity_write(file, desc_size_pos, sizeof(__be32),
> +			(const void *)&desc_size_disk,
> +			&xfs_buffered_write_iomap_ops,
> +			&xfs_iomap_write_ops);
> +	if (error)
> +		return error;
> +
> +	return iomap_fsverity_write(file, desc_pos, desc_size, desc,
> +			&xfs_buffered_write_iomap_ops,
> +			&xfs_iomap_write_ops);
> +}
> +
> +/*
> + * Try to remove all the fsverity metadata after a failed enablement.
> + */
> +static int
> +xfs_fsverity_delete_metadata(
> +	struct xfs_inode	*ip)
> +{
> +	struct xfs_trans	*tp;
> +	struct xfs_mount	*mp = ip->i_mount;
> +	int			error;
> +
> +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> +	if (error) {
> +		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> +		return error;
> +	}
> +
> +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));

Oh I haven't paid enough attention here, it has to be moved before
xfs_ilock(ip, XFS_MMAPLOCK_EXCL) not just before the lock, to exclude
ABBA with writeback/reclaim taking folio lock and waiting for trans
space.

I will send v18 if more feedback will arrive, otherwise, I can
resend just this patch (or could be fixed during merge?).

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
