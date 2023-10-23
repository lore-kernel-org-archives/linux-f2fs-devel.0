Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDB3C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Oct 2023 15:30:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1quwtC-00077E-VR;
	Mon, 23 Oct 2023 15:30:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1quwt0-00076j-QE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MeVU+FOeb0V6FcifivKgTCk+OtrpmImIzEQrN6Qfrx8=; b=VJ3CoaAbZYgfmCBR+FfOA0DL8P
 yYubSIgOiZ5hC9Zg8dZjBxPeqC2nz7ag1AhTtl53I2atxwKhmVGWOPEDF36iM3Wp5woLyz21HNuEx
 lpJCqELx8fTBKA7QHHISEAFqREP5BeG4GGwvzKkQ+dlr89lLYxu++394wMWbVI5IrRpw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MeVU+FOeb0V6FcifivKgTCk+OtrpmImIzEQrN6Qfrx8=; b=d9OQVqSdY3I9EOxtIKDMwasnWV
 4Bi9B1RAjUrkdFdVWwNyMH3kjXHaQ1fhTMrDBXQiA3s3jSixN9F4Df3NMYHSVLoUnGSOVw0mireCe
 6QaY34NjRdsJ8VnqcBkwVK4g7zYEyZvYyV8KULtiGuw0a++1OMcnPHdDUd3YIMIIOPzM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1quwsy-007FvU-Bl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1B2CC61E21;
 Mon, 23 Oct 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49DD3C433A9;
 Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698075025;
 bh=iCTBRr0dsiu33PXdRb3tJpIwc6vYGqE99DbJgnFKsiA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VIbm6w5oJQX5F0hlXID2dAkdV5UTAtYPxJdIjCJr1dXzn5BxNHV/Hi1nU4Iidhxgh
 XSIn5fSBRE9FkEAWfR98DUU4NRxz61V9odzGTMPtumPIG28XJhod7KXsYJhdW+Gvl9
 e1jAO2AoXB0GGBfkixq/S7m0q5IV+gc2vU9NQVOHVxer/xbsSGqS524wllIbYtwzi9
 zys+tkOPEhGeVULNMLfmtY6VmKgEh8/OAN6kZoO3T9fBYC49u9FpiB3VNJ1xfK7mJH
 3k/hi2lKl0/fyFqMazkt2J8ghsK3XePnvSIBHtlVyHJ6IpSalVvYdcA6934bk2dPm9
 Y5Nahwr7ZIzAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 26312C595CE; Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169807502515.26537.16625521816473138159.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 15:30:25 +0000
References: <20231020163645.2852056-1-daeho43@gmail.com>
In-Reply-To: <20231020163645.2852056-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1quwsy-007FvU-Bl
Subject: Re: [f2fs-dev] [PATCH] f2fs: finish previous checkpoints before
 returning from remount
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 20 Oct 2023 09:36:45 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Flush remaining checkpoint requests at the end of remount, since a new
> checkpoint would be triggered while remount and we need to take care of
> it before returning from remount, in order to avoid the below race
> condition.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: finish previous checkpoints before returning from remount
    https://git.kernel.org/jaegeuk/f2fs/c/1e7bef5f90ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
