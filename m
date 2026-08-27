Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE5C5DF9D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a8zDqGo8Sy/NmAPQ3is/UHoloBZaZlGa9rm8SOUctZw=; b=LsB0QyvM6uykMa24ItrdqHPtOv
	XoD8yNruoqQmsTarYGr2TTuU4Aq/dwVEBYq1gCe4BizbzppyyNuqywVBcxxpdheo+jmZCxYBPbDs1
	D/mhOzfzWO4Za+jITuHbPpx5RQExtdLuVU8CNX2drJ6llgwDZJNZS7DPF0Egvf7+Jihc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzS4z-0003gz-U5;
	Thu, 27 Aug 2026 04:51:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wzS4x-0003gt-QI
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 04:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uwIrA+EdeXY/4dQqQoC225Zbj528mnha7eUjxRlSA/U=; b=fa3EEII/xly2Gtjn3lUR3FuOVz
 JHOI+FMkF+XMEVDeAHCChuEpWNZ9fG/6HPAI+/RMbSHwfEFESOErPoM+Qt/TT7ZAKZuX+SxeRsTyQ
 xRqYI9m9Qqef2up3cSJa43f0hz+uRsJAAx06cC7gVq3mHCNoxj1b6hhgKtSDVLQE60sA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uwIrA+EdeXY/4dQqQoC225Zbj528mnha7eUjxRlSA/U=; b=h
 x6dgzdtU10AMwpenmEuAXpSO4++FGvMTnl+aghiMb/lWuCNhVFK/b60Rz1aGnucfxvheasZkdYm+0
 OG0IqPed4DLreNEMx7lQXnj+rojfFH38V7ELKfEYZxKweDUnNEpoF6qvZZzGi8jj9twDJqZV9Ywd0
 cU+QGNB3ZhrIyaGk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzS4t-0002nL-Rd for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 04:51:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C9F2411D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A031F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787806258;
 bh=uwIrA+EdeXY/4dQqQoC225Zbj528mnha7eUjxRlSA/U=;
 h=Subject:From:Date:To;
 b=K3KF8iwTi6Wn4z6Q/6AE8PIRo1SeF7pdgSWZTPbEPzdj0CMboTfr0YpHtt9zPY9LM
 Ppn0Mt0SYdoIkUzB6OGb5IeqZEJYuSBtOX3O8mmKEw3zb/1HNfXFFh5l6TXFRGyS76
 KbPsacVC/Q6JTCOi4kS+3zu9lc9YSFGsRtHEj/WsNDqBAhyN0c1a/qyLr5fDENBjLx
 7PJywmKcpvZDhFLamOmLAr9zJmmyHlxTYC8W35q3zveFl2DiLoItphSok9JfA6AS1Y
 6sfBfnErpepFQ97cIo7vTr2X2MtDvDBj2R6wPsgezGXkMLgmKNe5Zp7Xe3hT9PcRqz
 xK4zKxaUG8fLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 594B93809A09 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:50:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178780620399.1022614.10993788388434564954.git-patchwork-summary@kernel.org>
Date: Thu, 27 Aug 2026 04:50:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzS4t-0002nL-Rd
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

Patch: [f2fs-dev,v2] f2fs: support resizable tail section and unify pinned allocation
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1152164
  Lore link: https://lore.kernel.org/r/20260826153644.3726384-1-daeho43@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
