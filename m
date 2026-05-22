Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C7CD5BB4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zC9HduxQRbPPJEegKy/FZQ4hQsDot6zNpNwNnUGyCOo=; b=D0+EnM+iGa+32X+M2Yg45ALpGW
	3Ka5ZHxCjBCn5N9XqvYTFlhNZVPj7eN4z7qHCZFgvK+6dV58itFnVtb459tTnsI3D8GCVzk50soKi
	qdvehWQLW963NfZObaAcNq97OhY3QWFjkeceoU7j1Y4W3u1BNZEF6S+GrWAIDhFHJqW0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQHWX-0001xe-V8;
	Fri, 22 May 2026 04:30:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wQHWT-0001xQ-Im
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j+TGV0iqSQSvajBpcgxp2Nx3Wiwwn7Ab+d0PQ2KCouw=; b=dE7XyTgZNHjfhUNg6fm6EtRHUq
 hPhpFthCgGxaJPTfa2CUjGqkwsFeEM0f/6NZb7PHpUHMqvUFjVHxhD5wJ2W8H20bOdeDMziF/qy4p
 mMfyLMcfyAhnAvJK68YWLk8ByIZFppaeByud8yWPTZ/XA7Ggh9Oeu0ksI2GDnx0TDgrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j+TGV0iqSQSvajBpcgxp2Nx3Wiwwn7Ab+d0PQ2KCouw=; b=Ch/sJXr0++B9gNDs0fKOP8joBL
 FJmLsRvtyVZxFSWsaKPMbBnHSPrSVufYVlvakOn9GL5WSu1sTr+R6UQBMgtiv1olbexx/PRcAzzm+
 xxU0RoLkGy0UYJE8T1P7lkSbwat8pRJWn4aYRNgJnUtm9qZ+64w319qOgd1XKVkSu5+A=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQHWS-0007Sn-8a for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:30:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79BCB400D7;
 Fri, 22 May 2026 04:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F61F00A3D;
 Fri, 22 May 2026 04:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779424198;
 bh=j+TGV0iqSQSvajBpcgxp2Nx3Wiwwn7Ab+d0PQ2KCouw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ofG2CeAtEGqnPfhvULNahxrnwUktLnjGbufa12B0XzFqZTs7akl1Jc/vc2yaOdBFX
 30kX1hcZlqRIavFf4CA/4ocvGcYmCVY/0xN9Snvk41/XCcMEe8SeHcoYeslx9EhysU
 Qq9hT977Kb+8pfVEEFbCFFOgFYPz2i++3D+6ByrRXnVMxX01OaRbhTFzoW+CUUXnAe
 91HAPp278YO2NwEMeATG+PukheDrQ5beNwdLmR+o362fnuLM9F1EQR2x4JSiFW3S0h
 sKGKmAEWlUo43G+0Dui9FNQ2w+NyUvH/QyW1hlZZC3zgT2OOTTKRhDRUgw9tHFdaTR
 6igCZ/H+VrqXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 197C63930E41; Fri, 22 May 2026 04:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177942420763.624124.8044747546709124239.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 04:30:07 +0000
References: <20260521103748.1954748-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260521103748.1954748-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wQHWS-0007Sn-8a
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid false shutdown fserror reports
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 21 May 2026 18:37:48 +0800 you wrote:
> F2FS records image errors and checkpoint-stop reasons through the same
> s_error_work worker.  The ordinary f2fs_handle_error() path only updates
> s_errors, but the worker still calls fserror_report_shutdown()
> unconditionally after committing the superblock.
> 
> As a result, a metadata corruption report can be followed by a synthetic
> FAN_FS_ERROR event with ESHUTDOWN and an invalid superblock file handle,
> even though no stop reason was recorded.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: avoid false shutdown fserror reports
    https://git.kernel.org/jaegeuk/f2fs/c/e10b499e702c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
