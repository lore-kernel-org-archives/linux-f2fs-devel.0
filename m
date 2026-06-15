Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAE2CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQwEr0RE9Ppl5A+U0+rt32wJ4sR7+dc41RsoHWxwhao=; b=ZV3NbcEZb03gPNNUvFIT3VEJ1y
	JN93LjQeRIYXR94MX3l1yzGhWsT9zf8mSpVzcByBD7WkH/thMhGmbH7tHtBA+vxPluBxEu1J7RO+8
	INbATs5L62k0nQReMN2nAqUMfarafQ+Pprk8x2HgEFRAmUvvb1iilQRH2Se1Y0Bn2bAU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9Ge-0004MT-OQ;
	Mon, 15 Jun 2026 15:30:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZ9Ga-0004Lr-5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hT5UO8YECt1Zh+naO2m+zZjR3PoEy411iORlB8Pf9EU=; b=iR+FX2PUOcZjnLQAQW2xai7GeE
 sYLvXHtw2uw3PPMQ4yLwjYvenAVCtSCZLs9AdibcdZUlrim5pMbW3NkR6e0oeGumCRvg1Dp+3YIPD
 uStQa0eY0ubwweW8VGPa/9JgQwTm5vOOJ+yEz7Stz7NvtsoUFBwqzKfiuSLw7Kxekzww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hT5UO8YECt1Zh+naO2m+zZjR3PoEy411iORlB8Pf9EU=; b=lvyHWsxamAxylbWb+EQBJXy7WB
 9RXXtpcxAP/LdBH3tEluoV5KiQAm5NPDcCIs/AUFt0hUfsKrJHNMiGF0EZJM8vjIdxKp3QdcxLR9w
 CyDK+TQ5SDPfzodtSeesquJ7bwYjKB0LtfdrRy63jv9epCasMnMlZ0hRHhXLCi8rAKUA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9GZ-0002vD-Az for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AEDA41707;
 Mon, 15 Jun 2026 15:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0CB1F000E9;
 Mon, 15 Jun 2026 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537413;
 bh=hT5UO8YECt1Zh+naO2m+zZjR3PoEy411iORlB8Pf9EU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=bFictPhkEy2GgB3+W3OC33NitlF6QCxd2bbABwSfJAGz9ELH+Vg/Wwvf6AQi05yTL
 zogdADYp27lm5iPl+Kyfdmyge1j6bLlsaablIep7aLsJSDg7/4olIb8LO+ID1w+wHZ
 5bUqPHpi3mqnghn3Y/nQeJS/jmiQegRCy0hzVVUftr/l8uRIOuj+09IZHoU0fPx95b
 5Q51JpW5NzrpHN0Mjjv1l2ApreP2NSJodmetjxCE82kjygS1CxuVoACCOSzyiRJPcP
 KKSz4B2ZE+maOQ+HpGAgra7DgQNhEKIjm51dZC7lBNh9og+a/Mm9HFXyAA6lEWEXWG
 +bbFb8M/Y/Pdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0AE93811A64; Mon, 15 Jun 2026 15:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178153740838.3946007.5241009515125425224.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:30:08 +0000
References: <20260529022924.3655519-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260529022924.3655519-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wZ9GZ-0002vD-Az
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip inode folio lookup for cached
 overwrite
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
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 29 May 2026 10:29:24 +0800 you wrote:
> prepare_write_begin() first gets the inode folio and builds a dnode,
> then checks the read extent cache. For an ordinary overwrite of a
> non-inline and non-compressed file, an extent-cache hit already gives the
> data block address and the following path does not need to allocate or
> update any node state.
> 
> Check the read extent cache before fetching the inode folio for that
> narrow case. Keep the existing paths for inline data, compressed files,
> and writes that may extend past EOF, where the helper may need inline
> conversion, compression preparation, or block reservation.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: skip inode folio lookup for cached overwrite
    https://git.kernel.org/jaegeuk/f2fs/c/ec1a089b0c14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
