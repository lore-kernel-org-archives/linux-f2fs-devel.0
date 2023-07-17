Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0027DC001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7I-0006vF-8V;
	Mon, 17 Jul 2023 17:34:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS7F-0006v3-Ur
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6wNMhbacpipv5n/gj0l3s0Q0Nru6S+LBHbLasn76qAY=; b=ZGtMEh417/Ioepbd3ROy/bmsxB
 BDAVBjbNRHVCBKLI/3BaoCKvo96RozI1MjiqZFO54D5hR6j5eJZJ/vo+3uF/qMqpfeGXQWVz61tw/
 bLodGX7SFr13022K44OuqowOBLdc+tRyhOzFuY0dPAwadLF9aK0beEraTHQJHkiMmkRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6wNMhbacpipv5n/gj0l3s0Q0Nru6S+LBHbLasn76qAY=; b=hxhECgHCort1k09yi7INLs7K2x
 SEya0LtvIN3QE6hQMrWh5edHIYcpdjYgUqwg28+uzjr/Gfiu1mPmWKy2rgJIQWIY5q2f9GEJD5068
 iuGs6xKXOSpDhZxViZjwFpRniiIHjvxHAwdHF5Dd9DB8iH1hkjPgR303YZwbfTg5FGLU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7I-00014l-Db for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAEF611AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12E76C4339A;
 Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615262;
 bh=4ZvqU758s2JKaNXLRepPna0T6aOCUUXfAyBfPR8X2VY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XSQ4EZW3ipVSumHvPXWYtnkSlLMtIQsp55O6t0OWefIpLJU6mOQ33fykGZQSD+XCL
 WQO1rNHu79U+li2ThhL0UJi8n7KqE1NWixR5Lh9c2H6nYxiqTV2gI487LSAJuWObKy
 nrt9PO+ZGljxzeatGDTeLOX7UawhMbDJsyxXJqEplq8dEY9KTGA3K3HyKSCwkvc2kL
 cQRPGESCBHkyUv78DVU2WGtRP/jnJ56uwk3fZ8Ef9QkDA0RjuVjpAWMJn+dd7nJB1A
 yav6BMCReubq2L3MlZ1vaZ/VA/xS0uGeTuhNI10/xy9x/t+etnsHGwZbkGVHwlw2ZV
 2meSprAdgZ48w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E4D5FE29F36; Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526192.4078.9064603829957550841.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
References: <20230323213919.1876157-1-jaegeuk@kernel.org>
In-Reply-To: <20230323213919.1876157-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qLS7I-00014l-Db
Subject: Re: [f2fs-dev] [PATCH] f2fs: get out of a repeat loop when getting
 a locked data page
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 23 Mar 2023 14:39:19 -0700 you wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216050
> 
> Somehow we're getting a page which has a different mapping.
> Let's avoid the infinite loop.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: get out of a repeat loop when getting a locked data page
    https://git.kernel.org/jaegeuk/f2fs/c/5a47ad28e606

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
