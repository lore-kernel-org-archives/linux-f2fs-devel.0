Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD51CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8d+pNgXlAS4QC2ySMNzIzGRBIAuAMbSMheDXht3iJw=; b=OBD7LhZyCGzjr3U0Fgv3MIfMUn
	3MwxwcYD8q85rrWG+3UTqncZU0FKoyd8zeje7PftLS883UDjcUyJtyMaRJ4KIkdWA0//i9TmmHN5p
	d6Hy1CpWIhbAS3zrFca4oV48oEfwqAPAE5MlGMQMO2LUk1QREjdg99IhV7NtBF6IWgIs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1FJ-0001n1-97;
	Wed, 14 Oct 2026 15:50:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xH1FH-0001mu-RN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RnZFiZCHqen420BMwmHz2LltrzsBVhrMtvMbdc9O47c=; b=Q11zXO9szaeolxyuw5ZEMnDsPP
 hQBI3XKlEj/hwg467FbgrwhJ2YmGix2Eh/P3Ebc0e35XQoWdrSZTS1Otcj2t6mkF9aXwXn3WuJ/rA
 Gnk5NdFWAcQSn07ibWBOJzjN1hqEfR6ZZoLNcfDX0F3W8O+Dc5RIl8OjQ21uQbDQyZgs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RnZFiZCHqen420BMwmHz2LltrzsBVhrMtvMbdc9O47c=; b=f1+gmhv1QquTm+G7mtkTL/cgIg
 E+ZbSYBFdJwaREutBmUgKYZ0xBV4MEIhaE2wK2FdKSor4jh2dQEKzafnLJ/ZcORCj7xx0KlGXX3Us
 oECAVqSL7fZYtce+FdaoYjWJTShy6LpEM9t4EVz8KOuzvOJ0Uchs3zQN1c+EBYuu+EZc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH1FA-0005lB-5l for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAD7543C61;
 Wed, 14 Oct 2026 15:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9D1F000C5;
 Wed, 14 Oct 2026 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791993010;
 bh=RnZFiZCHqen420BMwmHz2LltrzsBVhrMtvMbdc9O47c=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=LnoiLFO+J6taut+9qzsx4nt3dQwNXaZCsLVea5Jp6GQbdGBc0tjx9uxbwu4rWwR97
 ovyRw1pVi3VYRaKOZ5yOYsCS1Z3yA54TvexsyFoo1oklLHHVyGSrKNoP6eDmrE4fbC
 kv/bB8rR1Ic1Afc9UuUWxvvGNiGy0yB+KACQbJX1Mr2KED5S0c0BLeUcCxekgU6Jcg
 25u1T/EzAW4VX3QMD7/cdmAI0H9Qu5p+0v4aGXjDyZw6AzJFMhWA8cab8mPRGuCvy7
 +SwerhPy4MHYhHX0HnfFETdmicXfEvVZKnYIUoUVeN3g0/J8B9pSoG4LO73EkCJgpv
 CiQyazjz1bwmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B432E39EDE30; Wed, 14 Oct 2026 15:50:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179199300926.2827562.10260780687438036774.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 15:50:09 +0000
References: <20261012182233.2685282-1-daeho43@gmail.com>
In-Reply-To: <20261012182233.2685282-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1xH1FA-0005lB-5l
Subject: Re: [f2fs-dev] [PATCH] f2fs: return -EIO for a lost inode block
 after cp_error
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Oct 2026 18:22:33 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> After cp_error, dirty node caches are dropped without being written.
> If such an inode was never written, its NAT entry is still NEW_ADDR,
> and reading its inode block returns -ENOENT.
> 
> f2fs_get_dnode_of_data() passes that -ENOENT up, and callers take it
> as a hole. Since the inode block is missing, the next offset can only
> advance one block, so fiemap walks block by block up to maxbytes,
> about 2^30 blocks, while holding the inode lock. It took hours in a
> power-off recovery test after shutdown and blocked unlink and umount
> on the file.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: return -EIO for a lost inode block after cp_error
    https://git.kernel.org/jaegeuk/f2fs/c/01ee16a7a758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
