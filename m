Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D47EC83003
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 17:30:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6wzS-0000Rg-7u;
	Wed, 07 Jun 2023 17:30:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q6wzQ-0000RR-0l
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=513lgufvoh3K9+6J0FhNPZqKEj/F22RwanVIgUCHSJQ=; b=Mi7W1dkAsJdyg4s6sQUBozs6td
 fL3MzmHFsmCW7Kdwc4MefoKalxtZPcowNm4VxlRUPPIlS9XcvekbhhyAbYKQLtp5hROSIHjCm31rc
 RZ8IzT4dUljwbMFXQxoTMWWv+sZ6RSKCJBNQSO09+q8D8xv0QhwMAjwU99fLgXxaeaaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=513lgufvoh3K9+6J0FhNPZqKEj/F22RwanVIgUCHSJQ=; b=WIHHjId0N8VJXRJCQi+2H8aD71
 uO/KMXMOJll7oaD4VZpSnkDVhdun1n24dn/7sN81xqVQnrLpLyL2SBbY519y5/oUAU2vMnZvR4Deb
 P61blA5W4YpmTJjymZX6nxRx4DJfsK3yWSDhi//sui+tqvwW5fKzrLU4xTZRHM8STCoY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6wzP-00DvrM-Vq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7BCA364210
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A4EAC433A7;
 Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686159025;
 bh=FTQAYVqKB9ife58WmF198IKKuckRPuxdOSAEbzL9Z8M=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=pgk38fYN8e14fd/2uozhIzgYfAvKt4oB0beevz47NG4rs5Bvp+3j0Sorl8YhqjM+8
 8N46r2MRIiNW9mUr5Mpb7vla/3i0/LsHBk5tEvuDSUhXPAOU+9ZdjJ+kxdHNDm5Nsl
 VEelWvXMh9SQ1kgI9fvF66eckVzFjR+x/Je20J/jaKN6DaKuW74eI678U0712sw0Oq
 S96bPEx4Yvn5E/RwGxcjd2ouwQKl3B1+QrYqyQVscJ7FInwDGEpYOU1B8zmULeg15k
 rLn5OncfOPmtfdPuS2WRlR0ejPcWBy5oYwcKNTj1ziuDa+7ZULyhuSDb7j5jU40VYp
 g+16Q8qgbF8+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4C2C7E29F37; Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168615902530.7521.17675789730262728885.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jun 2023 17:30:25 +0000
References: <20230602083605.2470674-1-chao@kernel.org>
In-Reply-To: <20230602083605.2470674-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1q6wzP-00DvrM-Vq
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: avoid dead loop in
 f2fs_issue_checkpoint()
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

On Fri,  2 Jun 2023 16:36:05 +0800 you wrote:
> generic/082 reports a bug as below:
> 
> __schedule+0x332/0xf60
> schedule+0x6f/0xf0
> schedule_timeout+0x23b/0x2a0
> wait_for_completion+0x8f/0x140
> f2fs_issue_checkpoint+0xfe/0x1b0
> f2fs_sync_fs+0x9d/0xb0
> sync_filesystem+0x87/0xb0
> dquot_load_quota_sb+0x41b/0x460
> dquot_load_quota_inode+0xa5/0x130
> dquot_quota_on+0x4b/0x60
> f2fs_quota_on+0xe3/0x1b0
> do_quotactl+0x483/0x700
> __x64_sys_quotactl+0x15c/0x310
> do_syscall_64+0x3f/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,2/2] f2fs: avoid dead loop in f2fs_issue_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/81deabbb536c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
