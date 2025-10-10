Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810D1CCA476
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k10fbDjTevEyQMl7+Bmditc77Lc0TPD56nXRHr3MtLI=; b=c/D5+FRy5sj0Qc9RoDriydbGIo
	a0179UeuXtM5kZmOzotHRQnyqTWCScKdcDIIeW+60S0wqTl0BLEWXVr90T2TUo1RL5lxXLYTY0tKL
	qx3nQtGeVfCBFX2shCzX2APguG6zSXORNC+28te5iD19t1VUXjxSsOI8/S0C3IkVNcrc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v7FhM-0001Or-BH;
	Fri, 10 Oct 2025 16:10:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v7FhK-0001Od-ST
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Oct 2025 16:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xosaZkgzhPC2GDhnsuQJ76yjIDs1xv2M0RyRCnVxHkU=; b=I3lTFXyC5kafEEuPGpI0uUm/b1
 IPe0fwy0UESPmfHnBIe1woHHuwfyyEa1aCDWIVnJPsV0Pn4GhfjjSoaVOHYzPUwmafD423Nbmcby5
 epDnF0vPn/uYYEsB7LSpj6kaxqf8kU3b7xaXM5YlFstO2h+pcAvghaztQ5CJ8ii6LPlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xosaZkgzhPC2GDhnsuQJ76yjIDs1xv2M0RyRCnVxHkU=; b=G
 v5KF0N2WaqP/F1Gchd5r+Rs92+uIVDyElckNwqaOftuNxB0vX2dEuW4HFpoA54Pb2FqojQ3Lz+xEP
 rIRFiSu7P1DhZY8CYilwk76ZGAKbi5NJoSQ48iyDdRoQYOtiLdCG82z9lP+9P6l/LR+fmUiKf0Off
 yRJgEoXbKAgEdG5Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v7FhL-0002HW-5R for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Oct 2025 16:10:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9AEF40278
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Oct 2025 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9903EC4CEF1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Oct 2025 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760112616;
 bh=acLEroAyfvN1sT+KwiT1EhoFkWvtZ1uhDbu1WUPnqMc=;
 h=Subject:From:Date:To:From;
 b=UstTxawcgQwJbF5G+o3ZvfwAWEEJKrtv9n0ZXJ9H+nBrHlcINifWgNHQB7UqDgWSC
 EcIaCG4v39o9F29AyDqBUdHusYe1wu8xYDPT9ahRKSOgYd3wRDxl3KT+5J1pjQk14a
 NgI9mnudQti9FSf/VmOnGZ79L65uOC7q2Dnoq1CBq+lEjCbspXhiw1dNcZMRP9Gxz6
 G1bJXrpQqgyPMO0k82J0bzyPL373HLYHEta142/FYYqruJFozBsKvyRZqfZ4Wn+Q2I
 PLaHXjcTBtoj9IAD9rZoiduLmP/8niLnJbI7CDsS85fqRMYpxNizNr9VszI746wI+L
 INDK46fFZgXmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 379283809A00 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Oct 2025 16:10:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176011260369.1033062.6745234042967692226.git-patchwork-summary@kernel.org>
Date: Fri, 10 Oct 2025 16:10:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1v7FhL-0002HW-5R
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

Patch: [f2fs-dev] f2fs: fix wrong block mapping for multi-devices
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1008885
  Lore link: https://lore.kernel.org/r/20251007035343.806273-1-jaegeuk@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
