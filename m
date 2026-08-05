Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35971C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTm7RdtqpoI5uvylolCtGslxbkK2s2YRun9FR1Pu/KM=; b=bI3ffJnMPYHJxrBSuZvpAsGeGC
	AOJbRvG5F6Z/79em93FxptAcSAWtiFk3ba52P/1xRV8Wwq1Ofz7HMnjyPN+Aceglyl4mA+eC92KMe
	MZOvdb19jOSzCGFIFwlI4K2ymGW1ePdk1gDYKluYpEqyPsnuzYJiXr8ZD/C5bLgFX5bw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3L-00086r-V7;
	Wed, 05 Aug 2026 21:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3K-00086l-RQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BL9OPYOJe8BM8zFJ/oNMfT3XXZLUPunKIA9orCeaaDU=; b=C2OXz0pt+r8aaojcYah6xHAGZp
 0GH8m/RayPsyH56M/9GhhWgQtrtX3qrm2w+tl5Uu2rqrzs/jtCA2yZ4i+WexCoxHkJklo6qQWmuhj
 h8SAN3LR3A0LaLewcjCUDpG1nFyhrnWPZnSfMSkw+QjD6jadHFDpV4pVQMR6ELeKjMDc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BL9OPYOJe8BM8zFJ/oNMfT3XXZLUPunKIA9orCeaaDU=; b=CyoeoClQ6glU1id2GoYixE9/po
 BU7MZgXaMq8KzhAACNfwygUm99tLIoad27P8E7ux63Chw8ZdeBuUQmvkMwm88XdMUD4zkG68tseTh
 Yf7gQCSq2QNosPSopRCEzVOL+QTpHsYSziW7I+cvwKR/UPEmXUWnA85aljr47aVtCUTA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3K-00043t-FW for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2416460A65;
 Wed,  5 Aug 2026 21:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9221F000E9;
 Wed,  5 Aug 2026 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964880;
 bh=BL9OPYOJe8BM8zFJ/oNMfT3XXZLUPunKIA9orCeaaDU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=lMucsSXTUki+bteK8yIxGDpfhYQj1o5AEtcmZc6UoEhkH7LM4hLg9wFX9jf8Q5Ngx
 5noBZVbRABTltiGM9W0oE36E5zejAi6Vjkw6PyU7cmmq8BA61593QrTW9jCXneyP/d
 PH40MwFYfqxxAJJVUa4lMewbttaBXeouyvS4+vkZ3hAE4sHfVBaGR2DXslYFx4F68y
 OuJyKHwPczEjxyfcAb/UVjutrq2ixbWow1JEIzcVMfqQpy5qNY7RxUfK3WkYz43+Q9
 jwLDzmjfYv+/Ir08izvEDVcXcEyAI6wTRWNn8ufkaUJo6HumDpJiNUKls/mboBVGGZ
 JyBTLFO0Xd/Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A56392FFD1; Wed,  5 Aug 2026 21:20:41 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484038.530543.7575324835869629902.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:40 +0000
References: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260716025908.608098-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Headers-End: 1wrj3K-00043t-FW
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
Cc: brauner@kernel.org, zhanxusheng@xiaomi.com, jack@suse.cz,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, pfalcato@suse.de, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 16 Jul 2026 10:59:08 +0800 you wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with &nop_mnt_idmap
> before allowing the "system.advise" xattr to be set, instead of the idmap
> that the VFS passes to the ->set() handler.
> 
> f2fs supports idmapped mounts, so on such a mount this checks the caller's
> fsuid against the unmapped on-disk owner rather than the mapped owner: the
> actual owner can be wrongly denied with -EPERM and an unrelated caller
> wrongly allowed.  Pass the handler's idmap instead.
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
