Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D7C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 07:14:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96999206E4;
	Mon,  7 Dec 2020 07:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96999206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmAjL-0002po-4z; Mon, 07 Dec 2020 07:14:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kmAjI-0002pN-Js
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 07:14:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EV5IVFkJH0BFDdHez1SDodfGp/nmaJToNafB1+J2kn4=; b=ipO5+PxOiRHBzVIE2inAzpMUwv
 Ey5C5In6tszUAYT5YoVJCknY1OuxPrir1w8DtHb7ZyHtyq5UY4TPfVClitgwJPNFpUedBwaXf61Yr
 a8clTi6YE/NcmE9UTFWHrhgPFgvDDqGfJOXomsdH1SoX2Zrg2Imz41MD57Xy1Wp3cdMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EV5IVFkJH0BFDdHez1SDodfGp/nmaJToNafB1+J2kn4=; b=TV+kSllhIAPWYI8aIHprDtGh9g
 Kyw10PrsaqZaRT+H4WCW4uXTrnvp7NmzTH+atquLI8somapwiVt4h7K42JeD7u67pQo2QR44uTohd
 AVnNIpbSdh6HYc3Ub1P2GFkGjHdp+RGiTMagEEAbUnQwT/HAM5KJyiYK4fuGHYqENCh4=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmAj7-0053xt-Vq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 07:14:40 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CqF0g1zW0zhngY
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  7 Dec 2020 15:13:55 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 7 Dec 2020
 15:14:09 +0800
To: Jack Qiu <jack.qiu@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20201205074055.31574-1-jack.qiu@huawei.com>
 <20201205074055.31574-3-jack.qiu@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <e7a2181a-a794-dfb3-31d8-7c6b5e5b69cd@huawei.com>
Date: Mon, 7 Dec 2020 15:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201205074055.31574-3-jack.qiu@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kmAj7-0053xt-Vq
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: inline: set FI_DATA_EXIST
 improperly
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/12/5 15:40, Jack Qiu wrote:
> Only set FI_DATA_EXIST when f2fs_inode has F2FS_DATA_EXIST.
> 
> Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
> ---
>   fs/f2fs/inline.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 0399531efcd3..4ee5b5510593 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -286,7 +286,8 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
>   		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> 
>   		set_inode_flag(inode, FI_INLINE_DATA);
> -		set_inode_flag(inode, FI_DATA_EXIST);
> +		if (ri->i_inline & F2FS_DATA_EXIST)
> +			set_inode_flag(inode, FI_DATA_EXIST);

This was done by recover_inline_flags(). it's fine to just remove
set_inode_flag(FI_DATA_EXIST)?

Thanks,

> 
>   		set_page_dirty(ipage);
>   		f2fs_put_page(ipage, 1);
> --
> 2.17.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
