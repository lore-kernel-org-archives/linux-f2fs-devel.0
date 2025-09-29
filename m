Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B5CCA46F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThcxtvCpmwbtd54laupYGYkivrBV/7zd+8O5EpHNXfY=; b=JcFOFGQCo5GI08ealnBx1nQn1O
	4BJ4hQDnaorJMhnFt95BPcjsW0+6XA6hyFnYE/UpsZd8nl6HatZWF1bNTeG/xwiU9DIEKnbBLAeKa
	6JA1G1eMvL2MDVLQq/9yYsCPn5qLvr19GWxknf7og2EPfUrmWaZXmRTy1nZFV8KviuP8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3MOP-0007XU-Qo;
	Mon, 29 Sep 2025 22:30:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v3MOO-0007X4-5d
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SH/E67tpYODbmizefBXiZU8kG3W4dxyE/E7jVvChm0=; b=JoGuWMWK1CJrTa92ycu3R01bme
 MZn0DpcbVGiRg0mMEHfX7qvfYMFB7g6KcHpnodsYFiuXZOrArpe+pKB3nBXKwbevPpQCMedP1Te3Q
 LEbO3tZXtVekdsyMBo1I4t/ydFVcaWWjLqVI+kghjAvi7zTH0gB+1+gIj0DOIqtV0jhE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SH/E67tpYODbmizefBXiZU8kG3W4dxyE/E7jVvChm0=; b=UlvsC6sQygv+VntD37d6+CF3up
 YyhWDPEBrpueY+n2n724j2iQJsMNhquzzlQ2OKq9R+1TFov1R/rOuHwQcB37yMag9qBT/oYnE5+4g
 UDpVTflFie64xVYgD2GEsfoE0Or3pKr2z+r7ac6r3PaXM5iiwFGbGwmhzXetaPnNEdkU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3MON-0005OR-KU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F22FB60280
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE7C113D0;
 Mon, 29 Sep 2025 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759185036;
 bh=G9TiOjCPerDpwIRRsRGWiZgp2hDuJO0vOo5XGhLYi/U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=anEYKVYcn8rF+spwMkVUp3KQ4mAJ6zrMMe1pAaso3o9hJdW9l8gcup+QSEONNMUxF
 Mi+6BFNzTb+aqPk0eWG9OFQwiTWivw3XbX+gO8MYMlF4u7lLnNCy/L9Z1N89PkQCbJ
 eiptXTIJBoBZrZtJUOVTQJtH35Ff4HhVvAqMb8HF2ZVSnnl0GgpEB99D7DH6cEEIoo
 1xLC3Mr4epnWjT+l61lX2N7uTP7MfuWw49EKlXPLbEmqmkw2MneZ+rEmKOqGtfsyuN
 Ft/gCy4JVluTB5VekBAtw//aoYb3gkHyytKRhjhWrGGTRXhQkQ0OmBjH3TWzrBB3aV
 YEJbUO/oAu1Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70AAB39D0C1A; Mon, 29 Sep 2025 22:30:31 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175918503024.1733438.12651094031657355399.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:30 +0000
References: <20250912081250.44383-1-chao@kernel.org>
In-Reply-To: <20250912081250.44383-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1v3MON-0005OR-KU
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to update map->m_next_extent
 correctly in f2fs_map_blocks()
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

On Fri, 12 Sep 2025 16:12:50 +0800 you wrote:
> Script to reproduce:
> mkfs.f2fs -O extra_attr,compression /dev/vdb -f
> mount /dev/vdb /mnt/f2fs -o mode=lfs,noextent_cache
> cd /mnt/f2fs
> f2fs_io write 1 0 1024 rand dsync testfile
> xfs_io testfile -c "fsync"
> f2fs_io write 1 0 512 rand dsync testfile
> xfs_io testfile -c "fsync"
> cd /
> umount /mnt/f2fs
> mount /dev/vdb /mnt/f2fs
> f2fs_io precache_extents /mnt/f2fs/testfile
> umount /mnt/f2fs
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/869833f54e83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
