Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8A2C47DA9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:29:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUYGC-0006pt-PJ;
	Mon, 29 Jan 2024 20:29:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUYGB-0006pn-Om
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ul/bQa+S0MF8W6b7qHQn8wJ+kUSGqEBAUkNclHG5I78=; b=K9+UJ/96iBiErvYXessQLCH/gN
 Pu5QFQb9zrhwRo80syjYUyAAHl2tMCrTE3AeuB5FwW6+Ewxb6IC9ze9TI+m37k1JSqiEuy1GZ71PY
 HHQyORiHzlW78VC8Nt3DxToDgq/8uHU9i6jT88EKPofYPoFxfrZUbuGdMDktE18vbt9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ul/bQa+S0MF8W6b7qHQn8wJ+kUSGqEBAUkNclHG5I78=; b=V
 VgSAHIgBqdQluUEWMzuUvHXCRov0e1tX8OIt69QUeWvbP5cRw7ja15MzftDAbHxtS70C5hJ4MN9WF
 3UMGRfCb9Z+/uwpEI98t8gc1ubNaAY5rlKbI/SQlKyOLm96JJbvQPxpE1h+BCjunlb7bBQiyUVCmq
 c8YcagajLOi69Qew=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUYG9-0008Pd-MT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 938EACE1770
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D62B4C433F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706560170;
 bh=5qFZmz3SXvstH55jw+5MZCd0jNY4lvMA1PGrTVeRFlw=;
 h=Subject:From:Date:To:From;
 b=ubtFJ984+ffE7nvv3d3E6H4WDsE2sOxPEqRcquTxiJhoZLpuwtKJ5Y0L4K1xNwtry
 V7UesdCs0wriznYxd8S1jOX2Z9jRKSZsaK9h5yT8TGT96DA95F6PnUz5w8G4Q5e8H/
 fRqVSbP//cX4/vPFRIrmIQiOWL7EGkYfxT0mWiSB+tvMJkgAKzthlHw3dpRegCOXmz
 YcCXkXoIy77Pl4M3cmJU8Juj+DRSFQaNJqloCN0Tnrrmp651SU9dngRJmDozqacwZC
 52ZvpfRmiodWutsbIUbNJLsI/JVDPKAIfOS5gSTTOdIK+ieOjAFSEbHZXX9CeD16gm
 pkUL/7e8sSqPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C080DC43153 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170656017073.16041.15814921083341624356.git-patchwork-summary@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rUYG9-0008Pd-MT
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

Patch: [f2fs-dev] f2fs: remove unnecessary f2fs_put_page in f2fs_rename
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=816566
  Lore link: https://lore.kernel.org/r/20240112171645.3929428-1-jaegeuk@kernel.org

Patch: [f2fs-dev] f2fs: check free sections before disable checkpoint
  Submitter: Wu Bo <bo.wu@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=813294
  Lore link: https://lore.kernel.org/r/20231229032507.2016012-1-bo.wu@vivo.com

Series: [f2fs-dev,1/2] f2fs: support printk_ratelimited() in f2fs_printk()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=820290
  Lore link: https://lore.kernel.org/r/20240126151917.837565-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: support printk_ratelimited() in f2fs_printk()
             [f2fs-dev,2/2] f2fs: use f2fs_err_ratelimited() to avoid redundant logs

Series: [f2fs-dev,v5,1/6] f2fs: compress: fix to guarantee persisting compressed blocks by CP
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=816638
  Lore link: https://lore.kernel.org/r/20240112194132.25637-1-chao@kernel.org
    Patches: [f2fs-dev,v5,1/6] f2fs: compress: fix to guarantee persisting compressed blocks by CP
             [f2fs-dev,v5,2/6] f2fs: compress: fix to cover normal cluster write with cp_rwsem
             [f2fs-dev,v5,3/6] f2fs: compress: fix to check unreleased compressed cluster
             [f2fs-dev,v5,4/6] f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
             [f2fs-dev,v5,5/6] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
             [f2fs-dev,v5,6/6] f2fs: introduce FAULT_BLKADDR_CONSISTENCE

Patch: [f2fs-dev] f2fs: zone: fix to wait completion of last bio in zone correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=820833
  Lore link: https://lore.kernel.org/r/20240129112740.1908649-1-chao@kernel.org

Patch: [f2fs-dev,v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=817224
  Lore link: https://lore.kernel.org/r/20240116141138.1245-1-qwjhust@gmail.com


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
