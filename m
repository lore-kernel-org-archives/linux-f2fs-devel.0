Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC3CCD185
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RGp+SCPO74+Wni1i+kuSiVh+N/VsKtRwjW7XvAYiykg=; b=Bkbqp/4sCyzgiDg6fmAtcAnPt5
	jEhv7HLqxlqgGPhqBtsN0iqnuI8mqvlq01DRZ9GKqB14LukBMhpi+hvbP6M9fTM3kOAGNZ8sC3x+f
	wDtEuUWVZGNOlklJ3z3gOa39V0OQx71vf/nCgDtXdTgezCcjwNB+kDgV8u8iaX4RR688=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v7FhJ-0006lO-8Y;
	Fri, 10 Oct 2025 16:10:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v7FhH-0006lH-Hu
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Oct 2025 16:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GvVEkakoPyCwe7oZxoEA4L4DBoAzjdAun+GwB8J9Ft0=; b=X6m5qJ2gK+LaEQuu9z5AX2sKbD
 LDGqiZ/Mc8LSDY/vQU4OWhJjhSdhIdZ7iiLGA+1w3iXy9ilTFm1kA8tmIbjBm2meKMudqNhgcNmqw
 C2NMUJgNEzHkwiU/mqUnRzoNySCTAn+eN4kLZAuBa+KGg861KbhXJEtJAoxKwuE9K6rQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GvVEkakoPyCwe7oZxoEA4L4DBoAzjdAun+GwB8J9Ft0=; b=hv5lWWSTVyKwoerY8w4Jf1UviF
 WMBMBTSHiG+B43vzkqQxeTTKcVAA+wpNqSGvSPYC8n6PrSJ9Qee9bdEoh4JmSimLvDz5keBA3GS+0
 nWssuPW+5GU+BfS1NnMVrwRPfwAHr6stKXaDWrLsdr2oBDpoMSpdD7G8LhMmrYlF05d0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v7FhH-0002HN-3t for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Oct 2025 16:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D0E7F4022A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Oct 2025 16:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA74C4CEF1;
 Fri, 10 Oct 2025 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760112617;
 bh=BYrNZj2WgdfO2F/sOzJIX3fMIOh78MZdybtGGqt65CM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=T3s53mzEmtixItjKB55IAS1viBVIlSNF7jtmzmn8+VmpxGgfvr1TmyK9TSjmo4XEG
 K8k1cBoYZB6D1J9w8zpVu2yrxonyiUzJ+bIgqKaF+gvqpzVTC7ofZSJwHL0Hu6lFhs
 u9KieecYaXl2DjEUoCMMPeBAuMZd5dewlBuxbFFf26Y+YwMgXbN/0i5UJFeO5ybGXJ
 gEH17QX/AdtiPNB3zb7UHCuu0MloPQfVEpm6Vc0OlYx99ykAYbn3Bjuvjvy2JozyAq
 ScsAo9Dc/Tf5sW0u98E0kSLl+37qJxyjey8lrSUi6PaDA7owMrQTM2FI+dYLuQeg+n
 ZAZpi7oNgXCxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70CD93809A00; Fri, 10 Oct 2025 16:10:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176011260525.1033062.2407373127040917969.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 16:10:05 +0000
References: <20251007035343.806273-1-jaegeuk@kernel.org>
In-Reply-To: <20251007035343.806273-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1v7FhH-0002HN-3t
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong block mapping for
 multi-devices
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 Oct 2025 03:53:43 +0000 you wrote:
> Assuming the disk layout as below,
> 
> disk0: 0            --- 0x00035abfff
> disk1: 0x00035ac000 --- 0x00037abfff
> disk2: 0x00037ac000 --- 0x00037ebfff
> 
> and we want to read data from offset=13568 having len=128 across the block
> devices, we can illustrate the block addresses like below.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix wrong block mapping for multi-devices
    https://git.kernel.org/jaegeuk/f2fs/c/7d9fdb3c9e5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
