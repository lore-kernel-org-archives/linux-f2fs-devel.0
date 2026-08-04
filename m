Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312E1C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvB3nXndJLJmVwXLTEflx9rkOZFXvm+eWQlUYohjP4o=; b=FsRVrVK47cLzRAbnPCTTYuW5SK
	GHDoIs0OxQq9RSvNpHOjWrpQfz7K1+81eeHnRs7NpIRH5hEskIPJ9t52ihl1WAODaHJU+SUyKfFLv
	Bw60jUjcjFB1xzpy+18mohtsBD9glwBbnRBZQwwZvY0YkyzmraiJBogIpqpKJIGZQ+Dw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrK0G-00086F-QQ;
	Tue, 04 Aug 2026 18:36:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrK0F-000862-OR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSmLr+VHPu87kVYpEEZ5Peme8i035WhFNym+ayfobW8=; b=D4xzgsbCCYuQrPkwDjhIhkQLW3
 m0tNrDn3WLarw0YJC/GmpJwRkvBWxj4Hr5yVH/8nM+rWugsVNIl33JwyAA6bUQ3TExpMFQ6/pfYgt
 Az1G1+YgWkdRc9vxmEUxKIWnQpk6jTCyLJM/x18EOs/QwJy3dQiOA4LFT2m6U5lzj+bs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qSmLr+VHPu87kVYpEEZ5Peme8i035WhFNym+ayfobW8=; b=aHizyBjRHozRBgMezdD9rzth/b
 tjCyU3oOjCdBmP2OIRVz5EchjPL3wXAUOnP8cF1P3JFE6Uc6hOQARtZMCrWUKNMW4dlkCRJcCe2gz
 6BXneWhDQ2zss70wwcWT7g8z3DqBrpVUASLIvcloHQzh/KUR0uRnr83XuxaR4Umu0zto=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrK0F-0002v7-2Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:36:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 70A5E60DBE;
 Tue,  4 Aug 2026 18:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 18F4D1F00A3E;
 Tue,  4 Aug 2026 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785868593;
 bh=qSmLr+VHPu87kVYpEEZ5Peme8i035WhFNym+ayfobW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QFfVCvciso3E8VVKC8HrJk04u7FxLqb1r2CPP5onuZLPGXTM59fOhxnDCm1WVwhzt
 Rmom57xuwDpATL1fGWNWIo0i8EuB5dqtwJz8n7jfEXCJU31W23EL+8RWqBEpPCKNNo
 cJTPYdHFbqAJrf5RpahTZvf8Gru7VHBTLLFu+goFFOEnGv1KphE5HvDfNYciCyDNB4
 Ym5FEJXczuyfGgbHsz58cLl9UVID79x325LFSzMLd/29i70L0kEGX3qHCpMbuT/ZHj
 UfvTExaptT44DfUHnAw98Q2TUL7hWbt1Rc3b4VxitVny9lSaWcuaU404Ne8h2EhBhd
 ecugqIUpDg+zw==
Date: Tue, 4 Aug 2026 11:36:32 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804183632.GO3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-14-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-14-aalbersh@kernel.org>
X-Headers-End: 1wrK0F-0002v7-2Y
Subject: Re: [f2fs-dev] [PATCH v14 13/21] xfs: use read ioend for fsverity
 data verification
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

