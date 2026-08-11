Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA4C5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4m3IHaXGuFE3530Yh9Vr3/drqL1HFj3zcR4+PtQ6+jw=; b=MeilMvGLJaEzJJYczM30YkwPDx
	dYnp05m39i1mYcirNYkhIkMhRbG0T76vI3VW64WV5udFyIXRIU62DHhYnyPlbiwOWhbhotpahQ0k2
	73AuKa2Dr0SCYldMIJn0ol1nsqDrDBiw9SWrY4woI1+gHVM21OzB1hw7I6yzBHHYDZbc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8f-0004cc-9M;
	Tue, 11 Aug 2026 04:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8d-0004cH-H6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K1hi/a3Td7yMq+N9g0EbBM2uvddsl+i6kV4KHJWeHyc=; b=BY2806K5GWrOAMFK065lBRri5Q
 TjSKR/SW4zRAVmuK07MKbTlqbFh94rpV5gohVI3IvdR73PM3CzKb1OAch3Nvax7QNC51NviJm5O2C
 kf6KzjA0FGPY+ZkcKJe/NxLiOdGdNM+peLTLE9Z/HOm6pra6wzWMI4kUm6HLaKNtZ7Vc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K1hi/a3Td7yMq+N9g0EbBM2uvddsl+i6kV4KHJWeHyc=; b=BE9r2Al4WFSGDusVCJn860qtCe
 yfrMKJiiz62RA9JzKfIY90ad+aBpz5CJknYtJ46Rh+ICp2oI7dUqMYmKk0KtHUAVHgtv2WTURcPeF
 a1xFScxA0Hk+Z5BTAJJI31k9v+/HNEi1IOIhjcCBJbKP2PeOPtLnyAg/NTkZqw33wVk4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8g-0008LG-CF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48BEE600AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B131F000E9;
 Tue, 11 Aug 2026 04:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422649;
 bh=K1hi/a3Td7yMq+N9g0EbBM2uvddsl+i6kV4KHJWeHyc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=m/8HerNnKid8VfYR9rn9VjniMu8smECbSZ3OxFNjM10nZb1nWWTEi2dvhOv+8/DbA
 2ghV/JutyWIzhFwAWIekPVH7uAD0hvNsGiGBaGY5UyjGDQvUWglzOM4ktbWEKIPNqO
 jnSU3Kx2BTax8HvUh8XgOmhawA9CZvg49R5mDEfR64axeYwZqRxRAP+as0fyoYtxAb
 0/GXv0Y5udi/XOzYOcZFlGsbB15iOcnkvqrAqwPLe0DEfYvb5ciicpYLL4RJuUzxTM
 qWqZtXW8pc/vJ9Wb/6czBTLd7WSXFGIxx8oLAatRAxuow161Wm8fMoOk5+JU9rU0jB
 2ADbwhuzxfAQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A5F3926278; Tue, 11 Aug 2026 04:30:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642260514.332426.7430218840788697980.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 04:30:05 +0000
References: <20260807220235.384637-1-jaegeuk@kernel.org>
In-Reply-To: <20260807220235.384637-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wte8g-0008LG-CF
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: refactor f2fs_evict_inode having
 three major parts
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Aug 2026 22:02:34 +0000 you wrote:
> 1. f2fs_pre_evict_inode()
>  : drop all in-memory structures
> 
> 2. f2fs_delete_inode()
>  : truncate inode blocks, if it was unlinked.
> 
> 3. f2fs_post_evict_inode()
>  : update inode records for future access
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: refactor f2fs_evict_inode having three major parts
    https://git.kernel.org/jaegeuk/f2fs/c/0d7477640f44
  - [f2fs-dev,2/2] f2fs: call __add_ino_entry out of the eviction path
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
