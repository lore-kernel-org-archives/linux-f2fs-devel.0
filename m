Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF7ECD37B7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3Cb/SnvkQH2NqKPMzgyMmAfSlzjI3xAIqbY7I+JELs=; b=k7N2SbciiyIVl0yoq0hRa6swVF
	qN81CuBCvI9icKVgHEVXul5A6EVPIc3K4PdxhC4yT5GAmrlFr3UkqIyIMAl1pXBZON/jeEh1p41ya
	X7ddl3yWF2obypAGtGHxAE8sDB1tN96g009/Ch4eItif0kpp/uV6ULIJBJXx2vfpBPww=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFey-0006LI-Uh;
	Mon, 11 May 2026 01:42:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFex-0006LC-Po
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7LoJY/QwbEGaqG2PWl5lC4FauPaWLe8v/wvsEhSmnjw=; b=kQ4Vh8Z6ekvhmL46n117s6L8Kw
 Jp++xcOerS1wOB5qLHd/CWXhcodsvVQLnEuA0qIplUJEp8D7KPVgROHSYv5gdK41MsM+W+FsB2FVR
 K8NY1JjSij/87iutgNUeiyRJrBPFFH1hDi6tDvYZPh2DSy5C5Dhsbe4KRcev9j1hATFg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7LoJY/QwbEGaqG2PWl5lC4FauPaWLe8v/wvsEhSmnjw=; b=Oqm4DJaYuNGygGR6BMH9PSbP4M
 0JwpJ/dfOxBU61SsP2+7zG8wtqwfTpGX5fm2HNIowXYJ03Lu2IZoMQX3VEBXgiZc+wmtLJBWnFxPq
 1e6B5KA5k42LRxvBxrDw20nw5MFF9yWq+I0LJFDh/6HJJ+N7pSG9yNowU718WOSz8FtE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFeu-0007BT-Qq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C2B54445E;
 Mon, 11 May 2026 01:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFA7C2BCB8;
 Mon, 11 May 2026 01:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463722;
 bh=dEWMu3ZTX7n5r6KyC8BEC3tfcFnDX5cw7H1+Yq2uGZU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gOq4n+zi4mGjbjkxtKEo7xl99ruQGOEbVwVQWx/hxpqgHHSFeMCVWp0lpfYfeyJx1
 cFf9ZRiOeIZ1MUn9ysbYEvYCK56paCDaz/h0p7xM9oHB9iIevP+EXKg2EiP0P1sx0+
 fCgcuTJM+/U3LvLXLJKl+PfivOr0CirGPuYWxvSeQpHdLsjdQK9J5zoPUSrclw4OGS
 kDDP/1wB0WTB2dO93SOu+78R9Jvzm96LHzZBMa6xgYljvSVMDHUVjS57V5klgYxh1M
 fV/RADeeR7FKn6aPiVZFf0o5xEHAuZ8VeEsGuxyPQhaFHOQKS09jyq1ks/z3U0ucc4
 m5zHILauVk/SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9F7B3930039; Mon, 11 May 2026 01:41:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846366929.1975880.13898644322342059326.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:09 +0000
References: <20260505125510.1369132-1-zzzccc427@gmail.com>
In-Reply-To: <20260505125510.1369132-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
X-Headers-End: 1wMFeu-0007BT-Qq
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate lockless NAT counter reads
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

On Tue,  5 May 2026 20:55:10 +0800 you wrote:
> nat_cnt[] is updated while callers hold nat_tree_lock, but F2FS samples
> the counters locklessly in f2fs_available_free_memory(),
> excess_dirty_nats(), and excess_cached_nats(). Those helpers only steer
> cache reclaim and background sync heuristics; they do not control NAT
> entry lifetime or checkpoint correctness.
> 
> Document the intent with data_race(READ_ONCE()) and a short comment
> instead of adding locking to the balance path.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: annotate lockless NAT counter reads
    https://git.kernel.org/jaegeuk/f2fs/c/e2b659d3f6ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
