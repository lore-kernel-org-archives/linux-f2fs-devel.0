Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C80E6BF2F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q2qDwvERyDHfWe7d14jKla6Nxuu8xoY29hrnWDskeuY=; b=MRRiJbRPpasYXM8zKiarGvra5h
	3uyoQUpfxRBLPiSRZxWa2WJmChV2hg9M7L4bQ2cJyl0Cg+05qasiaaQaByzBIHoR3qvZWoIUPiI6g
	6klR1SfxfmZlPprq3Apt/nSjF1Km91n4k9fOYtVLr6AFjMAyMY/Nm1zq1RIuQHCnTSEI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vls0o-0003rU-Hu;
	Fri, 30 Jan 2026 17:10:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vls0n-0003rO-Ik
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 17:10:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=46Lg25Q1w4gLbomNEobayDxoxS+Ty6qfq3aNxxCjhS0=; b=Pd6jH9dAe8QW8NV8+vKLcR8zDA
 Azd572u2NMSkMzPjMaGwQnTtU5r2/8Y4+8g/WZtq7YOQOICrog5tA5jr+SLfg0txwRnN5cnmyfdx6
 s41Huwv+YZiYXpxs3ztD9rqNaO3Q4jQC2B9J3P0oh/af6vvK0i0oiBps4MANPTfB8aBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=46Lg25Q1w4gLbomNEobayDxoxS+Ty6qfq3aNxxCjhS0=; b=F
 0tkrJx18vq9nycokVcEAKMgRhIW48MHOd3u2UKsoWdjKKXpVwDiCsV1zTDuKSALNqdEsKZJPm//+T
 6G4TIB8KhzUG7/VbVgH3poGHTcpm0luDFuCPdrhyJg5CfAO/BJ69wt8k8P1VEwq6khD1DATf8Un+r
 zMpoPega2/5MPisg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vls0m-00055j-KG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 17:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EC3240118
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jan 2026 17:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F562C4CEF7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jan 2026 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769793014;
 bh=p9xocASvl+HIa4rQibvJP1Q4qtirOI4k8yby41mg8/0=;
 h=Subject:From:Date:To:From;
 b=fjWI3gMP81QzCh7wWbWkXTf4tGkqm4DrdDAQjVNmHiGczUIOKS84pZej67GdyyZzc
 4cE+bNoHsSfkQy48vyCAm1ugEmEhjZaYxPi0WpmsqCQnSO3qiQl0VMH9p1bMFk7wrV
 ZsRIQ9lj1LkgsjE4XXAnrt9eDC830WgvqGrEjb2qfaogEkG9N0Dpkx8L/SYNCKUmyJ
 jdeKmDc0MOt175S/F6ucqeIibXy82mNIEz6tsWZeyVI1v98Kd5cG18YvirXeSA/+pK
 e8xT/Efm+LTRFEp4PMjqTH/cBbTanp89mr/+RMsX1nfCVBxKQlZkf1hQTOHSzqhPti
 OxZLRZPdYl1GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 C8DD7380CFD5 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jan 2026 17:10:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176979300647.3449000.14961657819953361565.git-patchwork-summary@kernel.org>
Date: Fri, 30 Jan 2026 17:10:06 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1vls0m-00055j-KG
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

Patch: [f2fs-dev] f2fs: fix incomplete block usage in compact SSA summaries
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1047295
  Lore link: https://lore.kernel.org/r/20260126222801.2229197-1-daeho43@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
