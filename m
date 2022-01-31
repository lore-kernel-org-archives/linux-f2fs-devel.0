Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A85FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Jan 2022 19:35:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nEcSE-0002UQ-8A; Mon, 31 Jan 2022 19:35:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nEcSD-0002UK-8Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jan 2022 19:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tcrewrn9T/dyU4Vh16Rf1StJfKvKN10MRQzbMwpJOZQ=; b=P2QSz1r2DmLyYoGqmT2hkpzy+h
 29oszP7O1q4ypKjgviGcJRXYDLclL7JnscDmkZ+0dchp8jH4QWBvBDOOaCosvGBRyKzy5KDl4AyIz
 eirMztcWGXOAgK1Acv3JClSqSpNsmY/TtST/iwQJONYUz90iUubf2EcqVL6dOQQ0Z16A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tcrewrn9T/dyU4Vh16Rf1StJfKvKN10MRQzbMwpJOZQ=; b=ORqmGURCMOPZXSuDlMXAAhipeT
 z/HvONOEyWq/0mQQS+kSsBECw/RbxFOtDec1SLyLRqk9BWMUt+82gtRCpdyI2OS0coYp8/EtqtlRk
 ZAbwdmkw5MJaGf8gDVv+8yHFhWEtY4aelgZ2jaFkNCQ+oqWtWEFx+i1sv0r9AZJniByY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nEcSA-008ZD3-4G
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jan 2022 19:35:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B97C061345;
 Mon, 31 Jan 2022 19:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423BC340E8;
 Mon, 31 Jan 2022 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643657695;
 bh=aDSxNsqNgxymIMupEkRchSOtPKLku8ZLqWJGphw2KQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s+jVDeyPLfSdinXQiVT8qLMyS4gdD4wPOBdtcRKMrTuHwdej7Xazt9hNQX3RZnHZs
 gm8lEqyFvWHXe9DMWkouGaL2fqPw6dM198xxt7024uTR8L9GKI8lnyWjuYrynhgYF2
 4KGubMHYmSc0/CMNBlFsYttKZRs6IRj1inC49dlsboaeXF10N3Z+hgfLbuzhCy9003
 1KXB1Ox8axiWipBP9B9Mc6sTatYl1E4F/FfgzAAv+s8BIj7/sYQ3YBXT8X+s5z76iH
 NuGvOGqLR8qckiFe1v0E7Jf3CLXxWxHLl46SYiW7DZ3tfoEJkhg8P0f04aHGbkr/zj
 GBh2a0BkJj9Sw==
Date: Mon, 31 Jan 2022 19:34:53 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Harry Austen <harryausten@hotmail.co.uk>
Message-ID: <Yfg53VflpMY3eDB4@gmail.com>
References: <AM6PR10MB2838F71E6117BFFAD3FD5A69FA249@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2838F71E6117BFFAD3FD5A69FA249@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
X-Headers-End: 1nEcSA-008ZD3-4G
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: disallow setting unsettable file
 attributes
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jan 30, 2022 at 05:21:39PM +0000, Harry Austen wrote:
> After Eric kindly pointed out the reasons why my initial kernel patch
> attempt was incorrect
> (https://lore.kernel.org/lkml/Ye79OLCFLR3H+GnY@gmail.com/), I had a
> rethink as to if the current implementation could be improved in any
> way.
> 
> I wondered whether something along the lines of the following patch
> would be more acceptable? It is intentionally verbose in order to
> demonstrate the concept as this is intended purely as an RFC.
> 
> What if SETFLAGS returned EOPNOTSUPP if userspace is actually trying to
> *set* one of the unsettable flags (i.e. it isn't set already)? I believe
> this would therefore not break chattr(1), as flags that are retrieved
> from GETFLAGS can still be passed into SETFLAGS without error.
> 
> If there is some other ABI compatibility that needs to be maintained
> that is broken by this, then please let me know. Also, I have not yet
> determined whether there are any concerns with calling f2fs_fileattr_get
> from inside f2fs_fileattr_set, e.g. speed/performance? so any thoughts
> would be greatly appreciated.
> 
> Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>
> ---
>  fs/f2fs/file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This makes sense, but this ioctl isn't f2fs-specific; it's implemented by other
filesystems, most notably ext2/ext4 where it originated.  f2fs shouldn't have
different behavior for the same ioctl.  If you want to change this ioctl, you
need to start a wider discussion (including the linux-fsdevel and linux-ext4
mailing lists) where the change is proposed for all filesystems.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
