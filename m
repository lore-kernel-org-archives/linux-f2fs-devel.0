Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5519CC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELS0MP2UPLR/HU8CMYuDcIy/oxZhaip+JG8G8uFG0UQ=; b=Y/KJMXhztuo2FW+gtOi/0cG6NK
	5PUaa0kjPAD/s+f4xj7B7z5omQIox1n07B8mgmg/jF58T8ZV14fxz2grXhqZrsXaJJgQF//7wui2P
	+QMifS3iNCxtGQxTIxhlCB1UbnB/IEd77PocQFyn40O1Mb7ZO5ByupOGnqbtHCplw2Pc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvrdl-00045E-L4;
	Mon, 17 Aug 2026 07:20:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wvrdk-000457-A9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f4n4adZtEiYzAk+llWpLl5YOfWM5kGjmQ5FiFjvGn/g=; b=foKRUekOp2jsLE0OLdt34n4ITr
 iwF1V9SRxsieTSbc2tRW2Cfy7fNST8XwFPOpEUHgGcxapkrwawo0VEVznSuWQzo0rDUola9m8N+oJ
 Yza9tNL+JHZ1TI2MpfWSEjtq8fA5HnsjNciGLixUp4ltBp9u2HjsQcCsFf+6l44Wa4M4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f4n4adZtEiYzAk+llWpLl5YOfWM5kGjmQ5FiFjvGn/g=; b=A+zek+mwspjdTNS/LLKrbEP1YW
 cT6Hxe3JvISGtvkvrQQIFLlx/HGD+dcrL6jFmUMVxT9IovMSOohVElt1Fi4bgf6IPA18K6uRFZ3z0
 Q7XDzmFf2raShD9Rsqag0mvo3xlS4030XRebgmQ8+RuAmqDB08/ofhO5oRRuVXYY89HM=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvrdh-0007Hd-UH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:20:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 65CDA68D07; Mon, 17 Aug 2026 09:20:00 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:20:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260817072000.GD17371@lst.de>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260814092448.1818082-18-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-18-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wvrdh-0007Hd-UH
Subject: Re: [f2fs-dev] [PATCH v15 17/25] xfs: use read ioend for fsverity
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
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 linux-ext4@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 14, 2026 at 11:24:34AM +0200, Andrey Albershteyn wrote:
> Use read ioends for fsverity verification. Do not issue fsverity
> metadata I/O through the same workqueue due to risk of a deadlock by a
> filled workqueue.
> 
> Pass fsverity_info from iomap context down to the ioend as hashtable
> lookups are expensive.
> 
> Add a simple helper to check that this is not fsverity metadata but file
> data that needs verification.

> -	const struct address_space	*mapping)
> +	const struct address_space	*mapping,
> +	loff_t				position)
>  {

Hmm, "position" is new for these kinds of arguments.  We tend to call
them "pos", "off", or "offset", but I guess this completes the matrix :)

But maybe stick to pos to match the naming of the helpers used by the
callers.


>  	struct xfs_inode		*ip = XFS_I(mapping->host);
>  
> -	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
> +	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev) ||
> +			xfs_fsverity_is_file_data(ip, position))
>  		return &xfs_iomap_read_ops;
>  	return &iomap_bio_read_ops;

Nit: While this is one of the standard Linux indent styles for long
ifs, the other one would seem more readable here:

	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev) ||
	    xfs_fsverity_is_file_data(ip, position))

> +#include "xfs_errortag.h"
> +#include "xfs_fsverity.h"
>  #include <linux/bio-integrity.h>
> +#include <linux/fsverity.h>
> +
> +static void
> +xfs_end_fsverity_io_read(
> +	struct work_struct	*work)
> +{
> +	struct iomap_ioend	*ioend =
> +		container_of(work, struct iomap_ioend, io_work);
> +
> +	if (!ioend->io_bio.bi_status)
> +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> +
> +	iomap_finish_ioends(
> +		ioend, blk_status_to_errno(ioend->io_bio.bi_status));

Indentation looks odd here, this should be:

	iomap_finish_ioends(ioend,
		blk_status_to_errno(ioend->io_bio.bi_status));

or maybe add a local bio variable given that you use ioend->io_bio
three times, and this would fit onto a single line.

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0959b97e641b..f329a57d6ee9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -454,6 +454,7 @@ struct iomap_ioend {
>  	sector_t		io_sector;	/* start sector of ioend */
>  	void			*io_private;	/* file system private data */
>  	struct fsverity_info	*io_vi;		/* fsverity info */
> +	struct work_struct	io_work;	/* fsverity blocking I/O */
>  	struct bio		io_bio;		/* MUST BE LAST! */
>  };

Please don't add new fields to iomap structures in xfs patches.

And I really don't like adding it here given that struct work_struct is
rather big and not useful in other ways here.  So maybe just do the
alloc a struct for the workqueue and queue it up using
fsverity_enqueue_verify_work approach the other file systems do.
Or add something like the block complete in task thing to fsverity
and simplify all these so that they only need a list entry
(which we already have in the ioend).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
