Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB2CA101B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:51:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sk8b0-0000l8-Ks;
	Fri, 30 Aug 2024 20:51:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sk8az-0000l1-I7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5/G0bWOXJgkk8p1XWZQEW3ybvU+hJmnIsKa6sp9ZoR0=; b=YR06p2xu6XbDW2poIG1W9z1OU1
 teA6xENTUZOxFUYAb4N1Zxypq3Y/NsT+5xkSahO5Fk124TUlw1msZb8bCXBRlVkRCMhHxcwbU9pnP
 AdEPi5o5tJkN3Q/zU+HsRgAR25M+xxfm21OjF/L0Paxqz+daKBLjcSfSXeEEIxhhFeng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5/G0bWOXJgkk8p1XWZQEW3ybvU+hJmnIsKa6sp9ZoR0=; b=RidxSrCfd6X+HyMofzERGP5hRG
 zt4S4wODRJ1OVpR6eEEMiYENLH1Qsb3yLP97T2/Rdt1iAkQHM8rd8S1qp0YCTvHrZTNxRxPhKYGES
 KN95bEArrRILpd2oy4AIIlWmvRs1geLV9kcnT1svswuNBa/rIqvfmsp4fNF2H1PMDu4o=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sk8az-0005mj-Lk for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F28A1A41ACB;
 Fri, 30 Aug 2024 20:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BDBC4CEC2;
 Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725051103;
 bh=WXxE0mTRDrcgb4N9+MYhxEZZT3OXqpBy5Yj1GIK/sfE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AXZX55nB//eD/NOzBJgg8vgYDlGecce3j4Opmo6QeZxK2+55tAruCTvH1pFMFC08w
 RbpRzKy4qrRjDPOmujoAoyUTO6S4oojTzlBqN3roFoDKgQUeUdhb4HmGcz8wbz+dLl
 +hR46pccjROMaHswb2Wu9TQP0jHR3NYZesv7FfeVDgIKBG6+3U36FEfIHA0ZaXgWiT
 hsOJf/KWfwof7mBEXIZgP6bXQTmFP5wLGL0+OpMz1f9ZK+Ptrz49/U1rVom0cK//pu
 ooYKUnac62epzEPLCdaXLLf24+aMOw/KRZ54XAfwZa8fs/FBn29t1P3md1KATYigVL
 86Kr2wsX62VzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70EA23809A80; Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172505110399.2712133.5128196263519102281.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:43 +0000
References: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1722476031-22106-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1sk8az-0005mj-Lk
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 1 Aug 2024 09:33:51 +0800 you wrote:
> Use F2FS_BYTES_TO_BLK(bytes) and F2FS_BLK_TO_BYTES(blk) for cleanup
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/checkpoint.c    | 2 +-
>  fs/f2fs/debug.c         | 2 +-
>  fs/f2fs/file.c          | 6 +++---
>  fs/f2fs/node.c          | 4 ++--
>  fs/f2fs/super.c         | 2 +-
>  include/linux/f2fs_fs.h | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up val{>>,<<}F2FS_BLKSIZE_BITS
    https://git.kernel.org/jaegeuk/f2fs/c/8fb9f31984bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
