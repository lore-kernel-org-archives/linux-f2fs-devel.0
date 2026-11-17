Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D16606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=URHSz0mE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IkCGn+/x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J4rRsw/x;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Szr7rKyT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=91oiQYUdxbdihgL/kcMnONtdbbQ2WVCx+Z+QJTkBRNs=; b=URHSz0mEGVYhmI
	HEZQrQehiNgqVcRCbRypAHpB9noLVF+SB3skQMFEneaaLxRw5IqMZ9TSuV49qwn6X9fUr4luzLHEl
	1nEG5+rpTxeErxrgK3oflu+ALyQiO0UXMUY+xt9GgTzCvMXyxqM6ZZgtsoYBJ32Gw9iuI43YK6frh
	3pk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTMNx-000000005LG-1dJr;
	Tue, 17 Nov 2026 16:50:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xTMNw-000000005L8-08DC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mYmFqNItA657S80cwv0+5oWCVc/8rWIHSqTpW1wpY4g=; b=IkCGn+/xqRuDi5u0V742y46RtL
 e/eWusEPDkbBe0JDrDT/moFUHUfyiQuUqVLciDti7SQZ7yysRAwkLUVzVoqHrk9WGz/ER3Xn2NV+L
 WFm7zmG+jJqI8OqWlJBxXeyI9JeLAORDA9g+atyciq9CSfr3tZIWen2V5SNrEImlnOLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mYmFqNItA657S80cwv0+5oWCVc/8rWIHSqTpW1wpY4g=; b=J4rRsw/xee/MbJzL5eMbD8AKzF
 KJMoULw2eyaDCQTmQpztEvFPPLggKgGeIO3Lwi/SXAGJ1cy04/apV8REhGW7iNUkL3MOE0LpeCVqA
 MFumoN9RLNm8oEcrJ3pXKqVue/ksPAecA9YpKYtphyBIOoZgf7DPAbkQV6nNbfAAixfU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTMNu-000000003W1-2b5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 128936194B;
 Tue, 17 Nov 2026 16:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7031F000C6;
 Tue, 17 Nov 2026 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794934212;
 bh=mYmFqNItA657S80cwv0+5oWCVc/8rWIHSqTpW1wpY4g=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Szr7rKyTESR1Z2xk0sYhcungVL2UV91/bOQbAuOydLUayVg7/IUG5FxuzS+F9b1ED
 YozZ+ApBIV/XRhG2ZIpDwcEy0YbsdmDP3vCZltLBAd/oaobdukxVKqeL9XSWs7Wott
 8TLRH4ynRI4zYF3XziS1p0MabCqDQDqwO33q1n5Ghqc6Lw0Vvtycu+qv29vqZK7o+X
 KeG/VPSMXElyp8g85yzNCmGTv7gCkwaDoETG9thM1Z1a3DxmV0z9ndGCloT9yfpCuQ
 4kJo3TQ2OIWcLQ1zTkjeIaieSfYDNq+Ag8PoG6oYNLmpSIsHHz3dwWjjYeXoLbZQfB
 HCZaIol380gLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B462D392706F; Tue, 17 Nov 2026 16:50:12 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179493421127.698822.8936869244996483473.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 16:50:11 +0000
References: <20261105034419.2701443-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20261105034419.2701443-1-zhanxusheng1024@gmail.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTMNu-000000003W1-2b5w
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't BUG_ON a missing orphan inode at
 mount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, yangguikun19@qq.com,
 jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  5 Nov 2026 11:44:19 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> recover_orphan_inode() treats -ENOENT from f2fs_iget() as a kernel
> bug, but the ino comes from the on-disk orphan block. An image whose
> orphan entry names an inode without a NAT entry hits the BUG_ON at
> mount with CONFIG_F2FS_CHECK_FS, or a WARN and a failed mount
> without it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't BUG_ON a missing orphan inode at mount
    https://git.kernel.org/jaegeuk/f2fs/c/b61a029304bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
