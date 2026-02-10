Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB78AEB2718
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7uRV7GWULgdgL3etLTwO22NE8EshTkz20bI6a0UMRaY=; b=UMI5chSz4wuIOqmxm8H/qzG3rl
	M7vB9DgtEMZe4f5V0nYro3PM1zJJNuYAcCauq9fIkcutvTA9pyzCbO0HNmoOM1qtoeStVj4QX9869
	UrIfpn82HdM16xTjFSS8gDQARTaavb4LSb7lh4+kDgrYsWQoc8lguyJE1bSNqsGMc2I8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vpvHl-00043X-Bj;
	Tue, 10 Feb 2026 21:28:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vpvHk-00043K-5a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 21:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2F4inzl0Gx5mLesVHY4/NV8qevekRe0wLsJZnczMnMw=; b=gkk/EWT9V9qtYGtzgB60RSC6d8
 MYXt/Pn4KzSDS3Hc8RaXxZTVeGpKZS5m2Oe6cY+S38m8wtoYnqWmlV4YDqKe3OCiU5dIlsXod/pDy
 O22jPlZy2gaVy4W74ZDWekH2NJrelpk4sW2MaBVR+dOyGXgHHFJU6UsVdFQxkNdq9v7A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2F4inzl0Gx5mLesVHY4/NV8qevekRe0wLsJZnczMnMw=; b=K
 7PUEZtsVx2GZP48WHwadnyc3grbKMnGYCCW87LQYCIBFVcEr6XOn/aL1+azhN8PTTrPhqgMdJcPXr
 APbdCpPt+oYglGTgyqMQy0URbUwAidnA789XYjM3yhN1932ZYTb8xJpMdoS/IR/qDkGcl+a1JblHt
 gxmoCW+Nd7c5/8h8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vpvHk-00051R-CX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 21:28:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DC1A44002
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Feb 2026 21:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFA7C116C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Feb 2026 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770758909;
 bh=9Mk7X3e/NaUQxNDRyd27kvjgPO22yc4Q2rUd79tKtlw=;
 h=Subject:From:Date:To:From;
 b=fHxBhewqm64mg5kBFrsz2ZfOK88sYFLYNEtWEgKNBVnPNsgiPoNoNJGAOBZyD7fve
 cZL7sv0t8+mCFIkB2DZWI17Uud4KWzKuygWT147xDLiE6aSPTGPshvXARcKaHp4Mno
 9DZUHxo/hj57R47jppiSspTk147RF99M8zbjOjjGZ+Ml9txTBhMEFKuDUbVP3iOrhi
 ithXUdpflAlVuaHrybp6KnpDbytIPfYBCbEi+h8PqmDHBuTrEgY3kPPmmnGRIePvb4
 Vt/Vn9Szc+zK/Tp2zaWUru9DzBFYrc5bHVDHmvEncVqBXOWw840elkbuKbj2FBCAmQ
 ISKOM4XFgk3CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 4A63139E3B79 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Feb 2026 21:28:26 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177075890501.3671709.15696353512099715164.git-patchwork-summary@kernel.org>
Date: Tue, 10 Feb 2026 21:28:25 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1vpvHk-00051R-CX
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

Patch: [f2fs-dev] f2fs: sysfs: introduce critical_task_priority
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1050963
  Lore link: https://lore.kernel.org/r/20260204030501.85441-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: optimize f2fs_overwrite_io() for f2fs_iomap_begin
  Submitter: Yeongjin Gil <youngjin.gil@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1045595
  Lore link: https://lore.kernel.org/r/20260122104527.416871-1-youngjin.gil@samsung.com

Series: [f2fs-dev,1/2] f2fs: fix lock priority inversion issue
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1049210
  Lore link: https://lore.kernel.org/r/20260130132809.59707-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: fix lock priority inversion issue
             [f2fs-dev,2/2] f2fs: introduce trace_f2fs_priority_update


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
