Return-Path: <SRS0=mcZ/=AZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B65C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:24:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BF02073E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X2z0hUz0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="W0B3O1aj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFfrRU6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BF02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jvAco-0002QJ-11; Tue, 14 Jul 2020 02:24:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nroycea@gmail.com>) id 1jvAcm-0002QC-HU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jul 2020 02:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=; b=X2z0hUz0rN1wQ07TSu6eD8ANII
 YEfrXy8RVNMFb8aSntOBw2LcZgBfSkrp98t9xHIyNZYkYwip1kWTILdSF7DBbY2YKRg088kUP/Q/D
 nZAd7Rx7auOKBR3SvRpVlAZ4UBzbOjqexxbiC4Df35amt36OvpJRxs84H7EtspXv3saI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=; b=W0B3O1aj7eeKc2eORUeZAf7nN3
 vdXNJ6Y0cl0W/ezGMcY/7NkpToTwEpw8K4v1a6rgimWYwuVxbr5fANydfCR2woy2ji/Tnw5Rx6bq3
 EPzgsi+2B876+dubklT/Cjvr991oqW1Ro/N2sf1pF9W/YWm7HJa0L970m8d+/7bKkJm8=;
Received: from mail-qt1-f179.google.com ([209.85.160.179])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jvAck-00GrlZ-IB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jul 2020 02:24:52 +0000
Received: by mail-qt1-f179.google.com with SMTP id w34so11761915qte.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2020 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=;
 b=JFfrRU6VO9nyB2CutrxZpYRw9Z/DY7NGnHc7yaGCJgjV/oeGMm7gUDUMn2Hw+DFEwr
 iZFUnN+AU8QEv3VXY6QjmLpETHOxi44WxXXIGVTMsBKAsoQ/Vo47oKXxr1TYPabv1FZ9
 Rpn0etW2cq4MVhIPqvOLKoA8d6WFKcLsjpf49XKFfUczmsMfHqLtVLjdchl733qmpaU1
 iGeOj/BLj0e/CL66lzd3dXDyTfv/XlxtbtsYKYpaeULok22FZz9GEHaGCT9l7NzMZPEZ
 877VHoIAL1jv2u5a2U5eONSDPTqMFHxQ0nkY/+kKjs/YlvQo5uCW56e2K1KQv455VLuo
 2iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zbcRxgW3JR28m29u/55Y7F17wlRrdtYw3svGpp+m0sg=;
 b=ctSQguryW8/WoKiVvGbK2A29CF5iRBdA0505TsLR6FARf89+QkSBUHh/Ex7cdOx0xa
 ut4ec2kwUdab+Eh3sIjcMPVEC06xYPEgk2CQ/Z0Gd5Bcq5AYAGYVR8D/OJ12EiXwapUK
 ckXExY4ZK3Kye3st7mSzYHSqGP2QEFSB78EZHKf6VtPRdz91jAQFg5/hb+bq427uourT
 Izqh454hASa3YE+rPgtOhxiyJl1dWA4EzOPZ4TlyWS7MGcfdjFLk2XZpbdjzyMjSQKIX
 xMuncSIftQDAxZ6sXFE4LOHM8/TdkrxoFDF9QAexJN10e0sHAe2Jr0taacQUmPG/k82h
 RRYA==
X-Gm-Message-State: AOAM532qK8LytLTnRiG/fcMpTABaCnVOAwmGkF/ITwM0qBFlzXItCeSa
 ExK2MKFN+IZ+aBO2LqNEr4y/203sioD8TcIPa6oebQ==
X-Google-Smtp-Source: ABdhPJyAQ09tdvgL6Dv66Q8tRJxbejbevW6MHwgjkdJo1J0PJRpaqYJXXUOl1c4EvtR33b15Bha4oFqdqndgJf9A6aY=
X-Received: by 2002:ac8:24fc:: with SMTP id t57mr2611282qtt.116.1594693484792; 
 Mon, 13 Jul 2020 19:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
 <20200714000347.GA19314@google.com>
In-Reply-To: <20200714000347.GA19314@google.com>
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Mon, 13 Jul 2020 21:24:34 -0500
Message-ID: <CALaQ_hriyvF8yaSihvGEN1U2jufCQ5sj=aknN+1xB=4EbkBWaQ@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1jvAck-00GrlZ-IB
Subject: Re: [f2fs-dev] F2FS Segmentation Fault
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 13, 2020 at 7:03 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi Nathan,
>
> Could you try to say "N" here to move forward to fix the corrupted metadata?
>
> Thanks,
*****
Do you want to restore lost files into ./lost_found/? [Y/N] N
Info: Write valid nat_bits in checkpoint
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18eca] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecb] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecc] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee3] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee4] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee5] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f78] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f79] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f7a] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d621] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d622] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa32] in NAT
[FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa33] in NAT
Info: Write valid nat_bits in checkpoint

Done.
*****

*****
Info: Fix the reported corruption.
Info: Force to fix corruption
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 124168159 (60628 MB)
Info: MKFS version
  "Linux version 5.1.15.a-1-hardened (builduser@slave-1) (gcc version
9.1.0 (GCC)) #1 SMP PREEMPT Thu Jun 27 11:33:04 CEST 2019"
Info: FSCK version
  from "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
    to "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 124168152 (60628 MB)
Info: CKPT version = 63f2b4a
Info: checkpoint state = 281 :  allow_nocrc nat_bits unmount
Info: No error was reported
*****
I'm now booted in from my SDHC card. So it "seems" I'm good to go.
But with the actions taken and the files I've seen displayed during
the fsck, I'm thinking I'm going to reinstall all packages.
Assuming the issue was related to the power outage, I do wonder why
there weren't any fsck issues at bootup at that time. I hadn't had any
disk issues before with that card.
At least now I know the issue would be resolved by not saving the lost
files and I can continue on my merry way.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
