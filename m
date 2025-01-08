Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C717E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:40:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVayb-0003Rl-N0;
	Wed, 08 Jan 2025 18:40:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tVaya-0003Rf-P1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 18:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sPZ6Yqkfx0WKJS1h+j9SpjRIiJMrhlXnj2S8/v5UUO8=; b=Yq/Ureop/inpmD9W//uLRnZmV7
 96n93TxOaClgkSo1qluk+FTZnkpsmBnvnYiM7OuEY5qpI/ySGkp52xrlAQxlJKnFYIQ3MFFBrEXkh
 Le00uSGb4rFueC4p4s82Efe207y2trOdSX0NlLgWrZAdgM79KDUEAt7mP/NisvhQfeBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sPZ6Yqkfx0WKJS1h+j9SpjRIiJMrhlXnj2S8/v5UUO8=; b=Q
 jII3shU0D9uwqGY9MkESMkqTtOP2pGsvNH8d7/fGQc0vRKNT9jPbchrQqIXmpasREycX9bMHBq7T5
 1U6onWyowY0NIQnTT85Z70/y05YeFSMmMF2DAJe4b+ZHFm3sHrRRDAsT6BhkfyMmK4/LJGjSKQcS6
 IeGWX15QbmU02SZw=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tVayZ-0007il-IK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jan 2025 18:40:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3D7E5A41712
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2025 18:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29446C4CEE7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736361613;
 bh=l3qBDKcw+t2/HnClrrq39eOGsB50vmE2/yhUCwOwKB8=;
 h=Subject:From:Date:To:From;
 b=GE03A5LCK8ovTrhwjR0HaJBBhY+yT3UrVNXzQU29J25FqhlBgTY5lkg1LXWP9B8Wd
 eIRviHZmgwZ9m2QwSeSZceKwaU0GEhG4d4Y7VOqmO9khcNvigtG31HJx9F9S0KF49Q
 US9jo6SBZjs+7hgJvQFBxBOElbX924NWjUzZZqx8+g8AkkP/lrqbmFOv3iMta5uxcS
 IEzlVWo4qlWpfmDQfE0qw95o5jP9PeHquggJdqIaqdrLbP8fHki+jLIxS+x+HvW3Pt
 2WCIXZQ67M1PxHsboAMtOgCQQNX5j0mGn9LwMmzQrvbrRy3pgMPZq6kAbw7fGbUe9v
 rBACfDldy7yDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B723C380A965 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jan 2025 18:40:35 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173636163451.743062.4199563461717582967.git-patchwork-summary@kernel.org>
Date: Wed, 08 Jan 2025 18:40:34 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1tVayZ-0007il-IK
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

Series: Speed up f2fs truncate
  Submitter: Yi Sun <yi.sun@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=920345
  Lore link: https://lore.kernel.org/r/20241223081044.1126291-1-yi.sun@unisoc.com
    Patches: [f2fs-dev,v4,1/4] f2fs: introduce update_sit_entry_for_release/alloc()
             [f2fs-dev,v4,2/4] f2fs: update_sit_entry_for_release() supports consecutive blocks.


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
