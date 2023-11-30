Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7CBC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Nov 2023 18:30:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r8loP-0007On-Ei;
	Thu, 30 Nov 2023 18:30:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1r8loL-0007Oe-Gm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Nov 2023 18:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rLPJky/QtxeIuRyl2HZrCFRyhbOpdbS/CarodoCHHs8=; b=Hu8DBiwLiYwp9Y3L5t3/q5zKQv
 hYsUQHcPWkzUM9WJ+beNDRnBbIU0pA/rP5oKPlgYnm9fgnh3PHFACaDo1u5I1ITCfVsST9bfoqGzq
 bLDTCLXjnTO3JZCzx7HuFJj+tKGTLDp+xxyJSxL4H8p/PS6wtqiY0QGOrdRJqMAqNDuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rLPJky/QtxeIuRyl2HZrCFRyhbOpdbS/CarodoCHHs8=; b=Yc0qykMmLIWuYnZAnviBEFzjE6
 kENizeYdYB0CuoiPHI8yTPxNZDtpdV5K6FiurFLRz4HyJ59qltzR7ElEq/hRlavC4ENIKiieRhbIN
 yPu+kU+AOOyMngBSLgeoLtWRMvSJ8oEtLowO2f/49qtX6S0ZjJWpQEzJaW+Qthb8JKgc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r8loL-0006TO-6Y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Nov 2023 18:30:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 275C461771
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Nov 2023 18:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F97C433CA;
 Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701369028;
 bh=X/S18rDtdxyHgxoYAi5a9JWKaZcSVpxepeUSLeT1xX8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=vDdITaceRlVOiKh2ptGtFykvgrUX9I3qvNHoPmRzhbG1L774/dy8jZQqowan3dBZN
 Lnh+bkW4B0TAdpu9V4/7qtYH3gz7snddltguQiIG+yHtFvL0v/9RwdS1ohllvRLPpl
 VdQ3rmlcz2sxMmbUl278gYhyNhYrAfDN1S0iv3ZUhYmqhNVJfkE8+OvLdIf+VEj8F0
 0dVtCbMIGwOTGwa+NndraBAgXmiIaD9og/5diiW98MXeWolOaH49ESmrG+ryJI6BPw
 PX3f+OstumRS81fHCwfGV9bJWmVIc7vmNk5xDLMlTHR/1zntKfIacmYqkulVgJoryp
 NRwlACyw58Dfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A950EC64459; Thu, 30 Nov 2023 18:30:28 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170136902869.21709.10431255824319332465.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 18:30:28 +0000
References: <20231128093130.2885216-1-chao@kernel.org>
In-Reply-To: <20231128093130.2885216-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1r8loL-0006TO-6Y
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce tracepoint for
 f2fs_rename()
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

On Tue, 28 Nov 2023 17:31:29 +0800 you wrote:
> This patch adds tracepoints for f2fs_rename().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c             | 16 ++++++---
>  include/trace/events/f2fs.h | 69 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: introduce tracepoint for f2fs_rename()
    https://git.kernel.org/jaegeuk/f2fs/c/5f23ffdf17e8
  - [f2fs-dev,2/2] f2fs: show i_mode in trace_f2fs_new_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/8e9cf55ef89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
