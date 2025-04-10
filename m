Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A761BC369A2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:10:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2jFB-0006qy-Rz;
	Thu, 10 Apr 2025 04:10:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u2jFA-0006qs-ID
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmbMpR6ueo+O9Zx9xuCNpvtlXbsbNhDuA2W0trEh0Tg=; b=Yu4eOYDeTqh0U4MTsaYO3UJEj2
 EuD7KDOlNZNTseHgCRnLvn7JA5GjvvuEPl4b546o3rjotJttMGtdAOQhfeb5mcVJd5eOPKKgB3812
 8GKq8EvSV3XClEPRDkuz1lyaaT+Xk6NExDSKsr61RZ6CZKr9aR0UHTV/kO/rrZRyRMLM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmbMpR6ueo+O9Zx9xuCNpvtlXbsbNhDuA2W0trEh0Tg=; b=NGMoNFi42g5frTf5lvzDUDCYuJ
 mHPerLzduBE67jst9j/zj7F3ReWwh+0Fk4/i9oxhHpnsnT4J90FohoUSVNX3PaKqXDGbbXK14Z2Qj
 e0le59xKzjOBd1eqOP8f7Rhh/DOxLQ9bPzLEaYQ2wKSCJR4WnqO2UL+tbByGeJjQ7byw=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2jEu-0001AZ-9h for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0A003A43821
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Apr 2025 04:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A4CC4CEDD;
 Thu, 10 Apr 2025 04:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744258197;
 bh=MxQmQXDfASm1KPFqYDhl4v/yAuddVzhL0fvjTL/VhLg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=MC9IKyH7lcBJHzGnhihmdhiDdv5Qk07pwV9DcbVBoZjJ8nCz9NCDesx6JOXTJfA/r
 tXyWBC146+9RliIlo139bIdeAlMuFZCXstaQfoLyIRRELjGoJ/HBIKt8yHn51tO2UR
 YwWCSz593lnWF1Ji0IK+fKexD/Wkj83bJWueByBI6QAgzzC0TXIzdSmPWlpPS0dVf4
 Eeywo7CObmJUkAfMEBoFgVRpJ5DmG2bxY2tape4Kd7bHJiJ7PMSTjGG7O/YVMTBZ2p
 WYKoe4HP5RVUh2N+6QAYjNvALAzxMRNB8z7wmn0LfyYipUKCK9gfXlwkvu8l5CyWuv
 XkUMIagvmgi5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB5F0380CEF9; Thu, 10 Apr 2025 04:10:35 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174425823476.3146257.16619631062841973924.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:34 +0000
References: <20250320022230.1938110-1-chao@kernel.org>
In-Reply-To: <20250320022230.1938110-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u2jEu-0001AZ-9h
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add a proc entry show inject
 stats
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 20 Mar 2025 10:22:29 +0800 you wrote:
> This patch adds a proc entry named inject_stats to show total injected
> count for each fault type.
> 
> cat /proc/fs/f2fs/<dev>/inject_stats
> fault_type              injected_count
> kmalloc                 0
> kvmalloc                0
> page alloc              0
> page get                0
> alloc bio(obsolete)     0
> alloc nid               0
> orphan                  0
> no more block           0
> too big dir depth       0
> evict_inode fail        0
> truncate fail           0
> read IO error           0
> checkpoint error        0
> discard error           0
> write IO error          0
> slab alloc              0
> dquot initialize        0
> lock_op                 0
> invalid blkaddr         0
> inconsistent blkaddr    0
> no free segment         0
> inconsistent footer     0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: add a proc entry show inject stats
    https://git.kernel.org/jaegeuk/f2fs/c/e073e9278983
  - [f2fs-dev,v2,2/2] f2fs: fix to update injection attrs according to fault_option
    https://git.kernel.org/jaegeuk/f2fs/c/2be96c2147e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
