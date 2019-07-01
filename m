Return-Path: <SRS0=+7CQ=U6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F371C5B578
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:24:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C52A208E4;
	Mon,  1 Jul 2019 06:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lz39kSH3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="akIkMnNt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoyjPOQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C52A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hhpjc-0003s1-7o; Mon, 01 Jul 2019 06:24:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hhpjb-0003rf-3G
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 06:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvTw3mN2DWRcY1t/B2mIOScNso0p3r34rhUisOGDeUU=; b=lz39kSH39aIoKG+CjKLzJzEAce
 EnohOMNbshwNRFqXZyMv+IGscFaFtV0Md4mz6BZMHnx7uTfetdn3aoOuU4wr4r4jf0SbNl3WSS9pc
 tPrcxio0EmH3Zh+iHIeLqKTMB+267i2hp680qFj8q9lI/Bma7s+TnOwPrfB/wmAASqnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MvTw3mN2DWRcY1t/B2mIOScNso0p3r34rhUisOGDeUU=; b=akIkMnNtWS0Yr3AvGzH9FnUYJw
 9DFC9WAv++G+/VXVAKStNSeJPJKmmY4VfBFI0FnZH6kW04us600MKNWNi0iuu+LLnhxxw1EFUqZzV
 wi+P1pkKwTkd1/4r3UkJTPIut3qBXagt599jEX81+qhLP8IrD0nQi5o+Ys8bS/nYy/g0=;
