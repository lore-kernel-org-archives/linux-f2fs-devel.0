Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD00FEC0EA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PV845mIZNLS2pv/nHW5S0nOG2oKy4Fh8JvkdopUKN2w=; b=dAW4JtvNv0aUZkGqXpxiGeOpzj
	0GPqPaAekZ4grKCj8x3iNddIGH2bpf69VU11k+Swml2ULcNysUAvlzYYbCpo5UoY2cWb9hiw8xYg3
	uoI4DS18PHccIV4eMq4j4ceyt7ooJvoKLXzRKiGvelXIoSOtnSwKZ5eZKhqQNe/mWzSg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w55cP-0003lO-US;
	Tue, 24 Mar 2026 17:32:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1w55cO-0003l8-SS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MMLDkHM2YvI3hRTBQViY42aAIPIfEPW0isN1hvwaZWQ=; b=W0YMCuTDYm92LM/riBOjNdfFPM
 xKGfMgqbY2Pszb0OHasfih6Nu19vpJa8XlCWy4orL+cbgdx274IhNtPyBNMjJ3vvIvi+8aizEtIUJ
 ALhC2JipPzfgJM9Kg40fPmCJECoDBx10hwsBKuAxG+G57P8lUNLSqsbkAKsVYQuBetr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MMLDkHM2YvI3hRTBQViY42aAIPIfEPW0isN1hvwaZWQ=; b=PFjKGC+KqDnPF1xjxct2i6sG+c
 uENFpve7msQ9Vt4hyMQwAWdTR70IpPPX3judJJLgN1ML8+Gcz1R2pGDtVIfkhqpX/cPqNbfhEhp+r
 SXwFDl77xYZki9F7AeToD382huCSVJoxCEOuUlI43iGhbzmM2t6E6WKLfZiw3wIWg12o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w55cO-0007qh-4E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D9DE7444BD;
 Tue, 24 Mar 2026 17:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E9EC2BC9E;
 Tue, 24 Mar 2026 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774373548;
 bh=v4w+4EnNwUXaI9Ys0bdzpbXa6cm5U/fz9tStEHf8Gnw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=B1mLvBo+2z9CyzlsDDB0Nv6V6c3nX15Ubi0UUazAwZXEFKejuDIhlhu+K1EI9QYWT
 KJkmxKqHM0oo8nu7nHzk5+ZkEWAygYoAhpEBnbVJ9JY5B3XRMMWnWmjgm+klZzIbgB
 6/YIYTCEakfawzAl7F74r6PCR3hXlpS1Qp9VR9qPth3zvv1ZVKlnAEXlq+n3N7lMdg
 YdkZZZqBNOGcMHnhkAyhCBQgOhWdYBE3SfNOMR4ORhJbaSdIN8AKj1wvI2wmfkanWu
 UOe+Xh3E0kt49R9FTxz3RfZ9Iqzpr/DeaWFot1YSBNHsDRXvc/TFm5tM3AJpr1JNZU
 7rnDuGb0MmLKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9E163808203; Tue, 24 Mar 2026 17:32:17 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177437353653.1223048.5601127809713877788.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 17:32:16 +0000
References: <20260323120622.3351920-2-monty_pavel@sina.com>
In-Reply-To: <20260323120622.3351920-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1w55cO-0007qh-4E
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: fix incorrect multidevice info
 in trace_f2fs_map_blocks()
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
 yangyongpeng@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 23 Mar 2026 20:06:22 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When f2fs_map_blocks()->f2fs_map_blocks_cached() hits the read extent
> cache, map->m_multidev_dio is not updated, which leads to incorrect
> multidevice information being reported by trace_f2fs_map_blocks().
> 
> This patch updates map->m_multidev_dio in f2fs_map_blocks_cached() when
> the read extent cache is hit.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/2] f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/eb2ca3ca9835
  - [f2fs-dev,v4,2/2] f2fs: fix fiemap boundary handling when read extent cache is incomplete
    https://git.kernel.org/jaegeuk/f2fs/c/95e159ad3e52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
