Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E2BC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVRd5nBCFxEH/d7BcCaeJZoZPnkfYtqsCHyQVVJzid8=; b=KEh6m7Esm3G5AjY7Om9aphyVid
	yUQKG4RNftK5xqBR/NC2aahzvWy2lBAs4aF9dFFuB+4kU82NaYTDNbKRPXuNIXELUCsbJJqrI1J5f
	xb00CkbQwH2hUBjOFwUfrt9Ux29Jrq7xsjCftbVC2qRELiPue8wTZVqxlxFDG2yJQj9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiKw9-0007S7-25;
	Fri, 10 Jul 2026 23:47:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wiKvp-0007Rg-C0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 23:46:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zAbiTc7SV8WiZhtg1dsCTH30vdfKHqz6tA06wbzCfJc=; b=KP/L0aRHvFonfXqTOYGDnQghhA
 OuDcBALYMTf1Fvz1VPrUCV5p3uXt4YNKH1hUQZ+tpBzIGVGYbpJtENFSe+Tqcw5zOIUUsplTOSWLn
 nTTAzVbMwNzB/YRJkqadceoZoHW6ffoqfjwzBUcFlcqSZ0YT2W4jRsLDQ2ApDo93SXKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zAbiTc7SV8WiZhtg1dsCTH30vdfKHqz6tA06wbzCfJc=; b=FkMtWrxhDUQ0r1DkxSA18hSif3
 azT03YCs6HWf86Sgc0jv7mvi5dRDRl+KkX6PKfiyQZl/r4x3GPBWHGjMh51Wb9IsoUNBzNYLsl02Q
 ecnmhPmvwKdyD6RpwrJLQ6vb3jPHB6zhqg+Z+rVDDhrWyJwa9MnJ59B6SJEOkbh+VZ5s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiKvo-0003w4-Ub for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 23:46:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EDA5600C3;
 Fri, 10 Jul 2026 23:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492571F000E9;
 Fri, 10 Jul 2026 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783727206;
 bh=zAbiTc7SV8WiZhtg1dsCTH30vdfKHqz6tA06wbzCfJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PWVBCawwijQB/x3en5NPn3juXXtN9ssNB2wEo1g8Hl5QS0+9MAwyDUQ8g1GYPbCky
 GVh7NfQh7RDSfNvhDuENXbffBuPwDUsTlebfZuonKA9vYyts+e3wNy3afdXkTn1cpM
 ohcgttvVFx1xb2AcGJdSkpCk2DMuLtzRtREuRy8tgZjFz471v0YOjJl/3Nl6/yFZ7X
 wCc6Q6Y9d1+8qRLgOqHBkMqH6XmuUtc8CgMkqtqZE18+vWI2wIKHzj+Tyjnbx5d5lQ
 jYllwlbEIDK3xm4CkL+6J114aktvnqw5qfk+3JYcc2ea5fM3idvU08Iq1JtAOlJ5g/
 J4hKNV5Lc+Z6Q==
Date: Fri, 10 Jul 2026 19:46:43 -0400
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260710234643.GF1911@quark>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
 <20260710085256.3464201-7-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710085256.3464201-7-aalbersh@kernel.org>
X-Headers-End: 1wiKvo-0003w4-Ub
Subject: Re: [f2fs-dev] [PATCH v11 06/20] fsverity: don't allow setting DAX
 file attribute on fsverity files
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 10:52:34AM +0200, Andrey Albershteyn wrote:
> When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
> it checks if file has DAX enabled and fails if that's true. However, the
> opposite case is not checked.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/file_attr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index bfb00d256dd5..5424ec4e3949 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -246,6 +246,11 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (fa->fsx_cowextsize == 0)
>  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
>  
> +	/* Can not enable DAX on fsverity file */
> +	if ((old_ma->fsx_xflags & FS_XFLAG_VERITY) &&
> +			fa->fsx_xflags & FS_XFLAG_DAX)
> +		return -EINVAL;
> +

This sounds like a bug fix.  But actually ext4 already checks this in
dax_compatible(), and the other filesystems that already supported
fsverity (f2fs and btrfs) don't support DAX.  So I guess this is really
lifting that to common code?  But the existing check is still being left
in place because it's still needed for ext4 specific flags anyway?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
