Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C955C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jun 2022 18:25:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o4RVz-0004ot-Vo; Thu, 23 Jun 2022 18:25:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pcc@google.com>) id 1o4RVz-0004on-4g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 18:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fH1nFwhoAjDGUkwMwWllX0sQiawtJf3T39Gf2Rzb+mw=; b=auiswUCxSLShmNndKOvCV1xOB7
 4wm1vhE2DRIKZDH+Fl6RcH65HcIh4cgmYXeiTirMQHTwQKBAD2UvhoCTncUSWBzfvCLA6rX/9gbNx
 ZN9mU0KaKyCX2OLdCLBne6YHEbNQrnQ3QwloabtE6cvHEHCryipbnGZiOTe9b5B0629A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fH1nFwhoAjDGUkwMwWllX0sQiawtJf3T39Gf2Rzb+mw=; b=jR2U5xhDVZyuDS+MHCzYDd04Xk
 +HOoLQ+Z+0jwcI6yCIiaTeWpAM7KqygmC4ic9xPyqGDRy+adTtSpGbhklC9jjXhpW9xAdkiJMQedr
 tpjebL/xOswlCKwV1wTqu7i+DU0ol0Hn0zTsVtQFZlcVFkhAGT1Yvq+w5LcI4TeL5/WE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o4RVt-00068i-CZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 18:25:13 +0000
Received: by mail-wm1-f47.google.com with SMTP id q15so11500986wmj.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jun 2022 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fH1nFwhoAjDGUkwMwWllX0sQiawtJf3T39Gf2Rzb+mw=;
 b=O+rAkBkE9ksOZ3DN5iBpSezsqrN6VTTJzX9b4Trr9YUH7YI2NtJ37x2NV97Pu1bMqY
 5hm6baHPiOdEsNaOaqLystFfWaPCbUt0ei/eyfMK2LPVrIcBe8Lw8wJGHdLHz77SKqDh
 YfSSEX11g8QcsTgTYCEWxGLoqbMTazqPJvqlalZjRZe7HWZb0RVfFf/wyLfHhXzsAWsc
 cT86PNt3WNNpiaTQUJCR8rGZ0I7XEKg15n96C1nvkfSAj05izOIHkTFKDuXAiXlEj3AW
 vVw2AoOKXq5HJn0fnTEAL6Pg9uD7g8IhaKv+YF5bB//3LHpNU/JNmawJI4rpdG57uS+W
 uptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fH1nFwhoAjDGUkwMwWllX0sQiawtJf3T39Gf2Rzb+mw=;
 b=gQ4O5ftDTici5JeYEjeVfsC9cNkkAjsIRR9advOdxmg+dzoQQkg/TaJIethgp9pRni
 a1JBBYLHOina9xJMKzMlNeuLYsreEEOTvojFJsVlg7gsdhXLIdvi/yKJ2CwZTRrhRdJs
 dgs8otiDUGFuDJEwGWEnwGAaawZIs+6epCF6NpvvZsWOymnRAJbKazOxeivhmsKDI25z
 fFmpqzOkh7wLWiaCJLxZ/mbesOgFhkgDYy2wywgfPcD5cPHGCbyOvoYipgA0hsZzZl31
 n7ayaQLRZ5P0v0xWb5aDA4n90LqsOWX5KfdrPW2KK2CQNggpUBxeWVrCP0TLXxy3klZX
 pMag==
X-Gm-Message-State: AJIora9rX+FFnU3cxX2ScSiUQnFGsSNZhm5uxIE4JVwHRurdIhtsO8aH
 OV+rW6OML6tIn6C/oXGqbzsqe8D3XSA3Mj1U9r9uow==
X-Google-Smtp-Source: AGRyM1ubV8gAQRwi84AFPmVCCxhClUP8OMNGSQTRAOtloQGKSjl86QmhaK7RavIwBoMSczTl+4GbBftUNXFvO+dJbnQ=
X-Received: by 2002:a1c:7418:0:b0:39c:6ead:321c with SMTP id
 p24-20020a1c7418000000b0039c6ead321cmr5564035wmc.171.1656008702861; Thu, 23
 Jun 2022 11:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220623181208.3596448-1-bvanassche@acm.org>
 <20220623181208.3596448-2-bvanassche@acm.org>
In-Reply-To: <20220623181208.3596448-2-bvanassche@acm.org>
Date: Thu, 23 Jun 2022 11:24:51 -0700
Message-ID: <CAMn1gO7WMngbyi4KrmNv687YoPP0gv4D0s-mvMB-iBNOsT7pug@mail.gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
X-Headers-End: 1o4RVt-00068i-CZ
Subject: Re: [f2fs-dev] [PATCH v2 1/5] Fix the struct f2fs_dentry_block
 definition
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
From: Peter Collingbourne via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Peter Collingbourne <pcc@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 23, 2022 at 11:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Fix the struct f2fs_dentry_block definition on systems for which
> PAGE_SIZE != 4096. This patch does not change the struct f2fs_dentry_block
> definition if PAGE_SIZE == 4096.
>
> Cc: Peter Collingbourne <pcc@google.com>
> Reported-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks, this is what I had in mind and it fixes the build on my target
with PAGE_SIZE != 4096. I also verified that a filesystem created on
the PAGE_SIZE != 4096 target can be mounted on a machine with
PAGE_SIZE == 4096.

Reviewed-by: Peter Collingbourne <pcc@google.com>
Tested-by: Peter Collingbourne <pcc@google.com>

Peter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
