Return-Path: <SRS0=mkZ5=AO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA97C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:36:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CDA206DF;
	Fri,  3 Jul 2020 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Sm+rxvET";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="entRBbjx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mirlab-org.20150623.gappssmtp.com header.i=@mirlab-org.20150623.gappssmtp.com header.b="sMfb2dKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CDA206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirlab.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jrHBY-0004lt-AB; Fri, 03 Jul 2020 08:36:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pahome.chen@mirlab.org>) id 1jrHBW-0004lg-9q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jul 2020 08:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71KZUr8/gJBn53YVJz4nrAm8HRuOCScS/eX2vnvR85U=; b=Sm+rxvETe0MjL1SiZ5IX4ZiqII
 r7cHRrm5RaWs/mqIdKwv8T9AXhvrSOfPktQscaUE6vIvs1egWZiRw/WmLQB5Wd2fWp7wokZg/AAGj
 uqUK+A2aN3JzL19TxKSk+wW28R5xHuln0WAWms7fTD9X8SavzO1dOGgHi6KxVTYDg3EM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=71KZUr8/gJBn53YVJz4nrAm8HRuOCScS/eX2vnvR85U=; b=e
 ntRBbjxPXJSxULD8vGhcvjtnUjA+HfKbVPAZSlzckBrxYYnyaq+OYdn9NTCBgfYq2JsS2eGltOl6K
 OVWVhP7Jpf+h5dI0R4aD0HIwAP5EdNeNndqehQdebVsQL3CR8zqwW9jpIwGEqdjc3eav1I2+cjAv6
 vjOM1vr1oubEd4t8=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jrHBT-006ePb-KF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jul 2020 08:36:38 +0000
Received: by mail-ej1-f52.google.com with SMTP id o18so28921141eje.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 03 Jul 2020 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mirlab-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=71KZUr8/gJBn53YVJz4nrAm8HRuOCScS/eX2vnvR85U=;
 b=sMfb2dKT2oal/CrboD62XplQ0XB5+0e1PPlWXnXnBttciMsaaUH+8g10HPclayqUvz
 326Tej/7w3OMUq+Cg6BilPxLnJ7oP80k+ipDnyXkAUBuleyAUKCbcu9IqgN19rAUQZQe
 PWK7/oCeNljpsIgxmic56rFRnUANHSUM8oLe9wV7tb4GBfh5DAlUHYUfKvw5dSDe3Rrm
 ulRt2p5oW0UX3LTAiue+pSFslC5sWqZJMfGTss32x7wF/7CFk0e/XA316/pnLr3wv67M
 0Dp7tl9Wh+8Kbh+bbN1zhkwPT+SrJmgFEGkjXBtSIG57r6hUSd5HyXhZocg7skjZedO0
 HTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=71KZUr8/gJBn53YVJz4nrAm8HRuOCScS/eX2vnvR85U=;
 b=maISTFjL6ql/lmw3ShtHddDpG5Hrz5iWXTyCrbUG9hP7GwGtTFwtz+hZjHPAy0fwyE
 U8PYvQcYlqsc0WriInGdcwPi9BnQEICgc4cwEPoRYH2u+7e1d+702xyH6DAoSgTArtve
 /g2pG4ro0MSJt8PheKnDECC3E/5M+9rjTC0yHKpel4WxrX1676dvdJTFp/ZKG0RHGCHL
 3+ERWhgTJ8N8DLQdPm6ciaZ9gq2pnnOjh5KNlbqGL68tSyVAAOSGTD/MpPXGvsdpeS7j
 O6aLRm75nagX2NdO2YIRBzX55jU1NXElM/SHhHignDxigYEo5WOeaLRRvPJTPd1QPxdE
 zQnQ==
X-Gm-Message-State: AOAM530tgiKjk9ywPGWHzvR2Ted72Cv+iHCYYEe9NvXX/ZZvxeIKLtzB
 2yEfjOi1tCsGQ2KA/UtBLlSR6XIRO2FC2KKnRlnLygy/njQ=
X-Google-Smtp-Source: ABdhPJxlavQCJxLwGPCrZt72GlQmUxS2ZY0jZk3vg2wgV5PriyBNZ174mybUCl5ViLSjAYORORYZZR5mCwuiYko8p9k=
X-Received: by 2002:a17:906:2b52:: with SMTP id
 b18mr32027620ejg.158.1593765388838; 
 Fri, 03 Jul 2020 01:36:28 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 3 Jul 2020 16:36:16 +0800
Message-ID: <CAB3eZfsq4+uY-4=DBU2WDN4VhwoYpQiezQXdgO3XR-cy3itGxg@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1jrHBT-006ePb-KF
Subject: [f2fs-dev] What's the known performance bottleneck when f2fs
 process buffered write?
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

I create 10 fio simultaneously in my server and I found that clat
attribute shows 50% and 95% has a 10 times difference.(each fio write
1GB file with 4KB blocksize with buffered IO)

That result maybe means later IO will cost much time than early IO.(Just guess)

I lookup the generic_perform_write() and the following procedure like below:
write_begin
> prepare_write_begin
> f2fs_wait_on_page_writeback
> zero_segments
write_end
> set_page_dirty

Is there any possible bottleneck in the above function?
Does f2fs_wait_on_page_writeback always wait there?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
