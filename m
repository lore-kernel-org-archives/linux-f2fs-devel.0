Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35669C56205
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HNPaTiuwgxknUUidNHpOWiUwOugCHaFi7G2q7vQkRJo=; b=ezzoEJNzfGBNdEpSYNOGgu/jbg
	Ic1xnjwaoIjegxTuTHNLaMhXPhkvpNieqPc0dWE50dL3gb6RtQItwF7h2lpu92R2mhDap1sJkcbdK
	MimDNNbrfLMrj/OoadFOj1dVJEEpcQ5OAaCdwVTS/yR591ctWtWGRUvyotlNXMD0zNLE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3M-0001f7-Se;
	Wed, 05 Aug 2026 21:21:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3K-0001f0-G0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0x6FWa3CcZ+trlpKog+0j1YzF5iFFxuOpBdpFBzJpTw=; b=CiC1SSIIWn6CwW2CsKSbMK8cQW
 TGK62n0MAsO/u4LIdfL12XKkStAbmCzegcrx5qWadzSlevz6hVQu0JiUDnJNiYSE4sKco6jd8cdDE
 enTr06EHW57hlUI3QOpY0tNIBak2fyaBa9cILXHwbbGuuPwdgWRgSiOLkwWXpWcN4zCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0x6FWa3CcZ+trlpKog+0j1YzF5iFFxuOpBdpFBzJpTw=; b=j981WhO+2HdUm5MC7AIcCZ38P0
 8n/nawa1VU6atwu4X0nwmcU0SjRBOgpESvJr5lsaZyhO3M60ThuMKG7Hnf9xQ2N7FfvIdGlFHPjix
 WddJzzS9wiIt6dn6JZvgKLyCiga/Wyt93Bf4kAQJP8KPxOcCTXe6rYrsIVRj1YddfTwY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3H-0007AW-Fv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3599243C76;
 Wed,  5 Aug 2026 21:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170451F00A3A;
 Wed,  5 Aug 2026 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964882;
 bh=0x6FWa3CcZ+trlpKog+0j1YzF5iFFxuOpBdpFBzJpTw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=IaB0ohv1/vKKZgeBUyFgY9cTwhRrwcrLPz+HpWZNdj5k3BAswITidOM4hRaBcY0q/
 ha8wchlLDm2xY2sU1jmU8vHPeR3PZoOxSUSknZRGn9j8o6Ns6IsvvjlKHh8ct1QGu0
 iPtsdqgGQaHNE4vmFvnnJlfavsEZISatH0wg01f8R7mgW8KfftyqlLKXsGhJATJ83X
 Q4Fmc5AQoMHr6Ir9d1FZffibGKy9znVu5VkoKdWGKS2cfmdvR3lwvn4OkP5w7JnmBJ
 o7P9KEJP3ofyt5M6IEY1ayebdsIxfq9nSa4IH3qDfe9k1KC8YOQJBVmrJCVEHlwEJR
 vFuF/rSzYgSmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198D6392FFD1; Wed,  5 Aug 2026 21:20:43 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484188.530543.11645876783488345046.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:41 +0000
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
To: Rochan Avlur <rochan.avlur@gmail.com>
X-Headers-End: 1wrj3H-0007AW-Fv
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 28 Jul 2026 21:16:56 -0700 you wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
    https://git.kernel.org/jaegeuk/f2fs/c/a54ffce4637a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
