Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E84C88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHsyg4PLog0XLYYHcKtMGHQs4qK71igkb2Sb27WJFPE=; b=TiMQozumAs/Aj2fcentyadLh2V
	2AlmgRzzgPLNElEcNmj5fOurkNpav4jITwm8SXOckFIuhfpYncUrhoWwzv8Feuo9mMFte817Y7/Fb
	9h+G0HqmJ3b5yPCPras1gf8n9Pu5OpZ80KDEu1teb5JFyv1VZXmGqUbwC+YyKuQ1XmiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eb-0004b3-HW;
	Mon, 14 Sep 2026 15:31:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eZ-0004aj-Pp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Av5rO3xR8J4G3fFOaXx1q8wbgKJL0nYhymS+qYV868c=; b=EHLHrGZqck4JdBm2SqxAmqU8hU
 owF+i9eT1bl5hiIY1TvGjGReKG8P5B/lt89E2puZl9c1gj/bIVXFspuTNFNvpAy2E9v6yNqJ6lgW4
 3Xr4UAMeqCqScafBFjssWifWD7us1zZsv1pOepktEI2rH6UEJK85ecdKfUD27nLo66PM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Av5rO3xR8J4G3fFOaXx1q8wbgKJL0nYhymS+qYV868c=; b=m5sat4Vxsrt88Zmg1FRKS4d6iz
 aGBxND9OfaLQfBwcMin0ot2bAKedKjx2TKU7I1pnbfSgi3YeTGCSEQF5D5J8qZdtE3WVDd7GN7CjG
 +XKiLsB3Qk8hKaflM27OvbJVzvEfrFmBGhBx/sQcSAUZe62S47w1WHatbKOT86OyPer4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eY-0003TY-Pe for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4013A60258;
 Mon, 14 Sep 2026 15:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9171F00898;
 Mon, 14 Sep 2026 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399885;
 bh=Av5rO3xR8J4G3fFOaXx1q8wbgKJL0nYhymS+qYV868c=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=LsA9mqB2qYDtJsfotXd4ggdqiVYDq5h1RPJF5zcOB7ZrKET6TLS80zq9baLV/gk0V
 XmN3BrqRX2KMDWH3KFu88+PWJnt0x9Ai07yq76RT6/ERPkbLFmlDJoLqF2IOCDcwH7
 U6PGg4fm0YOhf3APqy2rGSZZ53qZw3NhXTS8XRvRBT2HcCihlQHTavBQGEyklE0P9o
 NEqsZE35TlXAx4XiQ3SwNx9+DkL4PLgPoytMfuTXwFz/z3n+q1UFtGTpVRoJeUnzkJ
 Wkt+HS2eykvpvFWJu/6L9M0Lduncj7pOUzBmMOlxkYHbvDJXMiYUore38LAgXAxav6
 EdmTsf2KwgYMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 569733924A79; Mon, 14 Sep 2026 15:30:21 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981988.647967.8103343136989536572.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:19 +0000
References: <20260910022026.3301257-1-chao@kernel.org>
In-Reply-To: <20260910022026.3301257-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x68eY-0003TY-Pe
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid folio->mapping
 dereference in is_{meta, node}_folio()
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
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com,
 linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Sep 2026 02:20:26 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Otherwise, it may cause NULL pointer dereference in race condition:
> 
> Thread A			Thread B
> 				- f2fs_setattr
> 				 - f2fs_truncate
> 				  - f2fs_truncate_blocks
> 			    	   - f2fs_do_truncate_blocks
> 				    - f2fs_truncate_inode_blocks
> 				     - truncate_dnode
> 				      - truncate_node
> 				       - invalidate_mapping_pages
> 				        - folio->mapping = NULL
> - folio_lock
> - is_node_folio
>  - F2FS_F_SB(folio): dereference on folio->mapping
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid folio->mapping dereference in is_{meta, node}_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/b5a71253c5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
