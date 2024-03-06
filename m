Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46BC5475B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:50:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rhvPi-000069-8U;
	Wed, 06 Mar 2024 17:50:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rhvPe-00005j-Fi
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Mar 2024 17:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26ClJN5fxdRNROl0Qrcw5njl6Bfh1rxKHRJyCxi6L6s=; b=AX/8cRxVBQ25cLHE8RzLCh8eWr
 liqb/RGJjp+5DIk77NLXy9JzT5EdvCq5PX9Xp4bWP/7CBCc7JjQsQLkDJ5nm97KCVU/8PoxEoJtKa
 dk3jRO7aQmIGTO7jhXo1ExYuLLnPvozI2Bd1qEGTWqWjBgEY5iEPEP3U51rvwOm7+FV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26ClJN5fxdRNROl0Qrcw5njl6Bfh1rxKHRJyCxi6L6s=; b=UmUXnihc+ynwQ8nM4rACPyo6/S
 h6rGRGHDigT/yEqGrF0nvnXdNOA9lmDkbyjyfqcH+Ri4JSyBDyTa2YGmQJlx2mlEQC/9gcVyMvTmL
 M8JvrciE2BZ643W+bWjcrtltPPz5ERai+Ld8gnTI7Ep7iVe52xOcPxBvGHRUv+mnFLJk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rhvPY-0006VH-4P for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Mar 2024 17:50:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D16C8CE22CB;
 Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A2D7C433C7;
 Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709747429;
 bh=7CB5Bot5JtGx9FNOHp5QlZ+t4Ki7IpsGY6s5MKPegSY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=TFSZGg6tb8BmHi/WN/doDwAsZ9zfjJAYcUXgkYXP+0UNL4QEYLy2LEh6uFQtgO/8v
 7jRRTsO4l0zSuoiv16tK16/RA+gd92HgkIwTj0oVO9F908DVR5p3cVFmH0noZ1HmiZ
 UA1KnikxF7HXc+AdOGSWdq+FkKR80IQlMG1N1xwDfP4g26ZBW1Hcnzd9CKxAhJwIYO
 TfogW+jsIf/bA5elYAD9tA1Ig6fU2aoaKy85vuEkqa9SzWg0FEBlAGr6iCcIjAa1il
 d92h4m5VYBHZkj6MoZtIVcdku08ROcpcnm/HOish5Oz4fm6AIqahayztM15gIhdmZ+
 T2BSJbcW+0XLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 ECA7FD84BDB; Wed,  6 Mar 2024 17:50:28 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170974742896.3369.11970088169453313081.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 17:50:28 +0000
References: <20240305080943.6922-1-r.smirnov@omp.ru>
In-Reply-To: <20240305080943.6922-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
X-Headers-End: 1rhvPY-0006VH-4P
Subject: Re: [f2fs-dev] [PATCH] f2fs: Cast expression type to unsigned long
 in __count_extent_cache()
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
Cc: s.shtylyov@omp.ru, lvc-project@linuxtesting.org,
 linux-kernel@vger.kernel.org, k.yankevich@omp.ru,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 5 Mar 2024 11:09:43 +0300 you wrote:
> Cast expression type to unsigned long in __count_extent_cache()
> to prevent integer overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Cast expression type to unsigned long in __count_extent_cache()
    https://git.kernel.org/jaegeuk/f2fs/c/e88f4647d82f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
