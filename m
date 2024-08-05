Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521BCC52D72
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AQ-0001G2-Lv;
	Mon, 05 Aug 2024 23:31:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AI-0001FW-Km
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=teRNwejswpQPciAY02bxbDr2/q2anUv1vVOm4HNjynI=; b=jaHtijb5uqLPu0s979kRhnji43
 +N3vwuQDtUY3/l8Otq4fAPrwtBOWmAOm0d2wYui1ScOYca4mee2dAhWGVcbmZpRF6zShP4g3iFTYx
 SGGl24s426gRzAgDSdJjJo0qBFDeHsx7YYxF2rlLMkeXpXuDegBL+uJsBSq4iYWCmJnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=teRNwejswpQPciAY02bxbDr2/q2anUv1vVOm4HNjynI=; b=JbzaGN2g550tdBYmuKUe3getYb
 /E0Z7D+enOyjZEEBuAt1utoEE0+73TGOXhoQA5ow+Zfa/hisK6gNs6USoe24pvUvdr1BY2tlQ4FN1
 0yzGXEXyn/MD4Qj8xRay8pyl35zrwI0+/+5n3YwHj5iW+HX0yrnNeP1Zwg31lw+8ugIM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AI-00059v-1e for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:30:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A06B060EAC;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F036FC4AF17;
 Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=J7HlvM9ebl2LhQNjxB74nmObesaFPxmrkJCZVoV4R2A=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Sk1EJWeXRNZlVvwBXBskZ+EXiatDYRtVUsxFyKu/e6egYDHg6PIZ2JE8wkMW55GWq
 tSaFMWuqLz6ynzKZc8eKQ48PIcgGDr6S6sdftHhhKDqlTFdKU1KeqcUbG5D3AyUKez
 XPOwV6Ja4T0VryfMuzKfsma5cO3kfH9M4HLdU8QCcmY/kYel0P4RDFFQqeSlaY5G9v
 WMf7gC1Qk6Zynqv0Ru8teQJ/GFpeh7GrqSEIXIJP1EyLRdbsWeM5WZ336rAtSQ7n2Z
 tu55kE09kCxxz8OLY4ttQVdDAArZOqnj3FfzArIRD0FelmUCQzCRO3LWgxnjd64MpT
 igP/e6BCYfG3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E7CB6C43140; Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065194.2803.2752541342354642319.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
X-Headers-End: 1sb7AI-00059v-1e
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix several potential integer
 overflows in file offsets
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

On Wed, 24 Jul 2024 10:28:38 -0700 you wrote:
> When dealing with large extents and calculating file offsets by
> summing up according extent offsets and lengths of unsigned int type,
> one may encounter possible integer overflow if the values are
> big enough.
> 
> Prevent this from happening by expanding one of the addends to
> (pgoff_t) type.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix several potential integer overflows in file offsets
    https://git.kernel.org/jaegeuk/f2fs/c/1cade98cf641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
