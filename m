Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B254CD98E5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyQljyR5Eo9aW49mx5s7Fgwu54ffU2Sq1I9ly0u2iLw=; b=YUmy4U4YHucHyhD5bQmgNgDuOZ
	up+W57OABZPfJ5/mo5Qh2OPwl3PGM8EvCDrZo01vJQhajdvBYBNyDeyQXGAbMmJYeH0Uwntlm4oAz
	vjshLXBUBRYOWbO3dTbQdipdAdz9CIJefmn5FHfL04GD8SaAkMfy1m0DrNNmqcGM+1sM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZJsx-0007T1-K9;
	Tue, 16 Jun 2026 02:50:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZJsb-0007SX-FQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CNNe1T2Rrrn24P9kGz8Kt9VA8EiwOwuhQ6dN+SFK1gE=; b=c7RWzwxSaIFA4mEDDE2e3DFkWv
 VsRhRuW5ib3eFs77OLTRmuZC4W/SZvrPDDYGAYohZYeVp3kSPM7HKK4HTi67byzIcVT4Hpfs9DVc8
 UkMlFD5vgFDnoBd37952S6PgiwBQOdQqrJtzgIdhBHNsyN10VUXuS9lv2WaaLpWjFkes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CNNe1T2Rrrn24P9kGz8Kt9VA8EiwOwuhQ6dN+SFK1gE=; b=Y2SGFnOCGsz7QtPvejspcEgvMU
 WZZr/85WCbuQZsfe6XN66WQQmj04G4vzrMgbzklUqf1N6as4S+vMmpBGCdGlOcxu+xN5EDJDzh/eF
 jZtdLbQcUDWGD6Ih7KWC0Wd4lB6Aixh5h8Ec1rBZg1Ow779/+DhbFp/VPCxnn6bKk6Rk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZJsX-0008Oc-Sc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13E2F4044E;
 Tue, 16 Jun 2026 02:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEE81F000E9;
 Tue, 16 Jun 2026 02:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781578213;
 bh=CNNe1T2Rrrn24P9kGz8Kt9VA8EiwOwuhQ6dN+SFK1gE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=chquJTHvFPW3RbgnctnCDJ814DeEzwDbHoVeb05fock4jA17rvI+3w3b0SkunZOAp
 VFypFA61K4cAkMq/Wyc8fT1vR/cXIdC3Wbuv2KR23Tqe1EJnIihkxKn3MMw8vb3eXJ
 8EjuHHhWkGbpFD9QpTvYpH+WrtQYZ31IrvUrbxncer51EKeh9ha1eeDGo2yQJsLbNd
 KxyLYrgmOXfDtJP1W3DvnKRXCPsRNJovtOas7XPgj+uGroSjcuxBF4DHB4p2cLhHX1
 fYdF1hgdWtBDc7LNzBOoScEss4b/zz+nSVqf9QiZMTcJk587febLFzUCcjCWnGKIiI
 UJHWWar0nj2OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1992A3839A26; Tue, 16 Jun 2026 02:50:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178157820763.407856.9024495873605797681.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:50:07 +0000
References: <cover.1781119949.git.bvanassche@acm.org>
In-Reply-To: <cover.1781119949.git.bvanassche@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Headers-End: 1wZJsX-0008Oc-Sc
Subject: Re: [f2fs-dev] [PATCH v2 0/4] Reduce the time spent in interrupt
 context
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Jun 2026 12:34:16 -0700 you wrote:
> Hi Jaegeuk,
> 
> This patch series reduces the amount of time spent in interrupt context for
> completing write bios. Please consider this patch series for the next merge
> window.
> 
> Thanks,
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/4] f2fs: Prepare for supporting delayed bio completion
    https://git.kernel.org/jaegeuk/f2fs/c/130a2e41b08d
  - [f2fs-dev,v2,2/4] f2fs: Rename f2fs_post_read_wq into f2fs_wq
    https://git.kernel.org/jaegeuk/f2fs/c/41e63c48ab9f
  - [f2fs-dev,v2,3/4] f2fs: Split f2fs_write_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/09b06dc6a7d5
  - [f2fs-dev,v2,4/4] f2fs: Run f2fs_write_end_io() asynchronously
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
