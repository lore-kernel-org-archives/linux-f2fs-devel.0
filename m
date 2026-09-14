Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B3C88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G6Lm4i3+9O9e6KRmRGqc+X83q4mCCo/z5FPNvxBaOW0=; b=hH7Lx0Gxcc6Iv1Dm/bGOb/DFFE
	51R3fnk1XYMI85DkCsWHDaR4TCmx9h+jZtD0q74mF0mnqyeNuDpIapbECHU+dUseCrIykH6IuIp21
	c9lgxFSFSaIB8GcSLK/bnmRu9PD7rEYa8xAMe3eRFNWZpVnARi3teNXM3sZrzqCwRibQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eP-0008P3-Vz;
	Mon, 14 Sep 2026 15:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eN-0008Ow-TD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpY76s3GnvgYwaOhvoeara9xLcQyChW2rfV0iG9R79s=; b=FUfq/32JH6Pz2PTvn8iSQZJH4x
 mRoII3KmAH1CjQIyR9MA5r2ko2zbe8Lux45Jgf970i78UIr6natfnOaXJ9FhmrsgKPERjFk7HgdmE
 i+9wKRb5hKksWKQAzBhAuzKfgsHIemrXh7pab7AtmHp5T0y4xTSFBGmbxOGB4jzMfNww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpY76s3GnvgYwaOhvoeara9xLcQyChW2rfV0iG9R79s=; b=H8XgO0fCJPYDsUuKfOQOjeyjLC
 hY30adbqDHrVxvu7pSHwAiQNw8UZNZu4TGXbp/pSu+becQFBX/vWFmO9m2QXgFK7HJ3JMDWnCL7jG
 YWsUU9rCgFac0NL3oOa1BeG9GsNaJaivKZWc+7KJFB1dzg5Uub5O/LKh2BoZzNTEXiIw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eM-0000HW-B0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14170408EA;
 Mon, 14 Sep 2026 15:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99951F000FF;
 Mon, 14 Sep 2026 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399873;
 bh=HpY76s3GnvgYwaOhvoeara9xLcQyChW2rfV0iG9R79s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=WeX8xs9gBfGaaTuMrrISuW8ri4bHEZHRM7gyZyJSKwacYUn6fzMakRQ1lfmK/vRgD
 Ivk+aNbHeaa8lpnC18Q2uKCn2CmT8ebd3u/yLxXXyfYGlrolYlmhoQ74/ENrvVjq7X
 YAns5CutTvpYE0WQ/a60iaN4yJ7GD8r3uXVq76kYEWWFUsnNPrpYnwVowtAXs1bRz/
 y6lyTy0nWuX3g5KKLtfKD9AYQNPDIXPPenIBtDU1zQhKvN/iPIONM5Om8y3LTifSje
 jOR2Q6iRzJln9wzEfFw5Kx/EfM87q4/fz/+2Rs6zPrxTl0gQZgIl5jssfC3FMU5MfC
 ek86ng5fJ0n5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56A843924A79; Mon, 14 Sep 2026 15:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939980787.647967.18277345902202465744.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:07 +0000
References: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
In-Reply-To: <20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Headers-End: 1x68eM-0000HW-B0
Subject: Re: [f2fs-dev] [PATCH] f2fs: force out-place update for all writes
 on compressed file
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
Cc: devnull+jiucheng.xu.amlogic.com@kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, tao.zeng@amlogic.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 07 Sep 2026 19:35:42 +0800 you wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> For compressed file, compressed write may fail and fall back to raw
> write.
> 
> -Thread A                                         - Thread B
>   - f2fs_write_multi_pages                          - f2fs_down_write(&sbi->cp_rwsem);
>    - f2fs_write_compressed_pages                    - ...
>     - f2fs_trylock_op                               - ...
>      - f2fs_down_read_trylock(&sbi->cp_rwsem);      - ...
>    - f2fs_write_raw_pages                           - ...
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: force out-place update for all writes on compressed file
    https://git.kernel.org/jaegeuk/f2fs/c/a64a3fec11e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
