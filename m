Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE9C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EubFl9x98t8CeGUAOEz6b181/p8ndBQrq6zh2/iBszA=; b=XH+1TTyZa0iV2MnOD+W6vu2DdU
	LX/yi5pzXEqH85DpmF0kHd2PNdZx5vE28QgBPfHegtimj4QisKCMRYRnF/+DgZVyWuTw/tagK3qAR
	tfKNntVlGZ6gG2XU4B04mt535Uk3YaY7VFn4LSBAXmmnrpkmLxvHVSMD19LTUerSTMqY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjTO8-0006y6-Sz;
	Tue, 14 Jul 2026 03:00:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wjTO4-0006xZ-5Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cJfr09HfW+vVROQ0irOyEMo1PMk8FVcLJ1dq0f25jco=; b=Tc2Vt1YEPcpp5nBeaJt/FC64Ww
 6kAdJHCQGpnyzitXXeJcX7aqZjaP+uvli6tUH/4cAcb/Ghod4jdMeQDNIW4BNTgsHlb2Vp8m4WKZV
 ixujBgmkgm9ZUbS3u+6AHliM4mIsk+eGQuheoe6jByYQFWkAysslbq7dso9hsmQH4jJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cJfr09HfW+vVROQ0irOyEMo1PMk8FVcLJ1dq0f25jco=; b=DkLG//h4E3bRgETc6BUhXNG1Oq
 +WkjlO5cVEJtI7JCC8MIYgWgKT7SflsDgFqUqvMMZNSMXBVG7L2Ak2xIZvKcOVdzoA0kA54exSLh6
 pqo3rEu3pXnKoR0Opahgw8Hcj18gOM+wNC5CpFl4rjLTXKUkQMox4Xx0U5g9IoHBb+Xs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjTO3-0000ko-J0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C39F43C57
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7B91F00A3A;
 Tue, 14 Jul 2026 03:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783998037;
 bh=cJfr09HfW+vVROQ0irOyEMo1PMk8FVcLJ1dq0f25jco=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=msYO7tv1CAwQ6+UGegDf/eYq057+WiMTxfUijLZ8RMaIhMpgYkv/gG29SNgT94947
 c6s5a9gpZOlaTW0jYz/XjN5gBvQOpIXhWQiy+4qKJto3o9wTQJV4piu3dEW9+vazA3
 PHE3WzFqTiIKFKEdblcTqgu1TvIRWFHd6cgajg/xEGBgDsH0ISPEugAGh7oLa1RbZB
 a2K3gJKM7h4dx5bDHGxf7LJ/Q4LvIclqvqqyKgLbxGUVL5WPkbTsCeppZKsalfKjUi
 7rQ71QtQJiqqghJxYyiaOkjjeC5Cj/amcxD/Nu+Akz+J2C3pZE9CqBaN5TFp4Y0hNC
 9q/cJOBzJjPTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5689A3924FB7; Tue, 14 Jul 2026 03:00:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178399801188.2939750.4882347111407604068.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jul 2026 03:00:11 +0000
References: <20260706072606.3709384-1-chao@kernel.org>
In-Reply-To: <20260706072606.3709384-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wjTO3-0000ko-J0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to zero post-EOF data when
 extending file size
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

On Mon,  6 Jul 2026 07:26:06 +0000 you wrote:
> generic/794  4s ... - output mismatch (see /share/git/fstests/results//generic/794.out.bad)
>     --- tests/generic/794.out   2026-06-12 08:46:32.766426241 +0800
>     +++ /share/git/fstests/results//generic/794.out.bad 2026-07-05 18:32:55.000000000 +0800
>     @@ -1,4 +1,16 @@
>      QA output created by 794
>      append_write
>     +FAIL: non-zero data in gap [4080,4096) after shutdown+remount
>     +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>     +*
>     +001000
>      truncate_up
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/794.out /share/git/fstests/results//generic/794.out.bad'  to see the entire diff)
> Ran: generic/794
> Failures: generic/794
> Failed 1 of 1 tests
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to zero post-EOF data when extending file size
    https://git.kernel.org/jaegeuk/f2fs/c/7e097cad3ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
