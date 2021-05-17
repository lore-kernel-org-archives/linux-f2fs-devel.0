Return-Path: <SRS0=cGqQ=KM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86EC433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 May 2021 17:28:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BAA60FDB;
	Mon, 17 May 2021 17:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BAA60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lih2D-0007tt-Jv; Mon, 17 May 2021 17:28:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lih2C-0007tg-Bj
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 May 2021 17:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3TgoThrxtnCqmUNI7tWvMvw6065+CrdYkBjEGLPUtEg=; b=ZUW/2+HT9w4M55f2JsmHlAPZgf
 PzrJDpgqUO2NFIzL92STWFd16fP5ulmqkRHjTbx+bVQFRwOXGJPuZVLxu+nXzEhD4azH/dPWzuHn0
 imzVEnhpMdOUjwoUyCdO3kKDS6bds2TA/eFh4R20mVOhwQDjZSpP9tl80O5cYp9/EBA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3TgoThrxtnCqmUNI7tWvMvw6065+CrdYkBjEGLPUtEg=; b=EVA+CRLujC1ktKAHMKHuGXfTNv
 E6OIW0qMGYo7FTSN2uKlU6RCyHYPo/QCyNy9nx+Jd8GU9+TP4BiAA2y/D9Y2Z87gtjDaV9OyfW7GU
 06j5Bt9ZdSuPr9XYxczZGoxe68/CBI0KLt71Qlk9lLAg9N4i058X+eW80JUsPX2/upsg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lih20-00Bhtv-E7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 May 2021 17:28:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E1860FDB;
 Mon, 17 May 2021 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621272467;
 bh=XEjLvdy0CWJOwACIZyypbKf5Baefw5IgizZM3DSDsOE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aKkUoCkRwjSqbF2vpGLse+53r6EzeCWPt7SVerxnnYnOzfdwZ61CLDFfYDXCfycFi
 dspssmA7VWLGheh5gLMKLZeKe07whbcZfwknycQgwGybq2ZPH3dcwkDjgqg8HxMrs5
 z2BtP4yXrCQ4OdUMou1LAHFhNoiEqlFqB1jbMxepbpa9hIpkckL+FpmHPmZSTGLErN
 eIs1/BuQeXZ67BPsHVo2MJsxVJMR33IZt/4aMJ9hjgc0DkXT7UoaPovQA0M1vQ928T
 J8/IMVmFBs7oGVelUzb7wHMRl1GOr1vwiga2MKYsjhLv4UJyh98n2GPpnhZr6BQnqX
 cWkp1nQQUK+Tg==
Date: Mon, 17 May 2021 10:27:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YKKnkSag35cDXh0Z@gmail.com>
References: <20210517011557.21722-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517011557.21722-1-yuchao0@huawei.com>
X-Headers-End: 1lih20-00Bhtv-E7
Subject: Re: [f2fs-dev] [PATCH] f2fs: add MODULE_SOFTDEP to ensure crc32c is
 included in the initramfs
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
Cc: jaegeuk@kernel.org, marcosfrm <marcosfrm@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, May 17, 2021 at 09:15:57AM +0800, Chao Yu wrote:
> As marcosfrm reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213089
> 
> Initramfs generators rely on "pre" softdeps (and "depends") to include
> additional required modules.
> 
> F2FS does not declare "pre: crc32" softdep. Then every generator (dracut,
> mkinitcpio...) has to maintain a hardcoded list for this purpose.
> 
> Hence let's use MODULE_SOFTDEP("pre: crc32") in f2fs code.
> 
> Fixes: 43b6573bac95 ("f2fs: use cryptoapi crc32 functions")
> Reported-by: marcosfrm <marcosfrm@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3f8a7a6c250c..fa0ce6301c16 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4431,4 +4431,5 @@ module_exit(exit_f2fs_fs)
>  MODULE_AUTHOR("Samsung Electronics's Praesto Team");
>  MODULE_DESCRIPTION("Flash Friendly File System");
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc32c");

Shouldn't it be crc32, not crc32c?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
