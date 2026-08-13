Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D71C5DF67
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6SrHR4Mm7msYz0R2n8FhQ7IKo8s1GUlgWopgfw/CNAQ=; b=j6Jg//+H/Lyaoi0a65aafuGwCl
	tD5fdSc7a4GgalttxVj6R6EaK4SmURqM/HYaMShon0Wi/MLX6i0bg/vF1cJFD8ClPLo4jviEoNErP
	yluxuaFpe/q2pi+qNqOVP5CiUWDgwxncX1O+Fcxf1tyfmAtwvZJfK3IamcKTPXVwzyxs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuXsv-0002Uo-DF;
	Thu, 13 Aug 2026 16:02:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuXst-0002U2-Ii
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B+HlVhoB7IyPjGeDTnxqqVpYbFht2lIaLwfNuXU+1C8=; b=P7NIinCEg79zMltuhOaQSgm9cj
 rJxj6hSPVRBMcysITucaKCrbphV/DyFztFe22fioimxt/X/QazErj/4eE/s09KeLNJKN5TcwAsXqD
 LrGV+d1mrTcFHAMpuCeucyOIshrGiWO8wXg5U8fxXo2lk8POAEUiuDOG8xluYUC5sSok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B+HlVhoB7IyPjGeDTnxqqVpYbFht2lIaLwfNuXU+1C8=; b=bp6dhXahfMuDgu3yAVH9NnNmDp
 oOqQzziIVvWQ3F2o+wY8lbm6s5/C2WhPuFZ0d7tzmXj9y2hdwkItZ3nJdVDyaBAYEnaWlKienOTjf
 xD90HqmlAgp0ISHIXSY8/lJuT7ZkXFI5b7O4F+ssDmyfSM4UhPQyfr/PahZOJfUP63uE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuXsY-0005mE-3e for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32D424098E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 16:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167021F000E9;
 Thu, 13 Aug 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786636913;
 bh=B+HlVhoB7IyPjGeDTnxqqVpYbFht2lIaLwfNuXU+1C8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=aTdePKFs4geG4zMCT8BMgJ8pIkcJJVUSHIfe4wG4AwQmUYVWFMKC7/al+PE39eu0g
 dXCPnMjItVzAN9SMCvbctlCBCrTUWadAYzuqyr362WMUQOvSEw8xAfxR31A857rUgj
 h5GC2YeIE/tcU1XSwBoWC9LZ3cHBpEqCqyW53Pjvnw3W07IMvCn6YTTbCFN/hRfSoX
 hwrit3Q0+dMcgd+jOafHocGKglt4DDSY6qlQgU4zTdtm7+47aEO8xtHSqlU0kYrFz2
 jUtHO9X4LrQXH+sVvb1/b72rr73y+i+7yiiEeWE1WOHvYM5o42Rn+BAUtDjpgCJMwL
 muAVo209dJ7ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 197AC380CEE2; Thu, 13 Aug 2026 16:01:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178663686773.2934858.13174093696785530368.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 16:01:07 +0000
References: <20260812122008.281434-1-chao@kernel.org>
In-Reply-To: <20260812122008.281434-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wuXsY-0005mE-3e
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: cleanup w/ f2fs_need_rand_{blk, seg,
 seg_blk}
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

On Wed, 12 Aug 2026 12:20:07 +0000 you wrote:
> No logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    | 13 +++++++++++--
>  fs/f2fs/gc.c      |  2 +-
>  fs/f2fs/segment.c |  8 ++++----
>  fs/f2fs/super.c   |  4 ++--
>  4 files changed, 18 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: cleanup w/ f2fs_need_rand_{blk, seg, seg_blk}
    https://git.kernel.org/jaegeuk/f2fs/c/d2e65712dd31
  - [f2fs-dev,2/2] f2fs: fix to avoid pinfile fragment on fragment:{block, segment} mode
    https://git.kernel.org/jaegeuk/f2fs/c/b4539b948270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
