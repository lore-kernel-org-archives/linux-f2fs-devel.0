Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CB8D3B98B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Dec 2025 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FmvPYt5hXWArqZJgUSVpBrBuoFxFLn8wAzJgUg9rOlA=; b=c/RjiCRDShQb0ltq7pELsONtrw
	UZbqAfdQ7AqdeGG07TtJ5fYd9PO9noTfbu9s+Qb8oZT8iohRVnIYr415Mc9MAAmmGH0QHmJKOeWjg
	gQOiFKlJajZs+kgWEa0EDnK9482BzZrCkNrm72qCIhWvXfq8ynojmuNI9Qs66YX+oY28=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vT1Pm-0003ZF-AP;
	Tue, 09 Dec 2025 17:22:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vT1Ph-0003Yp-R1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Dec 2025 17:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wm2AGUQMQ8ZYioLvyS/Ui1HMtF9tWDPi0siZhK0rqdU=; b=eWvM+gCr82h5CJb76MC9JNV+wP
 Ls+y+v2/e2QSNcw3MT2tEVVEDYAdNPXZbC2txDfa2qQi9eb9RrTQONfhbLiSHF/5KyxZQpr++5lmo
 vWxCjpzsvl61WRY6bKKbu+p8YXzIZVX/kxxOJZ3SvdZrtn9MYwI57kDezJBkqWqa8lXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wm2AGUQMQ8ZYioLvyS/Ui1HMtF9tWDPi0siZhK0rqdU=; b=FqLXQLtEFFaN5Ek6mtvPzItHxU
 CTLL6YjfStYY08vlUzGXVCDmS9tWDoX6htq7wFfpDuc0iXMVQTQ+bIt8pmCTc4VCWv7L4yvbTvNsX
 qw1tOFly4ca8DjIsMEIdiAmO0T2iRc9KoS6IcoosOlDkAoh51niFdtJppMvDw/yHeDCU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vT1Pa-00010n-JN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Dec 2025 17:22:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 07274601AE;
 Tue,  9 Dec 2025 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9394C4CEF5;
 Tue,  9 Dec 2025 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765300915;
 bh=PUl+bzo4yhC3iWjPC3NSPKtGAECgAhIP3ifjJ4UzYaM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PUrs/IjauNwyVsMDc+ymhcYQT51M94CQqGOke7k5Er4egvIZUbili5cvXEwqIeg7t
 AG0PVziN74DkqOlW41nha/1gAKYpOWWKnE2mKxhudWaA/ZopnjWFTyUKIG3efE2qpP
 ImFr/lBzCNW+PxP5699xwlTN5YTctrKzXP6p3IhxXKz0cbKWn/JE3JKe7Pq/l2bMCi
 ryUItZIzpuB6vOBazSjKT6T3DUbwhF5Eo/aLvY0kwrcPp+NkYQr0Ap1GudEku3LHlu
 RjzKCbDkqXD/5QaUwsEoPJvb4BTTiC4r0AKhrrDhrg44I17SPMggcOkD0d76QcCEby
 NRaWiXz8AjzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F294B3808200; Tue,  9 Dec 2025 17:18:51 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176530073052.4018985.7520755795094110884.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:50 +0000
References: <20251107194720.1231457-1-pmladek@suse.com>
In-Reply-To: <20251107194720.1231457-1-pmladek@suse.com>
To: Petr Mladek <pmladek@suse.com>
X-Headers-End: 1vT1Pa-00010n-JN
Subject: Re: [f2fs-dev] [PATCH 0/2] printk_ringbuffer: Fix regression in
 get_data() and clean up data size checks
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
Cc: brauner@kernel.org, john.ogness@linutronix.de, djwong@kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, joannelkoong@gmail.com,
 amurray@thegoodpenguin.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Petr Mladek <pmladek@suse.com>:

On Fri,  7 Nov 2025 20:47:18 +0100 you wrote:
> This is outcome of the long discussion about the regression caused
> by 67e1b0052f6bb82 ("printk_ringbuffer: don't needlessly wrap data blocks around"),
> see https://lore.kernel.org/all/69096836.a70a0220.88fb8.0006.GAE@google.com/
> 
> The 1st patch fixes the regression as agreed, see
> https://lore.kernel.org/all/87ecqb3qd0.fsf@jogness.linutronix.de/
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] printk_ringbuffer: Fix check of valid data size when blk_lpos overflows
    https://git.kernel.org/jaegeuk/f2fs/c/cc3bad11de6e
  - [f2fs-dev,2/2] printk_ringbuffer: Create a helper function to decide whether a more space is needed
    https://git.kernel.org/jaegeuk/f2fs/c/394aa576c0b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
