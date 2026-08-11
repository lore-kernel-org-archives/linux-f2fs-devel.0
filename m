Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E017C5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A20mtWBXEAz4d+hBNezMiRZJnut9woPMmy7LSN+xpIc=; b=VHJiJtP1TzUyDOnVUCW4sH2dNk
	kVuICFJEWPHJK80JQDR/DPdfECdWcmKMFMb0Nx5TDzRijiv1z98RETzuUjSakqIVuhyhM7040UJig
	/s4LDeykiPt24AKZOENEa2HrSvsuVsHugP9jYM+2bDgN58RZY6wuTEF8Vc8oYosY+Ntk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8i-000082-Vx;
	Tue, 11 Aug 2026 04:31:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8h-00007v-6g
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9XeQck9TlcykaOFnEoWdlmWWEvPMM/2v6YyT30JUZ4=; b=dQzHMgU5saphCr2cyO+BJwJ5gb
 VhGXw1Z0QJrhi0CFHINmAvFvLaLUj7+uyiTufc650qjZ1VWr1Lj4KWzKG7/AiQIkti2QRuOK83Ny1
 qHKNwabllSZ9i5bE7QAAQOT0wTOukMlI5fv5uPrUo+n4C91aP8VslS+C4S+tzHczFCQQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9XeQck9TlcykaOFnEoWdlmWWEvPMM/2v6YyT30JUZ4=; b=TuV24j1CSpgLTx5oz3nNPManfT
 Y6vFSjY+QXv6mbC8+OiWPL8NwiRKiT4P4GyKPTvV6n67L01THCwBpAdjT+0TydcDmqMeo8NtU77uO
 iKkuNKl0l3kADyUKLzaiCtSnKjBrdeMd3nOiVChnddBxmysVlDWC0Y0DdO+zTkfndMxY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8f-0001dK-Qc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 489766011F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006B11F000E9;
 Tue, 11 Aug 2026 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422652;
 bh=G9XeQck9TlcykaOFnEoWdlmWWEvPMM/2v6YyT30JUZ4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=By+tPrSP347FzJQT+P/4b8v8SBAaDiYEntLs+XCRTlP/Hw1N4kLTIZDKod/MGofMc
 wOYC8Yrfz7zjcccifIYm6T7r7gHuv1pz/9xBalwEVY+8FQT+dJdeC0CNC8McwUGqr2
 l/8tJM/3rkoWRgqkCHT2oZE1hExr/lEQFHok2GTBCLZLXIhqts56LSaNVYTpwEk1Xg
 93Iz6GRr8WPWk1QbBb2ODxfsQ0Jn5V+a9bgUWq4tN7hyGKImseeObk6hVLIXuRAFz6
 qs48fOEigICWARa/1cq/fu48pTabaCQfVBWWFJHCityYSBN8pXcC3j6Si1oDTzCNpe
 p6/66nUVCNCBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9384D3926278; Tue, 11 Aug 2026 04:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642260813.332426.13008322190859495059.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 04:30:08 +0000
References: <20260806025224.2194078-1-chao@kernel.org>
In-Reply-To: <20260806025224.2194078-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wte8f-0001dK-Qc
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: print error information in
 f2fs_put_super()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Aug 2026 10:52:24 +0800 you wrote:
> So that we can know in which path we may missed to account the
> reference correclty: normal path or error handling path.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix typo in commit message
>  fs/f2fs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: print error information in f2fs_put_super()
    https://git.kernel.org/jaegeuk/f2fs/c/5d59e6a3777c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
