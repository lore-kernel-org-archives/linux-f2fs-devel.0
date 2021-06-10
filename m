Return-Path: <SRS0=4l6L=LE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5CC48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 16:51:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2DF613E7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Jun 2021 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2DF613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lrNth-000070-U6; Thu, 10 Jun 2021 16:51:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lrNtg-00006t-GV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 16:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o/Pa4xwqS3dFPQ6N2i4k2RmNkKm0bDjjLkOOi2EsC3g=; b=O3xBvW4oCQt7iQuRbPc12tDQAi
 uLWEcZxKUBQYr8AoW2Js3WdvoZ6+SMCTEa8URyaDprbiVzwY9Re0IOs5DBSllj2N4UM+U6RwtfOeC
 vV8ZP677dDHZySTi8NBVPtbHxjyBay6Caei9hq43FIFJwJzriXwpLqZfXR/bn1aMCs7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o/Pa4xwqS3dFPQ6N2i4k2RmNkKm0bDjjLkOOi2EsC3g=; b=Nesc+YeuLxDgoKyI1ZZ1nzFubS
 6TtQkRTcMgQNNTj5RQ6zWmJSDeAzv9mLac6iIBpKiPzLaQ+G39ZFw3vEAMwJU4gonpj6RQSuaBHNL
 z9Sb2Ac8zyGac77eKW3qDOsDqL4P+fEjASFwxZX05ZMPvtfQC5RslxGf960q/gYMcQ6g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lrNta-00084T-9F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Jun 2021 16:51:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD86C613E7;
 Thu, 10 Jun 2021 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623343861;
 bh=QM7SmhxztbSicY9WukzngYcAzWe6eXIb8R7ckl+q2JM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kt4XhSYQ2tpcSvWo2wbLRt6fRwwJHJMWkUEcyCG6PeIRMWBk4A3Oka5I77acH0Scz
 4W2vM8yeIoeYY9Ii1sUuY8FFULQ1Oi+FfNe/nVHLpLyQjjyObfj9W6TGUm8xS7ubJH
 vSeTK2YsA0SZDnf0DacDEEGg5px6Sr8hvjtRkQ7A8HzFI7hADvE32eWrGpUKkrpbkO
 anqTOLVxTkjngCvNhVrnKU4HiM9s6NeKR5eBl462xf/i7TsdrHNCw86eGhgs53WLqd
 QrsBdUOuIvLInY7cswJaQSQcfF8H5DmIQrV+DB59KsJonWi7N2PpDPMET5hhaPTu4h
 1+phXAC4pHLYQ==
Date: Thu, 10 Jun 2021 09:51:00 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YMJC9CY2nCG/6mp5@google.com>
References: <20210525205138.2512855-1-jaegeuk@kernel.org>
 <17318ac1-19e7-dfed-35f8-65a8e325fc61@kernel.org>
 <YL5Oth8oKnV7h8Pm@google.com>
 <53531f1e-7232-df4d-3a43-43db0e8581f1@kernel.org>
 <YMELoAH7T5b5HLhm@google.com>
 <fec816fb-a4c9-0e65-5f09-8c9fdae73c87@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fec816fb-a4c9-0e65-5f09-8c9fdae73c87@kernel.org>
X-Headers-End: 1lrNta-00084T-9F
Subject: Re: [f2fs-dev] [PATCH] sload.f2fs: use F2FS_COMPRESS_RELEASED
 instead of IMMUTABLE bit
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

On 06/10, Chao Yu wrote:
> On 2021/6/10 2:42, Jaegeuk Kim wrote:
> > On 06/08, Chao Yu wrote:
> > > On 2021/6/8 0:52, Jaegeuk Kim wrote:
> > > > On 06/06, Chao Yu wrote:
> > > > > On 2021/5/26 4:51, Jaegeuk Kim wrote:
> > > > > > Let's use F2FS_COMPRESS_RELEASED to disallow writes only.
> > > > > > 
> > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > 
> > > > > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > > 
> > > > Too late, as I published it in master.
> > > 
> > > Oops, sorry for the delay.
> > > 
> > > So does the patch "f2fs-tools: support small RO partition"?
> > 
> > sload.f2fs: use F2FS_COMPRESS_RELEASED instead of IMMUTABLE bit
> 
> Oh, I mean does patch "f2fs-tools: support small RO partition" be
> pushed as well? if so, seems I don't need to reply with the
> reviewed-by flag.

Yes, it was merged in aosp.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
