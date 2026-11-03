Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02758606A333
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PmxFfd9/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DpefpRKl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k8wRJKnv;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N90XzO9S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=j1QiliG5KbXZ3VQ/CoSsOsU8aHSCzOQq2ld4XXBPGXA=; b=PmxFfd9/y5qndH
	07aBIoudBu78werfr1heNqi3BvZ64csrZ0cBkhcawJqRHna3PJDLfnR1OQBRnne3tHkCT1uAoPMth
	PeRqi9MiRczNR+y/79nJBewtoK2EA0xgLK63skYib0hF40Vjllti2LrUMo6RcIvIiTRY2BXYziOOX
	rcE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO2jE-000000005L6-35Im;
	Tue, 03 Nov 2026 00:50:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xO2jC-000000005Ky-1Ilf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i9RuHFNBZMENyOkDRUHN5XsZLW09wcf03LGDxLT8lCY=; b=DpefpRKlxdWYnUZ1zTeiaWEA/w
 zSH9rrpwwFbgS2u3x4SNLZvbx6wdopzvFQjmiJDOnu2tAds6jw5qNk1e4yQUa5NftfgFSyOV0T8pG
 IyOWclGiPwbCZjiWcl+3TMoC6GqA7gvySjFNo/yJCac8H18IPZ0cOlKfxx23vMpSRDiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i9RuHFNBZMENyOkDRUHN5XsZLW09wcf03LGDxLT8lCY=; b=k8wRJKnvP63bAUYeGpYXxbdBnJ
 eOo1WCy6g+Qsb9AneOPBDunp3HIn30ZnC8vnXTsJOl8t60jdosybuLWfRbPe0owxBmheiqLO7/Mlp
 7rdWaWAkYM6MCt3+of9Y5pwuhU+UYRfb5Z5MxFK0nO0qW34oJ5msNJKUndJJY2xY3nJc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO2jA-000000001p4-3qV5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 549B46021A;
 Tue,  3 Nov 2026 00:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF021F000C1;
 Tue,  3 Nov 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667011;
 bh=i9RuHFNBZMENyOkDRUHN5XsZLW09wcf03LGDxLT8lCY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=N90XzO9Sb3Vnytfpu5xDABVi0dNPWLg+vaCUdWuaaPrlqEImuWcsip4rCFLqANy4z
 XORE7+1/KldyXZDr1DSwZgxESWBdNFvcam4UEfspOoTytDvtc7gyMk2chLKJWIXIlP
 hc4hZaagyJ5WJbmsw9DRqDYWsgoI/fAuNvTjTYZoLLHetoaqGvvnkV1XnYv2a1UbZP
 YBHVySerbuA+znoXCk11CeMAh0Jx056BUpu6cl6rtwpm71QmaWVv/xxpfkhbSp+o28
 Sh8a2g9/sFnwKCJkEKi96ZNeYi2eJI/FiIX/9rhDA1OXavsK5PeP09tmqYIE+RJUEE
 K+X888CpFjTYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 030E9380821F; Tue,  3 Nov 2026 00:50:11 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179366700954.755181.16767852529542286905.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 00:50:09 +0000
References: <20261031233935.9600-1-dennylin0707@gmail.com>
In-Reply-To: <20261031233935.9600-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO2jA-000000001p4-3qV5
Subject: Re: [f2fs-dev] [PATCH] f2fs: preserve 64-bit FITRIM minimum lengths
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
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

On Sat, 31 Oct 2026 23:39:35 +0000 you wrote:
> The FITRIM minimum length is a 64-bit byte count. f2fs_ioc_fitrim()
> narrows it to unsigned int while applying the device granularity, so a
> minimum of 4 GiB becomes the device granularity. fstrim can consequently
> discard free extents smaller than the requested minimum.
> 
> Use u64 when applying the device granularity. The checkpoint's
> trim_minlen already retains the 64-bit block count; also widen the
> discard policy field and its initializer argument so larger minimums
> are not truncated when passed to the issue and wait paths.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: preserve 64-bit FITRIM minimum lengths
    https://git.kernel.org/jaegeuk/f2fs/c/471dd2221735

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
