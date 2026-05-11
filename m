Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F99ACD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwNQa4r8QVuI8jIh43l6seYpMN9cMLjzAlbTKc2GwUw=; b=S94gKVqn9B6C2wSckb0GTmClmq
	SZzLliTvw+91TNL1+bPjK0hhwdnRtlvdIroIRd2YuCacF+W4EayoSCEYPjycMmPRbzH3rsrsMOuSi
	dfeihPmjgl5a46fqbNQAgoII9gPZLC13iN7AcLwUbtiaTEUo3ymm79KWFuUQZI9q/6o4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFey-0007db-36;
	Mon, 11 May 2026 01:42:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFew-0007dP-My
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XceJd7t51sFiVBjcaLRuIItPtImpbhV0ssBquxFiOrM=; b=gMK0qalBJYOLCln69TeL56Hd1Y
 EDwiqXMQd7PsI+NE9uIDFIPCxTc0YLTPMYE1dG+ebkRVE6oB7ObHAzVhwl+3hRaTVGJfHWVmRPQA6
 kqLPe7cQBhuvrfYK/z89BK4/yx5VtwmufmoG9j0r9CPXxuKi8ruIsSCAHCWSsW6QX1ns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XceJd7t51sFiVBjcaLRuIItPtImpbhV0ssBquxFiOrM=; b=DdWUxPK5vkEV52FL88fM4gIbuo
 dX2aSEjUe40pAQvS7eRqkLPfa9UXCfQh5yx54rbDasRpvbuovGlglsnHV4Ff++vwJVslAcJoH2tQH
 T4uYRs03rWxKkKqHlG3w1btu+2BDDCgM/fbFqpifbw3T+nLuYOvt+6QXZVyfdJmfRRNw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFew-0007BZ-UN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D9C660141;
 Mon, 11 May 2026 01:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E070FC2BCF6;
 Mon, 11 May 2026 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463723;
 bh=664IJjAnAygTswmMXcF4pR+ZLCEzxvR7rupLK9cmhDc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=eSOqaTlCgVRKrAN3+Rh4c/kO+h9bEdRH9q6nZZbzMilQwr11cf2fsetVGQ9MTb86d
 5F96/Njjr0v58HvCY3RVHeYfE13tKGa/HY03rwl+TGr+UhB622vTe26lLdeurtJEIP
 So+slAx8KtmQ0IQX1LccFv7iZt9iHJlF2S8g7cfZM+6vtMwdxK8LFQK0TpQaFiTWzx
 v90uPaZv8S777qMWPq2BeiJX0nUQED7sPS8JeVPU0bfNGuRyTGRWkvSaFqT90IrvXH
 XUxC/nG3f7wAomFdr9h8iNKgqPFJ5xBORlDt3uLSVNfQnmL2AY9zG4prHw1JVKwn3l
 fk7x5BWNk+hWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FD373930039; Mon, 11 May 2026 01:41:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846367082.1975880.2219593075807380790.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:10 +0000
References: <20260506010709.3287111-1-zzzccc427@gmail.com>
In-Reply-To: <20260506010709.3287111-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
X-Headers-End: 1wMFew-0007BZ-UN
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate lockless last_time[] accesses
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
Cc: baijiaju1990@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  6 May 2026 09:07:09 +0800 you wrote:
> f2fs stores mount-wide activity timestamps in sbi->last_time[] and
> samples them from background discard, GC, and balance paths without a
> dedicated lock. The timestamps are used as best-effort heuristics to
> decide whether background work should run now or sleep a bit longer.
> 
> The current helpers use plain loads and stores, so KCSAN can report races
> between frequent foreground updates and background readers. Exact
> freshness is not required here, but the intentional lockless accesses
> should be marked explicitly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: annotate lockless last_time[] accesses
    https://git.kernel.org/jaegeuk/f2fs/c/c4bbbc96e530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
