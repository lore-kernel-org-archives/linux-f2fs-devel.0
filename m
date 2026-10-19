Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33960705CC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nut16Zlh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jMRRMQri;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SnIck4Cc;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKV7OZXy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=md8/uPvPHWAjArEyWLoKfjIJiyUtL4HE0978uSUWr1s=; b=Nut16ZlhWYfOz4OgqXIAimqLW/
	cQpDu1QyPpz+v2fOR84ArfZaF13vo6WlRSqwhhbISgucu9geEIi1oKLAXZV6G7yZp5vpdJmY4gIJD
	lWFbZ6E+J5rW+s0vObp/bplVHYs+zgV7WMEDIuGW9HIT0KQvQDXiHyg5t4/p07LbwDG0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTQ-00086c-Mc;
	Mon, 19 Oct 2026 15:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTL-00086B-Nf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Nf9wnupM7UsTmZYyOaqyszBk5fb76vjzvnA24gK3Vg=; b=jMRRMQriAXGNRaF7FU7NwBwUo7
 4Fswz7hWxZGNg1T7391UMB02INV3s8Y+tupQXyiInIov4P/SNB9JmHBms4dh12ML6NcgIvTQCn/vc
 Yo7BRnmZBXKc7W+Cv6ttPLeLeEMOBe4YUvWDikwzYXFoXhVjjiJAcfAyKMihgBm/bM+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Nf9wnupM7UsTmZYyOaqyszBk5fb76vjzvnA24gK3Vg=; b=SnIck4CcgIVPhOqhldeDB4TSpO
 0dM37WPUuAJQM9Vgpe4a0YMMh2F0Nd2vhfJqQ0WVWNTr1ed6UjI//X1D9wsUjwVkB1Zs+2A3alBbF
 YVyrwKOnnTjSvmjNTiIQKCY9+9OvHggaE0rY6iAaXD2hvax+/XmqE4cSNC5Y/H/ycNyU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTK-0006vc-TM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 574E360DBA;
 Mon, 19 Oct 2026 15:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0729C1F000CA;
 Mon, 19 Oct 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424417;
 bh=8Nf9wnupM7UsTmZYyOaqyszBk5fb76vjzvnA24gK3Vg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=nKV7OZXyxmcofkaBM5qibS4Zk6uWp2/Lf6OI7aLtDkT1e8jNTRkmT+4+8CmU/ouRE
 Cs/XDyklAl8gb886JSebtddLTDWYXgRgQ7J+DQOY8pVygHlrqHiD1+NXFLDFJimVas
 byuZCMGcAvCuH5x2MCUDNlDWmxIQ6GVQtP+9ITdiIWocq49ed6a4X+zGBOzrU8Ly2d
 eHhzhzDHfOwSoedufOY27NIQ23beu6LrLsyQ7nSZ/kfnztRzOP1f+0rJTCUR9J0g48
 Uw7x2hyKdJfm0mHebdRKWMguaR+9wX7MC/xBHwSwCnvaazAqZo1ZJ+dozX56IFx5Zx
 ufO1tbEKEIX3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F14253811A71; Mon, 19 Oct 2026 15:40:16 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242441555.2714099.13023477274784358472.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:15 +0000
References: <20261016021737.4121867-1-chao@kernel.org>
In-Reply-To: <20261016021737.4121867-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTK-0006vc-TM
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential reference count
 leak in do_garbage_collect()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org, daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 16 Oct 2026 10:17:37 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In do_garbage_collect(), we have reserved reference counts on summary cache
> of all segments, once gc_thread encounter freezing, we need to release all
> reference counts.
> 
> Cc: stable@kernel.org
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: 02d91398a602 ("f2fs: fix to freeze GC and discard threads quickly")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid potential reference count leak in do_garbage_collect()
    https://git.kernel.org/jaegeuk/f2fs/c/894ca8b85666

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
