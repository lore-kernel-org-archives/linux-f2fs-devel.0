Return-Path: <SRS0=5ZV8=MC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C2EC07E9B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Jul 2021 05:19:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4205613E4
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Jul 2021 05:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4205613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m25OG-0002YU-J4; Sat, 10 Jul 2021 05:19:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1m25O5-0002XP-Fv
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 05:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=; b=U1rk50FuIUSAuYWqPOpuGyJuvh
 S533HAgc14und7R25H1tsxAVqc0ADifALO9RxZehN2vkOubVWDKd+/3CVUK5jvnIYDqmE88iDqNsF
 9zKxvtCvP9/UbCedLPHQh01BTUW5iMqNBcCG89T24zOPTfY35Go2ZPiCMXoBCrQOtiT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=; b=h2ODTtJ9R7+7KAlD0dKf1TQ3Mh
 Hb9x/ZZlHDxNrsR1HXVBe5KDo/gYZDhnjHbAfMGFYkEceZxZFX8AoTzgjwvkeX5d/Skhcn+zPmB2W
 j/pmuZeCBbfKBOK3WEwbEcKsJkebA/Eid3tff5ko5Z1EXxCZ7MWi9R4eTxsGZNmYBnjo=;
Received: from mail-lj1-f174.google.com ([209.85.208.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1m25Nu-002wLM-3P
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 10 Jul 2021 05:18:49 +0000
Received: by mail-lj1-f174.google.com with SMTP id r20so11622954ljd.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Jul 2021 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=;
 b=EaEdVjTewqP2FMVCV+xBPaBTDaAjtdPk7FAEjRMotPxW8/vhdaBacCCFRKRa1s7tMk
 bO0Hy5Jjnl/m86iHHSrRt1N6uDcSI1JiYuyba+oqQKVudS4ojL18RddFTKzaWCMoZ3O/
 e2zOqu0mThC9o9oBoU/Z1/NF2rzs5TvHVK9aol2IDNkbvYsqAXmDwBvu3F5er0diQcKQ
 k2C1x72XFgLdqUhsdYPUtAKl4rZlilJSNYsOhzkHLSOsCMjWDMIYe2KuzGqve+CeB0sc
 /FdnlsWkcioStZs16bjFB89Jw2CWWQ2KBd5s8AyZhGd1Uy2wslJe1sFHQg1s4DkrMybT
 rD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v4mATH1rAH12LEIYPmoL9CK2Se4W4ULkmGT4gCq/XxE=;
 b=L1meTirVDSBS571pg4Twjir9BuuEOYqG7F3lc66S08jj+0dngOOWiDmLGbpfz0CHRt
 HPK646XSB5kfw/JKMNh45I5UmGdDrXuUUbWoY3gb42D9HXKqonWqx0SRao0OR2ohVHIk
 hWK8kgD3F9nrE7dkBYVmwMC1MVVObsamRO/Wkwt/S/dFk5cmhh9vN1DbWpG1k8W0HV+Y
 4G/HED3fbu97V3UwxbLcvoofCTfCRMOW0BG0f3u9rDCuO7WFZbjl+YsvXaZjTeF9dgqY
 1bLVvUOlBm5QQwRKltn5Ij7Bc3VKT0+9ygzh38vWcd9rd5MueGi/zi6KisSR8z0t14p6
 ndAA==
X-Gm-Message-State: AOAM531yMTqMeUcUTTglDNyxwmCGTolkyyBxKRUeO5TB2MSsQXjgXwBB
 GZO5yCj21p2i3c4aE3nqHzxvovGB2ij9WghIXPQ=
X-Google-Smtp-Source: ABdhPJybYhyTYehKBEjPvWk0GmpxHKoNPM/gwNzhOC2xs0gou3sdV/v7MkjXQoQ0RuWW6J9FqJSvhoIZ0/8JWy65CsQ=
X-Received: by 2002:a2e:5812:: with SMTP id m18mr6295729ljb.327.1625894309549; 
 Fri, 09 Jul 2021 22:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210709204430.1293298-1-daeho43@gmail.com>
 <4f88fac8-2838-45ac-8f87-789b8b7c2d09@kernel.org>
In-Reply-To: <4f88fac8-2838-45ac-8f87-789b8b7c2d09@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 9 Jul 2021 22:18:18 -0700
Message-ID: <CACOAw_zNH5hOJGSgbeBSMtOiJuU8Knh5oCVvA7rmsJBw5YYM9w@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1m25Nu-002wLM-3P
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get GC info for
 each GC mode
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
Cc: linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 9, 2021 at 5:17 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/7/10 4:44, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added gc_dirty_segs and gc_dirty_segs_mode sysfs nodes.
> > 1) "gc_dirty_segs" shows how many dirty segments have been
> > reclaimed by GC during a specific GC mode.
> > 2) "gc_dirty_segs_mode" is used to control for which gc mode
> > the "gc_dirty_segs" node shows.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
> >   fs/f2fs/debug.c                         |  9 ++++++++
> >   fs/f2fs/f2fs.h                          |  5 +++++
> >   fs/f2fs/gc.c                            |  1 +
> >   fs/f2fs/sysfs.c                         | 28 +++++++++++++++++++++++++
> >   5 files changed, 57 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 95155e4ec7fe..0d863eb185f6 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -493,3 +493,17 @@ Contact: "Chao Yu" <yuchao0@huawei.com>
> >   Description:        When ATGC is on, it controls age threshold to bypass GCing young
> >               candidates whose age is not beyond the threshold, by default it was
> >               initialized as 604800 seconds (equals to 7 days).
> > +
> > +What:                /sys/fs/f2fs/<disk>/gc_dirty_segs
>
> How about renaming gc_dirty_segs to gc_reclaimed_segments?

Makes sense.

>
>
> > +Date:                July 2021
> > +Contact:     "Daeho Jeong" <daehojeong@google.com>
> > +Description: Show how many dirty segments have been reclaimed by GC during
> > +             a specific GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
> > +             3: gc idle AT, 4: GC urgent high, 5: GC urgent low)
>
> 3. GC idle AT

Got it.

>
> > +             You can re-initialize this value to "0".
> > +
> > +What:                /sys/fs/f2fs/<disk>/gc_dirty_segs_mode
>
> You know, F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS needs to migrate all
> blocks of target segment to other place, no matter the segment has partially
> or fully valid blocks, so it looks 'gc_segment_mode' will be more appropriate?
>
> Thanks,

Reasonable~ Got it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