On Mon, Aug 03, 2026 at 10:08:03PM +0200, Andrey Albershteyn wrote:
> Use read ioends for fsverity verification. Do not issue fsverity
> metadata I/O through the same workqueue due to risk of a deadlock by a
> filled workqueue.
> 
> Pass fsverity_info from iomap context down to the ioend as hashtable
> lookups are expensive.
> 
> Add a simple helper to check that this is not fsverity metadata but file
> data that needs verification.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_aops.c     | 13 ++++++++-----
>  fs/xfs/xfs_file.c     |  3 ++-
>  fs/xfs/xfs_fsverity.c |  9 +++++++++
>  fs/xfs/xfs_fsverity.h |  6 ++++++
>  fs/xfs/xfs_ioend.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_ioend.h    |  4 +++-
>  include/linux/iomap.h |  1 +
>  7 files changed, 70 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b8813e577285..14bfaed1f1f6 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -24,6 +24,7 @@
>  #include "xfs_zone_alloc.h"
>  #include "xfs_rtgroup.h"
>  #include "xfs_fsverity.h"
> +#include <linux/fsverity.h>
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -607,7 +608,7 @@ xfs_bio_submit_read(
>  {
>  	xfs_ioend_submit_read(iter->inode, ctx->read_ctx,
>  			ctx->read_ctx_file_offset,
> -			iomap_ioend_flags(&iter->iomap));
> +			iomap_ioend_flags(&iter->iomap), ctx->vi);
>  	ctx->read_ctx = NULL;
>  }
>  
> @@ -619,11 +620,13 @@ static const struct iomap_read_ops xfs_iomap_read_ops = {
>  
>  static inline const struct iomap_read_ops *
>  xfs_get_iomap_read_ops(
> -	const struct address_space	*mapping)
> +	const struct address_space	*mapping,
> +	loff_t				position)
>  {
>  	struct xfs_inode		*ip = XFS_I(mapping->host);
>  
> -	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
> +	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev) ||
> +			xfs_fsverity_is_file_data(ip, position))
>  		return &xfs_iomap_read_ops;
>  	return &iomap_bio_read_ops;
>  }
> @@ -635,7 +638,7 @@ xfs_vm_read_folio(
>  {
>  	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
>  
> -	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
> +	ctx.ops = xfs_get_iomap_read_ops(folio->mapping, folio_pos(folio));
>  	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
>  	return 0;
>  }
> @@ -646,7 +649,7 @@ xfs_vm_readahead(
>  {
>  	struct iomap_read_folio_ctx	ctx = { .rac = rac };
>  
> -	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
> +	ctx.ops = xfs_get_iomap_read_ops(rac->mapping, readahead_pos(rac));
>  	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
>  }
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 67c1357f4701..e9927688086d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -237,7 +237,8 @@ xfs_dio_read_bounce_submit_io(
>  	loff_t			file_offset)
>  {
>  	xfs_ioend_submit_read(iter->inode, bio, file_offset,
> -			iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT);
> +			iomap_ioend_flags(&iter->iomap) | IOMAP_IOEND_DIRECT,
> +			NULL);
>  }
>  
>  static const struct iomap_dio_ops xfs_dio_read_bounce_ops = {
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index d86009629b56..d1b3ccc65322 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -20,3 +20,12 @@ xfs_fsverity_metadata_offset(
>  {
>  	return round_up(i_size_read(VFS_IC(ip)), XFS_FSVERITY_START_ALIGN);
>  }
> +
> +bool
> +xfs_fsverity_is_file_data(
> +	const struct xfs_inode	*ip,
> +	loff_t			offset)
> +{
> +	return fsverity_active(VFS_IC(ip)) &&
> +			offset < xfs_fsverity_metadata_offset(ip);
> +}
> diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> index 5771db2cd797..ec77ba571106 100644
> --- a/fs/xfs/xfs_fsverity.h
> +++ b/fs/xfs/xfs_fsverity.h
> @@ -9,12 +9,18 @@
>  
>  #ifdef CONFIG_FS_VERITY
>  loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip);
> +bool xfs_fsverity_is_file_data(const struct xfs_inode *ip, loff_t offset);
>  #else
>  static inline loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip)
>  {
>  	WARN_ON_ONCE(1);
>  	return ULLONG_MAX;
>  }
> +static inline bool xfs_fsverity_is_file_data(const struct xfs_inode *ip,
> +					    loff_t offset)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_FS_VERITY */
>  
>  #endif	/* __XFS_FSVERITY_H__ */
> diff --git a/fs/xfs/xfs_ioend.c b/fs/xfs/xfs_ioend.c
> index 641f0d881b07..b0370af7a0f7 100644
> --- a/fs/xfs/xfs_ioend.c
> +++ b/fs/xfs/xfs_ioend.c
> @@ -18,7 +18,9 @@
>  #include "xfs_ioend.h"
>  #include "xfs_error.h"
>  #include "xfs_errortag.h"
> +#include "xfs_fsverity.h"
>  #include <linux/bio-integrity.h>
> +#include <linux/fsverity.h>
>  
>  static void
>  xfs_end_bio_bounced(
> @@ -87,6 +89,20 @@ xfs_read_bounce_and_resubmit(
>  			xfs_bounce_submit_ioend);
>  }
>  
> +static void
> +xfs_end_fsverity_io_read(
> +	struct work_struct	*work)
> +{
> +	struct iomap_ioend	*ioend =
> +		container_of(work, struct iomap_ioend, work);
> +
> +	if (!ioend->io_bio.bi_status)
> +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> +
> +	iomap_finish_ioends(
> +		ioend, blk_status_to_errno(ioend->io_bio.bi_status));
> +}
> +
>  static void
>  xfs_end_io_read(
>  	struct bio		*bio)
> @@ -113,6 +129,26 @@ xfs_end_io_read(
>  		}
>  	}
>  
> +	/*
> +	 * If we don't have block device integrity (IOMAP_IOEND_INTEGRITY),
> +	 * there won't be any ioends containing fsverity metadata. This means
> +	 * that those won't get mixed with data ioends causing self-deadlock or
> +	 * rescuer thread deadlock.

I think this comment should be inverted since fsverity + PI is
probably(?) more of an edge case?

"If we have fsverity and block device integrity attached to this bio,
we need to run both validations from the separate fsverity workqueue
to avoid deadlocking due to fsverity issuing its own reads."

(Assuming I understand the fsverity && pi case correctly.)

One thing I'm not clear about -- why is it safe to do the fsverity
validation here if PI isn't enabled?  Can't that also issue IO to pull
in merkle tree blocks?

> +	 *
> +	 * Without offloading the data ioend, verification can be done directly
> +	 * in this task context.
> +	 */
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && !error && ioend->io_vi &&
> +			xfs_fsverity_is_file_data(ip, ioend->io_offset)) {
> +		if (ioend->io_flags & IOMAP_IOEND_INTEGRITY) {
> +			fsverity_enqueue_verify_work(&ioend->work);
> +			return;
> +		}
> +
> +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> +		error = blk_status_to_errno(ioend->io_bio.bi_status);
> +	}
> +
>  	iomap_finish_ioends(ioend, error);
>  }
>  
> @@ -121,13 +157,17 @@ xfs_ioend_submit_read(
>  	struct inode		*inode,
>  	struct bio		*bio,
>  	loff_t			file_offset,
> -	u16			ioend_flags)
> +	u16			ioend_flags,
> +	struct fsverity_info	*vi)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct iomap_ioend	*ioend;
>  
>  	ioend = iomap_init_ioend(inode, bio, file_offset, ioend_flags);
> +	ioend->io_vi = vi;
> +	INIT_WORK(&ioend->work, xfs_end_fsverity_io_read);
> +
>  	if ((ioend_flags & IOMAP_IOEND_DIRECT) &&
>  	    READ_ONCE(mp->m_read_bounce) == XFS_READ_BOUNCE_ALWAYS) {
>  		iomap_bounce_read(ioend, bdev_logical_block_size(bio->bi_bdev),
> diff --git a/fs/xfs/xfs_ioend.h b/fs/xfs/xfs_ioend.h
> index 7c2a1ea3e6ed..992c248a693a 100644
> --- a/fs/xfs/xfs_ioend.h
> +++ b/fs/xfs/xfs_ioend.h
> @@ -2,6 +2,8 @@
>  #ifndef __XFS_IOEND_H
>  #define __XFS_IOEND_H
>  
> +#include <linux/fsverity.h>
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -13,6 +15,6 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
>  
>  void xfs_end_bio(struct bio *bio);
>  void xfs_ioend_submit_read(struct inode *inode, struct bio *bio,
> -		loff_t file_offset, u16 ioend_flags);
> +		loff_t file_offset, u16 ioend_flags, struct fsverity_info *vi);
>  
>  #endif /* __XFS_IOEND_H */
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f9e2fce21be0..96a00d61d4e8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -455,6 +455,7 @@ struct iomap_ioend {
>  	sector_t		io_sector;	/* start sector of ioend */
>  	void			*io_private;	/* file system private data */
>  	struct fsverity_info	*io_vi;		/* fsverity info */
> +	struct work_struct	work;		/* fsverity blocking I/O */

io_work?

>  	struct bio		io_bio;		/* MUST BE LAST! */

I slightly wonder about iomap_ioend getting bigger but I don't have
access to my usual workstations and can't pahole this to learn how much
that embiggens the structure.

Also I wouldn't be shocked if someone else kinda wants the work struct
here too for (say) future fscrypt/compression/whatever.

--D

>  };
>  
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
