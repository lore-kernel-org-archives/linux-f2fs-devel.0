Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD8C678D5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Mar 2023 17:40:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZbIl-0001j6-3f;
	Tue, 07 Mar 2023 17:40:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pZbIj-0001iv-I3
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 17:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxwxQOJNL5Wso5AvBfr5JwPREhs5veCmUGOZ5MsaMx0=; b=L10oYam3xNkAxuxk4Pg4f0i0Vj
 aF5xJ/HDgeFYqpwsyT9dlw3VfPOtWBvwArl2dx3qwdohG3gNsB+Cvu2ztzR2WMvS1r86X2p4hOISo
 4oMK+zBINocuXeCQj5Hj5BVlkFWNXY7NM4FIbcLSMjLn7fATgM+gsZLFgrX/jjQuOYGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxwxQOJNL5Wso5AvBfr5JwPREhs5veCmUGOZ5MsaMx0=; b=nV92vzj+/ZCXp3WXVZZNUNljds
 BVdJRkYxQdbTfSrLGYruvNWM8qmYX42uSadT8t+3dStG1XpiZK3UKEogwmLaiV5ERMM/0i/VQAmmP
 RN3al4j/6Skv1GSQSVwkaZpuEhO47HWQ/HmtCvtUvToyED7loDgLIb2fr03o5NQ6aXoQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZbIc-0001Kl-Aw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 17:40:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ABDD16152E;
 Tue,  7 Mar 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0699BC433A0;
 Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678210825;
 bh=G624Y1RmqZOesd6378n2jmdY1VkeEqxM5hJbs/7/LxY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FMOj1vve9R18caTJLaP/8XmAoHF0gvEPHDmS3B+sW/V9TFpNRmyR7aTvhJ7gbW9WK
 LJj1N36E9W0VLoQbqHmqoP8++m3RP9sKtlwgHXg5iXzluYYGOiV7AzNlEqBOMCuIDw
 kDCz4ZYnJPp6thh8qyYjPLle0rWekbwqgtQ7cRVRPnC32Pacl/g+n6CINKr3cQCz75
 M+qhXkzkqpYvteYSLSzwYjQ+mW1JGvn/f37lmYhuinhcmvn7bGbzoHMlKo/nT9jGtV
 VBhHcYkoWf8tYHs8COaSfocs/2gvXpqFw1jdDMAEfPJAMQ5RLRDRF0ULurx+it9VWN
 hs1aVxTIljG6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D5D13E61B69; Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167821082486.1693.13833377074235792413.git-patchwork-notify@kernel.org>
Date: Tue, 07 Mar 2023 17:40:24 +0000
References: <20230307151408.58490-1-chao@kernel.org>
In-Reply-To: <20230307151408.58490-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pZbIc-0001Kl-Aw
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unaligned field offset in 32-bits
 platform
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
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 Mar 2023 23:14:08 +0800 you wrote:
> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/gc.c:602!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> PC is at get_victim_by_default+0x13c0/0x1498
> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> ....
> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix unaligned field offset in 32-bits platform
    https://git.kernel.org/jaegeuk/f2fs/c/8cac643eaa93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
