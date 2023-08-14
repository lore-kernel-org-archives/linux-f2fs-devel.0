Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8882C04A94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Aug 2023 20:50:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qVeWF-0001rb-Dg;
	Mon, 14 Aug 2023 20:50:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qVeWD-0001rI-8G
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 20:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjPUGogHNLHvYUz1VausmOBorvhsghIX1pmWfbDgUlI=; b=SE61H3mWe+h6fQ+8pAphHVUOPu
 MAzja0I8v4VmYq8xnOH6FbnW+UjQlueC0SoE/Jw6prqq+E9bCNbRWtMEvlTE/GS/SUbNrdYAXO6fI
 HBfdtaOZFljfAecy1j1jCjTjYoiQ6uWznGTl3tPOTO7GkD6/p42u7LZL/NUmYsenUZdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjPUGogHNLHvYUz1VausmOBorvhsghIX1pmWfbDgUlI=; b=iMB0ymTwstcCcID1Y/1BrI6Q3e
 I5IFQhYbPZksvsciozyMKeLTxJ1cv9OwPv2GTPPGOhNeI7lnt0dAqV7rtXMO72Nj9aWQ6PyWTrz4D
 H63YxxlWSHfFv+Fn5jeekZQmz48voNDgwxgvOL5pLMjoaC/8Q/kJwcvVebU2recZfhwA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qVeWD-005nrq-AU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 20:50:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 062B7643D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6729AC433C7;
 Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692046222;
 bh=FI6aUE3s5kfOTtgi8ZGZCJWljDK13RF92dXiaXrgLNs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=sG/OlfmQon3zkukvQcU7yT25oOPE5z7YhU3eJyRsNTDbvFuQH++IHJoanyaAUbMEE
 ED7D9xcmr9ED4GMfkVw4GnRh4v0yJZ7XyiDPcg4vhfBWZlV5G+9OFFs2P3kvwWgY2B
 sl52FxNR0+baS2RwvtXPzsAFrIHVf3HI3SCcth0lx65sJR+9N/MCoDUkBjBwdeRgFj
 TT55MkIkiB08xAg2BMGYUibauY+1RncY0bLLOAoO59FLkMcQ0LlJrb7dC6j92Y9XO0
 /K3n+ig/2ovD59wpmKxEYbWvdFEpevL22PMlzB2AWfKnFfw5cgj+s+ktWqT5p55ZDs
 msysQFZtAjuuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3B01DC395C5; Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169204622223.5033.2752517082147339614.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 20:50:22 +0000
References: <20230719135047.2947030-1-chao@kernel.org>
In-Reply-To: <20230719135047.2947030-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qVeWD-005nrq-AU
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to update i_ctime in
 __f2fs_setxattr()
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

On Wed, 19 Jul 2023 21:50:45 +0800 you wrote:
> generic/728       - output mismatch (see /media/fstests/results//generic/728.out.bad)
>     --- tests/generic/728.out	2023-07-19 07:10:48.362711407 +0000
>     +++ /media/fstests/results//generic/728.out.bad	2023-07-19 08:39:57.000000000 +0000
>      QA output created by 728
>     +Expected ctime to change after setxattr.
>     +Expected ctime to change after removexattr.
>      Silence is golden
>     ...
>     (Run 'diff -u /media/fstests/tests/generic/728.out /media/fstests/results//generic/728.out.bad'  to see the entire diff)
> generic/729        1s
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to update i_ctime in __f2fs_setxattr()
    https://git.kernel.org/jaegeuk/f2fs/c/8874ad7dae8d
  - [f2fs-dev,2/2] f2fs: remove unneeded check condition in __f2fs_setxattr()
    https://git.kernel.org/jaegeuk/f2fs/c/bc3994ffa4cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
