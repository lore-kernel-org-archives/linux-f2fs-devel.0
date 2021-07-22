Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA99C63793
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 06:26:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD30610F7;
	Thu, 22 Jul 2021 06:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD30610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6S9d-0003PQ-TV; Thu, 22 Jul 2021 06:25:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from
 <BATV+97918bdcd432a6481997+6542+infradead.org+hch@casper.srs.infradead.org>)
 id 1m6S9c-0003PE-3L
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 06:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BriiUpxqmfP1ThU89I9ULOLyz26OuFrzUElAtPLy8Vw=; b=GNuwQnZTztHD6V/04EyEqaDwnV
 Sh0cpbMgYqKkxcuTlMd6qrTvkziFosWaLDuKUp5QL/u2q5U3qapahI5xZOl4qnhSvSiFIcig1383b
 MMbssskZB2M5jo5S3bEi50z/gDLVvXm6uPGGosUyRyE89S7tDXmvcgS2C8mz4a29kX8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BriiUpxqmfP1ThU89I9ULOLyz26OuFrzUElAtPLy8Vw=; b=QoOLuzqVwqyxY491EquuAm4omy
 FIk7v9do8Z2AN9fPSvPBhunBiVXN7Jzbj0hV85RemUYTPcRJ7g2RC0469FQzDSyfZCHRv/XPPriJM
 Yazh67WzoJP5NsswSuA3nuFtqscBq7H8/sinpBKZ7XIQjXrz+oYhBC4dJkptn9cD8wXw=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6S9a-0003FF-35
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 06:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BriiUpxqmfP1ThU89I9ULOLyz26OuFrzUElAtPLy8Vw=; b=XFqSDzTtHrHPI1j/ctyWUaukU+
 XHc9xgCkJaKt3d+dU06kQTpBmOfHwCMQrvkh0K0SYumgJGbFaGpJLdAYEUj8pwecwoqqDBmSnm/HU
 91GpK71Oswts78ZLUF5d783Ubhor2GSqCz06nwaBSIrJu0EDNpDRc9bteWAetpss0hDEiLZtD+5f0
 funMDFu6N/9TfLGd8u46P3ZdwnCr7olQQNEbgEyMUjB2Dc6ac2/gyZZDWqBemoXh69x1Lqu8z86Lb
 G1GbDSdlGvzSKpaMl+cgU8OkfBPwD7jYwxyVW6a3aScB0V/uBK4a1zqVFzaRZB6uQDfnHtwfsDy2T
 aFGIPujg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m6S8U-009xAz-T6; Thu, 22 Jul 2021 06:24:57 +0000
Date: Thu, 22 Jul 2021 07:24:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <YPkPLrBszwr1aiBe@infradead.org>
References: <20210721072048.3035928-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721072048.3035928-1-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1m6S9a-0003FF-35
Subject: Re: [f2fs-dev] [PATCH] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Btw, any chane you could switch f2fs to use iomap_fiemap instead of
the handrolled version?  Especially with the work from Eric to add
iomap based direct I/O this should be much simpler now.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
