Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF9C02183
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:10:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYtbi-0003xJ-MT;
	Fri, 17 Jan 2025 21:10:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tYtbh-0003xB-8v
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 21:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qXnIQvqF/MbM3gJxPg3f3Rjwzd+4A2FVo2vQoiKtypA=; b=fMMK720k9yTtsPhklHDHqGJ/tm
 GbN0rzBRGNDYO/uIino+BH27xgaUO2C76bZS8AuxuAeLO1/oxTbyiTWboue+Aj5NvtsSqKGVTBgqe
 J/vRuXt5MBkb7cm0LQHaS+rPkoCDsSLTjD4k9yNW++b66OnlJaNawhWE7/bTlvM2QAug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qXnIQvqF/MbM3gJxPg3f3Rjwzd+4A2FVo2vQoiKtypA=; b=Y
 jzkWfcThiibk5J76JcSSBD+7YfRd9lDb7z+qm63eV56k1o0WcdXzBSuggVqNkEnVoovqtFxx3xqEa
 Q27NMGRvLRJXgUAz4QTaa6+fS8j1gDBBS7+KZb+Z2AHyalBk5VgMuoj7ss3dntFtmGzsKflnE45Gx
 6WEAvgz338DIteH0=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYtbg-0006mi-2U for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 21:10:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 793A2A43421
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Jan 2025 21:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EDC4CEDD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Jan 2025 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737148209;
 bh=SU7DMOy1TeMkvIAU1jnEg1Aq8cqYCNml5dT/yVi1dgQ=;
 h=Subject:From:Date:To:From;
 b=IR4DuNXQFNGvGY06qTRLeRqIP2xH0hrJ97U++gIg7jJ4TR7fw5BOGFvwXLUYiRVGj
 Qb6m9m82ir2tmKluhWzQ5Z3k2mUZ4OrRHzia9q4koK1emQS9ESsFYulQaz2JqO6Rxh
 X4ypTwv5lLAUic/U8pMkWfKZuhEEOeuEbJM4vjHflK1j2chRXrOn1O3jOQYKcbi6ut
 62G1HUFM71px5EuUX4PNwf5anpTVu5yi5Z1DirR2Ng+TTd+pe8ZcWaJBq3AsKtk/Tk
 db6QsuZMwUmBXs/LiCfeMrVxofVoF+L1lF/xrKqDNElmJAy9AuA0cxx7Q4qrKSshrw
 JM/hespVVuExw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 794D4380AA62 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Jan 2025 21:10:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173714823199.2259050.10886787317811350524.git-patchwork-summary@kernel.org>
Date: Fri, 17 Jan 2025 21:10:31 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1tYtbg-0006mi-2U
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

Patch: [f2fs-dev] f2fs: remove blk_finish_plug
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=923485
  Lore link: https://lore.kernel.org/r/20250108181908.4148111-1-jaegeuk@kernel.org

Patch: [f2fs-dev,v5] f2fs: Optimize f2fs_truncate_data_blocks_range()
  Submitter: Yi Sun <yi.sun@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=925539
  Lore link: https://lore.kernel.org/r/20250115053943.2450661-1-yi.sun@unisoc.com

Patch: [f2fs-dev,v2] f2fs: fix to do sanity check correctly on i_inline_xattr_size
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=925249
  Lore link: https://lore.kernel.org/r/20250114123410.29123-1-chao@kernel.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
