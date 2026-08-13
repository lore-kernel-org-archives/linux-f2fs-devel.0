Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79132C5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nfMii/fN63ypgUU1RBGrNRIDVhKIEI58ZrA6Sc0+jFg=; b=bJTMfkGVax5k70i3js1JDHs/DF
	VTV1jrJKtUvsUtpjL8ZXKAvEK3qlhQfNfq5Y5b+uI0sCeCCwrQ4PXRgUnk7jc0AeW50hpzBgTBv4O
	scAUB1nf4f/Q4L/Dj6cKkRZgfwa4R9Ld06waOsjHvO3hEBZhD3J0DlNhlmaqZPTTeWNw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuXsq-0006OI-UZ;
	Thu, 13 Aug 2026 16:02:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuXsU-0006Nr-RD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6nSSlgS9yjno/MV8wcUKj2eHSzdqkjxNNzGrrUTnfCo=; b=jlha+suTdrX64HrNzV78fprLvn
 UNYX/+mk96qxk6boSL97JqGqcndF4t8BCH9MY269hKqPMyKURLOpnp3tMD7+dhYI5I/lfwDwrZPt2
 4L5AhbvsRryA/9dAxMtOEEPZiZ6dtlDBGnQJtCED7dxqdk10E2DIbatN7DgZqP1VdpAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6nSSlgS9yjno/MV8wcUKj2eHSzdqkjxNNzGrrUTnfCo=; b=H
 oTeJUY0Jywj7cWrmHsFs38sT4bPzsr8hNBvU4Z61dBqAmxBVzyWZ8MRSpLffw5f1np/Si2CHmFVXB
 gPaMK5XD2nTiUyLqZad0vFP4zCItCQQ2m/vR4vzkuNsF+8UhkMmvII7kvAumKPNFQEI8+a34u0B9w
 A02adKoht45Z851U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuXsT-0003G1-QR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:01:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E35EF600DA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 16:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3E81F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786636911;
 bh=6nSSlgS9yjno/MV8wcUKj2eHSzdqkjxNNzGrrUTnfCo=;
 h=Subject:From:Date:To;
 b=a+Nvl0YJjJn1oRxSM9zyUmQREYvqE5O82zLyTpSOvWuUtuMIlGBbMM6+c+dCtbtDG
 X+xiYE2DbI5hyuVqusTZVxHSlSLqavEU1WfmI2TXFwaxO79dvimzDSLoTykBIrLeVN
 EyJ8YMyr0OkJ5NbH1WliSNZ0BuXKoEkp/YVdbwNSj7/DbEddp37ge/Pn8oV3U2bqhF
 sfS582RPEd/JKZSNCSHmjKFMcmfPK1o8RylvxMiwGl5C8oBkSd2LF/o4CYHN1FYakQ
 Li9tPl5d+Pr5DH7X8rYnV/oVVYg9ConaNXchMtZ+X9MpLqqQb8zXJd6t0/oMffQKx/
 BmNAve1oL1bXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 963AF380CEE2 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 16:01:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178663686625.2934858.17795985632355526705.git-patchwork-summary@kernel.org>
Date: Thu, 13 Aug 2026 16:01:06 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wuXsT-0003G1-QR
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

Series: [f2fs-dev,1/2] f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1144704
  Lore link: https://lore.kernel.org/r/20260812122008.281434-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
             [f2fs-dev,2/2] f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode

Series: [f2fs-dev,1/2] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1144703
  Lore link: https://lore.kernel.org/r/20260812121756.278690-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
             [f2fs-dev,2/2] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()

Patch: [f2fs-dev] f2fs: fix to propagate error from f2fs_sync_fs()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1144705
  Lore link: https://lore.kernel.org/r/20260812122043.282195-1-chao@kernel.org


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
