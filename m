Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D4C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RYzGRZuWcmyVMrKkCYuyuUMZ+Vem0emk6C1MBLCq4k=; b=g3yZjEIx/meF6OZNoK6025zcCU
	E87qOQmJgjXyxe7pkFe1X/haZq0XEiKaIzAljLNaluZrHv9FT17wUfs7QT3SPkPFrI89E8Ym+Eups
	4n72SLQX7cpBVNc5JPVc2SPqAJBeZdfd4mzEw2kySn7VSXw1VhcK4y3h+arzm5D5TEvY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x420d-0007w2-IW;
	Tue, 08 Sep 2026 20:01:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x420J-0007vl-2v
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=weVkAE66PuFA6ueVLI0Xd/LFcQkJbuYpx8zORck9hV0=; b=EB1Y45Xs4/LVdJwlGehaufcc5X
 lFzRr1nlWQ7SQzDytvZjehA2sZ0io5+Io1R20KXBlYWVqH+DzdHanDsHfGxMWgAmW0oRnlcxwNHlt
 HDd0mZ46rP3YCm6ftRQ+4NsQTRmRsRpZXLTz5xLxlbDsTTVbPrUxUaM9PV3L6Mgu2Q5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=weVkAE66PuFA6ueVLI0Xd/LFcQkJbuYpx8zORck9hV0=; b=LurxZcfo4IXrSMp45G/PFWSWOf
 LFM1u24CtAPIECHy/CZR2VkvXxxdgM0825vg4wMj0LDxu4Qds+mFHzZUVFqyAlkOxHoL8/K6Ivk1G
 N2ZLLgYXG/R53jlyfGnxTID8Ny83KCaaze0vedQfj/66j6V7b6fFxD4W39MVnoavfXpc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x420H-0007Aw-Fu for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 20:01:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 365B5438DD;
 Tue,  8 Sep 2026 20:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B091F00A3A;
 Tue,  8 Sep 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788897668;
 bh=weVkAE66PuFA6ueVLI0Xd/LFcQkJbuYpx8zORck9hV0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=SwasziLrkOuMlx81wWsx483cNYNLzF+oZCc9sKNSse/cX4Vx9Cs+ElESNljJRij+n
 y/OIyhWwQlVYaKUqMfDFAN9Gx8GsfdA7AHx5XcmfcKyaI2XU+d5ya3fjCQFjRoPZDD
 CfEIrlrCFglzvOgvkvF4J7apH8lB+5/fgoMRZs4UqEhiGL/1+9Sgo1xTXFbIJs5cj0
 6Nj4P8oQsN2UUExnKkPWWdD5oU8vFItVK5MpXDgMr6WODxkqqzzc6fz6479udQUtzI
 RZQlpPV8qtpQsX1BzgbdSmrw93iYi0+jd2TVBu9J8rVPXZqgqN9bwwFenuXd7aZMIC
 0BtKR3WTZIPHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D09A6380820D; Tue,  8 Sep 2026 20:00:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178889760650.3720652.823497895203817513.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 20:00:06 +0000
References: <cover.1788479509.git.zhangxp1998@gmail.com>
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
To: Kelvin Zhang <zhangxp1998@gmail.com>
X-Headers-End: 1x420H-0007Aw-Fu
Subject: Re: [f2fs-dev] [PATCH v9 00/11] f2fs: prepare metadata layouts for
 runtime block sizes
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  3 Sep 2026 16:54:16 -0700 you wrote:
> F2FS currently describes several on-disk metadata layouts and filesystem
> geometry values with constants derived from PAGE_SIZE or a fixed 4KB block
> size. This series derives those values from the mounted filesystem's block
> size instead, as preparation for supporting filesystem blocks smaller than
> PAGE_SIZE.
> 
> The patches initialize sb_info early, describe the SIT, NAT, orphan, dentry,
> node, and xattr layouts dynamically, parameterize sector/byte/block
> conversion helpers, and derive node-tree geometry at runtime.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v9,01/11] f2fs: initialize sb_info early in f2fs_fill_super
    https://git.kernel.org/jaegeuk/f2fs/c/425a464e82a1
  - [f2fs-dev,v9,02/11] f2fs: describe SIT block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/b41496b999b3
  - [f2fs-dev,v9,03/11] f2fs: describe NAT block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/4b1fbe38ce5b
  - [f2fs-dev,v9,04/11] f2fs: describe orphan block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/0e346faac20c
  - [f2fs-dev,v9,05/11] f2fs: describe dentry block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/2f5562816fac
  - [f2fs-dev,v9,06/11] f2fs: describe {i, d, id}node block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/49d39bc4b877
  - [f2fs-dev,v9,07/11] f2fs: describe xattr block layout dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/fbf612f85437
  - [f2fs-dev,v9,08/11] f2fs: parameterize sector conversion macros
    https://git.kernel.org/jaegeuk/f2fs/c/87f159c1492f
  - [f2fs-dev,v9,09/11] f2fs: parameterize byte and block conversion macros
    https://git.kernel.org/jaegeuk/f2fs/c/7c8fd5156c90
  - [f2fs-dev,v9,10/11] f2fs: describe node tree geometry dynamically
    https://git.kernel.org/jaegeuk/f2fs/c/a4bfdfc5d3d8
  - [f2fs-dev,v9,11/11] f2fs: parameterize block size and mask macros
    https://git.kernel.org/jaegeuk/f2fs/c/6a0dda6838b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
