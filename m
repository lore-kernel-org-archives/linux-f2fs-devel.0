Return-Path: <SRS0=HVTi=NL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E12BC432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 15:21:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0023861166
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0023861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mH6KJ-0008Bj-E8; Fri, 20 Aug 2021 15:20:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <daeho43@gmail.com>) id 1mH6KI-0008Bc-Df
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 15:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=; b=MfrOYM+Dd3GqSWrpNuaUMgWgE1
 egkrIeRQ3/uDKEy3EsqthaTAKPghkPk7v/Vkh2QzJroQtAlBZ8YQpzEuCw6j48muSlYbBlejeyV+K
 v6+IfC0z2hJQsnIeFsvjAlmhq4XdrLFAXgYO25953hs+ZO9+FDmSgjGPa4GW9c5DgO8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=; b=LjapAWQyHwwL3j3DQdtui7+wEz
 bTtrsSX4NOrLenf2GKXVT6fvA8nzI9iMNLQqwsTHG9WSvZzD6mnjpB0+teTfE61fpGq1pY9rPmlqy
 L9TGOUWCPQH8opoGJjbLqjQSfABP8NsCKTRLBXdHmlD3sKMpnSdG0YznWU7FoZouQHFg=;
Received: from mail-lf1-f47.google.com ([209.85.167.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mH6KH-00Csk4-MW
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 15:20:58 +0000
Received: by mail-lf1-f47.google.com with SMTP id o1so3099014lft.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Aug 2021 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=;
 b=fGtrdnFpPtcwTxnxcEqd4hXGv5m/IwXMu6zHgsjkRMyBail4gdmQ/puuHj/QWaCVCq
 B2+s+lrSUego0C1JxtiO6EjLCGAn/8Ck/cQE1W63CW1z2crAi+dg3BUldWvoeIg9jSu2
 Fvmiu9DV0v9BJGeAeuge0DCOYk2uKDPdFAq3Noc5iZ2x1NFtcGPHyzds0c4H3NNOprhj
 4wpO9zq2tB5rTwrwrld2vmyKyjFpURdVstDegxPmx9/2j8+oDmc1yas3l1RDJG8IE3NC
 ryOzksZoKWzIW0A23CgHMu8d9BZvtMw6+B2AmKdorepfZulAzBJHoIq6XjkQ+RZE91f6
 tbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+3Z4SJ92yMv1cU71E0Fc+Pt/WE6+UKZ4tmdm2fUYN4I=;
 b=IwkH3jRiw1vLMKrK4tord0/mnAvWw6KzfaK1aGFlk3fQCOvr+OkeTXTkZ3RbmWlF8r
 be/rw+iEKy8dtIwky3kJxoZJrvUdvSqSDTNsfaRKk+lxFGvUSiiDfdtJLjHWJA8oQFaW
 F7AX994tsWhanG8APzLZ3v3FA4tB08v8A7R7RbwElTwpV3Uc96iVioL57QZ4+p+912gA
 u0T9zYV5IP2TTptFP9+zd0KHSRZI+AZKkAijebdhRxgU4EB7RmDs7L2HNNrjzWhF9yeh
 2IT2TbVjnhVi4MYw1WISYihctfapx7/OeD668Bk60MmuN4QUusD6/iYsGz1ebucZTY/g
 DHVQ==
X-Gm-Message-State: AOAM532TXOg0Eyb9PygQLCdYEbGQE1uMMAqk4XEwU7ckSeJnVI8uyZ4S
 v0S/n//mTwW2k2XOLFJmnO/R3uKuVB6JD3qANFU=
X-Google-Smtp-Source: ABdhPJwhgWUpB24B5xOZbrVx5H/6RcYKALsAPmKxUwkQH/ZVyccnhTyVnPNEs0g+SZBhNeYKkeBze0gjCredrfZxJ28=
X-Received: by 2002:a05:6512:c08:: with SMTP id
 z8mr15321526lfu.533.1629472851101; 
 Fri, 20 Aug 2021 08:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210808215234.1939266-1-daeho43@gmail.com>
 <5cce41d6-d59a-0596-6d14-e313aa91c78b@kernel.org>
In-Reply-To: <5cce41d6-d59a-0596-6d14-e313aa91c78b@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 20 Aug 2021 08:20:39 -0700
Message-ID: <CACOAw_zdL+3TPxJfsrZ0+nMHBbzU+uHNcp4vych1QCMMpvUnug@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1mH6KH-00Csk4-MW
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: change fiemap print out format
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

On Fri, Aug 20, 2021 at 3:15 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/9 5:52, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Given fiemap way to print out extents in the kernel, we can correctly
> > print the layout of each file in a unit of extent, not block. So, I
> > changed fiemap print out way like below.
> >
> > Fiemap: offset = 0 len = 60
> >       logical addr.    physical addr.   length           flags
> > 0     0000000000000000 00000020032df000 0000000000004000 00001008
> > 1     0000000000004000 00000020032e0000 0000000000004000 00001008
> > 2     0000000000008000 00000020032e1000 0000000000004000 00001008
> > 3     000000000000c000 00000020032e2000 0000000000004000 00001008
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++---------------
> >   1 file changed, 34 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> > index 42dbd60..0d2948e 100644
> > --- a/tools/f2fs_io/f2fs_io.c
> > +++ b/tools/f2fs_io/f2fs_io.c
> > @@ -731,11 +731,11 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
> >   #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
> >   static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
> >   {
> > -     unsigned count, i;
> > -     int fd;
> > -     __u64 phy_addr;
> > -     struct fiemap *fm = xmalloc(sizeof(struct fiemap) +
> > -                     sizeof(struct fiemap_extent));
> > +     unsigned int i;
> > +     int fd, extents_mem_size;
> > +     u64 start, length;
> > +     u32 mapped_extents;
> > +     struct fiemap *fm = xmalloc(sizeof(struct fiemap));
> >
> >       if (argc != 4) {
> >               fputs("Excess arguments\n\n", stderr);
> > @@ -743,26 +743,41 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
> >               exit(1);
> >       }
> >
> > -     fm->fm_start = atoi(argv[1]) * F2FS_BLKSIZE;
> > -     fm->fm_length = F2FS_BLKSIZE;
> > -     fm->fm_extent_count = 1;
> > -     count = atoi(argv[2]);
> > +     memset(fm, 0, sizeof(struct fiemap));
> > +     start = atoi(argv[1]) * F2FS_BLKSIZE;
> > +     length = atoi(argv[2]) * F2FS_BLKSIZE;
> > +     fm->fm_start = start;
> > +     fm->fm_length = length;
> >
> >       fd = xopen(argv[3], O_RDONLY | O_LARGEFILE, 0);
> >
> > -     printf("Fiemap: offset = %08"PRIx64" len = %d\n",
> > -                             (u64)fm->fm_start / F2FS_BLKSIZE, count);
> > -     for (i = 0; i < count; i++) {
> > -             if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > -                     die_errno("FIEMAP failed");
> > +     printf("Fiemap: offset = %"PRIu64" len = %"PRIu64"\n",
> > +                             start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);
> > +     if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > +             die_errno("FIEMAP failed");
> > +
> > +     mapped_extents = fm->fm_mapped_extents;
> > +     extents_mem_size = sizeof(struct fiemap_extent) * mapped_extents;
> > +     free(fm);
> > +     fm = xmalloc(sizeof(struct fiemap) + extents_mem_size);
> >
> > -             phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
> > -             printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
> > +     memset(fm, 0, sizeof(struct fiemap));
> > +     memset(fm->fm_extents, 0, extents_mem_size);
>
> Is that equals to memset(fm, 0, sizeof(struct fiemap) + extents_mem_size);?
>

Oh, you're right~

> > +     fm->fm_start = start;
> > +     fm->fm_length = length;
> > +     fm->fm_extent_count = mapped_extents;
> >
> > -             if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
> > -                     break;
> > +     if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
> > +             die_errno("FIEMAP failed");
> >
> > -             fm->fm_start += F2FS_BLKSIZE;
> > +     printf("\t%-17s%-17s%-17s%s\n", "logical addr.", "physical addr.", "length", "flags");
> > +     for (i = 0; i < fm->fm_mapped_extents; i++) {
> > +             printf("%d\t%.16llx %.16llx %.16llx %.8x\n", i,
> > +                 fm->fm_extents[i].fe_logical, fm->fm_extents[i].fe_physical,
> > +                 fm->fm_extents[i].fe_length, fm->fm_extents[i].fe_flags);
> > +
> > +             if (fm->fm_extents[i].fe_flags & FIEMAP_EXTENT_LAST)
> > +                     break;
> >       }
> >       printf("\n");
> >       free(fm);
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
