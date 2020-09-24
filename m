Return-Path: <SRS0=IJe+=DB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F1DC4363D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91E121707
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="nWVssHvA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iqZ7k+T9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9VS01GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91E121707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLXSj-0005L4-1l; Thu, 24 Sep 2020 20:03:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kLXSh-0005Kp-JA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 20:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3UZ74bBhZsWR1uph0JAak8WFzkzqogzRIak985IrpYg=; b=nWVssHvAptWNaHR8rLBZ7n7hSa
 px4EPbd95s5KfFAng3A0hOZCqETPiwfhsE64DTQaf1iRY4Si+QKAEbjvJq+PGZWeQb0KvhH4H9ERH
 TLrHye4E+ppKnVfGqnourL2Tv5C+LGuvSM9EJ/9Sqz6z0U0bTN6tZDEAvrCVbc/VDrso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3UZ74bBhZsWR1uph0JAak8WFzkzqogzRIak985IrpYg=; b=iqZ7k+T9XEVe0+rdWEKu6magIj
 Fv3Agt5JFKWbaQQcUvo6bbP0GaQF8+k9mmLvhAXdcSeJiqSM4WrcKsmGnA5Cb4j99L2AoRPyeWOA1
 rfSYckL1p/T3L0WsxYBtdyr4gkvcf6BF0/NYLFEJpKyxnUt4R9yN+mSbhGK+3PTjIe6M=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLXSW-006f3P-Ak
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Sep 2020 20:03:27 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CC48621707;
 Thu, 24 Sep 2020 20:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600977786;
 bh=4qmfMtKFtj1GJGkFkWVAtlMq33rZaTCs31/4IdPYFgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q9VS01GBzz6O6mO0j9z64QuPZISKKrv+9/L5RHqR2fvjRa2GE52yanS/0NdJ5me/Q
 ZvAnEk+SO6dz4UyHxJUC4XQAkSOv348iREjEmnJluefIBb0SZrypQkR0t2u4tuCThC
 YUNOLt3BSKhff+6NGw16fzuu0oX8md72JUsAwhAY=
Date: Thu, 24 Sep 2020 13:03:05 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200924200305.GA2568648@google.com>
References: <20200918030349.19667-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918030349.19667-1-yuchao0@huawei.com>
X-Headers-End: 1kLXSW-006f3P-Ak
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to disallow enabling
 compress on non-empty file
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

On 09/18, Chao Yu wrote:
> Compressed inode and normal inode has different layout, so we should
> disallow enabling compress on non-empty file to avoid race condition
> during inode .i_addr array parsing and updating.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 58e464cc15f0..139fdfc1dc55 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1821,6 +1821,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  		if (iflags & F2FS_COMPR_FL) {
>  			if (!f2fs_may_compress(inode))
>  				return -EINVAL;
> +			if (inode->i_size)

Changed like this.

+                       if (S_ISREG(inode->i_mode) && inode->i_size)


> +				return -EINVAL;
>  
>  			set_compress_context(inode);
>  		}
> -- 
> 2.26.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
