Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59602D6CFAC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=giRKMsvdhf5KYFa4XTXK8MTPN1dV771hd9m7StoFjqs=; b=NEneh0QfO90ibFHddXoNof3x8/
	/AGuccU9Ro/nnC1rbb4+HLP0ARRq6wYzJi9jMHXqkQwT7BrrdjLHuavc04ys9vdg4YNQtbl+XOAkt
	2D38kxyNuOY+EsgqVhWUXJ0jJzWAUGj7Bln6SSAz2AO9c1f6fWhJyNGljzeeJx02YDOc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj4RT-0002VC-VF;
	Thu, 22 Jan 2026 23:50:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vj4RS-0002V4-MU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glxphUU7DZItsOQJs/410AIcshukn40LHgbI+wVpges=; b=Lbr8V76SGhPma4XOMCa2s+0nMG
 PLn2jOpHu95aCMg5yJwIwPy0ia/ZH1dmyBXYoaDEuAnTsh/x+WtZ/ABRyNJ62hL2w4+xjfjTIDhVK
 WaaNP6KhDioIwQ6RlsfpsTqf1nJP4cmQRTJ9rjhyvtrCvJ+rVozYWZTAoazR00JhbmpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glxphUU7DZItsOQJs/410AIcshukn40LHgbI+wVpges=; b=U5aN0GdAAgODmE1koLeNsRAyNq
 1XYOSZr0143ly2eHc/InPZeOvjfI1+sLF6GsksxXgsQN0M7phgq3AW1OvAQYBbzWSZcHebodcAAoy
 fAHjtlBGPSw/T4z1kEh9dd0R+nM0hSTL+3YGmIMDfZmy3h3wJ6XXQ0JaKvBDV8fQdgCw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj4RS-0002Ny-6i for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:50:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E70B144074
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Jan 2026 23:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D90C19422;
 Thu, 22 Jan 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769125811;
 bh=AWBQpkCriEc5+GOtzh+lOpHnGtzERudcJ/fyebKhid8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DTnAnw7XpAp7Vq/1gU/hZ23mBAL70nSfFpVw/S3uNeI44+r1KBvVMBa0F8AFpyuGF
 Y7d47niu1UC6YJamyhdBBhavyiuqrWmDnm3TU/UGb4HELQnw9gBcDjVHWXF5FtKT4G
 cgrAJbQunyUzAvmU+VR2M5quQdamC6S+P5295Ni4TS5dF9KQkV8Io146aTAJbcysZF
 I2A6MPRIigZNGc4eEGmOVCVclmtkts5mnXGLiB/XBN5fhLA/44V7McdyNvWARWEzXd
 qjN0pMbvPZIRACDoQyuOg7RWFVrC133yYqy4eQBPLD2PH/eZHmw8SbdUxqqRne3bv0
 H4PyC36HUQDxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 4E9DC3808200; Thu, 22 Jan 2026 23:50:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176912580809.2327822.9286028451084853696.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 23:50:08 +0000
References: <20260116062927.21725-1-chao@kernel.org>
In-Reply-To: <20260116062927.21725-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vj4RS-0002Ny-6i
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix error path handling in
 f2fs_read_data_large_folio()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 16 Jan 2026 14:29:27 +0800 you wrote:
> In error path of f2fs_read_data_large_folio(), if bio is valid, it
> may submit bio twice, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - rebase the code
>  fs/f2fs/data.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix error path handling in f2fs_read_data_large_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/fe15bc3d447c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
