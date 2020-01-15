Return-Path: <SRS0=YOv7=3E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EE6C32771
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AF9222C3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="doySpTW/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mwJp8fac";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/0gVxnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AF9222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irqT3-0006kR-C7; Wed, 15 Jan 2020 21:44:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1irqT2-0006kG-IY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 21:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6skYaZ/a/MFBkD7IVCfCvlA3DYvdQDqfoyBsNT8csyo=; b=doySpTW/uqcmEEMePOAIumi6eK
 Y/BQavtyhYu7tHhakWUvE8jB+SIYvCh7JPQkqBW3Tw9n69Uif9vtBEGZ4UYzC+36fzoG5wGzV6btQ
 kvqwpul9PsgP22TOSzik9PMvXf1L+1htTLKKve6sW3L7By8HCzQcp73sdxn4dcRpKOh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6skYaZ/a/MFBkD7IVCfCvlA3DYvdQDqfoyBsNT8csyo=; b=mwJp8facofHrrEXT+ZaG17q6dy
 yOx0TG6tI2WMIk/LKmJ7JhjL3Uc+01DqzNwBTK+oYrMjIL2eNDPge1uqZc6wiOFwdbem07pMK1OdX
 xbb0W5gvys+1VDzd+1aCiUOM0u0ICjrXicHMYRyD55WUmWJuJe2m3+s4y/DLW5vXNLjE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irqT0-008BUS-PA
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jan 2020 21:44:48 +0000
Received: from localhost (unknown [104.132.0.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BFBE222C3;
 Wed, 15 Jan 2020 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579124681;
 bh=mE/mjZUev0yWvsC/cdIQQ/2Qb6eYka5CK2eFeu8pbQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X/0gVxnbzIOTvm8thhpsxDek7Zjf+LrsoK5jZp5opS37qy7ZLJqtiJMQsseDTjcE5
 7fGgDy/w+49Ywon+fjhrMt/rz8VYhjuEYaU81FBLQ5iNs4FGT4bhG0QgtlA3//YCTs
 pFRhLD9Qh0wTC42lS26hHny2Ybt+ge6g2srPddgs=
Date: Wed, 15 Jan 2020 13:44:40 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Message-ID: <20200115214440.GC57854@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
 <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
 <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1irqT0-008BUS-PA
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
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
Cc: Yuehaibing <yuehaibing@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/15, Shinichiro Kawasaki wrote:
> On Dec 26, 2019 / 17:24, Shin'ichiro Kawasaki wrote:
> > On Dec 26, 2019 / 14:05, Yuehaibing wrote:
> > > On 2019/12/26 11:44, Chao Yu wrote:
> > > > On 2019/12/24 20:43, YueHaibing wrote:
> > > >> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
> > > >> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used [-Wunused-but-set-variable]
> > > >>
> > > >> It is never used since commit 362d8a920384 ("f2fs: Check
> > > >> write pointer consistency of open zones") , so remove it.
> > > > 
> > > > Thanks for the fix!
> > > > 
> > > > Do you mind merging this patch to original patch? as it's still
> > > > pending in dev branch.
> > > 
> > > It's ok for me.
> > >
> > 
> > Thank you for this catch and the fix. Appreciated.
> 
> I have merged YueHaibing's change to the write pointer consistency fix patch
> and sent out as the v6 series. Thanks again for finding out the unused variable.

I applied the fix in the original patch.

Thanks,

> 
> I was not sure if I should add Chao Yu's reviewed by tag to the patch from which
> the unused variable was removed. To be strict, I didn't add the tag. Just
> another quick review by Chao will be appreciated.
> 
> --
> Best Regards,
> Shin'ichiro Kawasaki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
