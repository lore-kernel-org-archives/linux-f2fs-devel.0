Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF70C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jul 2026 04:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mt8WLBZAzUzUfKzpGJmnE1Z84RON1gvImPZAh1jfHbY=; b=dTb50SMltMfTlFc89JgePek15l
	ebgN/oUA3velxVkfOPIUpxbZHr9aIasWAkw9BYaFtXqAkHN6OkERW5vo4yCluWVgkT+xa6mGGbBtL
	fCq4aqkRhFV0aYddxVWEofUfLGnBPwpE/d31ApC7zC8UL6qroxDr9NrUxVZHHgWiFBhc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjrNb-0004WG-5I;
	Wed, 15 Jul 2026 04:37:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+8a8ca38365b0e2220bfb+8361+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wjrNZ-0004WA-WA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 04:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u9l8GbK/d939mjwNaaNEQLRSf13jlumm11AfM0M2g/E=; b=OFvYtAVQqS4h3Hchb7OOXWRS7e
 reu+yD9Q1G7m3i1OppGnIr4fPRFhvSwbRyCs0dsSbi+dZJ2x2kGJRnkDAjrT2/NGNkf+HqwaZlf6x
 JtfyZd93IVj+R3g38JY9PaNd7VWtu1xxyk3Gx/K0Dd/ek/6HJS3Mfsx9Hm98gf+rgBEI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u9l8GbK/d939mjwNaaNEQLRSf13jlumm11AfM0M2g/E=; b=YvkrXm8xGo5gCOkgj18vRLrCJG
 I7DBpuqlUgHt/F/6tBq87aAYcmW1rhVQ3THKmrxA7a7dujJ48RYBbNdyMkKzmPpDRamFqOFKY5Pfx
 CMss14qI6c1g1TktzYepNChcX2+gD2HAoYpBAg89evC81yRiNJX+x59CYdLjNarsv73o=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjrNZ-0000Bi-Cu for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 04:37:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=u9l8GbK/d939mjwNaaNEQLRSf13jlumm11AfM0M2g/E=; b=u4q7plxZwPseunwhumiGW9Hrt0
 fjsIF0kRFLxuM3vxKj9zGRJ0F9uWcOIIH7dSpCMuxRbpYcb9YMVcNn6znGTML1SNR7IsunPS4e9O/
 qZGv9rj74KEvzk07q0dkHsR4L5LPP/hHubVtiRko5ceSBc5KyuSbwxiU+ou5zWhzn1T8O2n/dyGz5
 alNkVbFQ3lSLmQIp0A0cdzN+WytTwT3LZqzA6zNHRz0B6FcHDNUE59gTXiTupBb/3uvOx15DXqsOW
 IPQmkmhkhj17fRkbI50G76w3UGXJPw5vOvU8s1H9/jNwLLL4CglkEr2ewoL8LlLFq08xEkPGJn8a/
 22ErO57A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wjrNS-0000000Dk9k-41S3;
 Wed, 15 Jul 2026 04:37:46 +0000
Date: Tue, 14 Jul 2026 21:37:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Message-ID: <alcOmorM0Sa0nHHE@infradead.org>
References: <20260710210646.3576365-1-kbusch@meta.com>
 <20260710210646.3576365-4-kbusch@meta.com>
 <alTTRoOEglwuf4vg@infradead.org> <alalpRYxjqtdJhVR@kbusch-mbp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alalpRYxjqtdJhVR@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wjrNZ-0000Bi-Cu
Subject: Re: [f2fs-dev] [PATCHv2 3/5] xfs: report direct io attributes
 through file_getattr
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, Keith Busch <kbusch@meta.com>, cem@kernel.org,
 aalbersh@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 14, 2026 at 03:09:57PM -0600, Keith Busch wrote:
> +void bdev_dio_align(struct block_device *bdev, struct fs_dio_align *align)

Nit: I'd usually pass the filled in structure before the source of the
information.

> +	case FS_IOC_GETDIOALIGN: {
> +		struct fs_dio_align align = {};
> +
> +		bdev_dio_align(bdev, &align);
> +		return copy_to_user(argp, &align, sizeof(align)) ? -EFAULT : 0;
> +	}

... and I'd probably split this into a little helper function as the
ioctl handlers sooner or later become a mess otherwise.

> +	case FS_IOC_GETDIOALIGN: {
> +		struct fs_dio_align	align = {};
> +
> +		if (!S_ISREG(inode->i_mode))
> +			return -ENOTTY;
> +		bdev_dio_align(xfs_inode_buftarg(ip)->bt_bdev, &align);
> +		if (xfs_is_cow_inode(ip))
> +			align.dio_offset_align = xfs_inode_alloc_unitsize(ip);
> +		if (copy_to_user(arg, &align, sizeof(align)))
> +			return -EFAULT;

Same here.

Otherwise this looks good to me.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
