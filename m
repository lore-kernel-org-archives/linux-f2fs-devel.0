Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D879C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUIEtFNEjqolzylpQXzxy789RQHLSicv5gcxNRGMxGs=; b=K37aEoxGcHrQl3zISosndjweC8
	Q0T5TnRIsnVcttWzKAXCpQuUH3/T98iOTiKHoZiDTtQ3wUH4JphCUxjdUdRjnASeFbm+RsLwk4h0l
	JWX0NP1sQf/fq1IeoDwS4pG2y10RVVClNbszuSoL+1Vcv3OSbHiZaxvgtBJxuv/B4Lgg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuXsx-0008Ff-8h;
	Thu, 13 Aug 2026 16:02:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuXsw-0008AE-1m
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HGmwtS6B+lmMNfgDG8dwjsD34hOGygpvCW32rqNxU/g=; b=RXpa7mcrSTn1gdB4eneDJbABms
 E5ogibKIPSdlGVHPD6+qZCSY7PgAbPOsYdG2p1Dn5sawfiDsPVAZTyvi9ZtLGkorPLz97WN/Vq+eo
 g/7cV+D5Sayn5GsRa5G6Pqel/nMRcicDhbkKPm+izwZXb7EKsQmEgiA7fsUhB/5D60Co=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HGmwtS6B+lmMNfgDG8dwjsD34hOGygpvCW32rqNxU/g=; b=hvefv3BSTai6vQhvqpks5va8lZ
 DM4xWOp5VB8OQHAxrEFpE57wvPXLMWHfzeQqCymH05CXD0qTF2G20o6gXSFya90fdFFAFsGfbDXrO
 jrEZ8/74++oIJHOT23hK2HXWVLrASkXLtRFjQLu+39yaP77W/YvDyG/uDmADGr8CDXXQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuXsb-0005mJ-0N for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3248643B25
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 16:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165FF1F000E9;
 Thu, 13 Aug 2026 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786636916;
 bh=HGmwtS6B+lmMNfgDG8dwjsD34hOGygpvCW32rqNxU/g=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=mUyJXnSm8ptX7vvia86pBms4JWP1sp0crFkBy7KPFf9pbZpNHMXZWjKvMFhcQX2ri
 9zktthef4Qf/SuhpN1kEdTS4Uxu7NJrNlEuM3+KE/J9CopRsL7W4etYGiCJz1p+Y0u
 pTFSFCCr28q8Kq8ypr+oTCldOJXpbQ1iRQkR8ws7oHvZSjRB9gjceCn4Q5ArOhW81u
 XnU75w0fzuZi7k6DR111l6Y84bWqcwmHbRFBkTdWw3Ni6Ujk69EsrNn5si3FykemE1
 gJNid9ouLnDNnuQ3ke9upBRePNpi8aUCNz3bk/Ufc8fAkv8PDiozq3L/Vnc74RBxWI
 UKv2hz+zYvojw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198C3380CEE2; Thu, 13 Aug 2026 16:01:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178663687070.2934858.5259431434864990132.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 16:01:10 +0000
References: <20260812122043.282195-1-chao@kernel.org>
In-Reply-To: <20260812122043.282195-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wuXsb-0005mJ-0N
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to propagate error from
 f2fs_sync_fs()
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

On Wed, 12 Aug 2026 12:20:43 +0000 you wrote:
> So that caller can detect any failure from f2fs_sync_fs().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c | 51 ++++++++++++++++++++++++++++++++++---------------
>  fs/f2fs/super.c |  4 +++-
>  2 files changed, 39 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to propagate error from f2fs_sync_fs()
    https://git.kernel.org/jaegeuk/f2fs/c/c7d026012a46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
