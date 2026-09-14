Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149EFC88E6E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MEP6vVRQ2oAQdt5z0PNJNtXpVCpw5ZAo7ObmbLC9Cqo=; b=MmuZhhjq+DaoEiPkBPTiQNUEtz
	oCHDQPQwso/Wjp0rKcedLFMJPeLh1GtMfc9Tr/tjRr6IEE6kgBGv0TJBlzFb1wKVkBcAsETqKaEAP
	po76E64zRhrBjzEaxxS5+noeNN73s91rd8PcgBQhO4N8S38JobjIsUcWgyvWiLp+Lcbo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eT-0004vp-AK;
	Mon, 14 Sep 2026 15:31:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eR-0004vh-EQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GRni4l4ymYbY7XYMoCKgvBmsHJcn3yOsNFwT+xszDes=; b=DtWw9GKec5A9dPsQKcOCb4og8E
 T6zKItnPo90vEApeKdkq5KQ8EmNW1DeDwGtTYW/vpcH0xrb33Z+lAz39aCba4MysAoNRw+IUFfFMI
 2lK4eGGdxShfAN37bt92zatrym5i7n+k8s/QfqNA8hlCPpb2gqRw/tmskftrGRaAizGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GRni4l4ymYbY7XYMoCKgvBmsHJcn3yOsNFwT+xszDes=; b=Oo0Lg6v5nUXcl/ti6r8L158klY
 vJbtfEWhKjDX3yXhIMvxVKm3v0QUpB/TfZmrt3AMPj+ozhjITR3DJnJQL/paCbks44utqyOweDaKW
 pSTedPktxIjeuaZKCptdwyyN+QPLHwa+kKm74XyV2hcD0biMmu/WLrTtHcfR9KOcu5jc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eO-0000HX-B0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B955260142;
 Mon, 14 Sep 2026 15:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F771F00893;
 Mon, 14 Sep 2026 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399874;
 bh=GRni4l4ymYbY7XYMoCKgvBmsHJcn3yOsNFwT+xszDes=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=TxCx4DEgFDzcucn1Lt04a2ETZcqd+9D8sNwR7HIksokdJcFqKFo/nUym/orNGwDrw
 6C1Jk7ZUCbTu/HC8Zj7shyaO27IVq5cHxb9sTZGv6HFCD/GQviRIkghLQkQkXaLGN3
 4jEcAu+pUStPQP0BXbFnFcvuxVaBivHQ014DdVg6/AcR+OVUsgXWGMHwPFtB0HR5sg
 aRz5b16dWYLa3WRhPG6jKGVpeZCMEzgd8U9E+Qk2YDNLbeou6KG4oSoMmRmyMowrr9
 hawJQfCncekX/NyGTjkUWQ0V+V6BVsm6/+dG44lz7Nrfj0BlV9WhujQYZ6+xWHhg6X
 MsrIvYCEZVl3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0BAB3924A79; Mon, 14 Sep 2026 15:30:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939980937.647967.15687709233091039790.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:09 +0000
References: <20260910030243.3005578-1-zhiguo.niu@unisoc.com>
In-Reply-To: <20260910030243.3005578-1-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1x68eO-0000HX-B0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to record both APPEND and UPDATE
 ino entries
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Sep 2026 11:02:43 +0800 you wrote:
> In f2fs_post_evict_inode(), record_bits is assigned with BIT(APPEND_INO)
> and BIT(UPDATE_INO) respectively, so the second assignment overwrites
> the first one: when both FI_APPEND_WRITE and FI_UPDATE_WRITE are set,
> only the UPDATE_INO entry is recorded.
> 
> The two flags are not mutually exclusive.Once the APPEND_INO entry is
> lost after the inode eviction, the shortcut in f2fs_do_sync_file() can
> take the flush_out path in the next fsync(), skipping f2fs_fsync_node_pages().
> As a result, the dnodes holding the newly allocated blocks are not
> fsync-marked, and after a sudden power loss, the data appended before the
> eviction is silently lost.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to record both APPEND and UPDATE ino entries
    https://git.kernel.org/jaegeuk/f2fs/c/06768d77ed95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
