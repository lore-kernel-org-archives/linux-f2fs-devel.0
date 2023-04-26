Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F45C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Apr 2023 23:07:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1proEW-0000oE-VG;
	Wed, 26 Apr 2023 23:07:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1proEU-0000o7-5N
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Apr 2023 23:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KRbd0a/qDQTDs15mdior7ibEFxYo5du7OaugRgzXWTQ=; b=RNdTEFZ1LtFAGuYkSP8eiPdpq3
 yMrw/NPuEVVV7o296Jvfc0P6bmZCkHJXbO2/zj6Zz0+3Xzfv2fb7eb5buin128q8uMLfjMfFmTqnB
 JT8JAlM1na8mckBtymWNpvS/lr9APzyq6E9pDECs6goHX5TjuIezpgbo1LCIwJCeMSvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KRbd0a/qDQTDs15mdior7ibEFxYo5du7OaugRgzXWTQ=; b=Yatao7XMvM/sbcWHCm8gpBzURv
 abmOmZ5kM36IN9Age7oZfBS3lLXgFIie0PtBWSHlph9AdhQoqcQnUOacfFrKdt7dOeLMja4VCPnSR
 N2JSELQ1JHUk8Dw+b8IEXSWJOZutjii7AhcND8+cM4QkvF0jUbWZ0RcntkDAMuhrg3vw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1proET-0002Gx-Sh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Apr 2023 23:07:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 659F663968;
 Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45B4C433D2;
 Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682550440;
 bh=/+hULzucfSLRlVWrR5BmDeyXpDowzM7ZKzI3SZWoaRU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bi3StrqxZmtuSO0VU5rtR4Xpo0KbCTRtH2j7+0g85WAx1upPH/NRl7Yja1ApSe84k
 3jS6/yzQK97XcK5J0YTrOeQbvoylykMIOm+JQSMvUGlfL1pmA0V3FtAiY9tJcdJ4yP
 vG8AoGxZm0rvlqNlfyFkF7Z0bwG3DXDH7iOWcvzWSKPKjX4U5VGc/PgZwcjrgblJti
 1jJYCRiHc2X7rOoTtk1rJrsc4jfxQJfl/TvgXzy04i/VfQtVd1ZYfyT2b1BrB52Bme
 lWYEn0qePPm/df1rFJSDTbUSzSAV7nq4k1HcKVo1vqVkhaRRO0lZe9h3rsrqtRxdpF
 DfTzM3ffHUkeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A3931C73FF3; Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168255044066.16014.6020850362177131584.git-patchwork-notify@kernel.org>
Date: Wed, 26 Apr 2023 23:07:20 +0000
References: <ZEgdmJWhJX9NJ0fG@google.com>
In-Reply-To: <ZEgdmJWhJX9NJ0fG@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1proET-0002Gx-Sh
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.4
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 25 Apr 2023 11:36:08 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit ffe78bbd512166e0ef1cc4858010b128c510ed7d:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.4
    https://git.kernel.org/jaegeuk/f2fs/c/5c7ecada25d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
