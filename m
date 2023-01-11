Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8915C678D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 19:20:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFgeF-0002dc-Pz;
	Wed, 11 Jan 2023 19:20:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pFgeB-0002dI-U5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5Ln+BzJ4Gd7BOfVt0l8iPS586pp2iBF91++94ltnZc=; b=Ds2NeCsRNkbRg7a99GGFUP1IIM
 jG83iWCIhReFN+TU4aVSTDSaOmGisnRCaaW8f0T6XHgbruK9nmQTz6bMBCkjRxoRPAlSXVvE8ZOft
 Er/UgkbjjwIvpg5lcXEUSzdYo3eskzGhykMckN+naygPFbmTU/cLDm4MGbNw8IhoBgOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5Ln+BzJ4Gd7BOfVt0l8iPS586pp2iBF91++94ltnZc=; b=bH8VUHpP2Detmstt0r8z4E6oRm
 dgQIkdjJeRc32U5cXgZ4Bj5Vk6SCw8sh/JwbJLqERwvr9K4UnaDQKipUfMN53TTkucqPwSRCd+qnb
 2kHBf8uIVvDTIm/SGnoOVAuI0n6ECPcmdBUXduMk57slOsOFEKSPwZ7pM+tgSlH1t1fo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFgeA-00011J-Lv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB7361E05;
 Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11E77C433B0;
 Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673464818;
 bh=zeLE3YuBaPwdWq0OnqqBjA40FXySaJ6AnpW40oUr8Lc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=IMSEorBOzO2Ww7x7/MWbXKeebz64zRMpkhWr63foKAF8w2ewvKjSHlVSjaFbXmGnr
 9h/FM7H2BGqRwIJGXBpwBk3xXcqefHtQlqmV+uxPPy9eapQ2mhpzablhm0CzyupE83
 L5TvexHb8NQdE/y6NnunONCAUtJsY3kpXZmXx2RxZI/KMOj7B7NcNdr7LyLTC4pK8/
 jSs6DskjNRKYw65jH4AJcBP/dX1jBbCs8GXXf2B3QdTLzH8h/98eJpfRuIVkvCSNxC
 mfy/wqnUXvvXpylOPFTaRHC+KTmGKwIcJRLzwvcwtAp51QKyJBn6zNtRrGUKMBUE0s
 iktjr6KNGgjIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DE8BCE50D61; Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167346481790.5008.280373755009706563.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jan 2023 19:20:17 +0000
References: <20221217052448.60656-1-frank.li@vivo.com>
In-Reply-To: <20221217052448.60656-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pFgeA-00011J-Lv
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert to use MIN_DISCARD_GRANULARITY
 macro
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

On Sat, 17 Dec 2022 13:24:48 +0800 you wrote:
> Commit 1cd2e6d54435 ("f2fs: define MIN_DISCARD_GRANULARITY macro")
> introduce it, let's convert to use MIN_DISCARD_GRANULARITY macro.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/segment.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: convert to use MIN_DISCARD_GRANULARITY macro
    https://git.kernel.org/jaegeuk/f2fs/c/f08142bc3a60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
