Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F8E10F930F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 23:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=up5S4VbtsCJgH54lq8LxgUmTlMBPeap54cKll064DXc=; b=LC5hUc+lry0E/U7JgXAQFOHXT0
	FYjFE8sOhWgStKyoGbC8iHLlCiNGkvhIENmamAdRX6NHfzzMU0Pw4raOq3vEmaMNvkiP1Bbq39x4o
	kpmt+z2pwsxWJSG+V18VwtLuXdIjqigKi0G9QPW7FGVT6OvuK+TNsPDwXADHRWyrxYmU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7ibL-0001HI-PB;
	Tue, 31 Mar 2026 23:34:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w7ibJ-0001HA-Sq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TtDPuzO1lLjL3a+YnHX+eQPSjEegdxYh4hGeIbFoiyM=; b=Gjo9cjyhRjjZorMvZCQ0uxaAbn
 EYuf5IEODpcTQF0g/i/hjQ9nnwZxzKky0S/SIOPdSaued92AyxLBlE5Eg/JhgORpb6JaK6BA6eWpG
 8zEeQdCp29GFuVAsvSnB0ghbFFAInD1lMbXsKVeMrbIHY9Qq799YXCLxCF8Bl1bpghoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TtDPuzO1lLjL3a+YnHX+eQPSjEegdxYh4hGeIbFoiyM=; b=Fh2Bwt3J9JSicClCmemBadxVg/
 +RkKjnMwQ24Mp9AOMFtLJnXv3ir7zphFnksPiQ+YSll8JbGoSR9NQ9dV54NYMaLb8Jnvp06yd6CuP
 h5CjxDk/ukCk4NXf/XxFIsF+/hhKIQh5l/+HoryM91ql/qa+xgfHqiR4+TQxukmcNXsU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7ibJ-0003PC-7m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:34:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C20660127;
 Tue, 31 Mar 2026 23:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E22BC19423;
 Tue, 31 Mar 2026 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775000054;
 bh=PdO42lqMcVPHLZHuXll3GmvVEJQHveKUtKE07QAD2zQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QF4+JPaWIRu7yGXcv99CyGAiX3a4odDvzg4PN6vuvN23D80RC6gL6vdyoyTgZ23LB
 NY2EoUrDi6QLYPxNWOIX0SC9Q48wdTlA8ldUY6LVRc32kMilkpjrVxNVNw63T9v/Ur
 5PsmafoPCqGJzhIjsAjW5byD3Q7jThDDz7oKYpUu836HD5N2jAaLR7e/XQ/cRWtNQt
 hdycufQvZo8fCP6IwdlXUtNUJYIImGPZAOL/tiwgkc8V9Ab3mm8qihuD6y1u+E/VcA
 IvA4nPFu6cNH2lHzzJv3PT2vqQwp6azKduerQ462LzN5FZor+JmYY7qm/9iy1WI1nN
 A9zYwhu/Gh4XQ==
Date: Tue, 31 Mar 2026 16:34:13 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260331233413.GH6223@frogsfrogsfrogs>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-15-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-15-aalbersh@kernel.org>
X-Headers-End: 1w7ibJ-0003PC-7m
Subject: Re: [f2fs-dev] [PATCH v6 14/22] xfs: use read ioend for fsverity
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

