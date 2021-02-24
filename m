Return-Path: <SRS0=8cUc=H2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A1EC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Feb 2021 13:16:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A73564E02;
	Wed, 24 Feb 2021 13:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A73564E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lEu26-0002Tm-Fw; Wed, 24 Feb 2021 13:16:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lEu24-0002TT-QS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Feb 2021 13:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/VQyuN/CKcAvB8jStoYvM2bFaY2y0w3F8cvrw8i7zHE=; b=LqvwaezvEQ+NteEfQyJP3gUfZP
 BwrzUd/MLLGeAPGcxaX1RCOqlXc6wcSOn42mw80smSq8ISc8lXPhSwK5zQXfPXnwQCYYvoaLa7JzI
 C1uY6S0SaUI4Y33h6pWeF2lLR5gfbBZHkIIvbdhDKr7dNaLmUmCrm9dQrbkojXUYT9iY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/VQyuN/CKcAvB8jStoYvM2bFaY2y0w3F8cvrw8i7zHE=; b=NdHg9OLxwKWkFi5AIaHU1Lj/SV
 VkZGUHHe3kAGRaWdRxSt148gknbpL0QnwZVhtvLWH9a14QBPaOgMLoluhH8euOBf3p+BMuFXpT5hQ
 Z164mFOdEK9eZBorkZzoRPQw/BhJZHwiYLwoUKBFd29vuPTQEiSvJSdM0D591jVP64Y8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lEu1u-003hpj-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Feb 2021 13:16:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8737664E20;
 Wed, 24 Feb 2021 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614172593;
 bh=ztz5lIKcoB1v+qQmK3hQWLFJAVrolWKXrMQEn7PoHQY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gwReZnVvrErIlJPy2NAM9yXMFmtP62ngIWFEIUqUcX6J/MiuU8u5k2uNlkjHNFgo3
 RTghPn7qe2Izz7mRdX/4cLg/xJyYp6evotzxc/xzrRCfFgs0Qd96WeJbf5pGqsjzFz
 XwwP50ckMdcrxdo9Q0GJirSyfmmvWMik4JsAVJ9Mo/IynNPQOU/xRgwck4wmDb/MxE
 VwPgNGykxyByHEED9BX86TCU6p8JeN9mZj43ONP+5ZObBXk/7+OJgYPHzXrMppEvzH
 UX7IByvXchXAPFV9coslzyXLEG0aA451gu6Qz8SjnPBDpFXfXFwP+sNcq6Fj9FSSOh
 s1MPBj8Nyv7AQ==
To: heyunlei <heyunlei@hihonor.com>, jaegeuk@kernel.org
References: <20210223112425.19180-1-heyunlei@hihonor.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <c1ce1421-2576-5b48-322c-fa682c7510d7@kernel.org>
Date: Wed, 24 Feb 2021 21:16:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223112425.19180-1-heyunlei@hihonor.com>
Content-Language: en-US
X-Headers-End: 1lEu1u-003hpj-Hj
Subject: Re: [f2fs-dev] [PATCH] f2fs: fsverity: Truncate cache pages if set
 verity failed
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yunlei,

On 2021/2/23 19:24, heyunlei wrote:
> If file enable verity failed, should truncate anything wrote
> past i_size, including cache pages.

+Cc Eric,

After failure of enabling verity, we will see verity metadata if we truncate 
file to larger size later?

Thanks,

> 
> Signed-off-by: heyunlei <heyunlei@hihonor.com>
> ---
>   fs/f2fs/verity.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 054ec852b5ea..f1f9b9361a71 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -170,8 +170,10 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
>   	}
>   
>   	/* If we failed, truncate anything we wrote past i_size. */
> -	if (desc == NULL || err)
> +	if (desc == NULL || err) {
> +		truncate_inode_pages(inode->i_mapping, inode->i_size);
>   		f2fs_truncate(inode);
> +	}
>   
>   	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
>   
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
