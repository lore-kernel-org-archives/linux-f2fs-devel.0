Return-Path: <SRS0=WbSK=WV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4AC3A5A1
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Aug 2019 11:07:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5A217D7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Aug 2019 11:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NxYVMZom";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NX5Kjhzv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkT62xzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i1qMb-0002ui-5g; Sun, 25 Aug 2019 11:07:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1i1qMZ-0002uT-83
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Aug 2019 11:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8SGo9XAFBhEYwlXQyGi6/GdZAW54DuJdi37MEZGdjGA=; b=NxYVMZomTZfzjmc7cdBBWA0rqv
 nq4lnXZjuMxW6gQXDX03gTI3iiNbKddMIaNaWnv9PESFz89NJLCYe0cqHPX0LLQ9GX7ZCbOGMGzDi
 dcOrA18O4y0LOVjfBLuaGkFy3iIpMBTEPlAoLTPrCm0B4nOBV4ElZYSUT5MT9BqITivg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8SGo9XAFBhEYwlXQyGi6/GdZAW54DuJdi37MEZGdjGA=; b=NX5Kjhzvxd4mUNNNwg3CsW6K1M
 sFj4cWEHPhJXb1dBFCOoV+djaIcKISujZE34tl7AuvFwH1k5QHmoPFs5yyCAJ+FCwCM4WF4ON/H0E
 ZW6T3ZpF9RVqX9YxDNpkf4Cskg+dOsVits1AhX76OzaqOFgRYLf9aM9fsiRgpeyevIP0=;
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1i1qMX-00Edgk-PJ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Aug 2019 11:07:11 +0000
Received: by mail-vs1-f67.google.com with SMTP id c7so9094385vse.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Aug 2019 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8SGo9XAFBhEYwlXQyGi6/GdZAW54DuJdi37MEZGdjGA=;
 b=TkT62xzYsiJuZMiKyXG66cuQCTwsI27LfYpywvqqAnB14lzobqghA4PRUGj4qwKcFp
 WmlGN5p5Y8wKdZu3DacWeTfvjnvMnrg0VrNL3Ua2TOsSqUCL2eX3BB4ZrH1p4JWR4xvv
 /dnYV3fRzIqJL07mhXJCauOi/Ibh4+BYvGF3gbCB55mUfcycCKdPimCURtn6TgLnzx9H
 FtwFB3GK4c6VAmL/IjPE1qePBjPn5NgEwu1jfV4r6ByCOVN04sVFg9xaTaXxeuoqRhUv
 uR6oTqIeaoffkRKy+r5iJYr9SVU2f0Ci797k7JEjD35+8pkS0oGaQYAe0fhMpJs6Ibwq
 Y0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8SGo9XAFBhEYwlXQyGi6/GdZAW54DuJdi37MEZGdjGA=;
 b=UL9rDPhm3QW6BpHxYUav/mAUiksZc0r5Uglg8hKF27H8//iGSdQFLB2lXeOzPFgAvo
 Sic25WeUIIQc6aTyn6XuT8BDef3vwrbKxapYlBY0kb8pQFV/ZAisBNFTyv5k3TsXRrQn
 cqRHj7zZ+eBFgZpfkhANdNRTFoemYVv/yydXqIRzCkD2DWhjfuM2cqz8xLabPMhxUpVk
 DmsA9FP98gJorOXSxPHpA0snJLcmH92RQRswmZXbgmHg1SmT7a3lafTHmlCphBtDln3W
 XuWLEKtjK7S7uUhdS+rCX4bubBynlNI5nVf3dAYRYpU7+LbYDNrIKOg7sfVp8jGiwA0d
 7aNg==
X-Gm-Message-State: APjAAAVvGlmg+jlnO+vzOWrdHTP9j0bihwluj+G14yEXFL98PUmRab1u
 DK7+wNgbtvGMU7tq643EpgmhMkAIL6+QXnXp7UY=
X-Google-Smtp-Source: APXvYqws6iuRR4VdbbqiIgX7BfkEZKN7T0BxVhZJu3a+Nn7EK6gniiZz3Cl/2a/X8vTMZyIrWiNPing5gH8KO0WtdxE=
X-Received: by 2002:a67:fd66:: with SMTP id h6mr7630155vsa.83.1566731223513;
 Sun, 25 Aug 2019 04:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAD14+f1YGinNQuVKc371vgJGJaaqYWqcaP6WwSuP1mwf-D2Tzw@mail.gmail.com>
 <5696f35e-d91a-801a-d2bb-fbbc188bbf4c@huawei.com>
 <CAD14+f3a1Uifebv8cybJOW8FrCnsvbrCCbT+JupxRVu3kpji9w@mail.gmail.com>
 <baa8b0ce-99b4-4f74-ff7d-e204bced4168@kernel.org>
In-Reply-To: <baa8b0ce-99b4-4f74-ff7d-e204bced4168@kernel.org>
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Sun, 25 Aug 2019 20:06:52 +0900
Message-ID: <CAD14+f1vkJtPpUEU1MJbxkZRRjR5Jqa8WWAGKBb2Xw4pPS3WRg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1i1qMX-00Edgk-PJ
Subject: Re: [f2fs-dev] f2fs: dirty memory increasing during gc_urgent
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

Hi Chao,

On Sat, Aug 24, 2019 at 12:52 AM Chao Yu <chao@kernel.org> wrote:
> It's not intentional, I failed to reproduce this issue, could you add some logs
> to track why we stop urgent GC even there are still dirty segments?

I'm pretty sure you can reproduce this issue quite easily.

I can see this happening on multiple devices including my workstation,
laptop and my Android phone.

Here's a simple reproduction step:
1. Do `rm -rf * && git reset --hard` a few times under a Linux kernel Git
2. Do a sync
3. echo 1 > /sys/fs/f2fs/dev/gc_urgent_sleep_time
4. echo 1 > /sys/fs/f2fs/dev/gc_urgent
5. Once the number on "GC calls" doesn't change, look at "Dirty" under
/sys/kernel/debug/f2fs/status. It's close to 0.
6. After doing a 'sync', "Dirty" increases a lot.
7. Remember the number on "GC calls" and run 3 and 4 again.
8. The number of "GC calls" increases by a few hundreds.

Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
