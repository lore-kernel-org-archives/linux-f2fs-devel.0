Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0902C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:11:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B151B20748;
	Fri, 24 Jul 2020 08:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jH3/mTfX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="eIPD13kB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+/rtKUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B151B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jyso2-0007rn-AX; Fri, 24 Jul 2020 08:11:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nolange79@gmail.com>) id 1jyso1-0007rh-Qu
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 08:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4DzTEPVPcHZjfAljSqPGt9exVomRk+O7SkY3bs/pe/0=; b=jH3/mTfXsb2OwQvvaYQ84t72lI
 LJysP/uZIkLr6J/YW+9kJRVw/5KSq/Sk8/hDXsnQwX2hIZt+wbqm+lDXnWQd1K5Kqx4ZWRlr1btjG
 LnuwwHcDIO/hIk0CfXnos3yuGzKFFqyMuaWL3vdW4/eTz9jk7jIhDIw2QEZrjjlGUBc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4DzTEPVPcHZjfAljSqPGt9exVomRk+O7SkY3bs/pe/0=; b=eIPD13kBgdzCRape7jt0zowkbx
 Og+D1pzgAdDeM5oBCGVYqt3fxSf8S8qD+CtNLj9u1Xb0Idm61Fp+GrOWTNU8XfnOJCAxWTdm9+qRR
 dGvZIGccIzHgm7kooGMdVrnA0Afhyx6l94dnyGlgeesqb3J8ibqqaOV2bPlZg8fgfNc8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jyso0-007HyC-I5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 08:11:49 +0000
Received: by mail-wm1-f52.google.com with SMTP id x5so6599358wmi.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2020 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4DzTEPVPcHZjfAljSqPGt9exVomRk+O7SkY3bs/pe/0=;
 b=C+/rtKUYtEnCcqGvgaV4k/I6RuTNZpvXyGlD/Rsl1cht5tR3zMknBqAreR9/mdMDdK
 ekVuXqSG5qvvu7iedVVQOjf8VWDDMQqLI9UQGrid3KhRf1zPbJqM1oO5kI8RUYNqMwMF
 OZKzeleVDLvTQi2mBTLDW9OTJt1/yB9UxwQxJ6KCqHFjLpXcnhpBJJVwdq1rxg4b1HXz
 Rah/dsZXnzsQo+kungXieJL6x8xHouKFdxD2AbLeBbK2gt4z7h8en6rXbOQCZmSMt3eF
 nodGjmuEzAHQ5/HG7dCQXdvejhJq0+6lrKfpbDtMad6GD6HlqoiItsP2Zsvnu/jiDtei
 ukmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4DzTEPVPcHZjfAljSqPGt9exVomRk+O7SkY3bs/pe/0=;
 b=FXfOGhDoH4UBwRp2rzhiR4hCWIcZa7wEu/tHTnqAAQWblB/UHkQwo2UpCwny7RFsfE
 Yz7EIgibfSaeAVpsojd+qO/aJZWmtrSoXpHdkR1X38p7ZQ7aFo1wDIE9FdEzqqgUpWyI
 MJOO1Yak0GbWc0XzdAFf9f3BrhZqcoL5kn+XNL2DXRUnFi7ACnW5r9jgps8jgfk/kcvI
 6+LWvOuEWXzZyOx9iBDj16mpyPqUNzpg219sQJH+pQX8zjyruJn2Xo5U4jGU9jsxBWaU
 CGAeDSP8P9j+Njz4Ka7SwaG0xaqgE9IG3/q2LZNg8SxdKGsOtck+NAzKLiCpFDKrA7I9
 +Z9w==
X-Gm-Message-State: AOAM5337HY93OIdhMjy8g7KlthBxvmeJhoFIMbsPojNhI2fJig0uFCLf
 4WbL3wEA+NoIZ+gMyhl9nQTcai2Xn7o=
X-Google-Smtp-Source: ABdhPJxEA853DhpObXCs5Ep7BzCCbOsUGR+OdZ8PBKU11ZrekBWr3GNGPJQADwj1DjY4sqT53YnzVg==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr7416203wmb.53.1595578295035; 
 Fri, 24 Jul 2020 01:11:35 -0700 (PDT)
Received: from lano-work.andritz.com ([80.120.136.76])
 by smtp.gmail.com with ESMTPSA id i6sm348948wrp.92.2020.07.24.01.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 01:11:34 -0700 (PDT)
From: Norbert Lange <nolange79@gmail.com>
To: yuchao0@huawei.com
Date: Fri, 24 Jul 2020 10:11:25 +0200
Message-Id: <20200724081125.3376-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f3094e40-13ff-ea31-faf1-9e78867f4a8d@huawei.com>
References: <f3094e40-13ff-ea31-faf1-9e78867f4a8d@huawei.com>
MIME-Version: 1.0
X-Headers-End: 1jyso0-007HyC-I5
Subject: Re: [f2fs-dev] Possible issues with fsck of f2fs root
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

I ran into this problem with fsck.f2fs 1.13.0, it seems that problem is not
fixed in master either.

My setup is an embedded device with systemd and I did nothing but swap the
filesystem from ext4 to f2fs. The result was that the init system would
try to fsck the ro mounted root partition, fsck.f2fs would fail (as noted),
and the init system would reboot (rinse, repeat) with no real chance to
interact remotely (headless system).

Thats pretty much as bad as it gets for an unwanted sideffect ;)

I first reported it to systemd, quite reasonably they expect fsck tools
to behave the same [1].

The systemd-fsck tool will end up calling fsck.f2fs with the parameter below,
and will fail as this device is mounted (tries to open it in exclusive mode).

$ fsck.f2fs -a /dev/mmcblk0p5; echo $?
Info: Fix the reported corruption.
Info: Mounted device!
Info: Check FS only on RO mounted device
Error: Failed to open the device!
255

A workaround would be to force or skip the check

fsck.f2fs -a -f /dev/mmcblk0p5; echo $?
Info: Fix the reported corruption.
.....
Done: 0.232165 secs
0

So, Id consider this a critical issue, and I dont see whats the conclusion
of this discussion is.

Norbert


[1] - https://github.com/systemd/systemd/issues/15106


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
