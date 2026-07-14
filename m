Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74C8C44508
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLe1UZ7aIkNIzmENWOBGF+RPxMoO8I6q88ktEJPrGn4=; b=NKHpZ4bsrSgMsCCrcs9qvfaHWT
	iV++KzdaXvmXnt3YR7MT6Bpl0p84p5inArdEEjbGfu7gvvh6W0iTY6wv/KQFQSadGLiZu46LABd22
	E4elaUsyVcnfeLb2wBJQ1vpIKIKInltLWzwCtWfGvXHslBvaIyNiv+IJUcXROGow+hw4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjTOA-0002e9-1M;
	Tue, 14 Jul 2026 03:00:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wjTO6-0002dt-2Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6XrlarryAV3hoytyni/VR2qLMtepQivN9954O6QWRr4=; b=gSGFFtBStQDezs0qiYfTpzASE4
 Z/1DGRn5XJztGjkBtefiC4Gt5hXeNuRLaLOFi2q/HSoRT7dRyYBnA0I8ZYA3vE6Y1upV9TjiMZiXh
 tEHR0ASh8Bblnxpj0862JQ8S5gdxRhrR2y6X2W/+KJCzte+PdNDm/SkhSUUx4uuT6dlM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6XrlarryAV3hoytyni/VR2qLMtepQivN9954O6QWRr4=; b=GJGqTrOp3Ai5s3l1UZmsX2z5tb
 JD4fNobcumvNAq/DcunpUBsqnFeFQEf9KEZ3mJT5/HDJpWqCP0lWzV7jGD81RdkS2Dgs1ku4JEftu
 j0fvzTSSAh2x/LHkyAV6i3P1M255cU6IM6g6R0tLI04HFQFE6+t9pN3ZwwLVdSOdj95c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjTO2-0000km-0u for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7DA143A07
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC031F000E9;
 Tue, 14 Jul 2026 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783998035;
 bh=6XrlarryAV3hoytyni/VR2qLMtepQivN9954O6QWRr4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=KWGCKTWTYgFsScRuBSY63iS5bNuI8oPxNiYDFBcVlH3Xp+TfRfTW3/az05U3HW1qu
 TII0w6QrpB5EXCXdAXvYAtoMAX/n+uwhFnGsExNMyvY4hiSZCYYsFeklfWMnuxUXKQ
 Ge/PEyP1Cbt60Q2meekY0u6IC518IVi7MTrgWku/9/KAOfiiXrSnB4cLY+ZnE8agqI
 Kf2AH/2YsPf+B816H6AwlD4Xci9JGxT1cE/bUxLqc6GWj2PvoSZnqWBURV6gVD7o3i
 GQkDWraJ8JbqntNB1h90gHZMK0PdNvdtK8ZICi5jzzGkZ5mFmXH5Is7OpVg7wwfHJg
 Y1rXlOaVsLztw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D09F83924FB7; Tue, 14 Jul 2026 03:00:11 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178399801038.2939750.8235712118479697157.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jul 2026 03:00:10 +0000
References: <20260706123321.4015678-1-chao@kernel.org>
In-Reply-To: <20260706123321.4015678-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wjTO2-0000km-0u
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: embed f2fs_gc_kthread in
 f2fs_sb_info
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

On Mon,  6 Jul 2026 12:33:21 +0000 you wrote:
> Instead of allocating f2fs_gc_kthread dynamically, embed it in
> f2fs_sb_info. This simplifies lifetime management and prepares for
> fixing race conditions during teardown.
> 
> - __sbi_store			- remount|shutdown
> 				 - f2fs_stop_gc_thread
>  - access sbi->gc_thread
> 				  - sbi->gc_thread = NULL
>  - access sbi->gc_thread->f2fs_gc_task
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: embed f2fs_gc_kthread in f2fs_sb_info
    https://git.kernel.org/jaegeuk/f2fs/c/1ab1345217aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
