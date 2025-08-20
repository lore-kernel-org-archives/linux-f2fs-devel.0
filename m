Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD16CA0EDC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4cbrT3nMQW6+p3VHhA1xmPwK3ebnbArLipkF1Lh7Ck=; b=X48ixlTkdLD/kVJTetTY6cDp1p
	Q3GhbDchZ3VdHUOreupXjtLZ19RdApK2lkg4pnMl/TXzk//jAAd4jUt9gJI8TSCuEymaBUGFhtOmw
	3fLZLhFXZGBdkI7Q03tjCXKCC/F+ZtDB9wnpfOwxJDHMImGcnNsbnx9Q3xK/w8I6sMW0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uomrk-0000kV-U9;
	Wed, 20 Aug 2025 17:44:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uomrj-0000kN-SC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Aug 2025 17:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BH1ckPfbvet82R9XwGPIo0ZQrjqsKGvIatV2CftBpZk=; b=FsNipImmjxFrm84NXHut6yoyd0
 mLjKK7jCmuO239VYcJ4VmXR/03pQZ6h26C409DgfM2YIX4pYKLGf+trvvaqOq2KTWIIfo244M1p/6
 WhYzt5MkuBRFUdev70o/OIZ4PiNCjG0gG/LEsrdpRm76PtCfN06+9rHFJkYSgewGn+bo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BH1ckPfbvet82R9XwGPIo0ZQrjqsKGvIatV2CftBpZk=; b=euRLjTS8cew5vn2gXb/eA7cLOT
 vFjX4W+4zjKHFyq+1p6c64hL3VjU7WxBts/gUxe7+JUJ5IDPLidVt910mMpaaCmTxxcgOWfJ+kB44
 tRUicLwCoq1BUVNjOUIgaWVeJpBgMACQZ3pEni8rChHh04XnTLgcZ5lLFj0CW4Z3Xu3Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uomrj-00051C-H2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Aug 2025 17:44:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 293C45C6677;
 Wed, 20 Aug 2025 17:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D1C113CF;
 Wed, 20 Aug 2025 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755711880;
 bh=OuwMD01vwGnn8S744iD11gw41Q7InIVrJolg3lPlQS0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/QdQHi1ke8bbF4UY1epgxkbN2tghghXqnCWYKQQKOoLBBdubXMUFNvA6BlMpOfuR
 Rnrnh3SAlL3mgaEWNjc5W/jmhQAyT5RpgGlGD5nQhqJ+K+U9cnR+w3/1jMqgRsc+6+
 zWT6FFxviit9J3/W3iY3YLfxxtP9u+IVzlEWGHq7PV7vhm4ribK+erkyFN6qkERd36
 cuYREuwdzpyPl4+0PNnU9LyQ6/6lwR4uWRCx0MP7RBXbepSohda54UlpP+eC/JulTi
 XlmZ1aCIAF1VbayGQnuPZM0utceCx6ZrHoJjZscOfaYCIb47OBKZbyTHzXGK/L9CBy
 P1UkaLNI/5QLw==
Date: Wed, 20 Aug 2025 17:44:38 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aKYJhtJRuszUhj37@google.com>
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
 <cd82a673-aa43-46bc-be67-6924500376ef@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd82a673-aa43-46bc-be67-6924500376ef@kernel.org>
X-Headers-End: 1uomrj-00051C-H2
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/20, Chao Yu wrote:
> On 8/6/25 20:32, mason.zhang wrote:
> > This fix combines the space check for data_blocks and dent_blocks when
> > verifying HOT_DATA segment capacity, preventing potential insufficient
> > space issues during checkpoint.
> > 
> > Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> > Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> 
> It breaks f2fs/005 of xfstests, can you please take a look?

Ah, this was why I got failure. I'll drop this first.

> 
> Thanks,
> 
> > ---
> >  fs/f2fs/segment.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index db619fd2f51a..d8dae0049b6a 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
> >  				get_ckpt_valid_blocks(sbi, segno, true);
> >  	}
> >  
> > -	if (dent_blocks > left_blocks)
> > +	if (dent_blocks + data_blocks > left_blocks)
> >  		return false;
> >  	return true;
> >  }
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
