Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C8C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMjvrWF8IWPavjy5BS0kmtuhbFFxZLCGCuzo6Yo98Bw=; b=D2oPT6m6wD/rJgthyYzUITgaF6
	j0EHL5OM7+lunYhWLpXyuRKa3V4JHQnISlFeN48X7zKR+Lk3PaYA6NcsodPNM5SG1qhe2zepUr71v
	WpnicBStd+44VHcn2GmBh4DVgMVi2wTXqWF7bKYqyREWHxYc4/UVKAfCtdDwcjca3VDY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqoEj-0007Jw-8I;
	Mon, 03 Aug 2026 08:41:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqoEQ-0007Cd-Ql
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TfQSkuEReZbncE2oup2LjZWcdyVQEqI2058eWQArA/c=; b=jYJi52LYMs363Jc9TDvTmJaFio
 MzKRUnhK8mwqCl8jXlr0lfjgeDyncGPQ9b+U45y7D+2JOXSCGV7apC4PuBrnmTF7wKT4SUmn9tN9x
 8COhetTClyi/cKbybiLtIu+AFh0fg902FARqyCv2YEae9FhwtDtniq5/74Gk5XKaGfho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TfQSkuEReZbncE2oup2LjZWcdyVQEqI2058eWQArA/c=; b=KY1Z2aelHab1rGC+SjxnTg8o1G
 pWTTOaZuyp37sWF12WTMPqmS2WHspkjB3c5EwRlPD/bgpBijQ0c+GABIOI9r+2u3H6vm/nXkT+5hO
 yxJcHlM5iMwk2ePOK3iE5Y0Ia4Hw/rombj7jDUxBwTCaqpPkMz/OjQhF/0kER2hK09FM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqoEN-0001PJ-Ol for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:41:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E53360A5D;
 Mon,  3 Aug 2026 08:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCCB1F000E9;
 Mon,  3 Aug 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785746461;
 bh=TfQSkuEReZbncE2oup2LjZWcdyVQEqI2058eWQArA/c=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=KIEGVyW7iNJ2QQzeAjT6M+Ou0ZgtOAMCMwwCEUyMhhmUcSo/Ha6MOLAJVjET6WDB9
 mXadHG4Cl8SWATeK2KIUFPWJaSw8bKBcGo28e4m3s+jQSvYcM97kUGrFmE5aSRPTUr
 ji8RncBWrP71MVHhBLeMKFhn+dS5ScuEDe0xhtvatSaxgZbJg+OvfdCwred95VR4pq
 Hx6m0EhPWr9Khltg5D02UdVNUW3LcZtyXqMXU6XsGxmdxOZc47c95pTj2TGqEeomHw
 rFgTh9ZOTJsBw13LZycDgTRdHSyLFdl5tHzk8Y2i2kGNuRFYmOyDS5DEhzda9MuJIK
 u0gbtiXca4OOA==
Message-ID: <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
Date: Mon, 3 Aug 2026 16:40:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rochan Avlur <rochan.avlur@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
Content-Language: en-US
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
X-Headers-End: 1wqoEN-0001PJ-Ol
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/29/26 12:16, Rochan Avlur wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Thanks for the patch.

I notice there is already a patch:

https://lore.kernel.org/linux-f2fs-devel/20260716025908.608098-1-zhanxusheng@xiaomi.com

Thanks,

> ---
>   fs/f2fs/xattr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 610d5810074d..281e2fd6c778 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -118,7 +118,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
>   	unsigned char old_advise = F2FS_I(inode)->i_advise;
>   	unsigned char new_advise;
>   
> -	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +	if (!inode_owner_or_capable(idmap, inode))
>   		return -EPERM;
>   	if (value == NULL)
>   		return -EINVAL;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
