Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907F2CAC5B9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0nYy+rRokMTk3N9RcPR08ZCVfArsV2cIZ4PVT0ieDA=; b=Rcuw7vx7ielEtvnYG1ZCCKYu7k
	3+IMQ2tYmJkFYl82a0v2xeK7luZcOME7uk4M4wZylfMkSf1RxlVSguVvclx6V5BHHxFgX8fwVNiNf
	sjo/ULCCwaRMWbtqBVlQ1vB8X+QeTNecAc8nkp9QMBVbe4svjxxUOnn113WZJzZDTe6g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3MON-00033z-Es;
	Mon, 29 Sep 2025 22:30:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v3MOL-00033b-NF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRpBZiPaSWVK2Cx8P9vc8qmYYjfk6XzoVXjcYA/dzRY=; b=id3uZu15dn7hSWd5XRKrFDkcSv
 du5bN8l43EjLyCU840okXLLWoNLg0ofynTIj/Vva3jBu8vCyXhB0CPMLs7B943TTR07IiUmbCLv+G
 1U9nc1lUqh0EeQucjCoCDCNcLKJgJXccW/uKLtx07W9vFJ13k9OnXUvs9qR7zgYaL7ak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRpBZiPaSWVK2Cx8P9vc8qmYYjfk6XzoVXjcYA/dzRY=; b=C4m5BMfuEkKKp8DXFj5a6T0Xxt
 wxNSkt6LpgV+dOeskgG7DTxPigl//E42qj2EtZqcdqzDjOGZVsQAcTiS1NXabsIYb3DEIncZ7asCs
 eqmR3ZnUgFqmtTveFIj4CrkxDPaL7ZS/7JXypy01f0X5SdUUnJEl2GDtGDuV66s0NoCo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3MOE-0005NY-H0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 266ED416EB;
 Mon, 29 Sep 2025 22:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0149CC4CEF4;
 Mon, 29 Sep 2025 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759185033;
 bh=gQYDaku1kF/Js+UoZZtUqouT1kwVsGXgv5zZeWdLxJE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QxId//ioZ9HbdlO8iF7p5g/kOzQJO6oXtCQNrMJL2arowN1YQzCJ5/ogN3JS0IqqG
 zF9ayL/lSxTjMshVmWYd/l7pFIvnYTUOrhRhZk/sMqj5GGa1Vf3qwWvFnCx7u3k6Ir
 myjh0Vpr1t7GVOA8mnNTIU8fybsc1pd5Wd7Eif5xp6gsPMO3eWk2nhvSFCiZAI16DU
 vGODjGJ852jwxyI+fHcZAnVxqhbojFMOdoAJKEYxY2lt8bV5TgbAZ+DI3ssA6BZMga
 YvR6Famx1GhG+zi/4trIMh2lkQ1MWhVpb9xztR5TYjEvgJ/r4PkD+56IUFzqdRIrN/
 2KaEdObQqTaIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADB1F39D0C1A; Mon, 29 Sep 2025 22:30:27 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175918502620.1733438.7002406299096595747.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:26 +0000
References: <20250910084024.1722790-1-chao@kernel.org>
In-Reply-To: <20250910084024.1722790-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1v3MOE-0005NY-H0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to truncate first page in error
 path of f2fs_truncate()
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
Cc: jaegeuk@kernel.org, syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Sep 2025 16:40:24 +0800 you wrote:
> syzbot reports a bug as below:
> 
> loop0: detected capacity change from 0 to 40427
> F2FS-fs (loop0): Wrong SSA boundary, start(3584) end(4096) blocks(3072)
> F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
> F2FS-fs (loop0): invalid crc value
> F2FS-fs (loop0): f2fs_convert_inline_folio: corrupted inline inode ino=3, i_addr[0]:0x1601, run fsck to fix.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to truncate first page in error path of f2fs_truncate()
    https://git.kernel.org/jaegeuk/f2fs/c/9251a9e6e871

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
