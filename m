Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6BD6AAF1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIrSYWdf6ltf64SzCSN/++0CbUUjSXX+D4jsxh88UiU=; b=Cxs1Wx6apc2RBNl8V/k8ZM+dTP
	PNP5xrGn/iHPPWiZxznxg9eKa3c2kuaaEOoOHtqjmThQTRXD/tKmtc1XCoxc/4oPklJXNpmzsZqJy
	R4iBxmLDX+2H7wYGI+Zh+FbAtCp9GcmYYJDW2B8cOVZhVNz8hfFpjR4bkBKiv3B7Y59s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8KwN-0003oI-9M;
	Thu, 02 Apr 2026 16:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1w8KwG-0003o6-Kr
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 16:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Tzl2gYTd/DvbcdRFoIYbYPPTea7zm9Ax/neWOjis+k=; b=YnyoWXztcSEHZyb+iK+EXZmttb
 lnnZnmwhFkYO1I74GDrrr2QxHEOR3gyOOZx6fI3WVfDavwVJZSXHIB/v8eSGZfYE5Z1JL+AJ3Iwa0
 HaM4Hc9qOZ4XnjbREI4GX3C9KsNzHOQ/fPf45ALca24XBl1JemGWw2RdYNltOdgK9fHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Tzl2gYTd/DvbcdRFoIYbYPPTea7zm9Ax/neWOjis+k=; b=AXUtKB/T3olsq8HiV1aimjWoah
 7MUcoIG8Hed2Z1LddeqO06/ZPpN7FTg3qqtC0m7S4eh5dNyJ1UwNwvD6yWvi175essp+AGTsZs6qX
 yLaeJwfMNoaHoepm29B/ANZY3QAiyHOVcrclWmcMj0iBy+v1aq1xvkJ1Ko3EmnJrFjEw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8KwG-0001EL-3a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 16:30:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 80B8060121;
 Thu,  2 Apr 2026 16:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D33C116C6;
 Thu,  2 Apr 2026 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775147430;
 bh=h+LgisoVO20HGnX5jLSi2dWiJcFzZpiRueRdsu2LgQU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=cszGE0SOE7kx4pXtU7+P5JhSL96N7oDOYUEwavA8FcZu0LFo3mCfaJqdWb+ir+M05
 S8EvcLJ7wYDkU/xN/0k9qLbBFCC//Hv458pIIWgd0XouAUi4GETz29Hecb20x3r+O0
 Yo58DQMdMMGd3ATU/jI9T1KJCuDuQxWvJ1nelEVymX4KMArmrKSoCXuWxrSDY12xN1
 +zemjbbt44794cLhSUAbh7Eew+4F1AHqKM4uAcsRQUf1yzxamD94+qJvdxxTaTlUcT
 4SZT02ZPCakSe2uq+noh9vvEfX5laRqC1gpwmorQt1mXZWg30ObVWaZDNnV1axPolD
 uwFcpO854fXJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9F8F3809A07; Thu,  2 Apr 2026 16:30:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177514741228.519974.11874366426235502856.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 16:30:12 +0000
References: <20260324094707.3959420-2-monty_pavel@sina.com>
In-Reply-To: <20260324094707.3959420-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1w8KwG-0001EL-3a
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: invalidate block device page cache
 on umount
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
Cc: jaegeuk@kernel.org, yangyongpeng@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 24 Mar 2026 17:47:08 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Neither F2FS nor VFS invalidates the block device page cache, which
> results in reading stale metadata. An example scenario is shown below:
> 
> Terminal A                  Terminal B
> mount /dev/vdb /mnt/f2fs
> touch mx // ino = 4
> sync
> dump.f2fs -i 4 /dev/vdb// block on "[Y/N]"
>                             touch mx2 // ino = 5
>                             sync
>                             umount /mnt/f2fs
>                             dump.f2fs -i 5 /dev/vdb // block addr is 0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: invalidate block device page cache on umount
    https://git.kernel.org/jaegeuk/f2fs/c/8979bc3d2a25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
