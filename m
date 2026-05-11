Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDACCD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21+ZliUl/p45O/bBR4ZisE7fxJ8CHFZL0yAYDxviiho=; b=TzxqX9u7WN0HbWGzdif2uIKWgS
	dQqDPxcDolVf/9GnGp7H8LgxLK9b1SHlYlH7A96aAHd7hmh8TyHHpWxx1DyMKeF5HiAu2liscMl2p
	opEWFXT0l2MAtAmphCMJtE/4tXvYXVItjPbdF4Q6tC4Xbgrlgt8Z8rKTLlnhJaL79w8M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFf0-00055V-Fj;
	Mon, 11 May 2026 01:42:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFey-00055M-QQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzZjul2lwjLLiWF3zwA1FL70QjJ7y/4h4xfWscZ6Kps=; b=ClxtTNdImGQTQmqPZEre8xAoq7
 hVizVv19dkOSdDV3+iVMHsQ46M5cjz44jo8LW0EVu1LPfpT19caeVt8OBtDCv3pT4C80GBl/pN1oL
 iziD1OkPBFGsEXkLwsbL3xCSj0tJGc14GVMevrEZudwC7BPeP91gMKRxkwecdU2TYb9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzZjul2lwjLLiWF3zwA1FL70QjJ7y/4h4xfWscZ6Kps=; b=GUDbR8ljTo1ZSt6PDFkRnMp8Pf
 P8ahtFnMCTNFgR5Bq+4DjEAIbzmeGofsk7nAoNJ/KZhroJ8Rr5Z7VBydt2fjUHl60KiozCC+n7tDy
 nvxfKyy2VIrngcKuVL/+bbxkVmnuo0yksU2EszNe5I0HPXRT1SHNUefOJasZxnfHUDR4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFey-0007Bd-6r for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D2D760142;
 Mon, 11 May 2026 01:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70196C2BCB8;
 Mon, 11 May 2026 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463725;
 bh=l1dMEIH4cxx+wnZB0tqVb04wT+dwsZ6juwhVU7G3jEA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=At5Qb51+LYJ397XHy123a03vgbfslynusNYk8Un6LteRrhANlCZmNOpF0hmW5zWj8
 dc/3bPYQb0oqwKrzX1MyX8rfT5JvNbaPHoZv7e65SNH8XEnwAUG4bARnNyrjl9lnPM
 FJe+CD5yG2/rzGA6wdRGJKLD11OLhel/+Iq5r01AFeJA3Ky6gzxaOiDLWA/es2UBH7
 +jIkEy958guv630flGvAUiaIo9nNta7ZYseUXPwLJC8bQd1HMJXgikZHTDI3O/v43/
 v1jxMR6zyiLs4hyD0XFnEeBuwoUNJjwWJqEvzQ6trlCPynD1rA6qXtuohjMSPzrUTa
 wHseFHy4SMfjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9E393930039; Mon, 11 May 2026 01:41:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846367229.1975880.775776220391157336.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:12 +0000
References: <20260212012652.GA8885@sol>
In-Reply-To: <20260212012652.GA8885@sol>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1wMFey-0007Bd-6r
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 7.0
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
Cc: fsverity@lists.linux.dev, tytso@mit.edu, djwong@kernel.org,
 aalbersh@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 dsterba@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
 torvalds@linux-foundation.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 11 Feb 2026 17:26:52 -0800 you wrote:
> The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:
> 
>   Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] fsverity updates for 7.0
    https://git.kernel.org/jaegeuk/f2fs/c/1bfaee9d3351

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
