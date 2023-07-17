Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8835C001B0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7E-0003jO-OT;
	Mon, 17 Jul 2023 17:34:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS7A-0003jC-OJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=15TXa+NCzunOr7HFwTgaSnfHocnZZ0DF6FdSlpaA4rQ=; b=CUYNyEKeFVW4e1nx63CIl7/7Aw
 vo41uxnfETFlDvNhhwCdrsvmMgxJBxoiNC8xWzDb/vGDNf3aP6B3r5UB4CKZHGejWTPyc88gJc0Xl
 Q4WDO0sGoL4vVMcc3rhVstIl1CcIK+O+ouVnxwSQSQ1SCg1uoN6LmqaRhHlrwBlb2X/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=15TXa+NCzunOr7HFwTgaSnfHocnZZ0DF6FdSlpaA4rQ=; b=e8tgK/vVLmz44CibJ4IdjHkioF
 e5KYgZZ7VOhg9pjyTMkVbuBmc9iglbhmrSbHUfvDHy96/WL7BqUuiQx7D7XzxkAmE5qJumixxXgMP
 kdRHaiGvADNVcJhIp6243HeOe/DB39uUWsajXhUD5EVvhaTeRvh9B/6qC1iC9R2+kkQs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7A-00AvF8-3b for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8414F61197
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E3CC433C9;
 Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615261;
 bh=5HpakzjV7y6m8RmvEp04Fq3yRPY3dfvIkBk0s3tcWlg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=A0PCzUy2hKyp0/eCHJtqvlxRS3KMOBo+xPHYvMGvdiz7FveMpMvRsDnhGbGKYSTYZ
 9C1yZsFAe7q0XIWpJdtPdWZ8GlK+KIo6KsyDf3mCzyKw5azLGnT4c1MivKKGu/1KTv
 hyT2k/V7+NuMQNSAmEAOEgJD07e5kGRRpw/5KM8KNI33s0PBQycyC4vqGzrk4YBDb6
 9IXKV867emtA1BOycbiD+LheonA5prN2hHIZqAko1jmJJs/9z6r/7G1O8wEUVVk3f+
 xFyg9tFYWLQfl2mt1FlHhkBtAI45GjXACvmyADXWWWz9NSE1U5dOB4SsuPnx2da8lR
 4I7zXfp9kDqQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BF3A6E29F32; Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526177.4078.6277797285337568603.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
References: <20230711200806.4884-1-chao@kernel.org>
In-Reply-To: <20230711200806.4884-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qLS7A-00AvF8-3b
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: allow f2fs_ioc_{,
 de}compress_file to be interrupted
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

On Wed, 12 Jul 2023 04:08:05 +0800 you wrote:
> This patch allows f2fs_ioc_{,de}compress_file() to be interrupted, so that,
> userspace won't be blocked when manual {,de}compression on large file is
> interrupted by signal.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: allow f2fs_ioc_{, de}compress_file to be interrupted
    https://git.kernel.org/jaegeuk/f2fs/c/eb0e30a6f8a7
  - [f2fs-dev,2/2] f2fs: compress: don't {, de}compress non-full cluster
    https://git.kernel.org/jaegeuk/f2fs/c/10c7134ee440

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