Received: from mail-ua1-f67.google.com ([209.85.222.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hhpjd-000HUo-AH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 06:24:19 +0000
Received: by mail-ua1-f67.google.com with SMTP id f20so4611702ual.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Jun 2019 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MvTw3mN2DWRcY1t/B2mIOScNso0p3r34rhUisOGDeUU=;
 b=WoyjPOQiMZ8AspkVPwKTW0LKxBdluHaHoZhSns/9K0TH4URQ2gg8SfHWfSUhpk+z+H
 ZkR7zXJgVlM5LsCqfTdvnIhdhKwZ+qNjF36t4Qgzgpp9Uy0sKMJucUiRpHe9hYcyRx68
 WK4kP6VvYGj9BRVKPB5LhllMWUHIe213aU6+8f767RPF6mSSPh406hiJH4OY/tj7xlZB
 mMQoWAw1Y1+Heo1OJpSHr3DkiuZ6f1whzd/Vmt8kO9IV9ghfan1GyPyLFkIFnMuE709Q
 x/72PtzNJ/pWjFRkaElOTQaxyAdn3XEKEA2NJnvDeRetI96e6v3IHLl9ONioQIAa/uf/
 BRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MvTw3mN2DWRcY1t/B2mIOScNso0p3r34rhUisOGDeUU=;
 b=qD8TSZoG+FH4GG0lmREtEbHcu+bdGEpcuiRp2f437RNEXy/1dyp2MMjUTchM4//IPq
 KlavfnEYRviqgdUq2gDPIc9W974vjSPH5WxBss8vWqxnId87J27GohZHFnQ/mtmH3240
 PGh/yaUTjV+eyba6ko2awVJMNZ5uZDGfJOa106VZm6OQqkhGafxp9UC23B+iEcInImEf
 6GMTI+jg8Ob4uNRR1SeZ1+KpsEvY8pLHNJcGRVLM3JCeMwaPT/+NRDssx2LwuPZLnhfp
 fTM6Zf7GkuuiwGpNOluCLUbpdYA22vBtbEUyPf2xaqvnuCWO1dx5u+tyMIhOigQNLhMq
 HRDA==
X-Gm-Message-State: APjAAAUzuFdF4bvFDAs7dmMWIRTcRynjx+u0Z5Etv9FARppTdvGYA2SK
 KqcH+F2EqoD2g/0U3NdU7ccCr3ZiX9jyfRMo1pk=
X-Google-Smtp-Source: APXvYqy+/AlLcZAySMipEKYiQT1kMkJhxqkNKDpTd8l2p1Pc1G5sogoYkSxo2Qv1aq7LuF4beR8KQOTvuZE8GrPjzWU=
X-Received: by 2002:ab0:64c4:: with SMTP id j4mr12848861uaq.97.1561962251030; 
 Sun, 30 Jun 2019 23:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAD14+f2ckNUv9n-Zb9UL_ojX8=24tYBhT-SsrcpVNogqee2tkA@mail.gmail.com>
 <6bcbb5e8-55ad-49c1-bb77-f7f677ceb526@huawei.com>
 <CAD14+f3NHosrL=5UOBSMbFxQ91x-AuWOj_w=JYkJSnmfDgTkvA@mail.gmail.com>
 <CAD14+f0ZTmmLBXtmHF_Kz23JLSJy+UzpNxwSMV4rvSCse3y7EA@mail.gmail.com>
 <7e1bfa07-5ee8-a276-fe6a-6d79bd9270c3@huawei.com>
 <CAD14+f1+puy4M6rL_SbGt9vej=7LgK+qEjq71_878=oqSvjJ2Q@mail.gmail.com>
 <0f89b0b6-5cc5-6618-72e5-8a2f81947161@kernel.org>
 <CAD14+f1xgYKAnzqLb-ZpzbeskZegGHXbrJ+vEHZe19_Jp3pBTQ@mail.gmail.com>
 <e3303318-758e-b263-f6ed-d55e98bdea78@kernel.org>
 <CAD14+f2XWeWvYXTjKbReJa7uZROvnp_-V419sBkpmWFp5L5BtA@mail.gmail.com>
 <20190603202719.GC34729@jaegeuk-macbookpro.roam.corp.google.com>
 <249aff47-cb24-291b-37f7-6ed2d854a207@huawei.com>
 <CAD14+f13+fKvo+-vOwu79O-mSwKS7r0g=gbVL65qv+MXPc+gZg@mail.gmail.com>
 <5c36de6c-fe75-e131-9f18-03e83fb5f439@huawei.com>
In-Reply-To: <5c36de6c-fe75-e131-9f18-03e83fb5f439@huawei.com>
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Mon, 1 Jul 2019 15:23:58 +0900
Message-ID: <CAD14+f3Qen80fQJp2fbQW6eG7sEkBeUChYqFQmZ0gGguKW8E2w@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1hhpjd-000HUo-AH
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs-tools: relocate chksum_offset
 for large_nat_bitmap feature
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

One more bump.

afaik, there's only about a week left.

Thanks.

On Thu, Jun 27, 2019 at 7:20 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> Hi Ju Hyung,
>
> Thanks for the reminding.
>
> Jaegeuk, I can send the kernel patch after you tag a new version on fsck.
>
> Thanks,
>
> On 2019/6/27 17:12, Ju Hyung Park wrote:
> > Hi Jaegeuk and Chao.
> >
> > A little bump here.
> >
> > We still need to tag a new version of fsck and update f2fs kernel code
> > to tell which version users should use as we discussed earlier.
> > -rc is closing soon, so I felt I needed to remind you.
> >
> > Thanks.
> >
> > On Tue, Jun 4, 2019 at 10:48 AM Chao Yu <yuchao0@huawei.com> wrote:
> >>
> >> On 2019/6/4 4:27, Jaegeuk Kim wrote:
> >>> On 06/04, Ju Hyung Park wrote:
> >>>> Hi Jaegeuk and Chao,
> >>>>
> >>>> A little update I thought I might share.
> >>>>
> >>>> Just went through migrating my laptop to another SSD and I've setup
> >>>> f2fs from the beginning with mkfs -i from the master branch.
> >>>> No issue as of yet and the kernel is working fine as expected :)
> >>>
> >>> Cool, thanks for your test. :)
> >>
> >> Great, thanks for the continuous test and report. :)
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks.
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> Linux-f2fs-devel mailing list
> >>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>> .
> >>>
> > .
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
