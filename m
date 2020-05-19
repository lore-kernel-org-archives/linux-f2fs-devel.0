Return-Path: <SRS0=f7od=7B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B315C433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 May 2020 08:12:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7CA207D8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 May 2020 08:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fxFzH6+F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SK/GxSuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7CA207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jaxLz-0006yv-P6; Tue, 19 May 2020 08:11:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1jaxLy-0006yo-9K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 May 2020 08:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SIEMLhuI2j/tP4ZKiNZCmoLQcBISGVYT22LEmWN3Et0=; b=fxFzH6+FDW3GmI2yiIRzLZudvZ
 Qy7fZLgQVMlsP/0PpYP4qxmzZEO+o4YXODBrqrkYAowYoALamIXQf6IWSfruUfmG+VE3voZtVG1BF
 KB1IZFbjzB0kp/SLm+ryq8k9+z9K1B+FP+I0iTVbjoY8wZoaNoSSSkkbID5UkbWsI+u4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SIEMLhuI2j/tP4ZKiNZCmoLQcBISGVYT22LEmWN3Et0=; b=SK/GxSuJB6Bq6Xm+mI97LTvFko
 0V1cwgTsOJRfyREO9h9Q1JbFy4PrWjrJp5G/PuQp11K18tl02Y10HYZ+nUoAcMrd+FHoy6NSGoCrQ
 OzOqIuVf5EV+KO2vqtaQ6thzPNXj1B/3Y21iUuq5Teo72D5A09fw+SNPG0naPqgRkhW4=;
Received: from mout.kundenserver.de ([212.227.126.187])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jaxLu-000OP2-K2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 May 2020 08:11:58 +0000
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MHEPI-1joAm82FOq-00DHXs for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 19 May 2020 10:11:44 +0200
Received: by mail-qk1-f173.google.com with SMTP id f189so13794438qkd.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 19 May 2020 01:11:44 -0700 (PDT)
X-Gm-Message-State: AOAM5339oSJovDaEXEDMIp8oAztDSq/Ef02GRA1zWoiKdH98dBzQuY8F
 q69QMAyR1VImb14p0mn+Y/NS4O/fl6yfro+FI6g=
X-Google-Smtp-Source: ABdhPJx6XgbSzoT+qvNjdY9pWlEyJs3vEhdbk/bed0qIGoM1ay/d49G6y8ZoK1QmCZ9OPzgrrkMiO8yQSdyKoKqOetU=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr18447360qke.3.1589875903344; 
 Tue, 19 May 2020 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
In-Reply-To: <20200519075213.GF32497@dhcp22.suse.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 10:11:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
Message-ID: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
To: Michal Hocko <mhocko@kernel.org>
X-Provags-ID: V03:K1:r/ZjKgBU/ib482cnscz66PZRRiEogifr+aQrVFGHjzTV0IXiCJy
 himyjAfch3Y6wfM4XiJbVYwcowfeliH32VkFgVfw1Ct0XYtNA0JAQXR+TIUGtwro7pw+u8J
 PmuO8euS5rZV1EVsc9z47bebQMUB1pBQr5M2Ea3Czwf7HeGMLTn3iRNSb9L5X8OtLw0DgkK
 wuFBNmOFyX3gMCu9X+Reg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WuFq2U6Bns8=:MvKjCriDrEUNjOZDQVIBee
 f/pZ3/LjjIzcb5IviY0iuSTtFrm9x0dT8LnSOeFvVZ2s7X8yeORhxnIS40MoDmim85GSxzg62
 gH8Xu1v3ovWup86iCmas4/BB0uRZC9HDNplIX3TgjdgzgFyiGc7TwG1uVVvPaE+IFT/hby1nL
 YzQhoVvPUsFtwpGB3g5c5Rv8oezQkIB/fiVOec4FXaI2ZrgMhXzhXTq93aT3UOaY5RCFV5LVA
 9PGdJVFftC4kv1iQTYEIKmUUYeY0Zj7ABapV9+l2Kh8/6pbHKJOVTDGCy3+HbDA8Ax/Weehkh
 1ddtJPXc3zKTpyXOmlalY2zWrFMzmmrgT33yMyihiTOus+s9gEyG9mMEWXZoxudOYjwA9oziO
 OIeuiD0+0NIyGvVZX6TRgvLkAS/JedQhU/ctOD9kIit+PjbM6YYFzz5JE+j7yaXsgK2BaJmDb
 yB1W64eVmHQi1cQ7SEVOGEKRmFVrx2TIVcscPWMjxUgIgeG3rfpu6U475+3nq4AxARVrQmTMV
 4P8Zlc9Oa4wAonmbWP6oc0BLUZPPOUd6MCZi6RslvaB2V111dzSezPDh1Yg56oUwzpA5RxgYp
 XLm4zmgcGglrYQoauhYqrer/RmWyeT47rXmoGIGQDhaUbKtKFZivIy5Kj8SjvdpFdsrOnl+28
 yK1UL3R0NquJ/EdAS5Ggr/bkToaQejL3MA4PJx0/mVOVSNg9SefVx/8NYLvcZUWCsQpGqGb+N
 x/wKAdWiaO9l3VF2Wlu802+5z8JvX5CwcflxAmZJhQu/K037VVfdwWyS4rWR2/pEq+Pwg7U6a
 deNPrYEjg48FA1LjkY6LmQ2R96pxK8yA0vfmdCokyaWCDctYGc=
