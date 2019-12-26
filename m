Return-Path: <SRS0=G1Qf=2Q=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24341C2D0DA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Dec 2019 10:44:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01DF2080D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Dec 2019 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MfYrglAw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="F+uMzR72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01DF2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ikQcZ-0007gb-E6; Thu, 26 Dec 2019 10:43:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ikQcW-0007fz-V0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Dec 2019 10:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CciSmY8mQmtaNJQQRD2CEzQF42UO9vxilmnwdC9yw6Y=; b=MfYrglAwuR9GNIqZsMyE9otvVb
 t0TrmKPUEKfT5S6jShuhxWtnE8UeFkHFg/byEcABTJiTN1MnZVEZf4zQ0WLQKqhajZjldrSmiEkuX
 xVqaxXMynFyBSRJhLO+YVK7k0LG5K6Oi7np+lhcp925fQ9ZINFkZQvIk3Y62aZN0UQ6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CciSmY8mQmtaNJQQRD2CEzQF42UO9vxilmnwdC9yw6Y=; b=F+uMzR72UsmscRqHPmaYi+rI3s
 9fw/RyxYTD2+XGTfbyCn4w4SbmVVFYqWNVHbxcLqd/lXvko0AcNzgZMyn0EhZ1KooZ2sxSl6PyuNf
 rJTrLYjk8y6abo5Hx2h/3anOekkeoyWL7rqlQ9co/5ynWvyMXceZ5389qwGvNY9iZEaw=;
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ikQcV-00FbrY-Fh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Dec 2019 10:43:56 +0000
Received: by mail-ot1-f65.google.com with SMTP id 66so32119996otd.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Dec 2019 02:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CciSmY8mQmtaNJQQRD2CEzQF42UO9vxilmnwdC9yw6Y=;
 b=KNoK3IeMzi+X89pI/lklPf7D8GtG0gzFvkztXIwMLse1+IZ+qsoi5m69Qqp4Y2UJmn
 6sn+WsAFYRP4lpxXJX+jfl12iRTg1aW1LEV096mhFccNvYxnAqXPo08AJa+yO5ms0wr0
 Lxg0lDMP6gQZY9GYQDHFlABzeaqTTZGo7ZdhYpDiSq4iyORYOJj6u7FjcXw2IA3aTAfm
 wKteaGo1HPqkfKXL1ImkhmHRnBh3dxp7vUmHQg9cUZGL4/iOCmhajErMx1463IinEpOs
 PE/6Oulevar1ynUpPfJUwqjJxqWEcrZPrI7aILkvwjHXPUw4fjFb1TJG+n+hZGjSeEHe
 eAvw==
X-Gm-Message-State: APjAAAWtjh8prao/FhK17nciyXADIRRv8NdL+tiNieXab1bOtKI6q0my
 jkYTRZmxi0HG5TkRmrTHCWzMImULFxVF1XcciEI=
X-Google-Smtp-Source: APXvYqytesbdCSLGLFU6q/okcfGBQxgxfB9uJmiMZLPv6rJ8MjCWELPe7w54OoSpqXkcWdWMs6j1xnfDq8bZFtD2v0M=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr45680549otf.107.1577357029668; 
 Thu, 26 Dec 2019 02:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20191223040020.109570-1-yuchao0@huawei.com>
 <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
 <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
In-Reply-To: <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Dec 2019 11:43:38 +0100
Message-ID: <CAMuHMdV5VtR+vgYKcZtvcz16GPp9YLG_ecAeDsiNCreP4rYKjw@mail.gmail.com>
To: Vyacheslav Dubeyko <slava@dubeyko.com>
X-Headers-End: 1ikQcV-00FbrY-Fh
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Vyacheslav,

On Wed, Dec 25, 2019 at 10:58 AM Vyacheslav Dubeyko <slava@dubeyko.com> wrote:
> On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> > > As Geert Uytterhoeven reported:
> > >
> > > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> > >
> > > On some platforms, HZ can be less than 50, then unexpected 0
> > > timeout
> > > jiffies will be set in congestion_wait().
>
> It looks like that HZ could have various value on diferent platforms.
> So, why does it need to divide HZ on 50? Does it really necessary?
> Could it be used HZ only without the division operation?

A timeout of HZ means 1 second.
HZ/50 means 20 ms, but has the risk of being zero, if HZ < 50.

If you want to use a timeout of 20 ms, you best use msecs_to_jiffies(20),
as that takes care of the special cases, and never returns 0.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
