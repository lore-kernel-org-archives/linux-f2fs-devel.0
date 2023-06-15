Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545F0EB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Jun 2023 18:00:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q9rGt-0005AS-MQ;
	Thu, 15 Jun 2023 18:00:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q9rGo-0005A3-Sb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Jun 2023 18:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzFlCO4bCc9RZQxzn2De+dtms0CxhdhbLd4eMcVI2c8=; b=HKDCWIDVc0u9lZkgMVTKajVROx
 6ozYldN5WdH0ET9QVGjWe0uurFpqoPf7eqmoXqC/Ko9QoseosJHssZy6SO3C2sQf4H4QwXKmVXivr
 vbgGtWtb7ttE9dXm2/aLGjnoF3uwXbo1wedjCuvLjAN+8liRpz0p7OzSzVNp3MziAQcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzFlCO4bCc9RZQxzn2De+dtms0CxhdhbLd4eMcVI2c8=; b=ict619Mg3c1dZ4UzO40UEm1BNQ
 H+5YTahQafFz9Z1ysbXCRhsqCbgBKZI+vLqS8EkrqSiWnUiNYZLgPdLrlOg0pK25323v1cqxnIR9R
 /BIdeaiLFM0CH/hlIPkVVPB/J9bk7lTEEtXT/XVgXSiKAaJqg0dOgrghabq/E6i54GrI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q9rGn-004QtB-Jw for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Jun 2023 18:00:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE9360F61;
 Thu, 15 Jun 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2758AC433C9;
 Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686852023;
 bh=zTjNcEllzl3aLrGkjNfY3daqXIXZvvpMNXCwS2+qpDU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=GKnv4zWtK5XKi9hCU3J3r4hYo24rHwy7vALUfpfIV231fVvnATfVQruVA7YGYZzE/
 8/U/YYOOCVyy7NjdP1QVHR58sLvoGMA8CUoLwK4pJj5VtrzQA9FYz2Bioa86VYLbP+
 E0gotbRFiEx6iw5Xz0cQhQaJtxN9J5NPCIXJ6CD/VRaSanTLZSfqDWvyFOWbEQS/0P
 8iNvMSrP+vvNkosTx0lHRKTjaup61Ejz9uA4Cc9hcWTKQSMGvnemyVh3Q3PHVp6seQ
 EHjjCSLDv42Q5rFZMhwIz5p2jahdOs8TSTzEGdjb5ih9qbS1lzTk39ZlyLbhwVyU2A
 BMuO6HBFvKO5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0E835E29F32; Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168685202305.7502.13424680817113801085.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jun 2023 18:00:23 +0000
References: <20230612233203.1571983-1-daeho43@gmail.com>
In-Reply-To: <20230612233203.1571983-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1q9rGn-004QtB-Jw
Subject: Re: [f2fs-dev] [PATCH] f2fs: check zone write pointer points to the
 end of zone
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Jun 2023 16:32:03 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We don't need to report an issue, when the zone write pointer already
> points to the end of the zone, since the zone mismatch is already taken
> care.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check zone write pointer points to the end of zone
    https://git.kernel.org/jaegeuk/f2fs/c/7faa5e31fcc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
