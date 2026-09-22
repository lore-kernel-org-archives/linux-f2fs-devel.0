Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C559C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JA5hBZTYrzWo5oLYr7K4pFKtI9kVFRgHnsIjvOrICFA=; b=G3Copa4auZAtLG9gK1Hac8wEwa
	PNMq0QtM+PhcPMN7Iu2PxqZtFcDz9tfIuhmYTKiKMdbis7pdvzU3keG1sUPzUZbT5GzBKp4CAgYIl
	LsgFjqTltFJg8tI87CYNsuCcRE6ILM+y8802GN3sLgM2bKXxR+f56PeSPvP3PFPVK8no=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x92Sw-0005A3-Oz;
	Tue, 22 Sep 2026 15:31:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x92Sv-00059p-0g
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jkdJbMj60D1Bl882A7vHpFfPJNELDfahplewLii3Ijg=; b=C7U8aPBN2ndqh3Z/E67vgLQVuo
 E96XEg37G53Awce6ZnPIQc0+RgMsvyuSTEqacv8mdKYjftBCujASE6/wGah/t0acK3kyoq6Z3slUx
 X7eFRMLWz/106a4FdMW2POiusoJch/CLHZpX1ZOG4TYz3LtfAq5NtxyY+DN7WdVtN9aw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jkdJbMj60D1Bl882A7vHpFfPJNELDfahplewLii3Ijg=; b=g73+TR2KJ9ygcrDT3D2q/rMxPq
 6xzTaIC9KavCOXR8t7IMimKjvKV0UFNY2DAQXLGJmufRc6bGV+KNSxeqm5WnLuPYtMy76PAPlTBye
 GMqh0j7CMGabPK5Rl5eUqC/IAA4ZiHMn9WoKt/Gyy/xrbKdPJdKszzvGgd3I7TAIycH4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x92St-00040M-O0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FFB444519
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A641F000FF;
 Tue, 22 Sep 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091082;
 bh=jkdJbMj60D1Bl882A7vHpFfPJNELDfahplewLii3Ijg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Vi/njdkn2USvYJKew9JTFF5TSsmnwql5fvmu4Ad2UqPTqeK/fWJzuw16x77AmLBNb
 979TgeKn9aH3q8ep7zPjKH+HQ0SYoXkzP3vthI5PTxirHQkWQV8f7kxlLWOx/CSTyk
 VJ9lF1FPdb+1Mj1Kzfl+qawnzk1xU8sA06pGSoDU8dXUUS7WPxD7Zt0AUldsx1wy8E
 tQP1bXSdKXFVpLBEahxDalN5qPvYtIfh6H9BDkGBnYAqlHQwm6Wnd92eZ5yk4WRyxU
 I6aXuenmljmDOmoJsr/Qgdi7+MK1D1lY2HJ+SYHlrww8MSQTJKiHywNezLl3vV2xAw
 Tpv+PyNQ7CS5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939073811A4B; Tue, 22 Sep 2026 15:30:14 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179009101314.4140645.13210408538473891144.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:30:13 +0000
References: <20260911232510.1816298-1-chao@kernel.org>
In-Reply-To: <20260911232510.1816298-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x92St-00040M-O0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: rename page_count with cache_count
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 12 Sep 2026 07:25:09 +0800 you wrote:
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> The count does not indicate the number of pages anymore.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/cache.c      |  4 ++--
>  fs/f2fs/checkpoint.c | 30 ++++++++++++-------------
>  fs/f2fs/compress.c   |  8 +++----
>  fs/f2fs/data.c       | 32 +++++++++++++--------------
>  fs/f2fs/debug.c      | 26 +++++++++++-----------
>  fs/f2fs/f2fs.h       | 41 ++++++++++++++++++----------------
>  fs/f2fs/file.c       | 14 ++++++------
>  fs/f2fs/gc.c         | 14 ++++++------
>  fs/f2fs/node.c       | 10 ++++-----
>  fs/f2fs/segment.c    | 10 ++++-----
>  fs/f2fs/segment.h    | 10 ++++-----
>  fs/f2fs/super.c      | 52 ++++++++++++++++++++++----------------------
>  12 files changed, 127 insertions(+), 124 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: rename page_count with cache_count
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: rename nr_pages_to_skip with nr_caches_to_skip
    https://git.kernel.org/jaegeuk/f2fs/c/a4b9fb9e6911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
