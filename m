Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B755606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Io2R52YQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lx/l0DqN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jFPKaWTI;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCQ2xNTB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5L/UP1g0HXVAZIBJMIpLqJI1IirphnuQMohKdSj77Ow=; b=Io2R52YQgCO5D0
	sELql9MPq9lTHM71PczG3eDvJ7T7B43Yy/aN6tWkhMIcNhLBruLcZefiTVL/sQPP/1VDHXuFr46Ln
	bsjDRAz5zbKIyiK2kPRmxdqTKnO3Wqa7Pmw3JyRAIZhCJ4W6hhzX0tfyYbXN9MB2Gz8F/HC6BIIKv
	zMI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO2jA-000000004qm-36ql;
	Tue, 03 Nov 2026 00:50:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xO2j8-000000004qe-2qlm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eBRs5G89h5Rrtmr9y8DK6nRgz/nS5TcDOrUBQMk99ws=; b=Lx/l0DqN5maStN1Nhpi0TReGrO
 LLUP5ZLq2u47oDpKQLCa9FrUFYVKn+zz14f/o6FZlyJL5mX5NU2HFGdKYgU/B/g1OjS1u9jZ1e/sX
 PJ63hoyCUB63T7UxX7zZEj0jqdAz+n4s23wm0sGDxgBxnag+gJgTHS70jMvB5UnfxsrA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eBRs5G89h5Rrtmr9y8DK6nRgz/nS5TcDOrUBQMk99ws=; b=jFPKaWTIe/PweikgyByTIUpzM6
 JS5sXHYSvMELvi2QLotIS3IJlFhCzeFRs7/RHrxUsA8a6BxZwsuWSfpNPiwke+lWZy0ofWCBrJfDK
 3svXMHhUMjGq7Ox4VKm6qIThlq3hZvyZJv4MU0XYihdNh1wTtegcwSJpTItHPBSxGtXo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO2j8-000000001or-0JMD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5731C601F0;
 Tue,  3 Nov 2026 00:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE281F000C1;
 Tue,  3 Nov 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667008;
 bh=eBRs5G89h5Rrtmr9y8DK6nRgz/nS5TcDOrUBQMk99ws=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=TCQ2xNTB3/VYbcrWaJ/Dd98YcjLIHe+Xx5g55nWDr2tEHFJbAvcpZ181egHhdKsVe
 cm0vwg4+qaxmKeSzjms97mFKnp7qS0PLnUYUpoFenA3ZxyYJAWWu/p5mTZkNGSEIk9
 m0AzfySfEvqPX4ftqls8uIl56vegNYUZ33diMyAqMBdYAEbbDGrzDdAGvwsWHkxq+L
 1LX7xKd4UZISqZC644/gcEmMTtaYGohJdbn54ppC394b5HOQSx5KSEY16RJjyDn51e
 c9k8uqbIuBnrxJ4ii4yCr3epVWafeUcqdF3cokSEK2TfPI4uqdzvK3FmNfetDpfo9r
 PCNlo8mWzJhYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 03069380821F; Tue,  3 Nov 2026 00:50:08 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179366700663.755181.16969065523229248918.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 00:50:06 +0000
References: <20261102004742.55105-1-dennylin0707@gmail.com>
In-Reply-To: <20261102004742.55105-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO2j8-000000001or-0JMD
Subject: Re: [f2fs-dev] [PATCH] f2fs: update inode ctime on exchange rename
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  2 Nov 2026 00:47:41 +0000 you wrote:
> When two regular files are exchanged with renameat2(RENAME_EXCHANGE),
> their ctimes remain unchanged. f2fs_cross_rename() applies its explicit
> ctime updates and dirty marking to old_dir and new_dir, which have
> already been updated by f2fs_set_link().
> 
> Update old_inode and new_inode instead, matching the ordinary rename
> path. Keep the existing parent link-count handling, which dirties the
> parents through f2fs_i_links_write().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: update inode ctime on exchange rename
    https://git.kernel.org/jaegeuk/f2fs/c/f842dd9251dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
