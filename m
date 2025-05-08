Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD83EC3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 May 2025 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZLKoDRiVAE4d45C1SV2tiaEIknf8UnE8lELv9VdbmXU=; b=VG+8Q69IlzBe6elnahDWRkhUSi
	Pv/cN21LQ9PFOvG8v7uf74MoCzahRhCATPPTf7sz/J0j3gG+TFux6Z8zmhLfwz6J8paZUMRKY4wA5
	oD3TWo3VfwvgkbrvJSxnudmRwr9NP8kZZQbq82oaF79cvZQrl8cN8uLH404U1o2A42rM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uD48N-0005X8-F5;
	Thu, 08 May 2025 16:30:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uD48M-0005Wm-9b
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 16:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+sldNSfq3s9NKTCHsGM9kRvGY8i+rNReJmMOigzkNkg=; b=PeP9C9971HfJSbDnCtxIyil6zD
 aeFlSl/t8A1Yd2D3/mHcmBuOEmjOrQqIo0GjiPhjr/hQhIF9thlEuQs+y8PSCspAVXrKRtw9JFFYX
 VFDtthqMFCcmm5VjAwTd4XbvPGRxGWCF0B/Uk0UL59ndYOoCvumAmGavH1uZ5JmNS+F8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+sldNSfq3s9NKTCHsGM9kRvGY8i+rNReJmMOigzkNkg=; b=R
 JURKhT4+a2oznR92Zcy5sG8dWk6hHUCDnRNMcGpGDiHKH8BagtaHfaFpfFMMXBptXbiajDSrQWtpl
 xOcQWNAV+LPOgHP5yOfk9jOzbhiIB8gldFp1awq19I8S++COEDteLY+7zXD/SFGloDPy1POmejY3J
 Hlf/75z1cP2+4Sp4=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uD48H-0007fC-FT for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 16:30:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C0E10A4DF17
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 May 2025 16:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D68AC4CEEB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 May 2025 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746721790;
 bh=oCeTEL/+ZVNSZKErwBEfuhi1lMUuBM2mu29maT2vitY=;
 h=Subject:From:Date:To:From;
 b=IByBkzsFjAiQTNYVKJLsQ/kfHsruIlMtMbisliTEmGgX8VlRsKTOko1kTeDiza2jw
 y20+ws793z1uMhYkUcmVD7jqqHuLQLyH1pUCWveqnXcz9WYIESUAdiIur1NeygyLcs
 QvcdDnYjkUVkS335Yw0B1H8MLZ5B+dH8D3fBQG6BtvnBi8SM8J07iEc+8+Yk2lQKS5
 f1kJ0jvSur8cVXvdb2FJFEl82UkJ1NkRtNYfD/QT/WUkoPFuhf2Pgs5LpgzY2ttaS/
 10EbeR52Co0C19QTr9MoYYjNnrCB3GQrm5rty8M42yO81UhBS/PZgOr102/mTftDvV
 0ouUWov9rzIgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3884C380AA70 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 May 2025 16:30:30 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174672182880.2971823.18131435625682656319.git-patchwork-summary@kernel.org>
Date: Thu, 08 May 2025 16:30:28 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1uD48H-0007fC-FT
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

Series: [f2fs-dev,1/6] f2fs: fix to return correct error number in f2fs_sync_node_pages()
  Submitter: Christoph Hellwig <hch@lst.de>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=960745
  Lore link: https://lore.kernel.org/r/20250508051520.4169795-2-hch@lst.de
    Patches: [f2fs-dev,1/6] f2fs: fix to return correct error number in f2fs_sync_node_pages()
             [f2fs-dev,2/6] f2fs: return bool from __f2fs_write_meta_folio
             [f2fs-dev,3/6] f2fs: remove wbc->for_reclaim handling
             [f2fs-dev,4/6] f2fs: always unlock the page in f2fs_write_single_data_page
             [f2fs-dev,5/6] f2fs: simplify return value handling in f2fs_fsync_node_pages
             [f2fs-dev,6/6] f2fs: return bool from __write_node_folio

Series: [f2fs-dev,1/4] f2fs: return bool from __f2fs_write_meta_folio
  Submitter: Christoph Hellwig <hch@lst.de>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=959577
  Lore link: https://lore.kernel.org/r/20250505092613.3451524-2-hch@lst.de
    Patches: [f2fs-dev,1/4] f2fs: return bool from __f2fs_write_meta_folio

Patch: [f2fs-dev] f2fs: fix to return correct error number in f2fs_sync_node_pages()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=960362
  Lore link: https://lore.kernel.org/r/20250507080838.882657-1-chao@kernel.org


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
