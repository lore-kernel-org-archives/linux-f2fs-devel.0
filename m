Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1E9C04AAA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Sep 2023 15:50:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qizTN-0005Yp-Q0;
	Wed, 20 Sep 2023 15:50:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qizTL-0005Yi-QS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfsO3eQSB6e5Iuaraab56PbFAa9WsFVQAnbuUUaYdvk=; b=O5GsjLlbPTIbRERIZ4IMkuyc+t
 rd7RI7P/zvykNB3huB0MHtlHrmPyrM/QEHAePTqEkSrCKmv84klX/bQYMWmwmWv7PC71scaCf4Dqk
 jh8NCLHEvYpaLZ6kh05VBRLgwHquNRTs7d3uJHBXtrQgguouG0uhuxddwz2SbXxsPB3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfsO3eQSB6e5Iuaraab56PbFAa9WsFVQAnbuUUaYdvk=; b=HBHRgy1GsAJE4EP5M7XUPnn6np
 lMaSg22bWaHNkUM434QekFx7Xszpywf0/DGDrZdVxV8tM1/8H70J/i0lbAdgCR2yUyIGxfzZwIpM3
 ON3tzhU4nLv4a9hjXwm3wl9sz/m/b3RAe0sFeSqIcaK1x66jFwSn3At6YzdZH9x6nb4w=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qizTG-00GvPp-Ck for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 24E5DB81DDD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2023 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78016C4339A;
 Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695225025;
 bh=/1672Hbz58PbiCTUwJZm1qr1uRwDuYVk0zfuDwqJfm0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=GAmidUmtByFG8Xtpk8rggPpB/ji6VR6J7VnGb4aX9FVQ4HZQIqx/G3Ht/x+gZBhHb
 EbU4bfxB64mXttF646xhh6PqCjKPFr0PlozCuIQtlABZibZYuwjclr3rvmEIYAfO4w
 RN4rZX6wulcZoZJSFiHhpCQ/TGCC9cI5e+ZKVGvlXYTcelNOAkxqPwvNlJUiNA5wZ3
 OJSR47v26BRE1upTW2bDEdZ4YTnrIJKboQ7kX3XHQFw7oGuArxCrdoYuOtxejcT/Yh
 kOTHDlo6qJX79lonWrRX7Kd1BGQ3vqTpyvCB8HUCi/2R2mLzH7jmtOmjoFapiyRth1
 sWBhIsqubeLVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 5F1A2E1F66B; Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169522502538.22557.17553337845342817079.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 15:50:25 +0000
References: <20230920004645.1462354-1-jaegeuk@kernel.org>
In-Reply-To: <20230920004645.1462354-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qizTG-00GvPp-Ck
Subject: Re: [f2fs-dev] [PATCH] f2fs: preload extent_cache for
 POSIX_FADV_WILLNEED
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
Cc: ebiggers@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 19 Sep 2023 17:46:45 -0700 you wrote:
> This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
> more useful for generic usecases.
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: preload extent_cache for POSIX_FADV_WILLNEED
    https://git.kernel.org/jaegeuk/f2fs/c/a3edf9f0bbb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
