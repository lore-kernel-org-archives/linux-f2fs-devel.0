Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B1C61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Mar 2023 20:20:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pboeg-0008Up-2U;
	Mon, 13 Mar 2023 20:20:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pboee-0008Ui-BV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 20:20:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ri/w87w+4BfajNTyodX+y/7hwak78uaDB2AT6JD45w=; b=hqpRT3Q42f4nUlfIwCeG2xJHfN
 FvnGYIXcgpqexdELPtvgWLu/KZek/4WCuo5OJ6b5If20eXTktL7qlACrCeW0+amstvzGIG/z28gur
 5sOaRsjad2oeKo6VzqDG2XoCDADY7rtBCZ0zsIM6iWXYt+Ag2c7me7a7WMXXc8xtG224=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/ri/w87w+4BfajNTyodX+y/7hwak78uaDB2AT6JD45w=; b=P
 0sS56oBbehp/JlRNYBcaZBnnuwoCTwyH1uf9JdYYtHy/lHqt3PyoWOqEQC0+EJoF5NBtiU+sMQKse
 Uh/Lyx4o0tUUqkGJqg7RoJ90II9cdfdSR1ALDiRKyv7LoUgmO2XBgcj6cYeYVata5eOtizrdlxBen
 gNXz4C5L7Fvm2Yes=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pboee-006lUT-8b for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Mar 2023 20:20:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CA600614B6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Mar 2023 20:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35FA3C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Mar 2023 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678738818;
 bh=wdHHFG6YIe1qqrBiSPG4zu7FztX1zw/l0P2hGgnMPts=;
 h=Subject:From:Date:To:From;
 b=HjzcbseiDCqDv54TqcaY3P4wcTAtX1fTsRhmBsROAZtPLKCsbfC98ZyTyGwb/aKRo
 8fJbxiWrk2YPU4U4ODEsNVZRVXTBdaKRWWd9YTPiC49/wgOWQHMXWPxPcc7sDn0Poc
 K164XehfoOu5Cnymef1MUPMi0ad+dNjk6iTnzRw6sdR509ZtZ1sM9LdwIfjaGUz8Ib
 pJeW1ms9K+lbIUTO07QtdNVvXLBpOAU0dO6qMy7GYEMAfMVotOMUFE6BNWSPpECe9i
 ZMvyGNEDpixd9inpFDE7Fjs6lng6TaBDDHyBSWQR+7nw/oTf6BuY8fS1U5CuDlmP57
 G6x9aB0YLrfpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1D96EC43161 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Mar 2023 20:20:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167873881806.1608.1390232262151178212.git-patchwork-summary@kernel.org>
Date: Mon, 13 Mar 2023 20:20:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pboee-006lUT-8b
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

Patch: [f2fs-dev,v2] f2fs: fix uninitialized skipped_gc_rwsem
  Submitter: Yonggil Song <yonggil.song@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=722387
  Lore link: https://lore.kernel.org/r/20230216074427epcms2p49a3d71b08d356530b40e34e750cc2366@epcms2p4

Patch: [f2fs-dev] f2fs: handle dqget error in f2fs_transfer_project_quota()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=723767
  Lore link: https://lore.kernel.org/r/20230221144550.46557-1-frank.li@vivo.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
