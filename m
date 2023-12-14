Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B42CC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Dec 2023 20:50:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rDsfT-0000zW-HA;
	Thu, 14 Dec 2023 20:50:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rDsfQ-0000zA-Kh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Dec 2023 20:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5/9Yuujb+adb6DAvRR8//1pSwLYTaoUmdiFnF/E7s4=; b=IWJSyXEPdWzfLPsShEqxe5FzIQ
 PQPMZqnanu2hWbsA7t7Gkj5meqAoohz+8acV4vOha/RWJ0y1PfZbnwTyvBBwspytReO2ILSrYAHHB
 NsSno/Z7T/EuCSe/JuiKtUuIBzrkZCYryeQEdyQ/jnGlKABrQcxpy86OBBCsr/s2andg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5/9Yuujb+adb6DAvRR8//1pSwLYTaoUmdiFnF/E7s4=; b=FmigIzc4UYV1ie1FHzQV5nL90D
 9mUzeqNoEehjwt+rBm0aDTDrwfVowTfe93mtrQ3/1TLYytT/7cyv4vFDBGczeQo5ng0Yct8GjEDxg
 WPBNOTvm0T9/wOW45rOv8hni0xNI2WQfCMw/l+Z2gEIPTv4A3JyohSNDtHtD1m75Cvi4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rDsfN-0000kQ-By for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Dec 2023 20:50:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C5159CE1D51
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 14 Dec 2023 20:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 382F9C433CC;
 Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702587032;
 bh=3Sg1Bp15Z7VsKSw5avAhEOsOLG+n/wcvl2qDa6EONC8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LqmFn5Ib6Pupfk2qF3etwq9EUTyKiUvIDZIiBX4CkJSANwHKlM4hMRecQrW0D8BP5
 l2rdpOHSyB4efTuJqmVSYBykkdFQGAWBES75t7SnUDT6vcsKD65GzQtx8GVQn52iJJ
 LtNuWMshvG929D3E/qIf7qxK1WJ6IarXiydv5xaA6i6a5Q8Vn55jwIhEoMe2HtNeSJ
 nHlDuzR9KOy206K/iOWp6Wl+lYRI/xngrjywtgcLChFIJeRTzzcRKgGWbOEed1tg0Z
 XomZWE/NQ8H9tnJ43qWsx0DiDC/2fFVoqtr5MjkHB0rWVhc74EnmKh8GdxrC5OzxyQ
 oM/h9iqnmTrPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 17BB8DD4F02; Thu, 14 Dec 2023 20:50:32 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170258703209.30587.161998781327399194.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 20:50:32 +0000
References: <20231201230257.238513-1-jaegeuk@kernel.org>
In-Reply-To: <20231201230257.238513-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rDsfN-0000kQ-By
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow checkpoint=disable for zoned
 block device
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  1 Dec 2023 15:02:56 -0800 you wrote:
> Let's allow checkpoint=disable back for zoned block device. It's very risky
> as the feature relies on fsck or runtime recovery which matches the write
> pointers again if the device rebooted while disabling the checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allow checkpoint=disable for zoned block device
    https://git.kernel.org/jaegeuk/f2fs/c/29215a7d43c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
