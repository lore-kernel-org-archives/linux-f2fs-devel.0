Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F6C369A5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:10:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2jFD-0003d8-Kr;
	Thu, 10 Apr 2025 04:10:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u2jFB-0003cs-3v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjxCX7cpKlvLf26wr9wvf1dgkxHIXsv4fbu/PPJWVMc=; b=HMoniWQK7BiTUpsUbaYv1URBfH
 BZ4Vc+DtBTKQcljfvnrqRtvdiOqqwaOzQKTIkHNiTec5fYrhfmD2UYSkhMGXwFBOvn8EuzBP6h62O
 3h58R9IWkqHyzuIaJKH2RPH72/APZWrgmcQEmRhjBCnkv8uski4ntVE0RgHGfrOUXT5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NjxCX7cpKlvLf26wr9wvf1dgkxHIXsv4fbu/PPJWVMc=; b=fFXJJ2Qvq1kfxQ3j6o9xH/Ur7V
 jUYDfe0T+ym52qmchN+chvhjciN9Qd6c5rsbHattSPjcwQu5keqiatnjm02ZK7zjtqonvFUqAR16k
 h0JoTvRna9y+hfYwI7skWLjm7phLS0yp/6KH3W+6skndfC7zOxbJAxNTUmtKTpAa0MW8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2jEv-0001Ae-Rz for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C0B084A3D3;
 Thu, 10 Apr 2025 04:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76393C4CEDD;
 Thu, 10 Apr 2025 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744258204;
 bh=QiD5P4HIEFdEOWQbswZze8511DS0Gq0+nwdZBm2CxBw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=nwZVT9juCsOi6/s26O+7Z47BmCQeV5KnULgd5h9sUOP7ssUzOSbRAtaAMGBeGZ7lS
 Q322aUXiDhTPW5r4I95WVN2Dt7kqb+VnU12riNMbGOL7Y+U21pheclUbX/H/K5p+kw
 aOD7kpvHuNtCGO147/eHZuyvO2qK2TkimZ9TwLyf9qiQNgTKjvPkmF9N8FbDMMqCXH
 pAmnopYIa2D4J6jf3COr5Sx/M2XoXzksRfs+ZnK3vFmG6G2yxA9Ky38Cqys/zRhx9z
 l61YyFAHagSb9KHCE24TSJu92tYK3/ZF1hDQ62j+9ZhFUmeobWyT6W+IKqN39BRaoO
 B3Y2VZziw3Nkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33B5A380CEF9; Thu, 10 Apr 2025 04:10:43 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174425824176.3146257.18250969661492747760.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:41 +0000
References: <20250325080646.3291947-1-chao@kernel.org>
In-Reply-To: <20250325080646.3291947-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u2jEv-0001Ae-Rz
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: zone: fix to calculate
 first_zoned_segno correctly
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
 daehojeong@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 25 Mar 2025 16:06:45 +0800 you wrote:
> A zoned device can has both conventional zones and sequential zones,
> so we should not treat first segment of zoned device as first_zoned_segno,
> instead, we need to check zone type for each zone during traversing zoned
> device to find first_zoned_segno.
> 
> Otherwise, for below case, first_zoned_segno will be 0, which could be
> wrong.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: zone: fix to calculate first_zoned_segno correctly
    (no matching commit)
  - [f2fs-dev,v2,2/2] f2fs: zone: fix to avoid inconsistence in between SIT and SSA
    https://git.kernel.org/jaegeuk/f2fs/c/773704c1ef96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
