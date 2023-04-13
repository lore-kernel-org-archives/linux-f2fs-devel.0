Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A753C77B76
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 23:40:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pn6YF-0007gy-Ci;
	Thu, 13 Apr 2023 23:40:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pn6YD-0007gr-Cb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SeKKjfuKu69fFYaNNTTVIq+pQmFGAznwOPXPFeCbZs4=; b=QJdfEVgSztrS5G+qt0Qcjs70ej
 Is5fXyzGgkGKI5k8yaDvIvW+d3kEqofAJGNiAsxOLYLu3+4ciKCwT7UsZ0VdzVVST6AbYvNlVHmVf
 7hEeqSArcsKlcMA4EqItwmEMXrVvtFvJUGE8+SWLMWY08YvDH4DZFiTPXqZeFuZoTQeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SeKKjfuKu69fFYaNNTTVIq+pQmFGAznwOPXPFeCbZs4=; b=J8obNGjIlGr6UgcfdyQHnP6act
 5/BAveBy/21qXIuBYnLqbiQcuTgpy7GTL8tDzdmmLYMSIWPBZyhaJ7WWkLEfT66PnbHmHkKEqWr0S
 DUtxn2cHbhjHtZ2ISmXk6sIbW2K7DA7y8VG1jc1XjwqKrJWiVoQbTCQ1Jsyzm4JuIifQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pn6YD-0005Mw-0g for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8346863FCB;
 Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE7FAC433EF;
 Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681429218;
 bh=V0CTI6o+YvR2IX7R2wrETiBS2lq5Y45MatYg9uYcBOs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=JG8Fy8qRxJ9y7/5GPehWNCw75bSr3YKUXfWq8jZbESZ5WNz41I5czIOhDjZb3Rro7
 RXTHdaa5a4A8WVNAO+rmGpE1KJmoWdUvUhp08HjqHtji4RX1mHHT47mau7rBtqa+ho
 LFWczpYkoimbFRpW9U5Yvu90n/Xg2aiU7BvU5NDrF+wQaYBJlpB18mr7je1rB7Kqw1
 /7Wc9+hw6n27tVa9hOFAPSVEbSvANzfCsK1hAgQhCTkbK5T3wi5x6qX520L2AvqEWv
 v36CQvtILgyWbLYD8mj5C6xuM3xLcCBvs71emVZwF52zJoyk0lbCpus+jXXHlH3sI6
 VIn0/NyQ0vGCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 ABD42E29F3B; Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168142921870.31957.2906267812232353546.git-patchwork-notify@kernel.org>
Date: Thu, 13 Apr 2023 23:40:18 +0000
References: <20230406221104.992322-1-daeho43@gmail.com>
In-Reply-To: <20230406221104.992322-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1pn6YD-0005Mw-0g
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix passing relative address when
 discard zones
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

On Thu,  6 Apr 2023 15:11:04 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We should not pass relative address in a zone to
> __f2fs_issue_discard_zone().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix passing relative address when discard zones
    https://git.kernel.org/jaegeuk/f2fs/c/1ac3d037bee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
