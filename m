Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8648C25B44
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Oct 2023 15:30:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1quwtC-0002hB-7w;
	Mon, 23 Oct 2023 15:30:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1quwt0-0002g5-Vg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmIflEXO6RQMtFdIBlDyTLwvKW6IOSe88g4yAT27WPw=; b=lvOW5v3lgNDZ1nlREAd02TnrXD
 vKj+Wznleabbe1HtTWL0gjtLD12Pw7myTOylfjIgRlH4e+v5tf9gPlqlSJ8LqNp9NocZsVJpornHf
 Rxou0roMd2Fcws6AsacVpN+CTOvK6dniX5IwOmrrHo/gyOsqzCtr8raN4gOOSvpSIBDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmIflEXO6RQMtFdIBlDyTLwvKW6IOSe88g4yAT27WPw=; b=kSxsV/WMdu5azX0oTxvdXiQfPt
 HWZcU+q8LWz3Iwx5CJZmEerEigeZ4B3LkXgPBKe/g69+z0nmRHG6J7FiBGAX9t7pCTzBcca/7Oy4p
 /G04D6wAssked8ZGduGLBZ+SA7wcyvLiKxPczCBVO0k4iGJj8TY+WlXYoyLpfSjWJLDg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1quwt0-007FvW-B1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 7B403B81EE0;
 Mon, 23 Oct 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 438DDC4339A;
 Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698075025;
 bh=B5OsZe8/lVf1JmDcA021tEGnZnS+LMlkjLr6pX3ZOT4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QXJY1fq1FwwcnGpx9Dslv1haoPlKdmOnKQYRAMVQo1VBzHGh3OHReSxV3bveVYLvU
 vZOUBW6Cy5nK0ToUok+LIE1/y2gA74eTu0QiKDp1ojoCwz8TjTJaqluOpmq3uD0T6M
 /vIQFsmqVL6FFwVACpW3A4xnLYeZa7ysB7N3K6vPcRDLtj8/FyRZX91CuBKKj39rNN
 JpDiWqb/YzdjJaGvm/6stwHsjcaiptTeL8PGhAFsz2WeLreiZv+Q4HVZ6BQiNukyPn
 M20xh69t3e+HqHf7qciCYU4pCXKmdLu9+wcF4fjpQfWcCeQagbScL+FhXS4a6YKGNy
 sfO/LjILAJGhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2D075E21EC2; Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169807502517.26537.6705085074698625171.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 15:30:25 +0000
References: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
In-Reply-To: <1712b338.95b.18b27c8a5b6.Coremail.wangkailong@jari.cn>
To: KaiLong Wang <wangkailong@jari.cn>
X-Headers-End: 1quwt0-007FvW-B1
Subject: Re: [f2fs-dev] [PATCH] f2fs: Clean up errors in segment.h
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

On Fri, 13 Oct 2023 14:45:42 +0800 (GMT+08:00) you wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: spaces required around that ':' (ctx:VxW)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>  fs/f2fs/segment.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: Clean up errors in segment.h
    https://git.kernel.org/jaegeuk/f2fs/c/37768434b7a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