X-Headers-End: 1jaxLu-000OP2-K2
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Hugh Dickins <hughd@google.com>,
 open list <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-block <linux-block@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, lkft-triage@lists.linaro.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 19, 2020 at 9:52 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 18-05-20 19:40:55, Naresh Kamboju wrote:
> > Thanks for looking into this problem.
> >
> > On Sat, 2 May 2020 at 02:28, Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > > mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> > > > and started happening on linux -next master branch kernel tag next-20200430
> > > > and next-20200501. We did not bisect this problem.
> [...]
> > Creating journal (131072 blocks): [   31.251333] mkfs.ext4 invoked
> > oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
> > oom_score_adj=0
> [...]
> > [   31.500943] DMA free:187396kB min:22528kB low:28160kB high:33792kB
> > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > active_file:4736kB inactive_file:431688kB unevictable:0kB
> > writepending:62020kB present:783360kB managed:668264kB mlocked:0kB
> > kernel_stack:888kB pagetables:0kB bounce:0kB free_pcp:880kB
> > local_pcp:216kB free_cma:163840kB
>
> This is really unexpected. You are saying this is a regular i386 and DMA
> should be bottom 16MB while yours is 780MB and the rest of the low mem
> is in the Normal zone which is completely missing here. How have you got
> to that configuration? I have to say I haven't seen anything like that
> on i386.

I think that line comes from an ARM32 beaglebone-X15 machine showing
the same symptom. The i386 line from the log file that Naresh linked to at
https://lkft.validation.linaro.org/scheduler/job/1406110#L1223  is less
unusual:

[   34.931663] Node 0 active_anon:21464kB inactive_anon:8688kB
active_file:16604kB inactive_file:849976kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:25284kB dirty:58952kB
writeback:27772kB shmem:8944kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? yes
[   34.955523] DMA free:3356kB min:68kB low:84kB high:100kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:11964kB unevictable:0kB
writepending:11980kB present:15964kB managed:15876kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[   34.983385] lowmem_reserve[]: 0 825 1947 825
[   34.987678] Normal free:3948kB min:7732kB low:8640kB high:9548kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:1096kB inactive_file:786400kB unevictable:0kB
writepending:65432kB present:884728kB managed:845576kB mlocked:0kB
kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2908kB
local_pcp:500kB free_cma:0kB
[   35.017427] lowmem_reserve[]: 0 0 8980 0
[   35.021362] HighMem free:1049496kB min:512kB low:1748kB high:2984kB
reserved_highatomic:0KB active_anon:21464kB inactive_anon:8688kB
active_file:15508kB inactive_file:51612kB unevictable:0kB
writepending:0kB present:1149540kB managed:1149540kB mlocked:0kB
kernel_stack:0kB pagetables:712kB bounce:0kB free_pcp:1524kB
local_pcp:292kB free_cma:0kB
[   35.051717] lowmem_reserve[]: 0 0 0 0
[   35.055374] DMA: 8*4kB (UE) 1*8kB (E) 1*16kB (E) 0*32kB 0*64kB
0*128kB 1*256kB (E) 0*512kB 1*1024kB (E) 1*2048kB (E) 0*4096kB =
3384kB
[   35.067446] Normal: 27*4kB (U) 23*8kB (U) 12*16kB (UE) 12*32kB (U)
4*64kB (UE) 2*128kB (U) 2*256kB (UE) 1*512kB (E) 0*1024kB 1*2048kB (U)
0*4096kB = 4452kB
[   35.081347] HighMem: 2*4kB (UM) 0*8kB 1*16kB (M) 2*32kB (UM) 1*64kB
(U) 0*128kB 1*256kB (M) 1*512kB (M) 0*1024kB 0*2048kB 256*4096kB (M) =
1049496kB

        Arnd


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
