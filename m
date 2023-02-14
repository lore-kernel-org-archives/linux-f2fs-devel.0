Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B53C05027
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Feb 2023 18:07:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pRziF-000630-VQ;
	Tue, 14 Feb 2023 18:07:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pRziD-00062s-Bv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Feb 2023 18:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IAY8dVYRcdMdybIRO1qO9xEcgUoFoKW3T8FHzeAQ6lc=; b=OlbwsdeCEujHRXVxxc/A2iqVr+
 iZY5llYXkAhbKw3ktIxHNcV2Hez1dnmtsmtQkvFngxISwMewMU4e9CCK69zUQhu+5ZwhSpvxr7uQf
 qMgMs40yay3HC6RvhCmk4VWMwrdhZCg/8eZNJc2pwkLzpSsI8Vj7pJCZ5SgW0k/3/3j8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IAY8dVYRcdMdybIRO1qO9xEcgUoFoKW3T8FHzeAQ6lc=; b=XF8ax0QzIQthp1zuHu3JXo6Yzt
 Hvgylhz6S0MLttuUw7LJna63M4zQugN7uhaU/saZG8NUkQAeuQsdAz0dlPhsww/KyynwIyd6i3QVd
 BCx918l+FbFNdVod9By7Ei+88kueu6nI+QgvvGHOVD6Md7S/ScLqb+FGPVO4JEJe5xlk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pRziB-0001Ft-7k for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Feb 2023 18:07:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0EB61802;
 Tue, 14 Feb 2023 18:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376EC433D2;
 Tue, 14 Feb 2023 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676398042;
 bh=nSR8hVUSauHMlrOcczG32O1VhiEbOlM8in7Lm4PwEhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dxg+Mhsn4lxcC06z+dkoCPWr3JaiUr3WDh04awWbGuBj6UtkM8hMA2isJvKD7cTOm
 QkZL2TUqA1r1oUrnfKpsn2EkXjrpfT48N6UybcdOT0Z4d3JDJyOMJ1h8rwUNqtyC55
 y//2VPHYA362k7I5o3Xgtrw1hQA+anp5/qEaSo7Wjmp4mDiLpkEZmNKwAmV6Wz98ET
 C54fJrAMqUEKuKziPKSSX9b2g965bSdffDP3VeVNHOssbHZrenkbuRJH1zBxavnud7
 KPv34WV5SXe4ygNFaRP0CxnRJM0cwTzJXmnCsxMxqn+yr/EX4C4XBzbKcL9KC6Qbyb
 7MKkxr5s6XfYw==
Date: Tue, 14 Feb 2023 10:07:19 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y+vN18flpTqWwvll@google.com>
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
 <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
 <Y+p4jezz5asWoPhu@google.com>
 <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abb12474-f338-dedf-115b-da70e4946cec@kernel.org>
X-Headers-End: 1pRziB-0001Ft-7k
Subject: Re: [f2fs-dev] [PATCH] f2fs: make kobj_type structures constant
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
Cc: linux-kernel@vger.kernel.org,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/14, Chao Yu wrote:
> On 2023/2/14 1:51, Jaegeuk Kim wrote:
> > On 02/13, Chao Yu wrote:
> > > On 2023/2/9 11:20, Thomas Wei=DFschuh wrote:
> > > > Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> > > > the driver core allows the usage of const struct kobj_type.
> > > > =

> > > > Take advantage of this to constify the structure definitions to pre=
vent
> > > > modification at runtime.
> > > > =

> > > > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> > > =

> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > =

> > Hi Chao,
> > =

> > Note that, next time, I won't apply/modify any patches merged in -dev,
> > unless it has a problem.
> =

> Hi Jaegeuk,
> =

> Oh, any particular reason, to avoid unneeded commit id change when the ti=
me is
> close to merge window?

Hi Chao,

I'm trying to avoid breaking the -next branch.

> =

> Is there any period of grace before merging patches from dev-test branch =
into dev
> branch? Maybe a week is reasonable? so I may have time to catch up in tim=
e.

No rule, but I'm trying to wait for several days while running my local tes=
ts.
If the patch looks okay, sometimes I'll queue it right away.

Thanks,

> =

> Thanks,
> =

> > =

> > Thanks,
> > =

> > > =

> > > Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
