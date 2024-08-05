Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361AC52D71
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AX-00013e-Kj;
	Mon, 05 Aug 2024 23:31:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AP-00012l-Qg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=53wI1vtz/QBLm69a4UGShfG7A+6U+j71RovMyXBQdj4=; b=b/jrVINlZoqGTY+S0sqxKZLg6B
 LhqmHd9w78r01lrxE4ppfEBdS0RZaIx91CL7Tyi1plTwk59WSiAJlx7Nt0+D87dmCftsTVQA8u5JB
 RhzWBWjfs3QI/tXcsvfoK0yqUfHWWVqEw8PPjkj4PAYKYL62uxLscdrNjCluR7Whqzk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=53wI1vtz/QBLm69a4UGShfG7A+6U+j71RovMyXBQdj4=; b=PNFLeJVS4Wp6Xdfyb58d7jqCUh
 Btlri/tm0bLXUPXlDluxxDwsd5nzdf6lmbOp8W99ZyyXsgEUTr0DV2HeRtRIpVHq55KFKdymz6hfH
 j0S3AKjAniMrzrLQ/6UgrHVo4UxTDKyZU+FUVFzjHUsVXloXFcZx9SkMlXC47XYCQpck=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AP-0005Ab-0E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4C62ECE0C30;
 Mon,  5 Aug 2024 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BF01C4AF1C;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=2bOiXsWKrVE2uHZy+sq7DklnFUHwG0Rbbo7m8zPxh3I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jhAxExI99t5ULNkFW0f1Sir0J0nqmAoAyV74XeVWlcfauAvCcVrhd5SIb416ytXwx
 Wg0YG403WalVA+2HhcE+TS/fsgPTnmObutdMW47MrPaqs1CNz85UMbTO3Bylp1ekaT
 2ePCUxtOYoosMgMH0W7mNGN4GUmHqWOnM7nRjbpZLzOy0V84odAbnVpGJ00AVRlP1k
 VWGI6ayQJgLDRCQJmmCivLjhWJo3cnG3Bdp94y/1KnWEgG/aJs8QWCmcn0C8HwWkuN
 X2oWWeJcYIfhuUERb0za0CYOnh6YPsTby9FxyCVsvTDwNnI6Voqg6LTaQelKo5adu0
 ax8oqNBSnOaYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 040D2D20AA6; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065201.2803.7144786550538079483.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
X-Headers-End: 1sb7AP-0005Ab-0E
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid potential int overflow in
 sanity_check_area_boundary()
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
Cc: lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Jul 2024 10:51:58 -0700 you wrote:
> While calculating the end addresses of main area and segment 0, u32
> may be not enough to hold the result without the danger of int
> overflow.
> 
> Just in case, play it safe and cast one of the operands to a
> wider type (u64).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid potential int overflow in sanity_check_area_boundary()
    https://git.kernel.org/jaegeuk/f2fs/c/50438dbc483c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
