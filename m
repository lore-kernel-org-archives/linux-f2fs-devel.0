Return-Path: <SRS0=qDwu=7D=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA057C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2020 09:55:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE5C204EC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2020 09:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="d1AZwAWN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dhjjLbTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE5C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jbhvB-0005dq-8Y; Thu, 21 May 2020 09:55:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mstsxfx@gmail.com>) id 1jbhvA-0005dj-NS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 May 2020 09:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3bYIDtSe0AYOWKep27yvyR4GhELIyYbRcGxHnYqpsNk=; b=d1AZwAWNsEXVN+hjr7Aw5vAYtv
 VpNp3ji2xZPFM6g/talYwIxyijF78OBif6cLoXlipIPCAWpXVz51fJMOMg0XuccuuCpet0ZRztYRx
 Hg1f1d0IgaU3ilz7fPdY6p4Z+Byux48TA0iTiGHth0vJt9Sie2xfgAY1OrES1xL/NI1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3bYIDtSe0AYOWKep27yvyR4GhELIyYbRcGxHnYqpsNk=; b=dhjjLbTd/BCq/RpqHXYVUkZhDh
 b6Ac5NRW6Cr7HxSphh0LCWCpREVsaG47nde6BAhBUpFMJ/IndfpNSyLQHIt/hUnhAfTZPONoJhjmg
 S/m2K/wESv08fN+oWwAMFndCVQOseM4zP6fPMrW4FQSfPhWSz2nSxrLui/s0JugZmXSM=;
Received: from mail-ej1-f66.google.com ([209.85.218.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jbhv9-003i7X-1s
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 May 2020 09:55:24 +0000
Received: by mail-ej1-f66.google.com with SMTP id x1so8043186ejd.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 May 2020 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3bYIDtSe0AYOWKep27yvyR4GhELIyYbRcGxHnYqpsNk=;
 b=Vchsl8Kc6F4YQKQeruDhjiD4TK6xI+NYH+Ipv4uWf01ET8Ovd4inSe2fmXj7qE9jRt
 PABS1p6q63SDnxzf8SlTZJ7nB1eAPUIMbGQUl57bb6CyCHC9q/GY6Jx+pusfjKqeStMW
 nWqcFcz2ciD/rleardHBdjrYAlkweKHA9czFafG0UZxpF8FKtra/YusuO5Xl4ivz+yOc
 MAIuuruKRqzlrCJH+byI96UDV4l2gZnG5SO7Nugfq+7tSm2TR2IW0SCM4JsVvrEVrO78
 BXeBYGPrNlsbhK63cCm2sOAqrR3JzANqonDQnkkuFA+VGHMB5K7AYxRrNKBPJtPqpK/q
 GhwA==
X-Gm-Message-State: AOAM533Wu7zXVIecuD1WxrE4SGc53QuFmEaiWqHHV2FgKORESD7hWgkQ
 4XDV/u2Zvyk2AXHWjZ80TZY=
X-Google-Smtp-Source: ABdhPJwkPKl947oxLKA7srqAfs9xs94g1gTJJERLoHvA+HQQuyirxmJpvQaMulbG/+j+XCDL1aFAmA==
X-Received: by 2002:a17:906:3a11:: with SMTP id
 z17mr2778167eje.460.1590054916702; 
 Thu, 21 May 2020 02:55:16 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
 by smtp.gmail.com with ESMTPSA id z12sm4507462edk.78.2020.05.21.02.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 02:55:15 -0700 (PDT)
Date: Thu, 21 May 2020 11:55:15 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Chris Down <chris@chrisdown.name>
Message-ID: <20200521095515.GK6462@dhcp22.suse.cz>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520190906.GA558281@chrisdown.name>
X-Headers-End: 1jbhv9-003i7X-1s
Subject: Re: [f2fs-dev] mm: mkfs.ext4 invoked oom-killer on i386 -
 pagecache_get_page
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
Cc: lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Yafang Shao <laoar.shao@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 20-05-20 20:09:06, Chris Down wrote:
> Hi Naresh,
> 
> Naresh Kamboju writes:
> > As a part of investigation on this issue LKFT teammate Anders Roxell
> > git bisected the problem and found bad commit(s) which caused this problem.
> > 
> > The following two patches have been reverted on next-20200519 and retested the
> > reproducible steps and confirmed the test case mkfs -t ext4 got PASS.
> > ( invoked oom-killer is gone now)
> > 
> > Revert "mm, memcg: avoid stale protection values when cgroup is above
> > protection"
> >    This reverts commit 23a53e1c02006120f89383270d46cbd040a70bc6.
> > 
> > Revert "mm, memcg: decouple e{low,min} state mutations from protection
> > checks"
> >    This reverts commit 7b88906ab7399b58bb088c28befe50bcce076d82.
> 
> Thanks Anders and Naresh for tracking this down and reverting.
> 
> I'll take a look tomorrow. I don't see anything immediately obviously wrong
> in either of those commits from a (very) cursory glance, but they should
> only be taking effect if protections are set.

Agreed. If memory.{low,min} is not used then the patch should be
effectively a nop. Btw. do you see the problem when booting with
cgroup_disable=memory kernel command line parameter?

I suspect that something might be initialized for memcg incorrectly and
the patch just makes it more visible for some reason.
-- 
Michal Hocko
SUSE Labs


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
