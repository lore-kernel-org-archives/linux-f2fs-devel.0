Return-Path: <SRS0=+JY/=U2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87120C48BD6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:12:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C762082F;
	Thu, 27 Jun 2019 09:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VfJt1/F7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NcBGoKVG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7dMUp+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C762082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgQSC-0001vt-3B; Thu, 27 Jun 2019 09:12:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hgQSA-0001va-4P
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jun 2019 09:12:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qKIBl751AXqODXd7GAEvTiqsTGcSW0dxpnjr57435q0=; b=VfJt1/F7K56QdyfObGHrKmrg2P
 Syrsl4qXMF3lGB4IErl9GrBaPjtDW4SRxjJ7tUPRCjuZe/4wzupN1Zcn8azFKAzm022qVldlgUyfn
 am11rYr1pK1ROuf4J4A5MoLNqgzKSu9O3leZReX4mM4UmC5zShnGJOhYe+Z6VHJ5X4XY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qKIBl751AXqODXd7GAEvTiqsTGcSW0dxpnjr57435q0=; b=NcBGoKVG6zwXTBORD9kqyG7liE
 LE2RLg5gyB6oIUcd6BIXV2xt5a02LcpVX2mCZQd7YA5M0KfcKG0xQR6DlnO30bUOo+EnwlFO5km+M
 n37mYmv11tH+scShs72N+lEpGDAYuweuqXj1QiDdM7JFTSqXJQtBASynGe4fh619W/YQ=;
Received: from mail-ua1-f65.google.com ([209.85.222.65])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hgQSL-00D9f6-UD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jun 2019 09:12:39 +0000
Received: by mail-ua1-f65.google.com with SMTP id a97so563544uaa.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jun 2019 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qKIBl751AXqODXd7GAEvTiqsTGcSW0dxpnjr57435q0=;
 b=H7dMUp+fqyujXhus2SVHsQTcSsTnEYVJZnMyBKqAIYl+WaL6BoFjdgTSNiVpPHFhw+
 GqjERzwPtj5TM3eOvcTJqUGjCuDlXXlFA7GDtLvAC6Xok/OBQa3v6E0pY5BEMC8q6s/u
 mKVFmCZrRK9GpgruDfjCu/MWPSTXr1jvarJZETCWQlbcD+90JSHkkByT6aBRtnklBbpg
 g81E69n+eT4010s0bRLqGOiJd0tqntuFK0jfiictta66ViTqbULS/4rJDQt9UgnvSt+h
 hputUYJRnX8NmBdi9tU01Ft4FlxB4G0/sQzmsbXuLkEUXHqOpBaYbMVf+GAcV8dZZ7BD
 XMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qKIBl751AXqODXd7GAEvTiqsTGcSW0dxpnjr57435q0=;
 b=gPLRb7hwJeHdXoenJVk5zycP6748MlOlZUZGXTCRh+3QBZeQKlczU+EWnm2vlZm4jX
 6QcGU/zGTgY8S7vlH6unkw/+XzQpY2cSNXYIf43YEAR6pVgm8jTxisgTlph+hMK7Z3qQ
 GpZgCYn6H2ud63H/o9CiK2mY6dzSoebh/vrHRMiW2WzV3K765lxSrIoRRdqAk9p6k5ME
 EJ943BkHI/fLqcNuCXot86zRyeTcvP3sPeD8JZdjeut/x/EMxs6BBJ3jg1VlkJg4iljd
 D194/SI0O6FDZi3/sNb022oaiEAys+wS2kTGgXAyelGacje7Sd+X5nMIRv/hl6x+ttlz
 tFsw==
X-Gm-Message-State: APjAAAXZ7+bd6p59lMHHfxIct9LmLZ+ieCZOu82cMKg8t15iTbdfgl5a
 wE+G6EcoS0cEH3IWP4i7exELt21bcrUD2SozJ+Y=
X-Google-Smtp-Source: APXvYqxZQoV0cIqpRNPiSFF/nynb1pFUAZ4DDGYUDIpM0XZe0KqctihYkh/h9TQ13jKXN2B+2hbVyAQlDBYDzUc5XMU=
X-Received: by 2002:ab0:72d7:: with SMTP id g23mr1615582uap.75.1561626751823; 
 Thu, 27 Jun 2019 02:12:31 -0700 (PDT)
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
In-Reply-To: <249aff47-cb24-291b-37f7-6ed2d854a207@huawei.com>
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Thu, 27 Jun 2019 18:12:20 +0900
Message-ID: <CAD14+f13+fKvo+-vOwu79O-mSwKS7r0g=gbVL65qv+MXPc+gZg@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1hgQSL-00D9f6-UD
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk and Chao.

A little bump here.

We still need to tag a new version of fsck and update f2fs kernel code
to tell which version users should use as we discussed earlier.
-rc is closing soon, so I felt I needed to remind you.

Thanks.

On Tue, Jun 4, 2019 at 10:48 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/6/4 4:27, Jaegeuk Kim wrote:
> > On 06/04, Ju Hyung Park wrote:
> >> Hi Jaegeuk and Chao,
> >>
> >> A little update I thought I might share.
> >>
> >> Just went through migrating my laptop to another SSD and I've setup
> >> f2fs from the beginning with mkfs -i from the master branch.
> >> No issue as of yet and the kernel is working fine as expected :)
> >
> > Cool, thanks for your test. :)
>
> Great, thanks for the continuous test and report. :)
>
> Thanks,
>
> >
> >>
> >> Thanks.
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
