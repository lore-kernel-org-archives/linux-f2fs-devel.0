Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC6EC05023
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 14 Apr 2024 15:33:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rw1qo-0005re-Eb;
	Sun, 14 Apr 2024 15:33:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rw1qm-0005qw-3m
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Apr 2024 15:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=srLPix37mAy/WG+stCfh0jISusTj3X1jQ3SA04XsN20=; b=iU3sY6nHa9avsIesQbx2B/kRqB
 IovI6GBjB6PsJOf0JRvF1kehViA/EGX8fjjiQ34WqpEBoHqhp1lAd4C36OuM1GHIsbslkj2GFBPTC
 frO01QzG+EzAWTiRaRPOZonFM9sphj2boVousICExZZxXR2uVp3BVfoT3NDZDs7FkjAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=srLPix37mAy/WG+stCfh0jISusTj3X1jQ3SA04XsN20=; b=Vo7yiVu6IKL0uq2IFdYQqWyH7Z
 Oena6ESSUFdDxY5ZLijolcFrVUdqhOeLEL0BxyyPJISd+Bs1fDg3HKePYeP3Z1Ubsv8UKaY/C/5fj
 5LdNM0+mvqnTzcGxParWrougyTgpe6oPwm/de2Wvbp1OD0oa8XZdlCnheSVpTMrtfMV0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rw1qk-0003Wi-W7 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Apr 2024 15:33:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E1EF9CE0979;
 Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 776BDC4AF1A;
 Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713108765;
 bh=aCUWzSW3nnOCWJY6Wih6C6rNM9RCw6Fje6P5C4uUrFU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=iKhHZbrH4yK4TpodU1SaUctxEHf4l2i9OPpl24g2y42r+srMG32IQb7O15I5WwA5O
 stfQvJK7KCywmrOcCPogx1ETwr+wuyAJJClGyyiidm/oip4xwXO1VKGCKbvrZUS7gb
 XhK1h0/Xw5Z098phPN6yoTFsUYoHq9ORfit6yziXZ0j7a16ECyaNYxI0YbJZzD39+m
 30OLMmoftHwUN2Y3Vs8FGbZ8TwZh5paVwpXobfut3a3QWUbbHi5d5209OKoe2Bvl9i
 4nCnV9j+IzXpRlx0aFXHpfem0YjJ7FI2rwQCXFPdFj3wDIGx/pU7cfBQF9fwAFOMes
 7Atl7NguR11Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 68FD9C43140; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171310876541.3156.7562582983890566171.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240322145955.2959257-1-chao@kernel.org>
In-Reply-To: <20240322145955.2959257-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rw1qk-0003Wi-W7
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to detect inconsistent nat entry
 during truncation
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, r.smirnov@omp.ru
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 Mar 2024 22:59:55 +0800 you wrote:
> As Roman Smirnov reported as below:
> 
> "
> There is a possible bug in f2fs_truncate_inode_blocks():
> 
>     if (err < 0 && err != -ENOENT)
>     			goto fail;
>         ...
>         offset[1] = 0;
>         offset[0]++;
>         nofs += err;
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to detect inconsistent nat entry during truncation
    https://git.kernel.org/jaegeuk/f2fs/c/92c556ed6318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
