Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F3FC282D1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:30:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1to3GH-0003Uy-77;
	Fri, 28 Feb 2025 16:30:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1to3Fa-0003UR-TO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 16:30:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWpXOCBBD7nYY0+PAJiK/7RiCTAiua86r5jW3QGrWsE=; b=QiVtHaWtfHfQ9jNhMxD5oisK9g
 Tm6yQUz0b8DSUvivCxhDvczHd5IUioCqFuqzikrT7ESWXDhxok1frcKiHgLcr2rJ1NOdc5qyBrLJh
 EYIWHDO/IRjwNAVY9WY9huj5q3RyIThWmxpviW1pV7K4pTe2rmHBf2V85TqmFe2BBVFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tWpXOCBBD7nYY0+PAJiK/7RiCTAiua86r5jW3QGrWsE=; b=N
 JMr6BrORGyJE9BFa+gqTsJWoxd/yqUdrg1DZB9se8tYMWe/DNiMBj7vJrEzYIW4bQQaOniluFDWKn
 +HXQY2rOMoAhU57iXyclVWqLB8XMuUc/kmC54L5SCTb41PovCdlD6Zd9CTsN9arp1q6b8BZcTlC/o
 4Iyx9M5QBCotwFhQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1to3Fb-0001bA-2M for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 16:30:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CB92861FAB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Feb 2025 16:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38972C4CEE2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Feb 2025 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740760200;
 bh=gl6boC/YMzKUGmpa3KuxTKI7w75M33S8cf9u3w8k3LU=;
 h=Subject:From:Date:To:From;
 b=X3vhCvNaX9gHzHapglqxQYiNsD77stlpBm1s0oNN8SlEgnyWOSEsZdXYyaXmT1sYs
 aERLnfNVup/MWtzXQfbe/tVaMMR5rbtEnmh4a7isXNgcY5Sauv9mFlc+LgzsZRHTa7
 bPUJairojRGZxwi2ToMOA5CYh3e5fDcfxnTpAkSQ2msVRSS4rWhQz+G+iifDfj1uQA
 Y3fu7OICabfq1UMjIaerHIJNUx1xB5Y/bXtCmGFaVtVENqqfGFROL12aumja/JEz9M
 tWXQ2Bx/Vc3Mh9REQhgLDNpGYqhSbqCbXF3AWqFF+/8IZ1IB/f2Td5MYalyKKWtj/y
 ZF3+LzvnvAQ3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7A3B8380CFF1 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Feb 2025 16:30:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174076023193.2198557.11880587687983463216.git-patchwork-summary@kernel.org>
Date: Fri, 28 Feb 2025 16:30:31 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1to3Fb-0001bA-2M
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

Patch: [f2fs-dev] f2fs: fix the missing write pointer correction
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=938697
  Lore link: https://lore.kernel.org/r/20250227212401.152977-1-jaegeuk@kernel.org

Patch: [f2fs-dev] f2fs: fix to set .discard_granularity correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=936900
  Lore link: https://lore.kernel.org/r/20250224062007.1324623-1-chao@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
