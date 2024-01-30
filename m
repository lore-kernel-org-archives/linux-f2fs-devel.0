Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A63BC48285
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jan 2024 20:50:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUv46-0005ay-4c;
	Tue, 30 Jan 2024 20:50:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUv43-0005an-67
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 20:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egfW9xWBlqdnDhPyihqrstCauf1gU0PaW0F7u8kAb3o=; b=HfnVsuV+PXEHCkkAPjj+qp5HAg
 n6PKgGLT7nvif8bJKvN5Ki1ib4tkzQeC++kFxVtrtePCHeHX7EBUqLRx9GlTq8qZNabUmYyvbrCI7
 Cci+HAQe8trTNWdhTdY80a99cH9IweT5oPGpstUxxXjA7GkrCN/6K8ilSSonKDoyIuOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egfW9xWBlqdnDhPyihqrstCauf1gU0PaW0F7u8kAb3o=; b=MjpnxY7oGIqRUWxxCTMKOBd7Is
 eeCY7am7ty6SGVbv9IIUq6q636zDmwH6cwaspy7d2PeCXQ+2s7+eeFsKDpZ14YmkxSRXdEhJVjrvx
 W7PSELf3lCN5V1uyRUvd9ZSNdo8Eas3VDxjUCiF1pe3nSFzotVLth/2hsKzFrzLT2THQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUv42-00016o-C0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 20:50:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4BB3BCE1CD0;
 Tue, 30 Jan 2024 20:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A3EC43394;
 Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706647826;
 bh=P9Nxfwsi22IBiRvPA+3XxCKQOS0jTpHQgVQTl1R2KsM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WzSiEehyX6Tp9o+FIoVXSXh9HQIC/PLdpk986JdLoKr5IFu1wT5kKH4jJhY3GXDBV
 A1eBj9mmTavRR3TNw+zTU2Yv9ExdZihV7+ATMpja6RJV/EIVqfFmowwA4i1SPAcjT+
 co0ilGsdsGqMe3/w+TTslncRXPnGwlExJ+DWIbKoYqDBRlCEXBDnaQyhA7q8hbs9xz
 kvUke0sQnF07bKUC10egOsG5GYx5zCZCD6NkussKVbeZo6bFoOU+jmLvAXVF5eCsgD
 L4fDSOKoNFfE/adNwHzFWAH8G8ZNi1FUHfWjYeQp3tH5zfDMDeP1zcsFy87N5JzwEE
 3ALTk6hsc00UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CDD24C595C5; Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170664782583.32692.9577632595929529789.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
References: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1rUv42-00016o-C0
Subject: Re: [f2fs-dev] [PATCH] f2fs: use IS_INODE replace IS_DNODE in
 f2fs_flush_inline_data
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 niuzhiguo84@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 17 Jan 2024 15:59:58 +0800 you wrote:
> Now IS_DNODE is used in f2fs_flush_inline_data and it has some problems:
> 1. Just only inodes may include inline data,not all direct nodes
> 2. When system IO is busy, it is inefficient to lock a direct node page
> but not an inode page. Besides, if this direct node page is being
> locked by others for IO, f2fs_flush_inline_data will be blocked here,
> which will affects the checkpoint process, this is unreasonable.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use IS_INODE replace IS_DNODE in f2fs_flush_inline_data
    https://git.kernel.org/jaegeuk/f2fs/c/5e9f083a7ae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
