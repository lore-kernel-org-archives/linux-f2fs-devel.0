Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA37C5478B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:10:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcr3L-0002QH-54;
	Wed, 21 Feb 2024 18:10:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rcr3J-0002QA-Ly
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ttfe6axKueyEE3LQwVf8ZlrWQNtoAVkuPgiDlmgdi3E=; b=KNZqfFSJA0HKrz96orEkC2ix1r
 KUYjNrhefStL6VQJwAJ0n/UUD8HmYD3wL7GDikGUQi+Zfwx53UpAPewV06iBJe0G0E+lBI6ZJTsqE
 NOKc98KHnvWdA53o9zM3utpn8ni7WJ9kfz3kJmI12OTRMJqHDt8QuGX3ntwz+9putS+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ttfe6axKueyEE3LQwVf8ZlrWQNtoAVkuPgiDlmgdi3E=; b=KcIlgXwn7JJ8XOPvIruMsGWC+c
 ZUK8YMoIPZgV005CuXRo+pt1EiwmKosHdKvDX2LlftJDF18XaZCxZ8ry4sC1w9FC4P7TcUxYmNWR4
 xHWT2Au0z/L3a33w0airEl/A1+26BkJ22SvApZyvHhGKreN/W7xg4oh9cU5pvmrNAGvk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcr3I-0001Rs-MC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 87002615A1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F53C43394;
 Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708539031;
 bh=V+n8U7f/vFWbDQbJTX2eAMwPJvubmBJIUIGS9j/t+m4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=qO7HGtcsoY6/mL3oTWvDGEZcz9aGRuQQTq4wEwE/eSJdiex+FkGs2cphNdKft/tqI
 bHeDaY2e8A7oNG5mO0V5HfGcWoRVG/Vh2NQqzrIW+/bPFglRII6OM8CcANVdZxJR91
 B4kAU0JkSQ3A5RZuH2GSdQU0vrxR/iD+gBTJxWDWmjc5dKXOQzNBx8UpBODlHrMRfF
 LMNLTeKK6PC2Ai+HBPARimAURPB3tzjYaAeL2M0PTI80ZWQ48S2Y/GJKcFhSchCcxG
 bXYvsogR1hHZzZlmEdjHcJAT1dC8sk6lWUTfKKxTAukksL8EJedeyqAQS4H1nArM8t
 4/VnaAyHz8Kbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D0659D84BCB; Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170853903084.7043.17909787736652958140.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240220031515.4039498-1-chao@kernel.org>
In-Reply-To: <20240220031515.4039498-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rcr3I-0001Rs-MC
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce
 get_available_block_count() for cleanup
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

On Tue, 20 Feb 2024 11:15:15 +0800 you wrote:
> There are very similar codes in inc_valid_block_count() and
> inc_valid_node_count() which is used for available user block
> count calculation.
> 
> This patch introduces a new helper get_available_block_count()
> to include those common codes, and used it to clean up codes.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: introduce get_available_block_count() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/48238f7bb552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
