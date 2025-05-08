Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF68C3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 May 2025 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8KBC0m/eYHPxV56RCx+u6l0UMr7+9gnFyp0WUw4I1Y=; b=EbxLJ/AC94yu83Ffwzs/gdutFd
	EkXvJYS73IjoV5LHgOTkDhUQdZJL469hKIBHeyjqOOweIfpHtk61nesVb4Q258rGs0xV22tNUsD4e
	k4l4/ouUIKxRXlZI/tPNIJx/W41QdcIWElcWZtNCCUrD/LHQghMS8Lzjwa6SReAp5pLw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uD48Q-0002PV-KO;
	Thu, 08 May 2025 16:30:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uD48P-0002PP-En
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 16:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rO95dSC0NqFibqanwFlHKXuSk0ogP/R0K4p98RslWIg=; b=mHKtx7zPVFKB4Ul62SnNeFT9xx
 /VDeyUt0k3ciRG/abP/JiP+2PAGJReQAeL3jgKCE9NcIgoHORppuedz27O1w4SCQ/36seaNXeKQID
 1AWGn3tEwn8da5pQyCjtPDaJQvTlNeyT5kS3OYEWLeZSPnr7vCC9cVqjN61aE3FspIHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rO95dSC0NqFibqanwFlHKXuSk0ogP/R0K4p98RslWIg=; b=MQZbgoH7PKc3/3Q6oOwk5Kd+9H
 R4C+v7mlRJI2XFoPe13uV89dIAC4dGErIbxsMvUK9xACtc4TBZH9zEe63Yptbc91SHcE21DP8aI/F
 NgYeqobeJKMpdr71Ag10BN4QnWt1xb5UtcFWi+/79M5nuHrP/yasNfW5RyZfQOOBN4Bo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uD48O-0007g5-N2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 16:30:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 281BA629DC;
 Thu,  8 May 2025 16:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF796C4CEE7;
 Thu,  8 May 2025 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746721797;
 bh=SeIAFSWx7zH//oPWO+0JB8KVFbGqrfACDBlR28gXzlQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=YpiEbtZaSJ+qSHZslzT+J8tPhqmeRm6hJG8xdBW+SrRTGWEn0MAn/ahVpQrmBB8m9
 IR/rAjBeX1Eekp2zjMRBYBdD2ix4olIArIeOmP4FgvCXkXJfO/6CrXGqXyD1X1xTSu
 59iQS57jCFHHU1mpWCJx/KAuRnTlzK6kk5patJ4b01nDvicU6ys5xGKiha5+w/H7w1
 FjF8Tt9FKBQ3n8QcQ3JtmpGJwQb6JR8qr0ffiOiojsYJ9Z3iO0WYzyxyBE0GpXa61o
 FPVuwaCO9wgbfgl2I7SoljhhKEgVJxHA5GwVhpTx6qTDz2PXbDjoTjV+wvwh4FylDQ
 LgBhq5aX+JixQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE4F4380AA70; Thu,  8 May 2025 16:30:37 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174672183636.2971823.10798843994622646234.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 16:30:36 +0000
References: <20250507080838.882657-1-chao@kernel.org>
In-Reply-To: <20250507080838.882657-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1uD48O-0007g5-N2
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return correct error number in
 f2fs_sync_node_pages()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, hch@lst.de,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 May 2025 16:08:38 +0800 you wrote:
> If __write_node_folio() failed, it will return AOP_WRITEPAGE_ACTIVATE,
> the incorrect return value may be passed to userspace in below path,
> fix it.
> 
> - sync_filesystem
>  - sync_fs
>   - f2fs_issue_checkpoint
>    - block_operations
>     - f2fs_sync_node_pages
>      - __write_node_folio
>      : return AOP_WRITEPAGE_ACTIVATE
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to return correct error number in f2fs_sync_node_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/43ba56a043b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
