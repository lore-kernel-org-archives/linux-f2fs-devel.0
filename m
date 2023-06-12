Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A754C7EE43
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jun 2023 20:50:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8oUh-0003Du-Ee;
	Mon, 12 Jun 2023 20:50:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q8oUf-0003Df-CY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 20:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PBkPI8Zi472xD9ibojlkySOX6BwL/RNb2pjc0k3l5tU=; b=Mg4Dm2AMyLMjUb8qCWDR4R+4kO
 qKfCSHcGPW8mlzLLabek1spxQp+ZOlCIKPbrpE1pUBHobgLhWmHCNYZFnUjYEPkqGKzldd2mXKIr1
 Wq1lIJnbYQdFb9eai0YFj4Hg7zQEE2tRrm2YtQe7xwnhbPzW/bs24ytWZ6ExybVmj22g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PBkPI8Zi472xD9ibojlkySOX6BwL/RNb2pjc0k3l5tU=; b=bwu4K7PRFo/Klh7SbZv5vjjbiN
 63GNhB9EiHXHXMLeBKo65ouTF3rSrPIL/sgo4OvJHupMhwbGfCmStuUrREWfNaGIiV++1tCd6eync
 IBrbiQch2KoU5d8JIiO2ygxt5w53HtbMMDEzA2J+DuLcpghkr/moL3WS42t0mM70hAwE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8oUe-0013OR-Qk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 20:50:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCB4628F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jun 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 597FBC4339C;
 Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686603022;
 bh=jS12uuQxTqxQ2t3KIocRVKhkQuA+O7CPb1iTWoSgv30=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WRI8EtoL2MPrLFpeoKJZ29wGGmG+Dh5bghhGGgqft9ChJdDYf8d5kk9VrCz/EaSRa
 0u2hJvqj8O/k9v3KkdCzOlEFMR4++9KygLsbZZ5zdC3CihGH5bkyYY1CLblIMGVAaj
 4E3FGcIxCqU6QwWdhrSM7DcQwPCryJG8H/sDuvooAwWDAqvXU03TDAzPw/SyqU1EBk
 BPTDm6YyVtOT5aJ/MKXLSwaDr6hakV/cYy1Ue7+gQbFF9ZZbAVnn44P9sbvzytRdhj
 p4axVTBTuwjd5boN//Hxu/sDGatqb9hecA8F/mHWvWo257zyLoM88Ex4LmKU1p0n4O
 NswRCoy7gGM9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 32E0AE21EC5; Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168660302220.10168.204042134009169734.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jun 2023 20:50:22 +0000
References: <20230606061822.1179551-1-chao@kernel.org>
In-Reply-To: <20230606061822.1179551-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1q8oUe-0013OR-Qk
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for
 cleanup
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

On Tue,  6 Jun 2023 14:18:22 +0800 you wrote:
> This patch adds F2FS_QUOTA_DEFAULT_FL to include two default flags:
> F2FS_NOATIME_FL and F2FS_IMMUTABLE_FL, and use it to clean up codes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 2 ++
>  fs/f2fs/super.c | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: introduce F2FS_QUOTA_DEFAULT_FL for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/4138d5a9121b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
