Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C506CC6B1F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTR2Mr83w0JPhZWezuETj2ZVAJhV1SLWFnt9K+A8Wpg=; b=AsczUsh0/yyawxFZv3xaS/gejm
	5z6LYRJm6fuX0t1GkS8QKVT9dSwTj4t4LHHi2y6eQjXkJjzEwzqzRhT7MreVzoE+vb1u8dTQNv6O6
	orv4NEAxQ21GxR6kxB7Rst1HGaQi8msILX4l0TyMsBMv5DbFyBUL4k5X+Mtrin6ll8GM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl14-0000bD-71;
	Tue, 13 Oct 2026 22:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl12-0000ag-8W
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7/uKeE/+oIcs3CACNXtRNe+WMreIgFyM/jVJG64BJE=; b=jW8GBVMjHB1xpZEwl/+7bY7S4B
 iN9tOkKnwx37WUkXA4cH3Mue1PdmyNc1aLoYQ+r7mN3LVNgPRrNvQTcc6lel6gFLM51FuTtKFalJP
 89479uJkWeZY7aijBm60nZP/rutoL4hPZmnpPQOu31ns+lc/a1UAOB1grWR+yKUffb9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X7/uKeE/+oIcs3CACNXtRNe+WMreIgFyM/jVJG64BJE=; b=DSlaw1fPRNcvIjPZjFxtqtFIzm
 cdaPOs1enGNIMc0rfhhztIf4wKu6m7mYl2f3WyekwGbjD5y210gr+9y2Rd/UYHBPuECf+e7qe41CB
 JIRMUEM9+cK7YJWy52mAm4DY+ga/pQacFVgi5jubGVuLi+N/sa+UI1gv+BHbUXSlNNng=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl10-0001da-Sa for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F5C26021D;
 Tue, 13 Oct 2026 22:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B961F00893;
 Tue, 13 Oct 2026 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930629;
 bh=X7/uKeE/+oIcs3CACNXtRNe+WMreIgFyM/jVJG64BJE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=GG9k4t2y1gkxV6RA7JOUo/4OFI5IE45bPo19MxkCrzPH0kgCFs9G0Edka5XwWMIDy
 MYJHniHeEBuOiDPlGNPv1JO9v3PYg1q8pHP6Dx5HHU+/URluL5jkLbg93a1ekzHfpt
 A3nyiS8XM7Kk+ePD2yaKGoYjHn1xOs8wExFyQvtZgb9nHVy1H+L32bLaYh8NnuQ0fs
 RII7T3GB50O2tkv24fYsJfirXpU8vyeOm1JqXBiRY4qdQpT1UQA0YE/jqOFFuub5E2
 VfenPhPlnzFUSQ/Lzv9azmP69q+Q3SDnot25bKtaNwM2avuHktXwNgBM/aR37t8Ghn
 HEPlDbrv73fnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F14DD39E4DBA; Tue, 13 Oct 2026 22:30:28 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193062775.1493834.5789106553835125031.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:27 +0000
References: <20261004170456.4104287-1-daeho43@gmail.com>
In-Reply-To: <20261004170456.4104287-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1xGl10-0001da-Sa
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert inline quota files when
 turning quota on
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  4 Oct 2026 17:04:56 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With a block size larger than 4KB, the inline data area is large enough
> to hold a freshly created quota file (quotacheck writes 6KB), so
> aquota.user/aquota.group stay inline after quotaon. f2fs does not
> expect quota files to be inline, and this causes two problems:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: convert inline quota files when turning quota on
    https://git.kernel.org/jaegeuk/f2fs/c/a85e09bd6cc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