On Tue, Mar 31, 2026 at 11:28:15PM +0200, Andrey Albershteyn wrote:
> Use read ioends for fsverity verification. Do not issues fsverity
> metadata I/O through the same workqueue due to risk of a deadlock by a
> filled workqueue.
> 
> Pass fsverity_info from iomap context down to the ioend as hashtable
> lookups are expensive.
> 
> Add a simple helper to check that this is not fsverity metadata but file
> data that needs verification.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks fine to me still,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c     | 46 ++++++++++++++++++++++++++++++++++---------
>  fs/xfs/xfs_fsverity.c |  9 +++++++++
>  fs/xfs/xfs_fsverity.h |  6 ++++++
>  3 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9503252a0fa4..ecb07f250956 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -24,6 +24,7 @@
>  #include "xfs_rtgroup.h"
>  #include "xfs_fsverity.h"
>  #include <linux/bio-integrity.h>
> +#include <linux/fsverity.h>
>  
>  struct xfs_writepage_ctx {
>  	struct iomap_writepage_ctx ctx;
> @@ -171,6 +172,23 @@ xfs_end_ioend_write(
>  	memalloc_nofs_restore(nofs_flag);
>  }
>  
> +/*
> + * IO read completion.
> + */
> +static void
> +xfs_end_ioend_read(
> +	struct iomap_ioend	*ioend)
> +{
> +	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
> +
> +	if (!ioend->io_bio.bi_status &&
> +			xfs_fsverity_is_file_data(ip, ioend->io_offset))
> +		fsverity_verify_bio(ioend->io_vi,
> +				    &ioend->io_bio);
> +	iomap_finish_ioends(ioend,
> +		blk_status_to_errno(ioend->io_bio.bi_status));
> +}
> +
>  /*
>   * Finish all pending IO completions that require transactional modifications.
>   *
> @@ -205,8 +223,7 @@ xfs_end_io(
>  		list_del_init(&ioend->io_list);
>  		iomap_ioend_try_merge(ioend, &tmp);
>  		if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> -			iomap_finish_ioends(ioend,
> -				blk_status_to_errno(ioend->io_bio.bi_status));
> +			xfs_end_ioend_read(ioend);
>  		else
>  			xfs_end_ioend_write(ioend);
>  		cond_resched();
> @@ -232,9 +249,14 @@ xfs_end_bio(
>  	}
>  
>  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> -	if (list_empty(&ip->i_ioend_list))
> -		WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> +	if (list_empty(&ip->i_ioend_list)) {
> +		if (IS_ENABLED(CONFIG_FS_VERITY) && ioend->io_vi &&
> +		    ioend->io_offset < xfs_fsverity_metadata_offset(ip))
> +			fsverity_enqueue_verify_work(&ip->i_ioend_work);
> +		else
> +			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
>  					 &ip->i_ioend_work));
> +	}
>  	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  }
> @@ -764,9 +786,13 @@ xfs_bio_submit_read(
>  	struct iomap_read_folio_ctx	*ctx)
>  {
>  	struct bio			*bio = ctx->read_ctx;
> +	struct iomap_ioend		*ioend;
>  
>  	/* defer read completions to the ioend workqueue */
> -	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
> +	ioend = iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset,
> +			0);
> +	ioend->io_vi = ctx->vi;
> +
>  	bio->bi_end_io = xfs_end_bio;
>  	submit_bio(bio);
>  }
> @@ -779,11 +805,13 @@ static const struct iomap_read_ops xfs_iomap_read_ops = {
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
> @@ -795,7 +823,7 @@ xfs_vm_read_folio(
>  {
>  	struct iomap_read_folio_ctx	ctx = { .cur_folio = folio };
>  
> -	ctx.ops = xfs_get_iomap_read_ops(folio->mapping);
> +	ctx.ops = xfs_get_iomap_read_ops(folio->mapping, folio_pos(folio));
>  	iomap_read_folio(&xfs_read_iomap_ops, &ctx, NULL);
>  	return 0;
>  }
> @@ -806,7 +834,7 @@ xfs_vm_readahead(
>  {
>  	struct iomap_read_folio_ctx	ctx = { .rac = rac };
>  
> -	ctx.ops = xfs_get_iomap_read_ops(rac->mapping),
> +	ctx.ops = xfs_get_iomap_read_ops(rac->mapping, readahead_pos(rac));
>  	iomap_readahead(&xfs_read_iomap_ops, &ctx, NULL);
>  }
>  
> diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> index 6e6a8636a577..b983e20bb5e1 100644
> --- a/fs/xfs/xfs_fsverity.c
> +++ b/fs/xfs/xfs_fsverity.c
> @@ -19,3 +19,12 @@ xfs_fsverity_metadata_offset(
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
> -- 
> 2.51.2
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
