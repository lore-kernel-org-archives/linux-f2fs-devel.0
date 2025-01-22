Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7287BC0218C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jan 2025 21:20:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tai99-00025l-9A;
	Wed, 22 Jan 2025 21:20:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tai98-00025Z-5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jan 2025 21:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6QDxZq8opx2zG/ZUj/dHBpC11W2GFkXlIN6HvpAuzkw=; b=DcM1PbcqxRKIcqQp8YGh9LxbKc
 X3bygHPcXHDzLIwlTX9UcCMS2MJ7noZWSJJMhmfxZfdIrUNR1oTFzKJwE3eboxToPRStS4RF8nKdL
 jXFwkBBT4kAtNUavqo9BpompmRtzi6kBoJZmc5r3oRw6VEmb9cUCNgtZJqs02j1291rk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6QDxZq8opx2zG/ZUj/dHBpC11W2GFkXlIN6HvpAuzkw=; b=e
 YkSukkllX4r+oiT8p9tq0WdrgFd9OCWTn+2zU06iE8/f/RHTJ4hKjRdLThytecIdHHgmHuX7NfPzE
 QiG4/HGqMhN9OnHF6lz1EiKQ0GMrxXxWzSTOVz6rcY2HbsModwAnHE02VnsyM/W0mfnIMNfDi/VW5
 Wq1KUMDN2PRGZnvI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tai97-0005NR-Gw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jan 2025 21:20:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BCABC5C5FAE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jan 2025 21:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E48C4CED2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jan 2025 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737580810;
 bh=m4NzLGhZkECgAR/YifYwKgVmjRNw7+YzyQv/oeYVP8Q=;
 h=Subject:From:Date:To:From;
 b=sR3FA9iOelno1faur8U8Qy3epXvSJFW4UF/PmGKoKLoXEnCvdUTABc/PF0GuNrVAR
 pmBWkDIW3JINyFG6ew2gEA55E383H/M7vOCURqJ7c7/Sk+QwysAbDFEHBlmcuFhUCc
 yGBJSUar2EGQBbgqcFuHrSMx/6IOPyOayHMjUE+kW7SMZQsDJ1YQmgagtu7tqze91l
 9cOpr0BG/JYS/QLG8vX2rQWrvcV8iAhQdWtxkDxVXNdYSblcq6JcHtmOWDBcgeIPyu
 VPDrqFm1GoQOJaaCxQYEC+de75SQnLjM5AKKFFWivUoFX7gbsqilkvgtzI6Ojmri7+
 w337hfvc5JAXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 75E60380AA62 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jan 2025 21:20:36 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173758083494.821180.6685932053368583663.git-patchwork-summary@kernel.org>
Date: Wed, 22 Jan 2025 21:20:34 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1tai97-0005NR-Gw
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

Patch: [f2fs-dev] f2fs: Clean up the loop outside of f2fs_invalidate_blocks()
  Submitter: Yi Sun <yi.sun@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=924706
  Lore link: https://lore.kernel.org/r/20250113014702.2312729-1-yi.sun@unisoc.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
