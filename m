Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2785FC76188
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Apr 2023 18:30:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjOwm-0003ee-6p;
	Mon, 03 Apr 2023 18:30:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pjOwk-0003eY-5q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 18:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/MhzcBLNyPlc9F3ixDDCbFwvl87msy/AaRv46ZDeEHg=; b=NaVD8NjxmyTiaXOPxO5dyHW9st
 b4R0l1LIQSBVi+Qt69YKSxlb0H87LdomyFPMmsaqvFv2XnssFiFqRBWbWAu7ZZe7wfDt7o/uwscXe
 E0NiLHm/DJUk0RPiW2CRRtk3mqLdSqEnfTPSRfjyZ6JhHaKaf2i6A3TK3IW963yDE7U0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/MhzcBLNyPlc9F3ixDDCbFwvl87msy/AaRv46ZDeEHg=; b=HgDKxxf1JjsvgLFHh2mb9lwb4W
 Gcsl8tFnQ+V5GPDB2x4zebjin6X1nKDywNNsCGgnGVZnGZPWEJodsrnlpDEsIDgfgW+wLhxp7p4PH
 rTQaduiO3lZ4EoVF9DGKeEgtOCzboyaSR9e0MTJkUscvbvrNvsvBPka4SPzx4R1EcHcM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjOwi-00Dxva-PX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 18:30:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 672E462373;
 Mon,  3 Apr 2023 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF2A0C4339B;
 Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680546618;
 bh=3DvCucPxUeD1Jihv3ZNtq1tc5RsK0vh2rCux0YE1IFY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=rteC1mXhVvEryy5rV5kcMzThKMLxZ5HH33G3TO5GYA/vnq+cqHfaEQahRF63Ga1vo
 7z8mMH+xBbBZokNVoRvJx2E4fB0JEsOHBCQWKFIs+6idpOgu/yyi2idfEhhOlsle77
 1dpUPqBM21vlHR2Qlknn0CC4EvpI1D40cAF9PC47EinYUhYqX7kiv3GmMUAd3IvU5o
 3EZS3rLvQsk2x84iUNS7N7gdQ1ir6MR38ozzWbr7Gfkdqj0+UxtFLQDKftxwv0YkoM
 MvXhz8CxD5EOV6cNnSsOixUxem6GubLytlnrvNvH4Icb4QcRNfbcTIG9GKMZ3sA+7i
 muLy/GvOqUFJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 9D3BEE5EA88; Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168054661863.14597.5981880840616760856.git-patchwork-notify@kernel.org>
Date: Mon, 03 Apr 2023 18:30:18 +0000
References: <20230402031259.286-1-yohan.joung@sk.com>
In-Reply-To: <20230402031259.286-1-yohan.joung@sk.com>
To: Yohan Joung <jyh429@gmail.com>
X-Headers-End: 1pjOwi-00Dxva-PX
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix align check for npo2
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  2 Apr 2023 12:12:59 +0900 you wrote:
> From: Yohan Joung <jyh429@gmail.com>
> 
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/segment.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix align check for npo2
    https://git.kernel.org/jaegeuk/f2fs/c/2aeb9c3b9a3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
