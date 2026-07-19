Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA09C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8fR2rlp+iqKIjjzR8ZxHeET0T1C2l8Td+WcwweUHn0=; b=WlIC1vqI7dkl5sIstnjg3PR189
	wG4TU+/kmXpUgRsBCwYWJYyOWs9fYabvmT7QXLeGv/s2pnVa/gg52WtMljEHkaXiSVpcPxH9TdtMM
	XQWJn6+1QnycK8ZXfRo93zrvEZQsoS7L+23gcNVdDDTZnq+7SSPN0AelfgvAM1y+SRDk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlLqH-0007pR-E2;
	Sun, 19 Jul 2026 07:21:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlLqF-0007pK-Cz
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9jIKAlXv/4RICULVFLnh1Fr9bNKFdUEweKxXxJ3WsFE=; b=dUfu374acD4wDY2/g0gly4o0x2
 jsfmCuP/kaAYke9OtpNuxPuob9wsb6mwK7GitheIfuog1RSn3T7uMTfz9NRDfFRClmq6GlyJcstnN
 U529kxWi4cwWOMta30Q5e5IuvPf5OlQrcdRMLCOyvIM+/fpWIW3L+ru6Vd11vQH+Tkbo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9jIKAlXv/4RICULVFLnh1Fr9bNKFdUEweKxXxJ3WsFE=; b=BMdV7bHsqA8/W6RMuJs5PVZzEj
 rVgD9tZUK7gT0EC6ACyaXpHAS1KFBHfViiE+IGSjYWe6jSEDw8UovbTGaTUNhNxkWlbUjCwEFzNao
 B4XgwHQdXXR4IIThmcNq1XHXlO/rCP1+kdhioUxQ4IcjdIgXKa1TYuMYLWxSZg8TjbDw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlLqC-0005l6-HC for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:21:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3443740AC0;
 Sun, 19 Jul 2026 07:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E9B1F000E9;
 Sun, 19 Jul 2026 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784445691;
 bh=9jIKAlXv/4RICULVFLnh1Fr9bNKFdUEweKxXxJ3WsFE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=R5ssUMUUeI78sn/WvsFCuyiMnBhNrYWTCD5rlCpQmUHYvES3jAhxZIjcHMyhGGLL8
 KwtlTHyTbv44xXM2zMqBoe6mEI0//1Ec14F7RpQEn9RYRRfIkgcSOeKBK4dEBkKXbF
 hYn19owUNnG3vB/6HzK2q2M++Xd9BA5PamtNVnZb/40S+GCo0tK+D3Kv78nYaW6PNj
 bgjSiIZf6C3VZvJ1Lg8O3yJp12vosf1uU3buJ9Il044XnvmHK1wF4k1TRT5vgX875v
 h8UhGrqATz+slqv4bVwc2zsgxc5xcrFOmKCCwBqwFsN+5STXE+5HxrlfU0arMmgyQu
 XdBj/N26CoSzg==
Message-ID: <c9081653-4295-4605-b543-ee84000b1ba4@kernel.org>
Date: Sun, 19 Jul 2026 15:21:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guanghui Yang <3497809730@qq.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
X-Headers-End: 1wlLqC-0005l6-HC
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in
 f2fs_move_inline_dirents
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/13/26 14:40, Guanghui Yang wrote:
> f2fs_move_inline_dirents() documents that the caller grabs ifolio, and
> that the function should release it on any error.
> 
> The f2fs_grab_cache_folio() failure path already drops ifolio, but the
> f2fs_reserve_block() failure path only drops the newly grabbed folio at
> the shared out label.  If f2fs_reserve_block() fails before clearing
> dn.inode_folio, the caller's ifolio reference is left behind.
> 
> Release ifolio on this error path when dn.inode_folio is still set.
> 
> Signed-off-by: Guanghui Yang <3497809730@qq.com>
> ---
>   fs/f2fs/inline.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index e2f7bedf1552..dea4ab957de8 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -427,8 +427,11 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
>   
>   	set_new_dnode(&dn, dir, ifolio, NULL, 0);
>   	err = f2fs_reserve_block(&dn, 0);

f2fs_reserve_block() can handle the error case in itself?

Thanks,

> -	if (err)
> +	if (err) {
> +		if (dn.inode_folio)
> +			f2fs_folio_put(ifolio, true);
>   		goto out;
> +	}
>   
>   	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
>   		f2fs_put_dnode(&dn);
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
