Return-Path: <SRS0=mkZ5=AO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0689AC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:29:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1C9206B6;
	Fri,  3 Jul 2020 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="csW7EXRH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HGg16T+c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mirlab-org.20150623.gappssmtp.com header.i=@mirlab-org.20150623.gappssmtp.com header.b="ZhqY3h9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1C9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirlab.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jrG87-0007hs-HP; Fri, 03 Jul 2020 07:29:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pahome.chen@mirlab.org>) id 1jrG86-0007hc-EC
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jul 2020 07:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wNdsx9MmHYeCewHtLDyMbGw8LAf0mg6xBOq9ktGToNQ=; b=csW7EXRH57hypWs6QE01S2tztd
 s38NxqDrRWoYB0j48aUvkC7xRtBMB0tycdo4sqTLQHK0iF/3zfjyH5tUz3moRuJb7uS576wneXSzd
 1xyRt6XWTLwRfuciJudgyz99AOybpWQsywjXDsyv1SfIhWShlp8Cub7ZEMm1D2HFH91k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wNdsx9MmHYeCewHtLDyMbGw8LAf0mg6xBOq9ktGToNQ=; b=H
 Gg16T+cSLDT0tBYmjtZzqgfrsLLyqh3ejswMBlpazohQHOfMl7M2n1Dz3KMGofHEgIV7bTU5orvBg
 xY7kpnwtyPjpfmc130O0uNVn0NoC9THtumZWEwIp2TVeBGeQ3yrVUjH5eKhxahf+UIS5AG65KAnUd
 WQjgV1wrdVhOjVz8=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jrG81-009ZYj-H0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jul 2020 07:29:02 +0000
Received: by mail-ej1-f44.google.com with SMTP id ga4so33088835ejb.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 03 Jul 2020 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mirlab-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=wNdsx9MmHYeCewHtLDyMbGw8LAf0mg6xBOq9ktGToNQ=;
 b=ZhqY3h9HwmILKT5IHy/d2I4LzbmA6lUbvD6m438yJqDNPK4R2c/nvrsshhPiCde/sK
 wiByrQzEPAnDyK1dQmalD8O6vMv3O7qfbpuFbOE290GXvkq5PDR03tmmk/hJWcR1sGpY
 uXIdx/TC8v15MTI4lb9J9nIKKKvr/KZmeSCIEndsI0rgY++1Jg2wT2irYIQf/88tggll
 JmjGcDMrcAGr4Un33HUaNrxWv8BmVF6tXrliXIw/a2/AFnlJ86o4pOKkgeyaPP+VXOtI
 dEih+TA9+e7O6p9TBscInCHZ6+g6jCzY6akmkEBYhHq5jXvATFc20U/JfAxdYxsMU+Dz
 tEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wNdsx9MmHYeCewHtLDyMbGw8LAf0mg6xBOq9ktGToNQ=;
 b=odGutHAUkSIxzj5mhaWYh/4Od9rPXnXxUovocUedC94GEUDnX37jG/qx6cuV7nzxNp
 5jpv8+hhHtoBIqhAjbT387q7yCYQL7L6w18NVAOMnPN39Q0Vj75x+C79J7zmcIvGc11x
 2S0Lw9SGLdaQbpAtMzV/A1nI5GoPf5A/ATltbHha8ZAWbKk6wLFkQBdskXVPhTffMz8u
 XqfJquHRtXi73nahyhPhT0gncb1lqIUE3lwI9CRLUxn4weBJQVzI0LM8oJjrP7b57aOk
 waC+Z6LNBH5EwHq7Mbaru0sP77c7R391X/AqjF0lCwAGkUJGLrfXGuPX6KwX/dj8VBs0
 J6kQ==
X-Gm-Message-State: AOAM531u1H5Mhtb3v5HP/DwczCLZPyhBqeZEpMpgNUQSFTGmHb//eVTe
 hKYxxW1DywWCU9Fn/Rark/BsXOsUNpMNLI3jMFGjDXPqP+s=
X-Google-Smtp-Source: ABdhPJxzj452QOy4cCNuKQ5P3fbPrauYRQVYF0JgVf0tl5haDw665TDq9Fh1AwLFzt8gBaTJxzF3+aT4qm4gUCbofQg=
X-Received: by 2002:a50:afe1:: with SMTP id h88mr39019027edd.295.1593760911500; 
 Fri, 03 Jul 2020 00:21:51 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 3 Jul 2020 15:21:39 +0800
Message-ID: <CAB3eZftAfxfJwA2fBC5A1wMsyvGchf1XY4ffZ4TweGO1SS_puQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1jrG81-009ZYj-H0
Subject: [f2fs-dev] Increase blocksize won't help performance?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I am a new to F2FS and want to test a basic benchmark of F2FS.

My environment is to create multiple fio threads(5 and 10) with
blocksize 4K and 2MB to know how the performance is.

And the results shows 4K is always better than 2MB.

I originally thought 2MB is faster because it fits the segment size.

So 4K always be fast is because F2FS process each IO of 4K? Even if
blocksize sets to 2MB, it will divide it into multiple 4K units to
process?

thanks


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
