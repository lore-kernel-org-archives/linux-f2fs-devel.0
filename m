Return-Path: <SRS0=Iz0M=76=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C3C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:53:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A03020888
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bEmKoT17";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hYdDwuCN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhIwFYvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A03020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jlaNY-0003va-D8; Wed, 17 Jun 2020 15:53:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <naresh.kamboju@linaro.org>) id 1jlaNX-0003vT-9B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 15:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=; b=bEmKoT17zXu2r6IzWA6bFhMK4Q
 tfs54axu9Lsvf2vc53sLBkxWwx0ELPfXAp/UKuQfPrqYEayK/GI8zbgaCAklMjkFgGXZyFIzDxAa9
 VesaKXO8ZVVrQRfLpBF1+vDVdAee2RN8R4UEzUYkCSvPxb8A7eBkjE9ZzSj6k+NDrxOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=; b=hYdDwuCNY/29g0UlLf7MAVE/4b
 UGVYbD7GXuQfZUxWPk5gIn7i2qzO6psmeWuLA2e3S1R/z059jtP5zr5TXP2QgP4kFaLMqC/snRhr2
 nx9ELGtHTEwTy/voM0yGwtHpUd1LqJvVIdHdjOCv5akAkvwmzcOQKEnNJg7GeOihodaI=;
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jlaNQ-009XQU-59
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jun 2020 15:53:31 +0000
Received: by mail-lj1-f193.google.com with SMTP id a9so3481192ljn.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2020 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=;
 b=zhIwFYvqS5d/Wg1MMLhDRV3GH6WnWZlkpKF5Gvf2n+o3mBbraSv6/+gF1/wVQ7Kcyp
 adAODQsWOEjXxtmaTAY8OOgeomh977J+Ip2X4RUs+QJLXP8fCHiBMryYWwGWY4gfVz+j
 OiEw3dpJmeQ9Ih8zjHeprM4Gt9tFC88PRlY3V32JvNQHp+cM065+LxGIkdQfR1HdKSbO
 xKOJtEAbSIP0jDNqHyXlIFM3pvnyIAdrXeT9Vjt+d3kXsBP5VgSVyDytRxe/UXnnLsyA
 sJ7nJiD9AsZ7Gc1Ka2IK/tLWXp9TnAK5clcp93WHPbbonXUq5u2axMTwgQjbamGfwQSH
 D6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Iil/oRjunCxRdn4O9EnhL5vFoe9sKPuHAAfETKSmZUw=;
 b=hmGLSEqzacBhraql8dPpfm3n5LGHRXIEdBVvH/rLpN6Eel0+7A+1OXs2lJgFHniOew
 /6PtdQqrjuiIZcnQBnGP3ogqA1sQejTnUAOrlY6hv7aXTL1ynoz5rT+7VFeIdfZujTk6
 6RV4jPxtcvWSIAlVMTo0xXjbItr6rhrd3+TMCYZHO+P6Udpt+b2F23W6JBHzRvCv8F6a
 DssYiDzhvrJxOitAHE2J25v7k0ZKI9IbKFBr4JKPAG4DIow+xCWoKYDCCOs/jnC59q5w
 GMgQqOJwygCDhKHCYSLB3iLnSi4wQ7KtAVwgIILDfthmCDzQQ2CCF3KggfoCcn/UOHJS
 OPWA==
X-Gm-Message-State: AOAM532vrbcUbtkNRVniUoKCsIH9zvwBTTOelLV+/3bYaNHc7BeC/F9D
 YTqVF6uQtKURuspKAsZs8FrVxcg6I/ZqI2eoQTlDNQ==
X-Google-Smtp-Source: ABdhPJwm+SOMxQr6ZmVaQG7EF/eaCNB4joE8BGqCN9p7milYkBjvhRKAPIHCQedzXSIf3foSUUfPOKBfz2Igul1hd1Q=
X-Received: by 2002:a2e:911:: with SMTP id 17mr4655723ljj.411.1592409197458;
 Wed, 17 Jun 2020 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
In-Reply-To: <20200617141155.GQ9499@dhcp22.suse.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jun 2020 21:23:05 +0530
Message-ID: <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
To: Chris Down <chris@chrisdown.name>, Michal Hocko <mhocko@kernel.org>
X-Headers-End: 1jlaNQ-009XQU-59
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
 linux-block <linux-block@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 17 Jun 2020 at 19:41, Michal Hocko <mhocko@kernel.org> wrote:
>
> [Our emails have crossed]
>
> On Wed 17-06-20 14:57:58, Chris Down wrote:
> > Naresh Kamboju writes:
> > > mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> > > mke2fs 1.43.8 (1-Jan-2018)
> > > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > > Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> > > Superblock backups stored on blocks:
> > > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > > 102400000, 214990848
> > > Allocating group tables:    0/7453 done
> > > Writing inode tables:    0/7453 done
> > > Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> > > [   51.845304] under min:0 emin:0
> > > [   51.848738] under min:0 emin:0
> > > [   51.858147] under min:0 emin:0
> > > [   51.861333] under min:0 emin:0
> > > [   51.862034] under min:0 emin:0
> > > [   51.862442] under min:0 emin:0
> > > [   51.862763] under min:0 emin:0
> >
> > Thanks, this helps a lot. Somehow we're entering mem_cgroup_below_min even
> > when min/emin is 0 (which should indeed be the case if you haven't set them
> > in the hierarchy).
> >
> > My guess is that page_counter_read(&memcg->memory) is 0, which means
> > mem_cgroup_below_min will return 1.
>
> Yes this is the case because this is likely the root memcg which skips
> all charges.
>
> > However, I don't know for sure why that should then result in the OOM killer
> > coming along. My guess is that since this memcg has 0 pages to scan anyway,
> > we enter premature OOM under some conditions. I don't know why we wouldn't
> > have hit that with the old version of mem_cgroup_protected that returned
> > MEMCG_PROT_* members, though.
>
> Not really. There is likely no other memcg to reclaim from and assuming
> min limit protection will result in no reclaimable memory and thus the
> OOM killer.
>
> > Can you please try the patch with the `>=` checks in mem_cgroup_below_min
> > and mem_cgroup_below_low changed to `>`? If that fixes it, then that gives a
> > strong hint about what's going on here.
>
> This would work but I believe an explicit check for the root memcg would
> be easier to spot the reasoning.

May I request you to send debugging or proposed fix patches here.
I am happy to do more testing.

FYI,
Here is my repository for testing.
git: https://github.com/nareshkamboju/linux/tree/printk
branch: printk

- Naresh


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
