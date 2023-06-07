Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AFBC7EE25
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 17:30:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6wzR-0000n8-KF;
	Wed, 07 Jun 2023 17:30:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q6wzQ-0000mz-Ip
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r066NRAzL6ww8T8LkwrjZeZQEkO6B1OxcB9+T07K5G4=; b=XIhu8iAUPqZt8A9lH/m3DOs1a9
 rg6PV0yu8BZTYyV+u/KdzNYNIWx8YZRpcKkExGYAcEA2+L7z7aWiZd2LWhmjwsm/l2EwHr1pPF2TK
 7JBoN5MkTx8Vdoj9Et8fh4+6islrmahI5C+VNWSDSgEahfAOm4m2vR8K4UALVlNyeF6Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r066NRAzL6ww8T8LkwrjZeZQEkO6B1OxcB9+T07K5G4=; b=Q0EqegRvR+fbyhB4wPAWsU5fDm
 ZoEVT/FhR2w8DDMlqe6OYC+mprq04BxFCnUVwkGg6ku9KS3zLc4cnruDy08BJIsu6Ps+Rh51a33uX
 AMSAaQxWic3KzErpazUf1MaSgfnRxY9QVftIwKY7IGhPsDMJQuwtMwJlHnPeZxoyP2+w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6wzP-00DvrL-VZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1BE6420C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CFDAC4339C;
 Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686159025;
 bh=zE2IShqugBtrR3++gA9RJ6k/KdgXrKYy2Y73L97WYt8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=lmWWZ0AsdDibxt7VYxODpXfI87U1SK9ss1XQzpQ7+xMcj5uZ7uoYRyjcg6lNCK4wG
 qwsIgkWeHVW7v+C3CGH4eCZS6jYTFaa/AbF/C5dMTEs2WXryr5I3JT+1fUqlMsXAxT
 EK4L490mLGBHvFS9oCnVoCqyCH4lv+/nKu54bbC5EFe8rjWAaHNNG8WhEjn/a0pL0N
 GFIR906MK7H5Xihn04o29SjDG93FVgl6NDiuMI/E7uETzuqZ750lTdNG5yerSbhbks
 kTAy44M5Fo/2hcQc8/ra8MpfCtRe6aAbvudRryRrErcOcUApmLoafUsWyF4VlsJGfw
 T/W0afM9tHlKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3910AE29F39; Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168615902522.7521.11156422070450767318.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jun 2023 17:30:25 +0000
References: <20230528074713.1682062-1-chao@kernel.org>
In-Reply-To: <20230528074713.1682062-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1q6wzP-00DvrL-VZ
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to drop all dirty meta/node
 pages during umount()
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

On Sun, 28 May 2023 15:47:12 +0800 you wrote:
> For cp error case, there will be dirty meta/node pages remained after
> f2fs_write_checkpoint() in f2fs_put_super(), drop them explicitly, and
> do sanity check on reference count of dirty pages and inflight IOs.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to drop all dirty meta/node pages during umount()
    https://git.kernel.org/jaegeuk/f2fs/c/50cfdbd772cf
  - [f2fs-dev,2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
