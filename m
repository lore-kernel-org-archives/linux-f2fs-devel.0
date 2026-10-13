Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F1BCC6B20
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjqrLi/ppX/7tQdUx/DcDyrNt75fRaMnZA/wrqA+l48=; b=YicQC+eM/rthXZzPEgzXrLQMjX
	J1XWWduFk2ZVL070hyusNh57Yn3nkvR0cRGdW/SQntQn3l7DoRALKDZhC/tAjaKZiaSyis9C73yqf
	TWxTBe+Mo7EhAMvzDaXJNLEkwmLUwsGH/zHobP1VD0do+EWigIm8i72DAxpqdX7Mq3uY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl11-0007Wr-7b;
	Tue, 13 Oct 2026 22:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0s-0007Ul-Oo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V1dhIG9s+dfvyv5FGLs5xco/ge7mxdT0ebSHp2TKX8Y=; b=h5qXbqI62E/ynFVUrC7nvujjwi
 TinBmCyGrrf9Zao0kDstqfhZVAJfx1N/eFPukB24zLWWOsVDlLVqWqUXxz5GX+BXK8mKAj0a5UihG
 plN3TcUAsmdvKmTomOCFJH0zSyTLYgaSVuvEgRQdnQMcJTBt/SVZZHuGV38Y9em2m7N4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V1dhIG9s+dfvyv5FGLs5xco/ge7mxdT0ebSHp2TKX8Y=; b=G+sy0k9mXobW81rph1AjGUPIX1
 zr2FFyZewxoOj+oXicvV7txJ8q0lOn7PS7Z5I4Fyf1h4ZmiOzbMqOFGxV184/HneA9aWE1ufoT89r
 mHFCJ4mrSdeKol156wmamCNjP9Z0chVobE8pp00kqAT3xoqMcmbkmSX45C6KrIGsu6qY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0r-00064Q-C4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA54260214
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F241F000FF;
 Tue, 13 Oct 2026 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930619;
 bh=V1dhIG9s+dfvyv5FGLs5xco/ge7mxdT0ebSHp2TKX8Y=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=dN2sUvzuTi5/yd7b5Aq1aotqHPIIQV3TBvZR0ThXZLnqPodw9S4mkUxshNdHF+Vip
 UQQIIgbdJUYdDDQUztnJj7bLc5L8LgjnsJsVvdzd6pgnY76pHOnUo6XZmaHjicYZnn
 AH5n/55lgbdM762TfpVTHQgjuFfNj4bm7mw87svGgFHje0sFNcREdf6Hxft0gZ0qFT
 M515oFtM2kUYnXNZyp+DORowuTe3rTzzz+JvCcRnoZviXoWZtr86wx6F3ONPl/18gy
 McefdDpIoo62HMgQMTN1PtJxUhDMOVHc1VShTRwastOSc7KCP+oDgrHB5/EV/7+Sse
 5hgTuMzGZq9MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7729839E4DBA; Tue, 13 Oct 2026 22:30:19 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061801.1493834.16888070301853963484.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:18 +0000
References: <20261013105538.3636822-1-chao@kernel.org>
In-Reply-To: <20261013105538.3636822-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl0r-00064Q-C4
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to invalidate curseg if
 change_curseg() fails
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

On Tue, 13 Oct 2026 10:55:38 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Our consistency stress test (fsstress + fio + atomic write workers +
> "f2fs_io shutdown 1") triggers below kernel BUG:
> 
>  F2FS-fs (vdd): Stopped filesystem due to reason: 0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to invalidate curseg if change_curseg() fails
    https://git.kernel.org/jaegeuk/f2fs/c/e74476ad8162

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
