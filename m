Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DC7C27C7B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:56:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sHQKS-0006uv-Kw;
	Wed, 12 Jun 2024 15:56:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sHQKQ-0006un-9S
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORnkHzlX295IrGtbxXVABIoPWnI67PEqQ2lw23hK6CI=; b=JOhxPpgq2JahEepVs7352PAtH0
 1MWaIKtqAiTEly52v3503aBxMV6KiAvpNQQO6f8CCyj6o5PdDtQlLs24g2R/G69lciaP+y7jZGcvm
 YUOFoSFbq8jdooWv9DFFK18J7uNYX6GSNILlCa6eo7EqVjwz85mf8MS8tPM46EK+xlc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORnkHzlX295IrGtbxXVABIoPWnI67PEqQ2lw23hK6CI=; b=WTJ/K8A9ME/XT1gf8Vr0Tkrwk/
 bI9kzHZW0dbot+cfH/SMMxt68D+ofp6UWDdC54nRlhhMhRLxS43E44e5kTc3+uhtlAtY6i7VTtHRY
 1IR/ntfhg0tXvxMKxfSXwHtQzNe1J02ddv3mXL1WVog3bvg5cy4CVOjHHJenFLF//Uww=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sHQKR-0007Ri-HE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6B07B614D9;
 Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21371C4AF1C;
 Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718207757;
 bh=DZPyxFdKirmwiOX/njEKegbJptxiHo8sI/vLKAKdO74=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=HYZaTL2vORBb8W8g+jzjLsH7pHyggMjmQkJ0pMhqZQNDXhzHhVufNzzvGCcSBYgnr
 z1QNVhCzNDuS7Fnar67O57lDD4XrGEb/KHM7yVTbkxC0KdmPNAc+jTgvDklTBapU/A
 7N7k/t2oqI7j2tNCakIwUjvQPKoNHYJk+jtienv1hvQOVBjAOeG0q7CncW/wjF75XS
 YseMAzlGeBHtvjCCNmziSlmh+v+LVATJWxpyxF+2Yc2mad/ihOx+l9nl6OeTZRsxbE
 OVocZUMxDrJFHS6+AYnaaTs2+GE2bbhMPMWrvUFmSUbJ6bJnDyhQFmVCP4oYJgYT5V
 docIxYS/r+NRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0C887C4361A; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171820775704.32393.17458759004168978642.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240530100158.762954-1-shengyong@oppo.com>
In-Reply-To: <20240530100158.762954-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
X-Headers-End: 1sHQKR-0007Ri-HE
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: alloc new section if curseg is not
 the first seg in its zone
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

On Thu, 30 May 2024 18:01:58 +0800 you wrote:
> If curseg is not the first segment in its zone, the zone is not empty.
> A new section should be allocated and avoid resetting the old zone.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
> v2: remove and update inaccurate commit msg
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: alloc new section if curseg is not the first seg in its zone
    https://git.kernel.org/jaegeuk/f2fs/c/76da333f4b93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
