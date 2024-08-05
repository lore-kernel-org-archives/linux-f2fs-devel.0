Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42022C52D76
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AV-0000Wh-GV;
	Mon, 05 Aug 2024 23:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AU-0000W9-3Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uO68BQS+k4Qc+4biPLzK+9JK1NLmArH8B8k7pReFCGA=; b=HAcflPEgQZgx3Fao2aNipxEN/4
 VCAQjzAj1eW7rwiELkK3opgINtY7T7BzQzYgoARyxsPGuX+bt6qTk6mQ79Ww+UeM+iDQiWn7a6b9e
 n/mycCx6ZIRsLpGWR4wBl3duly3ibT9OBeFwa4bsvgsQ6DNuJKvwtf/491bi4/24ifHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uO68BQS+k4Qc+4biPLzK+9JK1NLmArH8B8k7pReFCGA=; b=FL1N1Lj+xRAQYs6K9hLnucUqEd
 AuW+/e1SOkwR3P48IXYz+fIj1HnU/x8zq8c6rAXx6mMfxw+jDpRZSSVHrouLDvbn0NJI2+eipOu4b
 CXlfTFWHD7mG3zQ0mF5FuZvBjAH6v0AwLz0OkzQjFxoa+rP9EIH73isdEGppbCu12xUQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AS-0005BE-RV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1E96960ED4;
 Mon,  5 Aug 2024 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3979BC4AF63;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=ICHRUR5jiG7pkCFf4zi9Dn+hNtalIy1AkC9PonW3yrc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DJWr89W30EGdyju1Xw6btrY/GdBXaBVx2ADqkutNDxAc2LGGtqthqA4wuqDfyzDeq
 9uH2cxwbkoSwTmFpDxK2TRYGt8j22cmoIkdyY8gpW6EquqOKHZ8P7m7FhIpqgLynyx
 SYe1HzaJXBBOnHx14qtGC9X69S4Q9PEOi0ekEYeZHx1e1ymkQbwI7RPHQf+y4k5pgE
 B1FyEimiJv1q+A5OIUZZWimEBQ4KR3R5Miuq19eeHBTfx9aB1BkpNL0LATuc/NRCbx
 uFxXCan0wCkCQaFpTouzSP/yR67nbg+G5L/Pcmyoh4uenBz6yYyqtCIw5rCvyZYd0n
 7HNt5pePKrLCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 31262C43140; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065219.2803.34268911020752099.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240618072620.720535-1-chao@kernel.org>
In-Reply-To: <20240618072620.720535-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sb7AS-0005BE-RV
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: get rid of buffer_head use
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Jun 2024 15:26:20 +0800 you wrote:
> Convert to use folio and related functionality.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> - support large folio
> - use bd_mapping instead of bd_inode->i_mapping
>  fs/f2fs/data.c  |  1 -
>  fs/f2fs/f2fs.h  | 11 +++++-
>  fs/f2fs/file.c  |  1 -
>  fs/f2fs/inode.c |  1 -
>  fs/f2fs/super.c | 93 +++++++++++++++++++++++++++++--------------------
>  5 files changed, 66 insertions(+), 41 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: get rid of buffer_head use
    https://git.kernel.org/jaegeuk/f2fs/c/8ce36b8b1150

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
