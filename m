Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A53CC3DA59
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:40:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sTMsc-0002qQ-3F;
	Mon, 15 Jul 2024 14:40:42 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sTMsY-0002qF-D1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W1vrvC/lZXzqnE5/v4bjkLVwjEGCTzLjJ3PBGgyRUvE=; b=VIQ1XTHrTzAuPkaSnIDwpE9HEj
 llsAH23e8dq9aVkeM9lcJAaneL8oSqWzwiTtlwrpcQzPCRL+xzOKcxQEPbUT2gzigmofFZw0DXVK5
 J0539jjPFMMNJzNr7PzbsaKrw3bnLCZKXOWaQkF3WnEWymlYondcdl/xkuMDAG9v+X64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W1vrvC/lZXzqnE5/v4bjkLVwjEGCTzLjJ3PBGgyRUvE=; b=mEshbD+l8Vf9SAlu+w2ERc+PT3
 Ly8uscA7A+Ti1SoSncVg4czMDEsctzir0T8icS3gBACRJVDfqa6SR0DLhxxMyeOB2M1C19HYfDUXi
 pKpDmxmSUsLoxcpiM4vLWhfXXbgsNqey7qG9A4XGwKWVPs18y3Zb73j317jJHsyzBKEs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sTMsY-0003Di-Ii for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 62290611A8;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33039C4AF0D;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721054432;
 bh=7lQpNJeDAEX8VEuasSqugBf66qAmRs1PQ70h9A3wydE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=iLltqwFwu6TH5P9yJnujFqZCdIEwe/tHUXpG6lD1fQyiCHtYNux/q1CKAmdTBImHY
 MOj9lxZsCVy1safC1fq7E2HsBh6dqs9krY1frIFzCUqyVtw73NzO2gEEXSakBkGtY3
 D2eWeDHsgna1l/BL+CvVLZReqpYI0oR1XsLq+vsWPumu2SVPtV/StkGIUVpZWrBz3Y
 Q7Uivb7q74oQMNzdC1BKEy86NxOleYKjXkkxIsCRHCTtMnTHCJ7C7dbD9A3Z+GYbJb
 M4xYxr1VamZE7oLDzYgO0dWnckQjnfGjQlT9Nr82DRGU89iwTbMeTcwd3LJ7p5fovn
 sj9iVMBhbMJxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 27E2DC43443; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172105443215.17443.11491545195159801035.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
In-Reply-To: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
To: Daejun Park <daejun7.park@samsung.com>
X-Headers-End: 1sTMsY-0003Di-Ii
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null reference error when checking
 end of zone
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
Cc: nayeoni.kim@samsung.com, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 siu.jung@samsung.com, sukka.kim@samsung.com, jaegeuk@kernel.org,
 dongjin_.kim@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 04 Jul 2024 10:01:21 +0900 you wrote:
> This patch fixes a potentially null pointer being accessed by
> is_end_zone_blkaddr() that checks the last block of a zone
> when f2fs is mounted as a single device.
> 
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix null reference error when checking end of zone
    https://git.kernel.org/jaegeuk/f2fs/c/c82bc1ab2a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
