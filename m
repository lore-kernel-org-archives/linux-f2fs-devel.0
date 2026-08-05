Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB01C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQTY/Ky9ch4XdkA8xdgNwqmCKFU3x/tt9f5+yLpRRv4=; b=XQ8ksV4gC/04HEUCWjON7E8xYb
	5dW3Zy0VQaOtR5U8tXziS16BZWcoVfiY6k9J3jMUl3p4loTdJ2cl6tVAJrzi5aeC8P6lR7Kxahrbq
	jN6Ug2Xb/VxwasFDdMFvcsDAHCPukvtyyPIX4PMvtT9UtH9XjOhXE+VJFlsgUzZOFdtA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3Y-00088v-Vd;
	Wed, 05 Aug 2026 21:21:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3V-00088Y-Qi
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DiqmMNgl+BWvw+VbCGNinDS1ca+U7+/tJt3PS4C8gII=; b=hj/kU4N8XAmCUPe9JWree5acmB
 Ft7fPuQNFISji0sncQaV+XeoSAp7Sez+FZ4X2wL7LecogjLemUn2/E7snz9bM6IUAgokd5jGACyHk
 A670+pjQqN75kNszh4MTZvxyCm6Iko5sdbMlBssgzA3Z9nDfj3dpHBcGjWshNBy/DdQs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DiqmMNgl+BWvw+VbCGNinDS1ca+U7+/tJt3PS4C8gII=; b=cFi+5CvvcRnRI39H11CexTqVnn
 qlmvsVMIQL0UBudgIQ7YjlRxjI1spifbEIWlJDaqm0g2wwfUiHnawMN7g6UMIfa9HyCdw62qnx6bY
 Umdl555Xxd0hXBn+rIkqaanz7uUPFfFgIYI+/tgGh2YTZecwsPsJ2pCLJEQZo8UHNI0U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3S-0007Az-El for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D964C60A90
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC381F00A3A;
 Wed,  5 Aug 2026 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964892;
 bh=DiqmMNgl+BWvw+VbCGNinDS1ca+U7+/tJt3PS4C8gII=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=oKc8Fb+cUIoXxS72W70nyN9jzGqDLKDatrgZBzmobLozwPwb1b8oa3EXNYgpet2p1
 i9q6j+S2mP2s12FcmO4vNSZCEFEFWmXnVTzYnCsEdnfO7gGbs+VjJ8dCW0UhGFHe/R
 G6YiWVB/Jt3IRy3+RSWfGxzJpggLIlEA3hztngrZOh9TsHm0JcdaqoUbrYmUoE2a/z
 eIgBXFCV8Vex6uUqWIgQjSP6anygrDoBaQ0th8oWojziYjxcjmSfeGGRWGZSUL1VhF
 b4xtDZt1tDmcTuUptbJFGJjoRavjYEEI2iUbZw9DqLBUObqKmZEP43JQOiamF9uOFK
 d5OTlYXMbPAGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93920392FFD1; Wed,  5 Aug 2026 21:20:53 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485213.530543.10143463929977159330.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:52 +0000
References: <20260805122008.664576-1-chao@kernel.org>
In-Reply-To: <20260805122008.664576-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wrj3S-0007Az-El
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return -EFSCORRUPTED in
 f2fs_get_node_info() correctly
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Aug 2026 12:20:08 +0000 you wrote:
> Otherwise, it will cache wrong nat info in cache.
> 
> Cc: stable@kernel.org
> Fixes: 3cb396a2c790 ("f2fs: fix to do sanity check on nat entry of quota inode")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to return -EFSCORRUPTED in f2fs_get_node_info() correctly
    https://git.kernel.org/jaegeuk/f2fs/c/026d7aeadf27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
