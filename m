Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C00CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4AtTZqpkXSUvwBhg8sO1cQEsI3Ewp0qMulSxlVEnlY=; b=DG52CWM60HweC9xI6STs7+T+AG
	NGTdDYNAMOWvC8ahpPZZu86N4TTjF/3sElwzmL3DXEi1OiVnKkX7hEmAmrxDnps0TdGLEpyCpvqR3
	kfsTOyfMqjn3U26adXFH+MNGE+OTDlNPhoYQhf+JNuzg9Tn8R+mbGlSl3g08PnPsXy5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9Gg-0008JY-Je;
	Mon, 15 Jun 2026 15:30:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZ9Ge-0008JG-0P
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EifHw/YLYpw/Dcq7IYZh74Hc6w9ERqR9grR0ilAhAIw=; b=kKuHDRTeSFEDnv+g1nawcqYy1+
 nPZ5s8Lbk0nc9KoirDrK101j5E+4vqFawFHTSQLvDHnP2gkU3ZkT+zt6FiRmO5VpS7/T2sCkZiiPr
 wFiuJDoe7k81xoqIqNh7jTUC6qUvy5D2WXJecfkd1w+x3CPFlGqXJiHbl5YUNdA2Yd4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EifHw/YLYpw/Dcq7IYZh74Hc6w9ERqR9grR0ilAhAIw=; b=h6qf4N48cw/LdhwdpMBuSuAhDF
 EBbu9JGJjdqnoH1Uf7uRj/798hN1hMm63k55BLl2Di3w1SJQmqG+Id9qTpkqatlALOKV+grSqx90E
 tKYF1bmp6p6aRcFrM8UbKmMgVAabBTRAOZic/mkV6S4Ryr8bvC5acHnA35azqSz5rmfc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9Gb-0002vl-9x for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D467601F0;
 Mon, 15 Jun 2026 15:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D991F000E9;
 Mon, 15 Jun 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537414;
 bh=EifHw/YLYpw/Dcq7IYZh74Hc6w9ERqR9grR0ilAhAIw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=okjY35wncxyjrGteL7z39HyGj2rOZ24bB2jW9cGIPrqaGpFRgrPiRak/+BOrPcZuk
 jIYzooNVTJVMxozteEKnAVLWV3pLcNjAL5v55XE2+EHm6f6XMFSR1X1ZihTsxH0087
 B/nBWZMoy1vPApLczZ3emUOvOZM4e9clpbIP4PhvF926cGZHZ0s8vzRYJMaPyCH/B1
 YGoyZIMD07Oem5EKWRo1tlz4xh4NqWK0/oP9R75jLAG5uAIkIXwy2YAOY7tJPA8hrQ
 IO0xzY11Ylsx7kl9+146OhALXujP/Fnv4U7k6mLB60JFJkzYyFMxAOLjlDqfn6yg9Q
 vWpZi0JQfPTNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 567873811A64; Mon, 15 Jun 2026 15:30:11 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178153740988.3946007.10376202781077694557.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:30:09 +0000
References: <20260527120628.2255597-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260527120628.2255597-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wZ9Gb-0002vl-9x
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep atomic write retry from zeroing
 original data
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 27 May 2026 20:06:28 +0800 you wrote:
> A partial atomic write reserves a block in the COW inode before reading the
> original data page for the untouched bytes in that page.
> 
> If that read fails, write_begin returns an error but leaves the COW inode
> entry as NEW_ADDR. A retry of the same partial write then finds the COW
> entry, treats it as existing COW data, and f2fs_write_begin() zeroes the
> whole folio because blkaddr is NEW_ADDR.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: keep atomic write retry from zeroing original data
    https://git.kernel.org/jaegeuk/f2fs/c/b5d5ab1ebe69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
