Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B8F531CE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dyyvv4b1qJKYy5XzsDbkrp/7tpJd3Wdv/8x88wd8uio=; b=i2pJYNmUAWBhK7ZUm4WKUkJqBb
	7kZAoztKwBvSD87OmZwoMSP9Nxce0aTengKCMQMr+Pe1t9Buzm0ZuNwuiRh7MMfbTHj0xO8JgJAes
	MTur1Bc8OwJr/Or7wCT8pX7CpKloJo5skbeLtHT1Rj3+rcgM3pV4VkvfuzQq79t+Bp0E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCQGv-0002Ur-EY;
	Mon, 13 Apr 2026 23:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wCQGu-0002Uk-Oo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 23:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yt4jZmviV1ngt/qtZaIFrWKX8c+pEc6RMx6exH4wWhQ=; b=GydH376MJwtDHyfDqMPw6qMY3S
 iRidtykU2EvylQfPQljKwPaO2XuPCuhRw0Col+z7l4QOTKmz4+kl+22+op1NEBqrpfZyQt+P23xTe
 IZekHpLj/S3xLCBp527+tA4zDOjedTPAi4uvjG0R6207BCr1UxN3EW2+Xhnn/3/wLIlA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yt4jZmviV1ngt/qtZaIFrWKX8c+pEc6RMx6exH4wWhQ=; b=SP+d6B8gfGnaOyYA5etByRwrob
 u3sHsMQxE1priS7m/XTfDY1V8UUjAc+vUPNZa58xk+zHWM1yJzXgx+oklSBGmE/C/NHvmC2WCc46e
 Zq30Dh8jyv9rQlPYHDljNfDLyw+ziEd9yQMKISFOmIpr4hCgvtypsHcMwJ9HVKsrg6N8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCQGu-0005sj-8j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 23:00:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C8206183C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 23:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D4EC2BCAF;
 Mon, 13 Apr 2026 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776121237;
 bh=4DZ3xVzeB2Bxp5R2LjduVfukq5RQnVrcHdkAOQk9L+Y=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UZPrAXr0XtWvO3QvhL59g4vePHsrCc7to5cz8aA0s3GqngDFd6YSDwxQdRqi4O2vm
 285hPMBpv5rab+3tUaTVQU3fX/6ZkP5gik/CCFZfZIN3jExbejMG2ht7Kc+wuj/BVy
 I2zn6EW3vChHTbSVTw0iTFfpDLByYevW9qd/5V2pYtsNM/hLAjBOQs3xUMDakYhM/l
 Vp/n88jVD2rJ8NtKBQTcbrpC6B5cCpLUmB3oc9kRtMIofWbyUPFieStFCGLNW9lplW
 XfksVXA8azELvtpogfGckjGW0H+bRni/+GtvZkSQJ9bShrhtlZdNkmI8JdjrxruQvu
 8tuBogrtGrUqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9DB23809A0B; Mon, 13 Apr 2026 23:00:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177612120854.590374.5989618887426099253.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:00:08 +0000
References: <20260331174326.231867-1-jaegeuk@kernel.org>
In-Reply-To: <20260331174326.231867-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wCQGu-0005sj-8j
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow empty mount string for
 Opt_usr|grp|projjquota
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 31 Mar 2026 17:43:26 +0000 you wrote:
> The fsparam_string_empty() gives an error when mounting without string, since
> its type is set to fsparam_flag in VFS. So, let's allow the flag as well.
> 
> This addresses xfstests/f2fs/015 and f2fs/021.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: allow empty mount string for Opt_usr|grp|projjquota
    https://git.kernel.org/jaegeuk/f2fs/c/2a3db1e02ce0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
