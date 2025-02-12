Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA8C0219E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:00:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti2zC-0001nX-P9;
	Wed, 12 Feb 2025 03:00:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ti2z9-0001nN-TU
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n2CRfA3Fg/E3w3AclExIBdeswh9xS0HJyvp4fmruKPs=; b=PDltM13g997U+EerDg3j+2CR/u
 zKXbnlA5CuNQTB337dOWxAO79IJyW6eg4apN2zdy18zf1lZFProganSktUfcHg6ee91vPs89ILnlB
 2X8TMXHNLOQwXM9bAcnHd+GCnjeCzXifVsrTqvjNwVuBZ+UUR7RkiyrGHL+U4KR5AyBg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n2CRfA3Fg/E3w3AclExIBdeswh9xS0HJyvp4fmruKPs=; b=Z
 7/3i1k9YvfErW1NQOIu6cK3h/beTBVFXw/OnXM4QPl2NeOnB+BcLe7PbTYCoLpxQtEncHpCuoeGGn
 bFocMObr0hGH+GkGUNxbaeLFtP0ws654x5vcw4jcfjL3xbPxhYtKpfPSa52fB6daMUv0P5KB4qZ43
 hxtvbRfpgfR12ja4=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti2z6-0002CC-8u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:00:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28584A40EEB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 02:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45702C4CEDD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 03:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739329209;
 bh=z28u0LksvZp5sb8TYGa2PGyVWFMKJdqExNoU9QeFHpg=;
 h=Subject:From:Date:To:From;
 b=qltxLNoVv/eBJoZacBjOGeXkL2koBDVOoM959Z6wtpwCl5YNIGCycyoJLbodSqVbH
 lAhACQi9ujiAQehOcHDV6+vtg5i2RS8GQKTn0xzKq1ELKNr0Jb93gInL0uL7NmSXWk
 7VAtoHh10wK7RqotKTff3awxY/GvL65gtpMMNA3lWybe7NM84XkL/8Q8WZNQ3mreNY
 0Y1+nNoXGs8750MlBcKywriASREKD7dI8e0h2fMCqKK8RMYY5mwaHVJXKs2ZiJ7ST+
 OybhsGq5NCuJhAPaAlExZFRvr7NvFYi4Yfsayjqurh39Kqqq09uhX9WX64ZfQFwgNn
 gF5ZAfIRx92vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A877380AAFF for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 03:00:39 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173932923766.82998.17919721663275604798.git-patchwork-summary@kernel.org>
Date: Wed, 12 Feb 2025 03:00:37 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1ti2z6-0002CC-8u
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,v3,RESEND] f2fs: add check for deleted inode
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=932638
  Lore link: https://lore.kernel.org/r/20250211071725.457343-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to avoid panic once fallocation fails for pinfile
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=932637
  Lore link: https://lore.kernel.org/r/20250211063657.405289-1-chao@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
