Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916E3C531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAd5KX//T8iGxuoZ2zpGFmJdUJIvrjecU4rMkpzeyBk=; b=P2TJ6hzK7WOhbzahWy2s2eRER/
	NYfM+MBJIgvCibAWtZlg7ps2RpXTI7J7u+DF1MTmoBMvl8chF98G6/Ma+3zAOqhKX3SadhTw3+Y/1
	yLenPGxck7juRxBkNVqJfd6ZOwdw3VQrrP2DLkPzpkBaabOjgKq8F9uO1DakDYqVqpDg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woWC8-0004o6-Hy;
	Tue, 28 Jul 2026 01:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1woWBq-0004nG-Vn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 01:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YRblQhH+uVWut5p5K8lZwDABtoCwMjoVNvbtRet4Gdc=; b=MFCnIf45HQFYM8TWrN8vhzywhj
 2Zm/+pF5gMCZkfniie7+hO53v8p8GSpUT1GGHLCfa4IbgmhAr0+gKia40+V+v7YeZjqdkn81UKZjg
 SrqADSZljqRnbBj9JcD8RTGcGiCjrQ2FkXBB3ZbtF9ESprohVt7LCV9atiHFES0c29tQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YRblQhH+uVWut5p5K8lZwDABtoCwMjoVNvbtRet4Gdc=; b=nKkBLlT/ysb8Y7Ywk0s+Em/jmA
 D91yYfnyQvYdlGhvl91LFMtKAkwu9u28nSaQnBHiHfUxpcQ8XFu7uvcxZvDptjn2GOAxoL3G4ep+Y
 S34Gc2C8lwucwnU1Aeb9XsxQqf7B9Mn1pHiw0h7bCFtTw0IgYISfUk/yxej6CxmFbTZk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woWBt-0002SV-BX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 01:01:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A20060A74;
 Tue, 28 Jul 2026 01:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61161F000E9;
 Tue, 28 Jul 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785200455;
 bh=YRblQhH+uVWut5p5K8lZwDABtoCwMjoVNvbtRet4Gdc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=CSo9WHEjnd2dmgqvCw7qN0K2fbI2JHUCr8YJMtY5kvMFblWasUMHPNUjpd/l8jLp/
 YaseEsb33z275Ub4i8obhjFaVtoI70JAzTAFsC2J+AjMiWcvYGHkpPUsqDKtuMDB5a
 2ebrFNR2FmT0DO3TWFOZ7IJ7utl/MVs5xhGtAlQSJ/2gxantr0UMWGpG4/H6f3gp9B
 /HQ9A8753kp1tAYCFpbQRpLYET5N1X2mFdBK27qgy5B40JbRJgOMjtBNlowMmPxnSY
 fq2QavulcOwpMET3eR5aUj2vZNaG0eLMVwGtQch44EAqIGloGyn7a/4egJuyfwJY6h
 ei6FFH/OgfFEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56964380CED8; Tue, 28 Jul 2026 01:00:22 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178520042088.1482784.9634568618514854667.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:00:20 +0000
References: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
In-Reply-To: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
To: Guanghui Yang <3497809730@qq.com>
X-Headers-End: 1woWBt-0002SV-BX
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix dentry folio leak in
 find_in_level
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 19 Jul 2026 16:45:14 +0800 you wrote:
> find_in_level() gets a dentry folio with f2fs_find_data_folio() before
> calling find_in_block().  If find_in_block() returns an error, the
> function stores the error in res_folio and breaks out of the loop without
> dropping the dentry folio.
> 
> This leaks the folio reference on the find_in_block() error path.  Drop
> the dentry folio before returning the error to the caller.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix dentry folio leak in find_in_level
    https://git.kernel.org/jaegeuk/f2fs/c/13f88c0865be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
