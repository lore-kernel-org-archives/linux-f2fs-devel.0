Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9191C44509
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mn1TTQtBzaGB6tZn2vuQv3P4Elb2nBoQ58thuo0Me6Q=; b=DeBiLxjvoeSTWQbKT3Y9/VAWDY
	RPX+JMWP/4HzqSCLEXCNULRpaTsJ0vl0T5UVarR8rg2m9t2so87pQ50G8u2YaAaA/KpUAMm2KJpPr
	SQ9uogJk8ywPc8G/QHIlSRAmt/Ef/+wLEnjAT/Xz3GhMD3ZgSZZj38PdhzOtHQS1K1vs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjTOA-00063r-C1;
	Tue, 14 Jul 2026 03:00:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wjTO1-00063f-2J
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zChAImWOrlDN51gcoddbdazwdae3tP6/MAG5aFHKXeI=; b=ev6R6AsDjNxNzKsH1OsvwOxMnk
 nB1Y1NVFVxguP1kFaZQ6cziNJz34VdmXplCKB501v8unKLMCKGacWxrFRMtFUOymfuQFSBujE5v5i
 zrjTqVt5oNRw58IHLruN0lA5n2UpYhb2h/OPLVbnn/y7uEWmckpuYUjzrMYWxJ9aqIgg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zChAImWOrlDN51gcoddbdazwdae3tP6/MAG5aFHKXeI=; b=dahGgYntzpKNwECUxC6IgnsRgr
 rZdby+V7JR6N8Ts7lyFC4iyVPLLu/4OjqnATavpu0Ku8s9naslgXAhc6miUtEGQuwcY+lqf/5HiqW
 w9JF/+6NR/4w8GmpqGvn8JeMynt+qaDhB0I1z0RhbjyE9nzkPYDKkX+boR6K3CPvx6oQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjTNz-0000ke-Gg for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4BB3601DE;
 Tue, 14 Jul 2026 03:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997BC1F000E9;
 Tue, 14 Jul 2026 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783998032;
 bh=zChAImWOrlDN51gcoddbdazwdae3tP6/MAG5aFHKXeI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=G4v6PmXJCDJwnX6/hwmigLLg1xAapqTTBAu80i0vuAAlJbODU398uwrDQrgK6/h66
 ZdNlh/R+NZivJuqcKj27NVluxBTmSogc5SLArhv/cBWi0xbeQEA7d9zstgljrVq3c6
 NNYglqlTqHay6hxtJtmWkqtxDTuaBmt9Ucy3YUvZqTzwRW3hs3oluaVbgnTyYEUNDd
 JyLjlrEzgHgpLCz7I6c9BpQchpRtOrz+A35uMNFE94QqsEds5vq86qZo0UIYGb4Mq6
 1Nr9uIS89Ffvnp1ksXXdTKswKPEkw/XXHTmGlKJTGm+ApIcprb3RWzeN8aBQv3MItn
 nYhBHRl0AvlgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A213924FB7; Tue, 14 Jul 2026 03:00:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178399800738.2939750.5347430287438781500.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jul 2026 03:00:07 +0000
References: <20260629114918.224537-1-chao@kernel.org>
In-Reply-To: <20260629114918.224537-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wjTNz-0000ke-Gg
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential
 section-unaligned pinfile
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org, daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 29 Jun 2026 11:49:18 +0000 you wrote:
> Blocks of pinfile may not aligned to section size due to wrong use
> on pinfile, result in heavy overhead of GC, let avoid this by
> adding additional check condition in f2fs_setattr().
> 
> - truncate -s 8mb pinfile
> : random checkpoint may persist filesize w/ inode
> - fallocate -o 0 -l 8mb pinfile
>  - f2fs_fallocate
>   - f2fs_expand_inode_data
>    - f2fs_allocate_pinning_section
>    - f2fs_map_blocks
>     - f2fs_map_lock
>     - __allocate_data_block
>     - file_need_truncate
>     : w/ FADVISE_TRUNC_BIT, we can expect unaligned mapping can be
>       truncated while open() if f2fs is not umount abnormally
>     - f2fs_map_unlock
>     : following f2fs checkpoint and sudden power-cut
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid potential section-unaligned pinfile
    https://git.kernel.org/jaegeuk/f2fs/c/bf4272cef5ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
