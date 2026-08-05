Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F68FC55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgCp292s54sg1Gug+CnpuOihbVeVIYRqfwaxPvQQ8hk=; b=VZ0KXS/hZow7mmU1URG+Bl4M0p
	pBIxaAta7sgZRQR4n45gkmf8voONz3kvsA5qcKuTDB2qb6AkWaU8KT428ONrSJ90WSvi8QZK3WhVX
	6StybcZNQHI68wXz7LQcZXMQgRNcJ6TfyGqeJm8LbHQytNA6db0xpGGmqRC+aUv8LVbQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3Q-0002Ar-F0;
	Wed, 05 Aug 2026 21:21:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3O-0002AW-In
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWy/tQGfR/k8KvWDGFROVvCPOF7d6KtSjTsb8waW7XM=; b=lRowm22qbPFgjHiGDM5jNwzvbY
 +6/bwoH5yTiOS4xk3SUdA3WGJHGj2Aw31o1AaWaFLb13PkgbO+qOBY/LMqfjKR+31UejxERLZr1zf
 Nxyjh14OZ58b9FEWQvy6x0o387t1i696iR1R1qNqviOIPNFKYRDJxSH2s/FMRs0+MmtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xWy/tQGfR/k8KvWDGFROVvCPOF7d6KtSjTsb8waW7XM=; b=ANSCRm3Vd7H7W3luuJSsjNhChu
 LGuICVx1Fu3RPoYxm89eCGUIyPnbtLqlDNnBeHqhRJtcTxFu0eyoFIGA+7A8o6vFI/GRLfCcFZOGp
 N0/kuncxHwVjRfZYFcmFrk08G0/iJxr3E4cz2fDA6c4nYIKJcT3tfxp9td0dMWwXfA4c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3M-0007Ac-DZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA0B560A6B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902761F00A3F;
 Wed,  5 Aug 2026 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964886;
 bh=xWy/tQGfR/k8KvWDGFROVvCPOF7d6KtSjTsb8waW7XM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=eF1JKk47uC+npUxNd3LuCc2Xcx7VsFO6toHw+0JwUFZsHuZ4DTSbQaMUb1MBhVaZR
 QACV+Bxt/7S74Y4fTfv8ov5lAv+n2QNl56AmpUlm7zjO20AYh7uXFU96X+b3q3QmLX
 zQm/536sRKRJdNlHBKDQ/xfOQzqp0mWLG8ihr7Hbw5Q/C0AZkrACMPzAb5vW7E0KA2
 wqWj9HpO1yomjA7+jNaCxT8ALgAWzoZWqpcuQ0SUly4y77XmeOz1A2GwXU6jjPh6C0
 zy91JptZM8A49YECDekY92c3DoGCLKAsTC+n4IWXr98dBfJPuAhY4km/8B7VbKEsI5
 TXrcMd+QfcwQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 938F9392FFD1; Wed,  5 Aug 2026 21:20:47 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484613.530543.8785715885319365776.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:46 +0000
References: <20260805122920.674676-1-chao@kernel.org>
In-Reply-To: <20260805122920.674676-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wrj3M-0007Ac-DZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear dirty flag on folio in
 error path
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
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Aug 2026 12:29:20 +0000 you wrote:
> If node block is corrupted due to chksum mismatch or inconsistent
> footer info, it needs to drop clear flag of node folio, in order
> to persist inconsistent node data to storage.
> 
> Cc: stable@kernel.org
> Fixes: b42b179bda9f ("f2fs: fix to do checksum even if inode page is uptodate")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to clear dirty flag on folio in error path
    https://git.kernel.org/jaegeuk/f2fs/c/5b86eab84ac8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
