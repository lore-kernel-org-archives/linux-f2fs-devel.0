Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D024C77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Apr 2023 18:10:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pr0dy-00054k-CC;
	Mon, 24 Apr 2023 18:10:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pr0dv-00054e-U4
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2nqBCm0PvJ2aVo0sjV4eYxneoEx5j98XaM+seFxdKlg=; b=aWd0jPMuKHUPHu7x5Jsh0ttu3o
 jEWuFNOjY30pNSlwRD5L7WZ3cZ1D84QkIScJWID7X3lBSKRGjumoEvXizyN8wXmVq6u4KMviF2tRR
 13kEZkP3aQ2k+vdxcNsa8pv54ZknV/z8itvrN8AuiQCudUYOGCbQ1hXNOuSvrJWCSsuM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2nqBCm0PvJ2aVo0sjV4eYxneoEx5j98XaM+seFxdKlg=; b=B
 uyQ2eKlMTL8ENv5fBQ6n+cP6V9DvwyXna5iFdrZeCUweydeThS+xIDZ1OdeUHsWM/J1n5BTS43YsX
 lANC/HdS99X2iEIIg6I8WjUZMQ0VoBIrbxqhJVquutCkq2ZliO/phlXBbseln/Uc0q8B/L+9VeXHC
 wT4d/XNq1r1qq0y8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pr0dt-000FAg-DO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 14ED0622EC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Apr 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732F6C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682359819;
 bh=xz6azwOZ29qS4bSYMEgDy1PDZ+mqPdbCaj7B4msFbng=;
 h=Subject:From:Date:To:From;
 b=tZwCYxMRmwGtysLzgE3WD1ubKR9ufU12NsJPx3uWGQyTIzjLv62o9QUFj3d7NmKeq
 vYhUyvX/Z8TqG9Y88eGwoQg1fBfrgwMAyOPnRNPl6uAlbuSe46wCQ9z14/rPS1SVMk
 00W2X8k/D9CM9y75HXcWwc2K4XBDzlyOvkIV7YkcPh0EA6xP9PB9mJXNuBoN8/8weT
 0c1uWYqrkyEWuCYw3LHMDaGiZDrKCLcvAhqF0k6Hx0P3nDUmw1rj6PPoN5lqjnVjQ6
 0fZN2lKdZInvWopBxL/IhEGKtjl2Yd3On15O20Nz8R6EU4zjIUpRmXCwZSlapI913Z
 qE9Yydu0KnYDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 55AF6E5FFC7 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168235981924.17900.15684685287298771247.git-patchwork-summary@kernel.org>
Date: Mon, 24 Apr 2023 18:10:19 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pr0dt-000FAg-DO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: remove unnessary comment in __may_age_extent_tree
  Submitter: Qi Han <hanqi@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=740765
  Lore link: https://lore.kernel.org/r/20230418060954.67585-1-hanqi@vivo.com

Patch: [f2fs-dev] f2fs: allocate node blocks for atomic write block replacement
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=742790
  Lore link: https://lore.kernel.org/r/20230424154440.23279-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: use cow inode data when updating atomic write
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=742789
  Lore link: https://lore.kernel.org/r/20230424154348.22885-1-daeho43@gmail.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
