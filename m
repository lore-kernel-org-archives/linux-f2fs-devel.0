Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A5BC982FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JR6UK3NgBRO7HeVO9hjcxyk9gT7NyWOszbZJ2G8uRmg=; b=C41uRq67quOx3h23lXlclxezxD
	/y/iuNasdXjRBjSHnGO7Y/o5XnvzzZlQAhatSxXArp0QE6tmneJ1VnQ8QPBB+a/PzHBecTu523ZvM
	JA+M7t11C5IfW8rTtpq3cbaE9m8fPkg2heQIa5CGFVN/QeHcQgou/eHiKiGLdOfJYSSo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8sCo-0007V2-Su;
	Tue, 22 Sep 2026 04:34:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1x8sCm-0007Uu-Fg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xIUsqdTQPFnoKt9EnfUmvbFaGcMJVQ4YA3rI0Kzdh7E=; b=jFnk1GXZHgnkmpEJZe47pggzru
 QglkK5KKP2l1P/1koB5iESdtIrYNfDJawCY2xGhZSWCGn+4kVFfNqkBAPIEoy9qAWHnDlGDCNtiHU
 rpvEhU14oycqJZxFKkKH1Nbgm/dRCLZah27U3Z3ZhH3zJO2hUl2u/483delQs67sBzVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xIUsqdTQPFnoKt9EnfUmvbFaGcMJVQ4YA3rI0Kzdh7E=; b=ato2HcpVixWAiLmyJBpE8/5Oqz
 L/1Oa2FRh0F4S2hbyhIw7FlOJogzk6sJRbfjqYmy6tAFti18u64FqVNcRMaKogdRwuUzfiNYVEJnt
 0jkPWi3ZkA7ErkGSmG7EHMSK5bL3QLCgtBgBvgN0w3sTK2FQSx9MUpS0fNd7yHw1740o=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8sCm-0000Qw-LG for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:34:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 045F460216;
 Tue, 22 Sep 2026 04:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A206D1F000FF;
 Tue, 22 Sep 2026 04:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790051642;
 bh=xIUsqdTQPFnoKt9EnfUmvbFaGcMJVQ4YA3rI0Kzdh7E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gwqL4D0O/UjlOCn56Mp2fmUtkof8dZHMjba1D2crqNr2z3OIuKQfQ+R8MYqM/9qBY
 +MZrfysIILUxfXdW92FglRkZnLFkEH+RMuzwOkvZNgrDIh16XCfiCMybtyLIOFeMR3
 6tvJPqf99pUG34bvSoEkqWPslrNQbSm0FwHnUX8WkU44xPnASgnLQtWygHnkzxIPmF
 4f+o0kY/FyxBscHKGqWdkUTo2vfIG0ZCQgbZQH1sqCY0n54AmhY4xWyTMBRTezUVDe
 u32quEfqB5qsbHxdVSjO7gRhVGOkILDi77C/IIvlDjVGt+7jcT084+zoGT2AKuDJml
 /PeDEFYcz7SwQ==
Date: Mon, 21 Sep 2026 21:34:02 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260922043402.GM2705364@frogsfrogsfrogs>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-14-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-14-aalbersh@kernel.org>
X-Headers-End: 1x8sCm-0000Qw-LG
Subject: Re: [f2fs-dev] [PATCH v16 13/21] xfs: add XFS_BMAPI_UNWRITTEN to
 unmap unwritten extents in __xfs_bunmapi()
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

On Fri, Sep 18, 2026 at 01:15:25PM +0200, Andrey Albershteyn wrote:
> The __xfs_bunmapi() is used to remove all extents past EOF. Add
> XFS_BMAPI_UNWRITTEN to remove only unwritten extents, while leaving
> written ones in place. This will be used in following patch to clean up
> unwritten extents on fsverity inodes.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 6 +++++-
>  fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index cc48f6e20e80..7ba76017ae56 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5280,6 +5280,10 @@ __xfs_bunmapi(
>  		if (del.br_startoff + del.br_blockcount > end + 1)
>  			del.br_blockcount = end + 1 - del.br_startoff;
>  
> +		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> +				del.br_state != XFS_EXT_UNWRITTEN)

Odd indentation?

		if ((flags & XFS_BMAPI_UNWRITTEN) &&
		    del.br_state != XFS_EXT_UNWRITTEN)

/me again wonders if bunmapi ought to have its own flags instaed of
reusing *some* of bmapi.  But I concede that ought to be a different
cleanup, because figuring out which flags are for bunmapi.  I think it's
REMAP, ATTR_FORK, NODISCARD, and UNWRITTEN?

With the indentation fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +			goto skip;
> +
>  		if (!isrt || (flags & XFS_BMAPI_REMAP))
>  			goto delete;
>  
> @@ -5414,7 +5418,7 @@ __xfs_bunmapi(
>  			if (error)
>  				goto error0;
>  		}
> -
> +skip:
>  		end = del.br_startoff - 1;
>  nodelete:
>  		/*
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
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
