Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A26C761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Mar 2023 16:00:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgpHC-000482-74;
	Mon, 27 Mar 2023 16:00:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pgpGu-00047O-8X
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SJ6yumhRStLhIYhYwZTOjDyop/PyPyjpcBXBU07q30Q=; b=nAloYA/SDwyagKDP0kULHtGqA7
 shqN0N843MKOuto4tY9sRX0DS2ahk5mo1kALzU1xk9j4kJ5J90k1+RiAOdUfqt4WWSIiAezD+p8xK
 2WhiTjXp2MeYdUwAPeqW9or1YO6V7nvnowfdb7mSrtA6r8sZPRLKFn07ENvGk4pKT8lM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SJ6yumhRStLhIYhYwZTOjDyop/PyPyjpcBXBU07q30Q=; b=OUCekVRKArWzgDp8TqX0o3Kd6J
 DgQxNjsx54SgGK4zZJVuc0Z2FHImWBnehzXa1GwZhKFDtqZLq1RhMXHgv1Iqni2FlUd8gvwTT40Ji
 hJVCEnNP1P8u7JMHjmPFzSlnjcTH1RP0EGA1PZQQtWGY8RhjId2otHLVNAhnXvVGk0wA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgpGp-00038S-9I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CCDCCB816BF;
 Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29540C433A8;
 Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679932820;
 bh=mTrcWKNvXGbT1nCUhAXnXUsx1ffGSRzt/7LW7RE71Oc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=TmtfLLkexyXxxNSU3ZxwjIWeNSqeqVM5tZpT6DoY8HccxP8lLXzZQJtSqtoNiObPi
 0g9LrejVu4HKz7iJ3SdhQZPvirEZ5l7hL5P03w/xCeN+T0v5Bk8bZmTFMMHsWpVsJP
 sIeLQjUKIjrIudId00QQRMPI1BwXNksmv133H0Zlb2J5jEceWF/etzMjeRaKGu22U1
 Zs8RCNKRiYhuJfJeNfcIYDEQSjGj78y0s9bIFyIMOQzphutGtEB3GPdG0BIr99UaQ/
 UXFgG814S+Wz2yhx1WUWANwaLtYMtPVtMEDrUpU1wl6L5MHzqgtnXwk0wYeLsA6AnT
 7I+xusfwuUyGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 18387E4D022; Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167993282009.32120.676262168059778051.git-patchwork-notify@kernel.org>
Date: Mon, 27 Mar 2023 16:00:20 +0000
References: <20230321001251epcms2p4c1fd48495643dbfca2cf82a433490bb8@epcms2p4>
In-Reply-To: <20230321001251epcms2p4c1fd48495643dbfca2cf82a433490bb8@epcms2p4>
To: Yonggil Song <yonggil.song@samsung.com>
X-Headers-End: 1pgpGp-00038S-9I
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Fix system crash due to lack of
 free space in LFS
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 09:12:51 +0900 you wrote:
> When f2fs tries to checkpoint during foreground gc in LFS mode, system
> crash occurs due to lack of free space if the amount of dirty node and
> dentry pages generated by data migration exceeds free space.
> The reproduction sequence is as follows.
> 
>  - 20GiB capacity block device (null_blk)
>  - format and mount with LFS mode
>  - create a file and write 20,000MiB
>  - 4k random write on full range of the file
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: Fix system crash due to lack of free space in LFS
    https://git.kernel.org/jaegeuk/f2fs/c/86003b7460ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
