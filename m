Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33CDCC6B0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+RjJp3s5MEwJF1TDGQr4tqjXDAsYmfJI9rFmFVQlwY=; b=iptRiAExEJSMRZDlob3s79WB8c
	CoeQw2ettutr3zQ2CHEw8Vj7wZ7Rl9jz5UcmSDfubVkR/E9lz/OiKE9Jaqkj3VsDRUfU9nv6bbhBr
	YfuJuLtaOEcyi75HYHYOroXrOFqSZZNxXcyp4tl3XkYGKNMzaNS2GRRj9TUUsLk6DBps=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl13-0000ay-Ps;
	Tue, 13 Oct 2026 22:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0p-0000aT-SC
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hwQirrEUF3uXN2QkIHd3xB/D0I8Glv1KEhePDFLUieU=; b=JMg4UyEzWkAhySmUDA6uaU0469
 gA7uvtSHYpF8LdBhmTVsxLx/zQg1bN7+7MLWI1tRFfukn6MtLyZTPdysm3btnB+xF5NWLM0nVFGAw
 1QYnfmxHKq7vkTsfAoGoP0n9pJ6wlNuPf7oBIe+mWRJlv0peD3Sn1G21NFsYCj+03hF4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hwQirrEUF3uXN2QkIHd3xB/D0I8Glv1KEhePDFLUieU=; b=T9ZoSX1xqtbPQ8Y5oVV1qruhNn
 LYLGMnzUu/epNFmTJdTX5jjHwtPhhSGtTfugexcaNd/p5xOLMg5hjEUu6wJR3Mm+FEnGk6D4dV/L8
 T4lrB/UCcbYM1uVvKy4GoufIftNAKNmhlZKxxCrvDmpYbk+gq7yZUfgnrLiogiC9wjAY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0p-00064P-Tv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56809601DB;
 Tue, 13 Oct 2026 22:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1051F00898;
 Tue, 13 Oct 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930618;
 bh=hwQirrEUF3uXN2QkIHd3xB/D0I8Glv1KEhePDFLUieU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=j3d0R4rH/lAhx9C+iO9Jv0bY82aw0BRdC/XlXmdO+A5iokSiWXVNhe+XdlXwTGw4o
 +YLydK1Hq7B605wzKvka3iC0ZVhnNChwctbV4AkabAVubXNNakODFNWd3qScRNQ0DB
 tRLATbmssz60PLfZOe5N2rhuR6itgW5t8kIWa2TcywexlS59NlTcd+M+KTIWfRPfHo
 A9G9pkMbWkLV4rHXLdN2vnHlzZDbAc26DoCmNJExXK1Jg0bmt+t+3LDI8FlsRQmC8H
 rQ2oUQfDeDNX7rVQkT9qMLmGCgilFM8r9rUU1OcYfN0YBqnU+WscyTTTNY+lH48gee
 2NjxzzZAjNQPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F15D639E4DBA; Tue, 13 Oct 2026 22:30:17 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061651.1493834.8828966574519236203.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:16 +0000
References: <20261010165750.509939-1-hengyul@cs.unc.edu>
In-Reply-To: <20261010165750.509939-1-hengyul@cs.unc.edu>
To: Hengyu Liang <hengyul@cs.unc.edu>
X-Headers-End: 1xGl0p-00064P-Tv
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow empty strings for journaled
 quota options
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, joannechien@google.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 12:57:50 -0400 you wrote:
> Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
> Opt_usr|grp|projjquota") added support for passing usrjquota,
> grpjquota and prjjquota as flags to disable journaled quotas.
> 
> However, it also replaced fsparam_string_empty() with fsparam_string(),
> which rejects an empty string. As of now, mount(2) and
> fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
> prjjquota= with EINVAL, although these forms are still documented in
> Documentation/filesystems/f2fs.rst.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: allow empty strings for journaled quota options
    https://git.kernel.org/jaegeuk/f2fs/c/0354a04b8c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
