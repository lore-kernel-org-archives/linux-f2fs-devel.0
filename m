Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E026C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Apr 2024 20:56:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rvNwZ-00079P-PM;
	Fri, 12 Apr 2024 20:56:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rvNwY-00079F-Tc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Apr 2024 20:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f2eAdr6I+AQXSfPM/kBjIb0AhFwkO+Rou078T9dpguo=; b=WJYR4yVNg2ARhPHddWRkZXsN8V
 KQgFWdp57AK9AwUiF+Yj8X7Mpn9lLnjgMXOUqnbcu98hNS9VUHVWZP9/FtP8DP0MIGZNG9UigWJaY
 u7310TflmDaTdfj/fmGaFCArs2/KYTo+KqFk7QLArKyOHTE5bchDoSuKuSCbnjOUZdxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f2eAdr6I+AQXSfPM/kBjIb0AhFwkO+Rou078T9dpguo=; b=akUF99aId5O5Wp2ZklvA6y+cmg
 vX8y+ynuIMHZt5uXXYPvKbW2kLayCmpCAiLJwJhegtmUIV98jYF+XvrdFBUUu8RgkbuyV0CSaqY0L
 oxBejpmBSa5DWRYjaVIGal1xHQ9T1DYlPQgtIgQEDvwq2ACCkywzgJkKgpv3bkKaHdNo=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rvNwW-0004cm-I8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Apr 2024 20:56:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1A381CE2387
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Apr 2024 20:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E969C113CC;
 Fri, 12 Apr 2024 20:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712955364;
 bh=EqCqyiam+TyOhBuv0Ql8sinMo9ZD/uH+9B8oI0QJNeQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SCVda51fezwFmGWgStTpm1VbFuIAunct53zJGSzKB7TykRR5SUga4mgtvZdrtf1rs
 F7ckHwjUoypk6vvQ+HMzPtgVPvpdQnmqcQAugckVVn9ZdMQtQhmPh2VAGN9/6D7DO8
 QYXewx3M4LaTSKOG+q8UQ7NN/cSn+Q9+YFYAcsBpUEKY5caiAhOUgJRgC6HXgtfVl9
 WqtwamsUuyBDbutywDq7MNAwiPJa18ZDwIXYePG9T1C7D5B5DAzgaLAKAfyy+YoafD
 QVJYg3YRHj+lZYG42FNHAqa5IbHOWxVEQ/FqbdFKHPzVWzdfTLkF/+2loXZIUknqEo
 0Tu4xVvkCra1g==
Date: Fri, 12 Apr 2024 20:56:02 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Zhmf4klcOr4eplin@google.com>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-3-jaegeuk@kernel.org>
 <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
X-Headers-End: 1rvNwW-0004cm-I8
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block
 address
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

On 04/11, Chao Yu wrote:
> On 2024/4/10 4:34, Jaegeuk Kim wrote:
> > f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> > not the corruption case.
> 
> In which case we will read ahead invalid meta pages? recovery w/ META_POR?

I was trying to debug another issue, but found the root cause. Let me drop this
patch.

> 
> Thanks,
> 
> > 
> > Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index eac698b8dd38..b01320502624 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >   		break;
> >   	case META_SIT:
> >   		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_SSA:
> >   		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
> >   			blkaddr < SM_I(sbi)->ssa_blkaddr))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_CP:
> >   		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
> >   			blkaddr < __start_cp_addr(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case META_POR:
> >   		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> >   			blkaddr < MAIN_BLKADDR(sbi)))
> > -			goto err;
> > +			goto check_only;
> >   		break;
> >   	case DATA_GENERIC:
> >   	case DATA_GENERIC_ENHANCE:
> > @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >   	return true;
> >   err:
> >   	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > +check_only:
> >   	return false;
> >   }


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
