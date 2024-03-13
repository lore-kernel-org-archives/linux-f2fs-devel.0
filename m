Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B4C54E5D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Mar 2024 01:30:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rkDS7-0000B2-MD;
	Wed, 13 Mar 2024 01:30:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rkDS5-0000Ar-JR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Mar 2024 01:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuARYiyIcT1PM7Kfq0gVcYChTsc+N/Twv3AjRsR/zTM=; b=SX+qY+SVXi+U+lS/WvDSUrzywB
 1JZbYX1ScgU/FXqmYIuc/mjhbU7EVaEeZG4Po32nMZ9aow7LHBouhThXYiQRe3Gwl/5xVnVxKFhJj
 lSfft6fPeaEEzeJuwmuO5yiM9+KGW03C91euUJ1cRqmG6Z4x0WrcjvFsWM6FfvZQTyMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuARYiyIcT1PM7Kfq0gVcYChTsc+N/Twv3AjRsR/zTM=; b=nKSXH7/mj0bx+/u1k/q6XYYWOZ
 VxrUuolAPzwtle0Z83Hy3iw+elW46bU8sBHK5Z8KYeNKd9d2zdzDa47/c/zyrR83RcQ8fXglVtMfc
 71x4bnRpBJ+S3409tVdViC5SsouEbkRD+i40ITdMfbmpryEVNmA7Vwkv2HDK21iI2St4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rkDRt-000237-Me for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Mar 2024 01:30:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5BBE861362;
 Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF8F8C43390;
 Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710293430;
 bh=7nZy9/vurPXr1lYbS/73LM5YtBWgmbZJ5YIqQSYtFnQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=J2Bga/YRp8sVgNGz4lcaA0QlE7hQfgHBNd3QdMB6cHyqXJqSEERoitbs2VSjHjt2E
 B6DsR5KTJKZ4CYuK80W3zg0cbAoJzQq9pm5Ygf03xmdcE0shLRvu1ZfJPghO3kwu/O
 iqEpTSN78NxwvVG2np+US9IIf2M0u6umaW5TXWs4wcq4+2kp9kA3fUkAyAUnDigX/T
 MUzjIO9ulbz7Z3PUHtsEQQ4WA4GS615T2XuY6H5W3afTxK8/Mc0BfClcu0bvF7KeUa
 7Xz2TPBAEr2857UYIqDypdiGvBdhMeSW2Z+/UDDzyo3HKt4ruEyqLd1vYO1aVlKyTP
 5If3Arl3uP5sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D0540D95057; Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171029342984.17296.1929429193688050018.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:29 +0000
References: <20240311235921.1832684-1-daeho43@gmail.com>
In-Reply-To: <20240311235921.1832684-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1rkDRt-000237-Me
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent atomic write on pinned file
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 11 Mar 2024 16:59:19 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since atomic write way was changed to out-place-update, we should
> prevent it on pinned files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: prevent atomic write on pinned file
    https://git.kernel.org/jaegeuk/f2fs/c/c644af133283
  - [f2fs-dev,2/2] f2fs: prevent writing without fallocate() for pinned files
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
