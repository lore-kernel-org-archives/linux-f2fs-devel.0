Return-Path: <SRS0=SI9F=JR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B57C43460
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Apr 2021 18:35:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF8E613B2;
	Tue, 20 Apr 2021 18:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF8E613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lYvD9-0002ws-98; Tue, 20 Apr 2021 18:34:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <butterflyhuangxx@gmail.com>) id 1lYvD8-0002wm-AJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Apr 2021 18:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=; b=mLf/tB2dFfhgLLVo4Cx3WVK0ZV
 gVuyR/forRutcAetpGizJ25KLrHiTmvV2YD6ytd8ontr94PMkn43B7hYNZDpUrzVfBmNG7msAxYoS
 +V6alS/YHQ6nVibQQivKRJLYVhszzD/uC+y8xVx3ExTpApWWr5UpynVsLgCBBkvrJoMQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=; b=B3km+k1eQzcmpPagAZlQeYgyr5
 O5lEkiuKk5ObQuUxY6ax4zPgf9oBi/rnAhfdgZ+WMmaGdq4Bo0NwP0Q+2m43NB4RxJbDcaMoF9fB/
 aGKLG1+RjKZFTyoWkNjScx92SFeiP9MJMrnDuuUA/x1xQxwaDaS/576ku8thjeMVIS6I=;
Received: from mail-yb1-f178.google.com ([209.85.219.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lYvCy-000806-Eq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Apr 2021 18:34:58 +0000
Received: by mail-yb1-f178.google.com with SMTP id y2so42080858ybq.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Apr 2021 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=;
 b=HIrW8WT9mQHKJPBllBIAPKsWTumJ72st8Jhlxb6coBcFIu5v/yFCGicz6Q8YQEUT67
 vSml9cuPKhRqmq5HoBnwhjiHH6ITsUwzRbbSkdFTqFq0gN4EGVHYC8V57xNy64C6imdg
 z+DfqClwcZi4OhLXdzHT66ZnHqQbBSllmLDiiFuAhNyF/1O8xsWLI1Sq3FDFiglz8H1o
 Bl/p9NK1TYdhX1ievcaXEmGZkNEs9GeWKQUPlItFkTa1i3lr7D+G5rQnHK8gHPQ7fSH+
 Obn8aljmS1elPoWlrh8ysIFsTK5M4QYBsLrmGbm/Z2TGwFcn2WRHZAM/cUXbLBa2Cj8L
 DSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vAOrCoyYrv8Lm0v4fykeO9V9jTibRdCXXAxqwXvAZpc=;
 b=SS8POfWAsa3NXibVSwNtV7GmyQcVPpbUwOfb1dFRHbephHMG18pGerblWTanhO6nlC
 jonvvSclKalLzQPJuyxgtQa0a3CTwG43+zOO8DQeHklS2e3MoPB/lPCpP3x2rzvwa8BG
 TxQYWew4aEkmj9szo9zWZrNXM6ZBTJwEkj3buVS3b1oBnXW91zWWtqdeAYT3h8e65Jxy
 eQMluahcDxdUYuBl2ykWxc3xO7KGhNw3RGeNhQZs7tQHh09+4WMJhJc54cHuVsrzp8py
 b7cy0x68ck89Mm0cHKBMVDa/qySbjWUDNlvO11Ra2hOiAzGCBCOYKbHzgIxWxvO0kTFA
 66gA==
X-Gm-Message-State: AOAM533xwABZgRdVRy5wZ/TTNW/p5A5bbao3QgsF92JrJdDdxcQcwBfZ
 OmQQA1w3CdnTP8G7S3LcAWp8ESrvLvAqf9W4hAM=
X-Google-Smtp-Source: ABdhPJykLsBh8EHrMaEKAoX89i+Ci+kFzS5mmksxZ77n8wDBxEcllYxdWRrmBdR2azGDdx5qcyePBN1W8KkuCA1plKg=
X-Received: by 2002:a25:690d:: with SMTP id e13mr26615947ybc.90.1618943682929; 
 Tue, 20 Apr 2021 11:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114730.71103-1-yuchao0@huawei.com>
 <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
 <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com>
 <YH8SvK+OLSKAEYpJ@eldamar.lan> <YH8dJQCJm7iqsC+a@google.com>
In-Reply-To: <YH8dJQCJm7iqsC+a@google.com>
From: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date: Wed, 21 Apr 2021 02:34:32 +0800
Message-ID: <CAFcO6XPM4hrHTh6-DKO8TOCYTsHW-n8QWJywvbvnhTECQTbZeQ@mail.gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1lYvCy-000806-Eq
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-bounds memory
 access
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
Cc: linux-f2fs-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
 Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Cool, thanks!

Regards,
 butt3rflyh4ck.

On Wed, Apr 21, 2021 at 2:27 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Hi,
>
> On 04/20, Salvatore Bonaccorso wrote:
> > Hi,
> >
> > On Tue, Mar 23, 2021 at 02:43:29PM +0800, Chao Yu wrote:
> > > Hi butt3rflyh4ck,
> > >
> > > On 2021/3/23 13:48, butt3rflyh4ck wrote:
> > > > Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.
> > >
> > > Thanks for helping to test this patch.
> >
> > Was this patch applied? I do not see it in mainline (unless
> > miss-checked).
>
> Not yet. Queue for next merge window.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=b862676e371715456c9dade7990c8004996d0d9e
>
> >
> > Regards,
> > Salvatore


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
