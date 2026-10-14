Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEA6CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmr+GGy93DGcmbfnkh/e5uDyCUyMOUyp/T4+FgQking=; b=Rtd7U3G8O3r06mD+1m69JXc+pl
	ED2BZdFHS5aCtFjxn5ErniwXmJW5Hny7mKrwKX4Qm0bnlt848w7n2zopo1xI9cMNGWEZpHIPAgQaQ
	D6pzQDByIZ6szrYb8/ToMdBlj5QL6KRlDMwVtPOXP/wlDylhYiqRdfaHa8z1o7bpL6ug=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1FC-0005Ut-FM;
	Wed, 14 Oct 2026 15:50:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xH1FB-0005Un-3J
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BWcGP0R1K2RWgMwju9WxVfcYO+ewJZ3btvZAZzc5rn8=; b=m+t8BMt9OTzrEpuscpKLgTPPdW
 eAEG8XOv9cTFxTRUfkRMd4TfP6VbbraSPGxmicaXg76sFaf8CoqdtLuRLrjKcLJNb83mxgvKItAT5
 QVAXXqjBqbkX+jXwuE1DjPFD4DSVMRenbsxrtWVrGOSx6QjnrYctB6D+bOBUxhmys5qU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BWcGP0R1K2RWgMwju9WxVfcYO+ewJZ3btvZAZzc5rn8=; b=cp0d+Zy1pg7395Y2pDyIdK86IG
 3rG/YfygIvVh7RepoFevqIsfV7cYnU2yCty6ItKOFMul/5/KHSw5APRdW2Ha8h4wN4/KmHVPvLTT4
 L/O5i6rZRNaKBlyN2YOoLDjBQmbhE6+DZR71q7Pbkdymj9dI77z/wgnUIpGJY2zhUwHw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH1F7-0005l8-5X for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBF1741644;
 Wed, 14 Oct 2026 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5161F000C5;
 Wed, 14 Oct 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791993007;
 bh=BWcGP0R1K2RWgMwju9WxVfcYO+ewJZ3btvZAZzc5rn8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=G39UyhoP8qMyRI7FDCGrRhCXRXfIRfMLCOIcRvVckBqFBVU8Rdzcu0Zeey9sH6qPp
 tSmmHp4/l608uiIIrBMdYA3q4CrRyg9viIJXwjy+ZpvJfcemT57xo6MRxKnlSo5jNc
 Hhxh80bZnCnQwyI0nYzCQht6PXScMYrb25cj63hRvbI3LhvdzYJ4TZebr6SsAvWy1L
 VT3bt9SaRBAfSfMTTxLmcUClpJGuK7X28CaJCCtwwjf0NeJD+EfmwuBZw7TBIDjSGu
 HrakHxNRJ1ifd6mAF6qUQQHlLs7mHDL/ROoPeXHGvvE78D6eZ7P8N1NET92ubH0r0c
 /fDIpsiygV/tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B449A39EDE30; Wed, 14 Oct 2026 15:50:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179199300626.2827562.16979303699242428038.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 15:50:06 +0000
References: <20261012025442.770777-1-jnhuang95@gmail.com>
In-Reply-To: <20261012025442.770777-1-jnhuang95@gmail.com>
To: Jianan Huang <jnhuang95@gmail.com>
X-Headers-End: 1xH1F7-0005l8-5X
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quota: fix quota flush failure
 during filesystem freeze
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Oct 2026 10:54:42 +0800 you wrote:
> Quota flush retries can be exhausted during filesystem freeze.
> 
> freeze_super() and the quota checkpoint may race as below.
> 
> freeze_super()                       f2fs_ckpt
> - down_write(&sb->s_umount)
> - sb->s_writers.frozen = SB_FREEZE_PAGEFAULT
> - sync_filesystem()
>  - f2fs_sync_fs()
>   - f2fs_issue_checkpoint()
>    - queue CP_SYNC -----------------> - block_operations()
>                                       - down_read_trylock(s_umount)
>                                         : fails; freeze holds write lock
>                                       - quota flush retries exhausted
>                                       - set CP_QUOTA_NEED_FSCK_FLAG
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: quota: fix quota flush failure during filesystem freeze
    https://git.kernel.org/jaegeuk/f2fs/c/e455328a66a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
