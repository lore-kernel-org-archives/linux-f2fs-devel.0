Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE877F43858
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sfnhoKxispofUAgIiWrBHFGXGkmnkSRnDPkbaty1LJI=; b=H/+MubhLPLrzxe3OBy2kpT065X
	TZZZkTYjOIpJgA58Ug0kV7MYlX7D6fsgK0LW6JXOvP1OQrL590Dwze9ztWrTJb6VEjjDbxytVAJWQ
	727xrxp+WcRiMdl9ezDJWcxrZtJY+4cBq532LtRwS1KUoDI2yedoV74NKlWaBRM2TDKE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wD3SQ-0008M6-Et;
	Wed, 15 Apr 2026 16:51:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wD3SC-0008Ky-OB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EpG7jt45QL0SeaTHmIXRn54UiRI021ckeTf7xIkIsRo=; b=jY/MJN2XKnK9aV42ZYAZaSekpM
 3H7xifg91PJPVl7+5OCksp3sP6N7Uk0/f4yOg7os2R4f/2Kxm0FAP+5JM7z36HixaqoqEamMFPYZb
 3toYV2M+DuW1oiN7hRN18nqUPPxCFjb2hp7KJteoebmlHo9BUsDB0sWgZaYIDSuy59Gw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EpG7jt45QL0SeaTHmIXRn54UiRI021ckeTf7xIkIsRo=; b=e
 9/PSE+zZoebz6efDLYQzjltBYTFRUMW1iIseaqPVOz5j9mPuT/OjL72Dp4Fex9AR1vYhGKhGOxQG5
 reVjmw8tKeR+dduwVEEqJtIDPQ1pIftiMRCtK3F4HtoVNI+hL/BZz5sETLq6OUQPhd4TrzQtGprEO
 LvE5m2IM3IJ01h4I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wD3SC-000178-8r for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D2CF544381
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Apr 2026 16:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED0C2BCB8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Apr 2026 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776271858;
 bh=B/otPwTg18iezt63Sa68xLnJb2NzXHI56QEM1lIgdAQ=;
 h=Subject:From:Date:To:From;
 b=j4n72rTOQ9B5B/ZHEDH1PYpCIhAOsPiqq2Ql0L3qpJ1qRG2Dw4Gyi5xKIkXWo6M02
 R8OewBLDoHvLITLy38kZ1Q/nT4yLmrB/6hrCX5RzOoqKjExZW9aXFEf5TVavvyPkeZ
 a33MRo4aJ3H+I7ZaKd23CqxWTImNmqEULOYDy6HVYrIQ47qK4IF1jW8njSqd7acGOy
 RstX6sb2cXY5xKC8qzWxUfkadjQatF/DfeG9w4OKi7wATFFx68JN59yi0L2JTJFsu/
 mNPlA/0YO29oIiyYaiQSYzvckiPJflNMUNMT+k2P7LsejlFtfekZeEcczFjBFZtD20
 uK9eoYs9NNyzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 76AC7380A964 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Apr 2026 16:50:29 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177627182838.2303073.8012102223566683281.git-patchwork-summary@kernel.org>
Date: Wed, 15 Apr 2026 16:50:28 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wD3SC-000178-8r
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

Series: [f2fs-dev,1/2] f2fs: disallow setting an extension to both cold and hot
  Submitter: Yongpeng Yang <monty_pavel@sina.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1079812
  Lore link: https://lore.kernel.org/r/20260410150537.1683974-2-monty_pavel@sina.com
    Patches: [f2fs-dev,1/2] f2fs: disallow setting an extension to both cold and hot
             [f2fs-dev,2/2] f2fs: protect extension_list reading with sb_lock in f2fs_sbi_show()

Patch: [f2fs-dev] f2fs: fix node_cnt race between extent node destroy and writeback
  Submitter: Yongpeng Yang <monty_pavel@sina.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1077053
  Lore link: https://lore.kernel.org/r/20260403144015.221811-3-monty_pavel@sina.com

Patch: [f2fs-dev] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
  Submitter: Guangshuo Li <lgs201920130244@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1079751
  Lore link: https://lore.kernel.org/r/20260410124726.2035729-1-lgs201920130244@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
