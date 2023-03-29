Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A939C761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Mar 2023 22:21:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pheAl-0005SJ-R0;
	Wed, 29 Mar 2023 22:21:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pheAj-0005SD-KO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Mar 2023 22:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FAUiaS6v4S1hT3uxzORIKblhKASWsiLTUI26SHZn/k8=; b=AmKEelwZrbDkA7Dk1sNGF8FTT+
 4Wr+XzVXgOFz5Duxh7M/Ym3OyzBN7IQQYZd6r/Zm4tBiKlZlz/Z30tt7WtV8Q8/WMtfA1y4GF9HQg
 mbeIdD4jf313KgscJm/9n/Jze6gQLrop6PVeghcHJey26vaypOhaLZIlMRZ+mZB71EG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FAUiaS6v4S1hT3uxzORIKblhKASWsiLTUI26SHZn/k8=; b=DoH65D9dgvaneLWpS4Ux0ES6Eb
 VCDEOxxIsYpfFK/alIh07/sq4pILqBhErA8bM7Ltbu6nCnu4rGagG9PV1MaEvW9ptOXOlHU3gfLSO
 8mzYLqZERpSenNuQMfzdz3yQa2C+Tmn/8jG3Go0FvifinhH+vPUOGfZWS44Qup1NP6KU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pheAj-008rhI-6k for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Mar 2023 22:21:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E14AAB82482;
 Wed, 29 Mar 2023 22:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD12EC4339B;
 Wed, 29 Mar 2023 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680128489;
 bh=dEY98fti8YdNLuybKGKQCokOJDiPjSDXGX1LP1Dsnjo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=fxim0T0Li1ctRBtf59cgGXtBHIrEmBPsigbgs3HQsclFEwDrwLbnBi0XUwmJYivbC
 UPbWmcnEMOX9Ou5FgIR5vkl0177wiwYkvB7Idu21eZ3xxtdlaQhcQRwdgGjfIszKKO
 6VNvx2iDPU1Xs8BhQyFW2Wh+VUUqy3z7OfK+Zw5W19ZWKR37fqLzO8GPksIWfkGpMC
 b+bweVBPNFEVE5+WwyN+tmXBDsUimaH4p+Zt/NVxiwJ6LYb+2b9ojpTAHS2Q2uRfyn
 +e1Uuf1x0jRRb/MHHexWWKQCuLbIj7+FEe8Hw0wt1AWzTdnkv7rsCU3J5HlsAqFc+0
 EWzTd4yTMDqnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 81F77E50D75; Wed, 29 Mar 2023 22:21:29 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168012848952.3718.12657695551719922710.git-patchwork-notify@kernel.org>
Date: Wed, 29 Mar 2023 22:21:29 +0000
References: <ZCOHd4jYn8zUCEZ0@google.com>
In-Reply-To: <ZCOHd4jYn8zUCEZ0@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1pheAj-008rhI-6k
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.3-rc5
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

On Tue, 28 Mar 2023 17:33:59 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs fix for 6.3-rc5
    https://git.kernel.org/jaegeuk/f2fs/c/3577a4d37f9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
