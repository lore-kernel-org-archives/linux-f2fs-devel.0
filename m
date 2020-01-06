Return-Path: <SRS0=h4up=23=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2844C33C8C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:26:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAE1207FD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Gt/QQKNC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cZnz9qaI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF9AnPuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAE1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ioY1U-0000GX-0C; Mon, 06 Jan 2020 19:26:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1ioY1T-0000GN-3u
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 19:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GO0UzBoLhk3X6zPIIyPoFsmhqx78YbnC1/SO0j/SCM0=; b=Gt/QQKNCdtdmgTKGmuPjy2ixy5
 x6QDOPt6WtMMTnlmgNvU5fVmJ0T6mJwLDpBq7j5qPk/v30L1JaOXOCKmbWVD+qiz5ioAhacfLRI+D
 Pp5DViUGKvXkEGLly8Ix6B0cWjLW0hf5BQn7ZgUR5daYdVvyS/hfcvg7oI3D7QvikieU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GO0UzBoLhk3X6zPIIyPoFsmhqx78YbnC1/SO0j/SCM0=; b=cZnz9qaI07tSa3RTyK5YyPcJ29
 abTrzo9NJ1VRaWqTYSHw4aQ2qrj+77IHp+sycHfe+uUAPmrVuC8EjVtjtkR0bI70qD7oobK/se0rA
 Wh+35pLQ3cce3OHQ0JtS4QnG8/Y3/yV8EhBWWxXDspufMMyWEZWHCnv77bYDsV3amk/Q=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ioY1O-00BrkX-Bm
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 06 Jan 2020 19:26:43 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1921207FD;
 Mon,  6 Jan 2020 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578338792;
 bh=VqTyU2RlTLgSzL+Ruz0hd8I1VqsH4XlXPDI9GzRjKhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AF9AnPuV6xe29dgVNaLfENYinKREP1vSQDAaZWjLgGFPhSoqUnN0bhj+HJ5afJxrS
 WZfDIS4wgMj2ume86S5efZdD+t929q+QSrFDG7mCvvm5EZxDesnrbib/PBNaPbB1e5
 uLFXiybTwHT11AS9w6i6oeREiY8YwQTejY6xI0Bw=
Date: Mon, 6 Jan 2020 11:26:31 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200106192631.GF50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
 <20200106080144.52363-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106080144.52363-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1ioY1O-00BrkX-Bm
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: compress: revert error path fix
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Could you please check this out?
https://github.com/jaegeuk/f2fs/commits/g-dev-test

Thanks,

On 01/06, Chao Yu wrote:
> Revert incorrect fix in ("TEMP: f2fs: support data compression - fix1")
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index f993b4ce1970..fc4510729654 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -601,7 +601,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  							fgp_flag, GFP_NOFS);
>  		if (!page) {
>  			ret = -ENOMEM;
> -			goto release_pages;
> +			goto unlock_pages;
>  		}
>  
>  		if (PageUptodate(page))
> @@ -616,13 +616,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>  						&last_block_in_bio, false);
>  		if (ret)
> -			goto unlock_pages;
> +			goto release_pages;
>  		if (bio)
>  			f2fs_submit_bio(sbi, bio, DATA);
>  
>  		ret = f2fs_init_compress_ctx(cc);
>  		if (ret)
> -			goto unlock_pages;
> +			goto release_pages;
>  	}
>  
>  	for (i = 0; i < cc->cluster_size; i++) {
> -- 
> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
