Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10633C5478C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:38:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rdZVI-0007v5-Gr;
	Fri, 23 Feb 2024 17:38:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rdZVG-0007uy-Ga
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Feb 2024 17:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ucFxmdfuZ3Geip4gO2qoRomC82S1rXqpGu+DQxqOhVA=; b=PSgoS2lrKEEYGNDpBkTjg8M4Nk
 Ti2V0cYYd5Yl0cIikQcyQXp2xwQDzcbsIdfAcvm1vqKMZylogNnJ26RW8U0TQEh/nCQZmNP1+9rur
 CLXMJGRorqzBEys+s84iG/mSvd8V+Fj50HcF+7/iH8lZAQkcbnd4jP9q5QRcBeFOOYog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ucFxmdfuZ3Geip4gO2qoRomC82S1rXqpGu+DQxqOhVA=; b=CBVGxNgbENgHS2+sM7VaxwaPrP
 kyMESB5SKNba1mfv/sd1NRvcP6+U5pRfK7aLzZXdZmwrtvHkGwsB/kbNr0grkpbOFiZMJJFN2yK/m
 ZFBr9iMgVa4CWgnVD7Bh96ZDUfZa6MCZqEQnTcyhOBbkpx/orKTzzyKHQPV1YlqR7xHY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rdZVE-0007Q3-8I for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Feb 2024 17:38:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E04FECE2D9A;
 Fri, 23 Feb 2024 17:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9219C433F1;
 Fri, 23 Feb 2024 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708709897;
 bh=ttrzHMHz6eq+1XGV7AwZlunD2vgDHUr+e4dp54rXgjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fWCzy3j43oA72Js7OrwHVRgXRHqDpU/OiUWIAnfNLP4BpGxH6yhmKKDepanL0LF5p
 +Hr6f+i5d1ys6ys+Xt27OWltlBz5eXb5VoeJns0Un2uVR/yJxFsB60gtp0SE2pXp++
 QrJPOwE2VBL6NhNZqOUynmviaJGIT81lf/S95a7mIfyxnr4zjWmtfX6Z54G9Z1Lxg1
 9wK0zLhPfiW/tf2SW4F1OvvFjTS21VZjiUr9dcgMBY68/Xq6bV1rENR70IW4RoG31n
 JGNeidQ/3gk953LC/C9a24Fywzf1hmWxQmHd6IqKU+dXZgFqdw1Nkv9BkAzs9+lVmk
 BXjrlrwI98duw==
Date: Fri, 23 Feb 2024 09:38:15 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Message-ID: <ZdjYBwNTaxbZHpo4@google.com>
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
 <20240207005105.3744811-3-jaegeuk@kernel.org>
 <ZcQSV0HyTwoiW8os@google.com>
 <f174092a-192a-47f9-a1d4-14d86bba266c@kernel.org>
 <ZdT3EqOB-wXM1NLm@google.com>
 <CAD14+f106hmLXMOfLu_cd55rAKmv-KLq-HqCSrKULt27OPhk=w@mail.gmail.com>
 <ZdYylhiPrv9Pa7It@google.com>
 <65e03e4d-b7ef-27f9-2651-eac372f17a9b@bjorling.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65e03e4d-b7ef-27f9-2651-eac372f17a9b@bjorling.me>
X-Headers-End: 1rdZVE-0007Q3-8I
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: kill zone-capacity support
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/22, Matias Bj=F8rling wrote:
> On 21-02-2024 18:27, Jaegeuk Kim wrote:
> =

> > > Doesn't this break practically all ZNS NVMe devices?
> > =

> > Yes, so here I'm in questioning who is really using w/ zone capacity. I=
f there's
> > no user complaining, I'd like to deprecate this, since this adds code c=
omplexity
> > and unnecessary checks.
> > =

> =

> Hi Jaegeuk,
> =

> I like to make a couple of points to hopefully keep the support in a litt=
le
> while longer.
> =

> - NVMe-based zone devices continue to be developed with the pow2 zone size
> and zone size !=3D zone cap features. There was some divergence in the
> first-gen drives. However, all the second-gen drives I know of are
> implemented with those features in mind.
> =

> - A very active community is doing work using f2fs, and many of those
> members are working with the ZN540s device (which exposes a pow2 zone siz=
e).
> =

> - For drives with a capacity of less than 16TiB, f2fs is an excellent file
> system to use and is really useful for various use cases. We're using the
> f2fs daily for a couple of our workloads.
> =

> Work is ongoing on btrfs and XFS to support zoned storage devices, but th=
ey
> have yet to be through the trenches as much as f2fs has been with its zone
> support. So it would be great to have f2fs continue to support the pow2 z=
one
> sizes, as it is a valuable feature for the currently used and second-gen
> drives that have been released or are soon becoming available.
> =

> If there is a performance concern with the feature re: ZUFS, maybe the po=
w2
> implementation could be slightly more computationally expensive, as the
> feature, anyway, typically is used on more beefy systems.

Thanks, Matias for the background. It seems to be fair for keeping this for=
 a
while tho, IMO, non-pow2 could address both parties.

> =

> Regards,
> Matias


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
