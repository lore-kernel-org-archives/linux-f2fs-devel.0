Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AEAC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AQ-0007Jf-Q2;
	Mon, 05 Aug 2024 23:31:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AO-0007JJ-GK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YQBNEE+kMs4JlG0RWa4lITIKM/v/QABO1y0fG/hhYxA=; b=Kfuz9CuVgFvLy8D+xnb9RVp3rn
 +oCjJ3wPPgz7QaMDMWIGc8GgsEmB31peUkCY8Iw5frQs5c9KKpJWD4QMC0eiXHXRlLosjregC+ImZ
 EuBd7f1xkliHPxa1VHrFCNRmRR31iDkFp9ri+r7Cjc2CZZdz4UBM10/aNOJLIl9H0/Fk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YQBNEE+kMs4JlG0RWa4lITIKM/v/QABO1y0fG/hhYxA=; b=AP5FXSPblNfathw2+NOrurv9Ub
 BMuShBFYVcaTtu1XPzUcD79zhpJ2lhVnKfgUKtmA/cpG7UU5ZpSubZNiiMYz0qWVZsFL7RCvmtqkT
 qNWUxvzX9fDNVjDIjYznE0uqmb74O5tfhfUelZ3tm07U4e0+7pd/qSsktK5yGpQoKERc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AN-0005Aa-St for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F2A6360EB9;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 322F0C4AF60;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=FlTtLuEqcMWLyx/LMaFM9OOqSTon0XUUkMGVwH+Q/lM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=YY8CiRt60T0or/xWTL0sQIBIKm5DiH/imjeVEOsEnwbFWZmRcoKUgKvFfpWobONZK
 hYg4XKc5AAFNy/1j4UBF57vusTKD1UV9RguZgazUKJUcp8EA8RTMqVz7gUabchV17B
 CPzzOdGjLQ0DxqJYXaoh8Kb6aKWV8xvaVEOErCfUbfNZu5wENBzLYiEEVTiBEH5/Tj
 9Z8Rsxwgto57kqc1kZeWTDJl7UwUJo5742GgnihrP3aaOZ+aNisKkHgIeWapZh7p4p
 gYHC5BSU7p6tXrtm8I4UN/LdhQ7nstMi1goR3lTyDU4+TUsIpD1lBTYjjIEk9AZbMC
 kcBgj+ZGoIsYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 29E3AC3274C; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065216.2803.2204816071029078570.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240614004841.103114-1-cwjhust@gmail.com>
In-Reply-To: <20240614004841.103114-1-cwjhust@gmail.com>
To: Wenjie Cheng <cwjhust@gmail.com>
X-Headers-End: 1sb7AN-0005Aa-St
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: use flush command instead of
 FUA for zoned device"
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
Cc: qwjhust@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 14 Jun 2024 00:48:41 +0000 you wrote:
> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
> 
> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
> command instead of FUA for zoned device") used additional flush
> command to keep write order.
> 
> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
> Introduce zone write plugging") has enabled the block layer to
> handle this order issue, there is no need to use flush command.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: use flush command instead of FUA for zoned device"
    https://git.kernel.org/jaegeuk/f2fs/c/2a331ab343ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
