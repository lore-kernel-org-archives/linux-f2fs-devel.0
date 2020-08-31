Return-Path: <SRS0=B6y3=CJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF263C433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:55:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB72206EB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TFVjZNA/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LXdNwmF1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLzRPQ09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB72206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kCavD-0004cX-91; Mon, 31 Aug 2020 03:55:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kCavB-0004cM-VV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Aug 2020 03:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=; b=TFVjZNA/xNeVRp9OuYJRJdiDKl
 JtCFSr0WJzGwhWC3TUu9tRz8ZmV1RtNdz98xc2rLuag5mQqJTrjXSGoRaCEU18/JBajNq3oH8Xzh+
 kUpZTlsogBEDbf+EAFgZNMWVpPtpPF1mdf2HwIe/oWvCHYpTft44sPls4S8bE8sdrYk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=; b=LXdNwmF1KTrYSXWgny4ajOJkkj
 SCXU/44PZgHZh/cTn+Re0upY0lWoSEnIpZ/gok1fyAI0sDyThtlVvDy1I5uiyQTYPTwdHS2UMsdTo
 KXN11a1agqbjQ4TNRkswwFJgFYAH1ocVA9IW57MmwDbTB0+KSPwLzarlmiWGJ4tJe87E=;
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kCavA-00650F-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Aug 2020 03:55:53 +0000
Received: by mail-lf1-f65.google.com with SMTP id w11so709023lfn.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2020 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=;
 b=kLzRPQ096GT9g3Z+Z8cryY7oTlxYxGQ3+9PjvhuhX0gtolEE7ANyqgOLS64/MrdzYL
 qT7C6i97ah1Hpvy5sk7dNDITzb0XdLQGKH5vU+LQJxFTxrEW8IBjy4HcD/xMiX6vP79q
 hz41kqbBJPJ1USTcMqbya11vdMb3gJBpaev2y2MR1KAb8pisKETcRdQY1M7nnD8wvbP5
 cfvTJr2k4Inm45vgiXD3gWku7+JxRJluQOBAAVuC6KpCuAZ8negB623XbcH9IDJhoE33
 CpIZvDOdCTyiAWSWurA2SEdaw+yQU20kaxZg8d0eLe4fwpVlMcwyNtyDEn3+qa2Ale9K
 fxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=st+ArUspW4cfoVkyw71QvK5Tr7yiSZTbcPXCqE9k4Fs=;
 b=fok7NQOhjMYtcbrmcQLMWj3eiEkdIehSvPElLG4ojaJtGPNGCSdrMJJg6et0DbsZZF
 CXzVeW+aqjFeVBom40+4XfTqRP87F+G1MOjlKGBxB4ESQnMCvgIBLGORyxGdSp/2UPEv
 Z9/xS4VjkPFgXEOuh+1Lytwp3TMYy+ZCU9Zs1WnXpOhLReXW4RNDpSRg2HQ/JLvzp4Si
 cRJuQ0YwDteLUYENvNwcdYtzM2DqRxpF6jSNMnqXRK0GItfpgRlPDZH7FrOCMxr4Vb8X
 ShPG16jQZdeeO/Pg7bQv4QtTf/Tc7yvAiOpLHAM81YzGcesoS2wyFzRWiZz+mWxhGYOR
 9QBA==
X-Gm-Message-State: AOAM530LfXWw9zn+9+SIkJHAkAxJBHFXnjwjU7HSMcHw5VurD4aiZa/D
 02NWScMOepn4ZqB1t2d13tIc/9T1s8o9I6EUzKA=
X-Google-Smtp-Source: ABdhPJxIsMVgf/aNMl2I8AppTt2CTCql4I2LzVgzXYWCtuowuZpK8it75q1FCxd4Ctm+ZmX1MT4hnRVUq0s+XO4umrU=
X-Received: by 2002:a05:6512:6c1:: with SMTP id
 u1mr4692195lff.28.1598846138571; 
 Sun, 30 Aug 2020 20:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200828054629.583577-1-daeho43@gmail.com>
 <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
 <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com>
 <bd1a8ffa-83ff-b774-9bed-ed68025d0c7a@huawei.com>
 <CACOAw_y=O35_SFxdfsVER4+a+n-eE6f48NXF6CsAnj=Ms-dgkA@mail.gmail.com>
 <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com>
In-Reply-To: <c4f58675-9df5-e3af-45fc-6fa924e3ee68@huawei.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 31 Aug 2020 12:55:27 +0900
Message-ID: <CACOAw_wZFAyyt8qPCFd-LQKpMGa1moyOqSBpUnaeM0z2Y5Z+cA@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1kCavA-00650F-Ef
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
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
Cc: kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> - open(O_RDWR)
> - ioctl(FS_IOC_SETFLAGS, F2FS_COMPR_FL)
> - write()
> - ioctl(RELEASE_COMPRESS_BLOCKS) -- inode is immutable now
> - ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL) -- Should we allow to update immutable inode?
> as we know, normally, immutable inode should deny open(O_WRONLY or O_RDWR) and later update.
>

For this case, with this patch we'll return -EINVAL for
ioctl(FS_IOC_SETFLAGS, ~F2FS_COMPR_FL).
I thought RESERVE_COMPRESS_BLOCKS ioctl is always required to get the
file to normal mode after RELEASE_COMPRESS_BLOCKS is called.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
