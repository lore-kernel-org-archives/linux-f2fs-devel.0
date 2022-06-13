Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED2C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jun 2022 17:18:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o0nhY-0002Ek-DA; Mon, 13 Jun 2022 17:18:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o0nhT-0002Ed-Rf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Jun 2022 17:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klIfEkSkLiaTZzmT26GHDd8hcO8iWlBFGuqTtI4Kcvk=; b=F/oUDooLc5WBnUF5W0V6ixTyGG
 2XCYHZHJtgCRFiMseF3ChPiKfffk323WJzPFN4X+pnQ8i70VdzWdC/UmuMoOKJeR6U5Xo5rXQUXyW
 SuyOskclHBr5vX+hhheRmY/iNZU2/rrr/FrEIzh+eGBBXFVc000Yyf/IVy3kR5l+IIoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=klIfEkSkLiaTZzmT26GHDd8hcO8iWlBFGuqTtI4Kcvk=; b=ld+HLLPN0sHizHpZoT+Bi3QfcC
 qXUilEd5NbodO5JDAYYJhF4NNHigg9OI1og9FcUp+2dGzWqTHfNPV/FzfM9sAGQ34thyKcnOwzVvf
 z/6t6ahdXyHfBTFZsePEN8A1+3d1ZH0YuzenxYP8pxERN8cTC137rjvEnVNMj7zR2UPw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o0nhO-000PJa-SA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Jun 2022 17:18:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 808B260C25;
 Mon, 13 Jun 2022 17:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA7FC3411B;
 Mon, 13 Jun 2022 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655140672;
 bh=I7zhquTCHiU1cX/QcueveyTLeLXa1KVMfppA/Uw7T/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aPiC/l7YP0+P/Mq8byhVCgleFNHCwBwkQ06tyF9EwDKxDuvXwxYZcQHQYCUMNl72g
 9nHiKGCdhdyvZgUuJ00I7EnJYvex2i+aP3/H1FCWagRgG8iBIyXHhpPEDQpGBVOgrk
 I+nW+gNC+CtYnuehTs6i6QGWnFR9fOeHwgEsEAa77hl0uomcvxIl0Ewx6js2oqfNUY
 SWWPu2PDT0VJAJ0NmW8EGJ4FBLzPydvKPAD7KKrEwXJ5qRUwfoIydOnOMS7a2rXyhI
 fw/g9aQDjOiu2AdO3WaQuI/W8DO8CW+tbdxwgiAD0oVlstvZEZYoOg4DX5vOJ5Lvt4
 6mYgTTXHdpfPA==
Date: Mon, 13 Jun 2022 10:17:51 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Liu <chaoliu719@gmail.com>
Message-ID: <YqdxP411VW4Egxgu@google.com>
References: <20220602072449.998303-1-chaoliu719@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220602072449.998303-1-chaoliu719@gmail.com>
X-Headers-End: 1o0nhO-000PJa-SA
Subject: Re: [f2fs-dev] [PATCH] f2fs: refine comments for inline flags
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
Cc: Chao Liu <liuchao@coolpad.com>, linux-kernel@vger.kernel.org,
 Wayne Zhang <zhangwen@coolpad.com>, Yue Hu <huyue2@coolpad.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/02, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Currently, we use f2fs_has_inline_xattr() to check whether the
> inode can store inline xattr. However, it might be misinterpreted
> as the inode has at least one inline xattr.
> 
> The same is true for f2fs_has_inline_data() and
> f2fs_has_inline_dentry(). To be more intuitive and specific,
> refine comments of inline flags.

I don't see a big benefit to get this patch, but will lose the history.

> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
>  fs/f2fs/f2fs.h          | 6 +++---
>  include/linux/f2fs_fs.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e10838879538..e0205d42588d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -730,9 +730,9 @@ enum {
>  	FI_NO_ALLOC,		/* should not allocate any blocks */
>  	FI_FREE_NID,		/* free allocated nide */
>  	FI_NO_EXTENT,		/* not to use the extent cache */
> -	FI_INLINE_XATTR,	/* used for inline xattr */
> -	FI_INLINE_DATA,		/* used for inline data*/
> -	FI_INLINE_DENTRY,	/* used for inline dentry */
> +	FI_INLINE_XATTR,	/* inode can store inline xattr */
> +	FI_INLINE_DATA,		/* inode can store inline data */
> +	FI_INLINE_DENTRY,	/* inode can store inline dentry */
>  	FI_APPEND_WRITE,	/* inode has appended data */
>  	FI_UPDATE_WRITE,	/* inode has in-place-update data */
>  	FI_NEED_IPU,		/* used for ipu per file */
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index d445150c5350..a3c6750a66ae 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -223,9 +223,9 @@ struct f2fs_extent {
>  #define	NODE_IND2_BLOCK		(DEF_ADDRS_PER_INODE + 4)
>  #define	NODE_DIND_BLOCK		(DEF_ADDRS_PER_INODE + 5)
>  
> -#define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
> -#define F2FS_INLINE_DATA	0x02	/* file inline data flag */
> -#define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
> +#define F2FS_INLINE_XATTR	0x01	/* file can store inline xattr */
> +#define F2FS_INLINE_DATA	0x02	/* file can store inline data */
> +#define F2FS_INLINE_DENTRY	0x04	/* file can store inline dentry */
>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
>  #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
> -- 
> 2.36.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
