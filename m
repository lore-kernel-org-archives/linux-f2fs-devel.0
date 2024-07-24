Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6295BC3DA7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:17:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWRYx-0005Nj-1n;
	Wed, 24 Jul 2024 02:17:07 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sWRYk-0005Mg-5d
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 02:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=880YjQkJ9kHOiMfy3XroLWlI+pfjja366HxrWJ2uAw0=; b=eFlnTUMrxNhcNlYY6KM7eSHQXW
 pjrpz+O6h8DY/s6CkUIkJPxCL9x+4CuzxqOJTqh8gbFo+0xfQgZqxviECZy/00M8pQkGtcvdtQB6Z
 7X48K1EurPmiJFm4SrFXg7ICQr0+1IKqcxr7tPh+Nd/Gbqq2d96WGCGZI3L0ieufFX1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=880YjQkJ9kHOiMfy3XroLWlI+pfjja366HxrWJ2uAw0=; b=BhTHCyaA0SeJFwI+Zlta/dDHNQ
 XzHyWCxyDvXNek8C/bd8Ky/yqR64j+8Y53uWNX/n09GHNTz2cA/RBF7/A1sowbm9WTRAczvk5KQZ/
 xOh1NB4jy8vUXYsK0J0uuzG+TOaxYKiZNi+E/V0CtVfsaMAyx5+SvfwuPnkOhIXN5XOE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sWRYj-0002Hs-HM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 02:16:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2873E6119D;
 Wed, 24 Jul 2024 02:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 917B4C4AF17;
 Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721787407;
 bh=O256qwtoDTt0sY2c2+MzY4GWbDYIhg2GsSCQvSOSG3I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Uy74heXSn+D07XnF3R7c6mdqtDnzVu9CAtvod03+tYzstNr8UXR08P1aE1NQOB3SC
 f5w1R4OTju7HY+MNt5MsPB9P6seXhz8pUnGGEwuYSFFeIe5nZVWSNkbMvXd87pnN17
 vMphm1DOLZVnKU8b0/ZxKEKGojQD4ojUSWCfWXl7ka/PXNMMkP4zWzqb7LuxJR07h1
 P6xP+3qUzJFP6+D7p4Qog/EbCizDF6KZDOtbc2Mbg5VbjwjdxylAPQq7vo6WPDZkEO
 yLCKW36puUFVpLvQaLVwxXzYaK/MBErRgwNIygyhhW+ju3OZIuAbgQqLbsEOmXuD4x
 MJ0AGFsyM9UuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 799F9C4332C; Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172178740649.17759.11088131748657824514.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240620032335.147136-1-youling.tang@linux.dev>
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
X-Headers-End: 1sWRYj-0002Hs-HM
Subject: Re: [f2fs-dev] [PATCH 1/3] fs: Export in_group_or_capable()
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
Cc: tangyouling@kylinos.cn, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 20 Jun 2024 11:23:33 +0800 you wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> Export in_group_or_capable() as a VFS helper function.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  fs/attr.c          | 2 --
>  fs/inode.c         | 1 +
>  include/linux/fs.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] fs: Export in_group_or_capable()
    https://git.kernel.org/jaegeuk/f2fs/c/9b6a14f08b48
  - [f2fs-dev,2/3] f2fs: Use in_group_or_capable() helper
    https://git.kernel.org/jaegeuk/f2fs/c/8444ee22adb0
  - [f2fs-dev,3/3] fuse: Use in_group_or_capable() helper
    https://git.kernel.org/jaegeuk/f2fs/c/153216cf7bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
