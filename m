Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A03CC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAHaLhwMtSe4vJ4YurcbQTGOM2qdANt/2zTrE097lFs=; b=JdQI47UawnWiYQexNmq9Oza6IS
	HuJQyHtCgFX3BQEXX80n3KU48SjtFxsVBBZqrpQ28qjEctFbNTKkDxK71HVbQAU/SouZPx6ahxnG3
	W0P1KQKPaTNeX8eX4ObfrJLozPwriSgK/0rjnsro/t1OzGV0dKDQh2kBuiIc11Lp5sX4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHOoZ-0001ho-Gh;
	Thu, 15 Oct 2026 17:00:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xHOoY-0001hg-5G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 17:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EnVH/El3lsJ985kz7PRqXdqaNI1QwQfIBF95HlvT3ZQ=; b=GNqM8pbk5tWuOJotWAd3sPvq4U
 lh0eSKLtQz+ahoY8XSMRMM6StI7RerJzg0HLXIHIfwUL0P93moomaycL/Tt26ao4TGCe8mMfPA0kt
 cq5z0xT00VhXDBhUj0YRVSUwrhmSX6b8MeHy3hIFUQ9Y0RFM4seA/wei5RuXbHRXYf1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EnVH/El3lsJ985kz7PRqXdqaNI1QwQfIBF95HlvT3ZQ=; b=GmgATAV9ou3zDM5qwZFQEvfRBH
 ox/9o1MAR9hDuZE5TCnjQMy99WzsZFHSqkeq7hC3PGZfke3d3vZniBvrAEMdJctdgs3ysB+U9nhwL
 Sk9SPy7rqGowicMoz6AgK7WSKYpW5BPMdZYSV7usmw9nyl87+VmnbKjxshZwLO5XdEkc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHOoV-0005vl-4f for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 17:00:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1284416DA;
 Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B537A1F000C5;
 Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083613;
 bh=EnVH/El3lsJ985kz7PRqXdqaNI1QwQfIBF95HlvT3ZQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Y9PQoUqIxmvwP8mQ/R/4JhtFogkE1llDXKwYJ6ygX5sMAIGy6jhxG4acFui/0OXlh
 t3lqx22GfB5Z/NULaAjlm3MqqaLl05TKKXnL1scOfnncV0n2DgB6zMCamkcOiL8TC1
 ENmAc0GAfUtVAnNy9ae1UgdeiLVDrvb+uRgGENZLyUWf8SeerYXgDrmkeURuCZGide
 Oep26LsfiIj85cpOrBSxxy7RQ3tEQZ0+Bs1blCqRcjpbcZM+yahYP9P5MkTMpR5eil
 UW7NTUehWC7d6EweMpIMfp1lF/fmoPaY4s4KTYLHnwXWEd79zwONEVGc3Dvk+y/OKZ
 ONgz0MphxQj2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 A98003808209; Thu, 15 Oct 2026 17:00:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179208361251.4008483.14776408696216396844.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 17:00:12 +0000
References: <20261015025732.1564032-1-daeho43@gmail.com>
In-Reply-To: <20261015025732.1564032-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1xHOoV-0005vl-4f
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: release a removed xattr node in
 roll-forward recovery
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 15 Oct 2026 02:57:31 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When xattrs shrink enough to fit in the inline xattr area,
> write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
> the file is then fsynced without a checkpoint, only the inode block is
> written, with i_xattr_nid of 0.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: release a removed xattr node in roll-forward recovery
    https://git.kernel.org/jaegeuk/f2fs/c/3368225b737b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
