Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2C7C2D0D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:40:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sLngT-0003GU-DP;
	Mon, 24 Jun 2024 17:40:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sLngK-0003Fb-48
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WoBRdiB1JenDhNnjXiXx9/WHtghAR4JxtOtdkvhDUoE=; b=ezX5r9nkfKGkoRSRK0K6ihP/1J
 AVWYJfBhDUaUc5/MMbuNSSqq7norZueeNkZlHoOpD9iPx8DMFTc3T5V3V/W8D8YMYsjdiIXzNqZ3h
 72/KROuFa/xXjtETvqu2V2s0f3Zcn/608ae66ltErHMHb2OFo0vPnqVLfg7dsAO1G31Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WoBRdiB1JenDhNnjXiXx9/WHtghAR4JxtOtdkvhDUoE=; b=P8tBtn4h9xSoRR1LffRDDwcSWF
 SU3cm73Pli4ETGP7UuzwaDhfURLQj0gQ2gGHYBY6szqfe/5vVZUejsklNku0DvVWoP1IpmsUvbjh7
 dhNUYkd6sDmvrlo31gcEzoQ5bxTVNqlwTepcyh+dPG52+Y5GDVWHiZaA4w5xHcIJ1F3U=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sLngK-000253-D1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EDC6BCE01C1;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E1E6C4AF09;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719250831;
 bh=UgjBZziCdN2Taf5eSsXXsJtqJ7kU4QpFWTH/FtVBLpI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=X8TTt8NB9+lbJ16LgMefXf5QzIdmNGecHO8hwaP+8t3elXmTKdtteoLgirIQfg18c
 EzdiiZoDHp+jh6CvkhANt+NWw8UjjokUyl1/G4llWyGnTSt6H+xvI/pgWGWuXw7dqp
 4yLum1Trx21XMUBzd8NP2hkpbFKJyu8Rw8kUe3bqqxSBkTZ+jTx1+PlIluE2XukFyp
 krtFb64IFyu6Je63O5AkemsJ4kVFqOQ2nYjWCDPPDfOqvwcTExBqnmHVxRXUI8bjyj
 vXSB5ADRN8entcQcFaCmVHVkVFf+1DeUiQfWWxQieGHabh1RRm+w31fEj+5DWjBI7f
 iTHNetKJ+bDgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E2A33C43616; Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171925083092.4247.2292355325725216488.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:30 +0000
References: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1sLngK-000253-D1
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: enable atgc dynamically if
 conditions are met
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 7 Jun 2024 17:00:30 +0800 you wrote:
> Now atgc can only be enabled when umounted->mounted device
> even related conditions have reached. If the device has not
> be umounted->mounted for a long time, atgc can not work.
> 
> So enable atgc dynamically when atgc_age_threshold is less than
> elapsed_time and ATGC mount option is on.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: enable atgc dynamically if conditions are met
    https://git.kernel.org/jaegeuk/f2fs/c/6efc3a05e613

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
