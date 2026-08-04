Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC97BC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3Sw/4TK5xDos3qIyI4qXzUoCn0kgSm9r8wkom/Lptk=; b=BJOSfxMZaxZx20MVrUjoqZL/Jc
	xmBM/KQ7ym6xvF8zK/fqgyN2McUVrdr+JsWUPO6MWQf5y8bdVEXtTsmZky7S4IlfVbCLMffS6p4bj
	qdud1DE79LqCMcH23Inda1ZgcuhdZzFWPXYACDR9e0d1u2f/ZHlgX1ZHi6ytfw5bOEdY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJTQ-0003Gj-JY;
	Tue, 04 Aug 2026 18:02:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrJTD-0003GS-E9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y2NLRiGuBNOJ6Z8BI9xM1Xpil32458EDcgBYHRf5xO0=; b=HwemdeBVlaW+E0/W5MDSR9QSsQ
 2M0sJnKZAgSzarKOzhAGyFSkTzWlOxf9sEAWB4CQISciMoIly2kbVkHBvQovnC39Hn7Vuvm4CKZqK
 VJ1RKcqZnurR6m3r2a7IWxyaZC9rTMsUswKgasx6GjP+H9DTdABcouAUiMmOMdl64j7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y2NLRiGuBNOJ6Z8BI9xM1Xpil32458EDcgBYHRf5xO0=; b=ZNTBemSavOpT8Bhym0+GhqCzkJ
 jP2kXqRhCToWMyIAlhtOOQC8owZ4wEwQakw4zX9b4nhZe0SMIiJAxPNOpAt8wgyUw06kDDCSSIlKY
 PpNLuVo3JavodJDiz+y+tzar9H4z3BDFwI4GneiCrjld0I2mgjAD76SxcQhH4+7itXUs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJTE-0008Vb-Cr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:02:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 3CCFF60AAC;
 Tue,  4 Aug 2026 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DC1381F000E9;
 Tue,  4 Aug 2026 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785866543;
 bh=Y2NLRiGuBNOJ6Z8BI9xM1Xpil32458EDcgBYHRf5xO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GAGCWjPIAyRk1FTePZVk3ZTky9GVEGih5BCDLS3DV9UiiXAn8lz3Bki8hOXq+7RfE
 1uswLruc72tjdUjSLt7W3WUWLokJw2cWHJ/hwndk34bsg+8KujXHysByZZ39l3ANAG
 +ykl4oDTAOaHXoEmR0bNMKPgt8UEyIrVyYaqUFKMNsPvUfjRDkRnecChE8qKXRYfk3
 Lzy9MLZT7WMiEDuVEbbyyX9nAN0wZ/8Yyx7xIJRw8JNNd/7SiY9ME6Pgw/ppye0xud
 /NhvrRYpTbaBX8oLV2er1kYDmhklTapD37OwYPSrUlO97jf8Ste09csg5E4Kh9WDhO
 GPfRMkwHGktpg==
Date: Tue, 4 Aug 2026 11:02:22 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804180222.GK3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-7-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-7-aalbersh@kernel.org>
X-Headers-End: 1wrJTE-0008Vb-Cr
Subject: Re: [f2fs-dev] [PATCH v14 06/21] fsverity: don't allow setting DAX
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

On Mon, Aug 03, 2026 at 10:07:56PM +0200, Andrey Albershteyn wrote:
> When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
> it checks if file has DAX enabled and fails if that's true. However, the
> opposite case is not checked.
> 
> Note, that the only other filesystem supporting DAX and fsverity is
> ext4, and ext4 does check for this case.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/file_attr.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index bfb00d256dd5..473ebbe9af31 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -235,10 +235,15 @@ static int fileattr_set_prepare(struct inode *inode,
>  	/*
>  	 * It is only valid to set the DAX flag on regular files and
>  	 * directories on filesystems.
> +	 *
> +	 * DAX and fsverity are incompatible.
>  	 */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> -	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> -		return -EINVAL;
> +	if (fa->fsx_xflags & FS_XFLAG_DAX) {
> +		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> +			return -EINVAL;
> +		if (old_ma->fsx_xflags & FS_XFLAG_VERITY)
> +			return -EINVAL;
> +	}
>  
>  	/* Extent size hints of zero turn off the flags. */
>  	if (fa->fsx_extsize == 0)
> @@ -246,6 +251,7 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (fa->fsx_cowextsize == 0)
>  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
>  
> +

Unnecessary addition of a blank line?

With that removed, this makes sense to me so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	return 0;
>  }
>  
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
