Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F973C47094
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 23:47:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59974610E7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 23:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59974610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lqOyG-0005gh-Ic; Mon, 07 Jun 2021 23:47:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1lqOyF-0005gZ-BE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 23:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bfztbiz16oF+TgKNGJbBHKX61DjOq/OF4Uy51kuFiOQ=; b=Mq27+hh/b6wnI3j46+o0/mlDxF
 O78mE5euuz7tNoptz6EF+5ppLgDFAznJcLVBalzEoqM/le2bbTz9T84jAXT2iecAlCobWiY/5RPvA
 TeKzSg3D++qOTQQ2TmJ74gF5mcO+TkYJ/H36JSuXi2GTyge7505FDLZ6fwi0MA23EYHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Bfztbiz16oF+TgKNGJbBHKX61DjOq/OF4Uy51kuFiOQ=; b=GzhkFTAe+1zYsREQ2O0yMUFjPt
 fvAmu1FhhvbtMenQp2sgyMnjO3SX6lIIjwX2d60aiqg9ZHMPiBDG5oZnOG3p/D/3xPPy/IgR+E2Pf
 ikH05FfjpS7sEujKfGDFNM4gp52tWUaPm1407jk2kiGy2O5AojrdFay0ixjznCfQyVxA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lqOyC-00Go7R-Sh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 23:47:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CB93610E7;
 Mon,  7 Jun 2021 23:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623109663;
 bh=bnHo1ahnMtzIECUmZYxoFPz90v3g99AYWe+v6R24ZI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=otp3fkgcxCcUHl4PHxHfR4hE+jxni87eLJ+77Q2/3vEFxJKGtH8iv+nrPj+qI3G7B
 yhfX4u8HMbztotB4IUC6Kkv9Id961rgnwySwcA2y0hy5JT9v7c0lif7ZJyHZsz/iG3
 tt67TmxR74r1ZDTq3OekzIAFEHJAZU3s6yK3/XpWQIJMU0MUIfY01cbyfeITYVH0lm
 0K9ennsNvHNQEkTdBqwVo+je0IDWZtPNeX/rMPQVDWvLZmhwksznnhdX/CWkd++cCD
 mFklQ9yG52Hqw03QlbOaswBBcgxIGapIfwf5C8vE8lZ9r7cwHD+pOschngJKcr9zVd
 A7vH5zm7PKc1Q==
Date: Mon, 7 Jun 2021 16:47:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YL6wHViJbCKVGx4K@gmail.com>
References: <20210607232715.3669-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607232715.3669-1-chao@kernel.org>
X-Headers-End: 1lqOyC-00Go7R-Sh
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce cf_name_slab cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 08, 2021 at 07:27:15AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Add a slab cache: "f2fs_casefold_name_entry" for memory allocation
> of casefold name.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/dir.c      | 16 ++++++++++------
>  fs/f2fs/recovery.c |  6 +++++-
>  fs/f2fs/super.c    | 24 ++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 7 deletions(-)

Looks good, but "f2fs_casefolded_name" would be a better name for this cache.

"f2fs_casefold_name_entry" makes it sounds like it contains some bookkeeping
information and not the actual casefolded filenames.

> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 96dcc4aca639..ee400562157d 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -16,6 +16,10 @@
>  #include "xattr.h"
>  #include <trace/events/f2fs.h>
>  
> +#ifdef CONFIG_UNICODE
> +extern struct kmem_cache *cf_name_slab;
> +#endif

Also this variable needs to be prefixed with "f2fs_".  Otherwise this will cause
a build error if/when ext4 adds the same thing.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
