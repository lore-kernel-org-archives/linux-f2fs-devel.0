Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F31C636CD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 19:10:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMw1b-00035h-FM;
	Tue, 31 Jan 2023 19:10:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMw1W-00035D-P8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2xSV8+hm4kLpmify4Ao7DRX/XMrwvlmQUGLHfYS/6A=; b=JcylT1/33iE2JoxwAR5DotIM+v
 YkpwBbQf3x2WgVS5gHfjPEMSw3J32m3Fg7fnLtVXeUU20/73OGJrcDENBRKBE6/j2NoMsylTynhL8
 3iQiQAdwXld2IN91G+wijrJ1fYhjFTl7MEI8M5Iaz9PrI+LSFXPnzjLL+Pd/XjeP0hGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I2xSV8+hm4kLpmify4Ao7DRX/XMrwvlmQUGLHfYS/6A=; b=FzHuCeajOu5xHS2Q5e69ONisiw
 LAbPCH6wSutc35mHZ/2q9kMCkYNWSfQviCHu4P83iuURSvrGMncMpKyhlXH+4PVXpl/dUKNpJsigG
 96QhCGK2c/RXhtrIfjknSbZqZPSV7+zYA2c7+kSkZz3feJpi17rQc9ZTSwmKqqE63n7E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMw1S-005sYt-QU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 685B9616CB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FFEC433A0;
 Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675192220;
 bh=tCiZPdBodHgn+9HGNSelz7b93sIkuDQColYmbEDd9S0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VlI4hatzDQ8JmbW0G/9iPlsaY5C1y9GqsFEavNR117DezU+LlkSaNNEH2r76Tggxs
 umDEnv9sxtp3pKQw85c0NZ4gq+KT5PDy0U+WhtY0IBLuTEVVQDWyNM38OlQ3f6qDYf
 5KkBvwVHy6v4977LSEzs/YCQAaZ0tJN6Qnmw2i0wTwVpVLpz+QrKzcpayTXSnVcTvv
 baOAR3RRuG/ZqD9y2nTamPJpTLPNiFyamDvPPxp94mmnxmRCfqWx1yOXgxEFHphUek
 UeEaTY5SzGSSsOlPRAttCcCpmlRqZlsMpYg5lHC0KB7wbAhQnrKgWfnfcfpqW1d0Pa
 Ng6hcSAiEGe/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1D826E50D6C; Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167519222011.20142.17605283450543529387.git-patchwork-notify@kernel.org>
Date: Tue, 31 Jan 2023 19:10:20 +0000
References: <20230131144701.34418-1-chao@kernel.org>
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pMw1S-005sYt-QU
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clean up
 __update_extent_tree_range()
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 31 Jan 2023 22:46:59 +0800 you wrote:
> No logic change, just avoid goto statement.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clean up __update_extent_tree_range()
    (no matching commit)
  - [f2fs-dev,2/3] f2fs: fix to update age extent correctly during truncation
    https://git.kernel.org/jaegeuk/f2fs/c/334ce4a79c9e
  - [f2fs-dev,3/3] f2fs: fix to update age extent in f2fs_do_zero_range()
    https://git.kernel.org/jaegeuk/f2fs/c/de6b3a5e09b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
