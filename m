Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C5CCA5FC5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6URIGi5eVPYJAgtgHtmg42TMlPl10zfr/aKgMQCz1E=; b=FfLGumHPs0syDU1xt0d84JeVil
	2i6QjSPMLbKNMNM4mSEARHF3irHA3VtEsqcNq559VHC5sSBLwaY/j7LTxAxnZ9ZNL2YanAOGcv6vX
	5y817YiXvRmRwjZCie1GZIenT4bZISVjx6+BBKxU12MZK3EN1pF7CHpFwlMew44Nv/Vo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBxyb-0003pX-7I;
	Wed, 30 Sep 2026 17:20:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xBxyZ-0003pQ-O3
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S5SovKu31nc0diQzX42s1+cZ/X3J7FUudvMNU5K5FaY=; b=B37+LlStcurYLOKxh5qo7UibKJ
 l3o5WzbvfG1x925NGcfHfA/pRKr634Nr+slS1DPZ7MH+e7l68sZ1yvtpI3Z7T0mAKeaZ/Tmwasolt
 dHJSVhXS4DiywDZC5fhVmN0yX/jzZx2loRzgD9hbRUviNOGCBGNZN2rT1WofJRbZveBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S5SovKu31nc0diQzX42s1+cZ/X3J7FUudvMNU5K5FaY=; b=NqtsBf9ZSdwQmbAn8a1uEzfpuD
 XDKQTY+SF14xHWEulMQNomhEfOyTLmXDsVN79OM9gwhMsFXsTFaaS81EYrNBiHq/Zheqh49DLeEWv
 o/S62tkKvliCg359ngdpco1wM6HFfZJ1YsMKscbEkr8OKnRaGGAeliVO1UUZ/LLqnR9U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBxyW-0002Tv-Ma for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 158DC60258;
 Wed, 30 Sep 2026 17:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9111F00898;
 Wed, 30 Sep 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788806;
 bh=S5SovKu31nc0diQzX42s1+cZ/X3J7FUudvMNU5K5FaY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ckndykqqNUOSFtGG/pMBSGotblsKgMn4ceJAhSb0AZOGbXC6TTVQxcWW+nYhJ158o
 5i0c2DlNDGZV9fPEByQO0NXQIq/oHJ1cZHJrdiZTLzQpv7U93BtuksiY5OLTmiixoj
 atFvYY6NMzprSrqdEuWM8uMaJN9D4hZfcmSx+NGJMF4V5AX3BBNiwS3jJ0/B6AjEbt
 X1YowmimXY4C5rLituG1hiqM6xyzlm79+9IsSNHHcufLKB5lnqkcTn5k75AS3cablJ
 MLvlGxw6FqnEfEtmSiBHNmYsKaoixh6BCvbFklrpswHm3HqKqhWaN+RkpSoJOB+hvU
 M/2NVeixb/EEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B43773A566F2; Wed, 30 Sep 2026 17:20:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179078880553.2027760.391939361418091885.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 17:20:05 +0000
References: <20260918133922.8163-1-jsjlee1020@gmail.com>
In-Reply-To: <20260918133922.8163-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Headers-End: 1xBxyW-0002Tv-Ma
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject device aliasing without a
 multi-device configuration
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
Cc: daehojeong@google.com,
 syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 18 Sep 2026 13:39:22 +0000 you wrote:
> A malformed F2FS image can enable F2FS_FEATURE_DEVICE_ALIAS without
> providing a multi-device configuration. For a regular single-device
> filesystem, f2fs_scan_devices() returns without allocating sbi->devs.
> 
> In this state, f2fs_dev_is_alloc_blocked() passes the device alias
> feature check and dereferences FDEV(0), resulting in a NULL pointer
> dereference during segment allocation.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: reject device aliasing without a multi-device configuration
    https://git.kernel.org/jaegeuk/f2fs/c/7566fec606d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
