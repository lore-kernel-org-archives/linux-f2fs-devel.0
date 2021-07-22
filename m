Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C119C6377B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 01:40:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0760460FDB;
	Thu, 22 Jul 2021 01:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0760460FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6NhH-0002my-F6; Thu, 22 Jul 2021 01:40:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1m6NhF-0002mh-Bx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:40:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=; b=N0u3gAZxKPHVJwyIz/GJc4FT5z
 zN8DLS8rYv0IuUtgnLoau4RUNpOKVJPXm1ETa9VSmUfhv7hHBv5M4UuPIOVGp2QlseUqPjjari6Jm
 2LPyM2cWcEkTuyMoxWLEcdgHq60/7F9+QmJ5z2HsBWDnnPluLqKk1AXbXaSSbXTM2dfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=; b=OMOyQELnqe393pYfWR5XGb5Z96
 CLfni9+RrilkemP0/V9CZfIlsSOZcMyyc1vDxHBTkQ7modDpj8HvmggQ6n9ngvIQfEx70oT3pysEr
 VhEUi6pkhkqHR8MVB7KaeOsRr8VX30ceAHYUl+WAgTR8vvmIGAohOTDuCyQGiSyUjIWQ=;
Received: from mail-lf1-f47.google.com ([209.85.167.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1m6NhC-00GIka-68
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 01:40:21 +0000
Received: by mail-lf1-f47.google.com with SMTP id g22so6147934lfu.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Jul 2021 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=;
 b=EXRjUOr5oYArS2i3JP8TKaeSGun+zuOG+vnC5qIBfhOHtXBLHXzAswrWUEuMiGlgy3
 YsbvNpd0JTQpS+LR1YDhkTkeRFKTAG9ynEWYpShn9t2sqnYJ/+Fa/E8vP63MzwCaHLbU
 h1IwJWZ1z+ZqKlLA6XKCSCFN52VgBHyqeEgZw667z2dO9Qcu+ML7YZAu2HYqxOke7Sy9
 GpX6tk6KWsjwxfm/ot6MeCrmpmvHZc+CSxYn6IdzPthQ73VmlySuRurkNP4xTSs/ukvw
 IrviTWTdxc/VK94UsWEM1GSr6Xh84S3d4qi8Fnl+bR3QY3+MeDgqlD3FUuXwtF9Kp43r
 xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eWU7SdOsmeYo0TWfgP+Sn4a+QG5zD3wUdqHKbsK9/EA=;
 b=oV3DGZsB/Nj5a7N8w26vj/1QGy3c4r6t9NA9oq3QMy6g2v2b+pxER2VqtxpB0dIvnG
 NNgUS6ncuu3eFQIAhbc1cvEKLERcsav5zegqggxe6+pd4mIG24Am8ywEULHRrZfHBYUn
 MbZbu3pk3YA/lr9njf4mm3wNgQ9u3ggkV57PIbIBzyCuEpDnJcOlf411DNCgDX82CpyR
 iErQTjccey3/r15humaLyb307Ppm/QOS2Qw9kP/22aipAAZ9jEyeGH9w+WBJ5RPBQjWM
 +BqHBrlN9TukkBzI09ypon8bGczzdqcDmmmwOIGa6Ij+D1h6Qytk3CLYdthcMFniPbqo
 uKdA==
X-Gm-Message-State: AOAM533VADCdOqTYWNoiU43UA595ds/+jFASdOqZhldjWX04mGKpK+Kt
 e+Erc9U60R7r1EiEu/c7e0sSaSLTRu2QhJtYK4k=
X-Google-Smtp-Source: ABdhPJwUzHIuTlfj2HDSYaARWRI3kfa5pWpLCqC6mCujsgqa7zMaj2h1/zJ+KCVpfcd+a4yjurQws0KNmHaQ+/aS10Y=
X-Received: by 2002:a19:c3d6:: with SMTP id
 t205mr27042837lff.622.1626918011651; 
 Wed, 21 Jul 2021 18:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210721072048.3035928-1-daeho43@gmail.com>
 <YPiTLwB3d8BWSKje@gmail.com>
 <CACOAw_xq3_ccqzh8dnomFXBOK_iN9LOTsOBYSBzDJHSSDrRxVw@mail.gmail.com>
 <YPi4rRg2ZPFBWaTZ@sol.localdomain>
 <CACOAw_xeTSa8J_9=+6thXvFT75u734D5asNRogUxt+DC-tPhxg@mail.gmail.com>
 <YPjGsSEdsoSsCJlB@sol.localdomain>
In-Reply-To: <YPjGsSEdsoSsCJlB@sol.localdomain>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 21 Jul 2021 18:40:00 -0700
Message-ID: <CACOAw_yWAUNiziiQuZgRDaVrOxceuEpO8QtoYGmhxxJV2s7wWQ@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1m6NhC-00GIka-68
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 21, 2021 at 6:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 06:04:22PM -0700, Daeho Jeong wrote:
> > >
> > > How f2fs stores the mapping information doesn't matter.  That's an
> > > implementation detail that shouldn't be exposed to userspace.  The only thing
> > > that should be exposed is the actual mapping, and for that it seems natural to
> > > report the physical blocks first.
> > >
> > > There is no perfect solution for how to handle the remaining logical blocks,
> > > given that the fiemap API was not designed for compressed files, but I think we
> > > should just go with extending the length of the last compressed extent in the
> > > cluster to cover the remaining logical blocks, i.e.:
> > >
> > >   [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > >
> > > That's what btrfs does on compressed files.
> > >
> > > - Eric
> >
> > I also agree that that's an implementation detail that shouldn't be
> > exposed to userspace.
> >
> > I want to make it more clear for better appearance.
> >
> > Do you think we have to remove "unwritten" information below? I also
> > think it might be unnecessary information for the user.
> > [0..31]: 2683128..2683159 flag(0x1009) -> merged, encoded, last_extent
> > (unwritten?)
>
> FIEMAP_EXTENT_UNWRITTEN already has a specific meaning; see
> Documentation/filesystems/fiemap.rst.  It means that the data is all zeroes, and
> the disk space is preallocated but the data hasn't been written to disk yet.
>
> In this case, the data is *not* necessarily all zeroes.  So I think
> FIEMAP_EXTENT_UNWRITTEN shouldn't be used here.
>
> > Do you want f2fs to print out the info on a cluster basis, even when
> > the user asks for one block information?
> > Like
> > If the user asks for the info of [8..15], f2fs will return the info of [0..31]?
>
> Yes, since that's how FS_IOC_FIEMAP is supposed to work; see
> Documentation/filesystems/fiemap.rst:
>
>         All offsets and lengths are in bytes and mirror those on disk.  It is
>         valid for an extents logical offset to start before the request or its
>         logical length to extend past the request.
>
> (That being said, the f2fs compression+encryption tests I've written don't
> exercise this case; they only map the whole file at once.)
>
> - Eric

My last question is.
How about a discontinuous cluster like [0..31] maps to discontinuous
three blocks like physical address 0x4, 0x14 and 0x24.
I think we have to return three extents for the one logical region
like the below. What do you think?
[0..31] -> 0x4 (merged, encoded)
[0..31] -> 0x14 (merged, encoded)
[0..31] -> 0x24 (merged, encoded, last_extent)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
