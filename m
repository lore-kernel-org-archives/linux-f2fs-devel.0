Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC0C19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:50:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tpq4S-0004Ur-OG;
	Wed, 05 Mar 2025 14:50:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tpq4R-0004Uk-FX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Mar 2025 14:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCBTln0WSYmBdya9A3LqxmAnX4lHBg5liwzuWsPGwtA=; b=VE71MK+DgXEBZnYDAwCN08n8Rk
 R850ra+lxs2y5Ebe4idTHWVk+MzA7SiHTtMSgSoV2DbaJ8Y/3E8JsJCms3OeUdPa/dgxTKU/3kgW3
 37HGOUmPM/het2t4QuV1J9SfCfsMqSL1eZ0fFPVfHBhiRgWAQm4mnBi4FqJlLwm+Pmn4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZCBTln0WSYmBdya9A3LqxmAnX4lHBg5liwzuWsPGwtA=; b=c
 5D0addIUKRtefDwvo+zQ9JJ+WNJtxb+Tw37TSP+iYVHVbsPEwxp+E5leFwzcDjwdJuR9dLQgaEHXB
 U+abBwN3TFyDRfC2Fg1wYrO9DcgUoMW5BR/NU9NpcORI0qeHKo3xjKYQlvomedceWjW0sdiDsPLz2
 JX2E3312WjXqrl6w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tpq4Q-0006dW-6X for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Mar 2025 14:50:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F23F35C6A1E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Mar 2025 14:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3F6C4CEE0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Mar 2025 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741186196;
 bh=rZTpwNwDJT20Cf7aOAk5B+WKSyMHbldoJUCNMpJ6ZPU=;
 h=Subject:From:Date:To:From;
 b=sEePtnIWAbe8R1PyBhcACG8GD1WU3OwAgYOuLlQoc5JuVTZVCiHOk8HYVjLrW1Pj2
 Q0pv7HbP35HFsDOxlIPAw+j/HzZ1QP+u0LQMWOeySYE8G/17RbJW3ipvHKcDcvK7Sg
 k/xxwtfvmuP6XQCu9x+tcED/8dth0pXWUKkNRy24SE4YL6pvrcip+zTxdOyd3G/ued
 a78Q960YCNgIgCogbFGTXu5eJeBaeXsN3JuzoZeeM1a5GSza4DYiUHmsky0rpA7c7o
 1/quCsUgLhcYm/TJpTimsGDpGmTfHqEGQqWYBdf4yWPkJx0B6RE7DhJwLSip5EAsOv
 1X6jgGn/wMQ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B254D380CEDD for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Mar 2025 14:50:30 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174118622932.908551.8699636131152138071.git-patchwork-summary@kernel.org>
Date: Wed, 05 Mar 2025 14:50:29 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1tpq4Q-0006dW-6X
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

Patch: [f2fs-dev] f2fs: set highest IO priority for checkpoint thread
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=939781
  Lore link: https://lore.kernel.org/r/20250303221730.1284822-1-jaegeuk@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
