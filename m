Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2946C6FD1B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Mar 2023 17:40:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZbIn-0001q4-MP;
	Tue, 07 Mar 2023 17:40:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pZbIj-0001pk-Rk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 17:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=24YD6Q4+lqMY4Nu//Qu/G1/IQnDyuQeElknGjb/MC+4=; b=E1lGhpw2Pjp4hMEJmDle2O0yvJ
 33pLCH5/SyIQxBj8DKvl0iCGDi0yZglAJFLENv2YjYNo1uM14LBmWJLixT7EzaniqXPXBecGDYH7f
 ShRhtpbpHTiXeLKs0GOOjCruFT2usXvYXWpdlM0coX2SYgRDYHJe7wuzTCfdGXkYZ6tw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=24YD6Q4+lqMY4Nu//Qu/G1/IQnDyuQeElknGjb/MC+4=; b=Ud1M9OeCaBpPUN/IVzLei7r0Ve
 ftej2JIFA5X9ctliiECoGhychBdfVHMW7ux6GbtkFH9aZQZYDurBsPwUKtjZuNE3kjedThE0vuQ3k
 2iTn4DsS8v7m8Csx88EX6T6a+5DrNuLObvmcbnNbi6oaffuhhTd4/n7PoJzbn/Rwxvpo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZbIe-0001Kp-Mc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 17:40:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 43C13B819BB;
 Tue,  7 Mar 2023 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96D7C433EF;
 Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678210825;
 bh=sIZlFfMWBsTCJuuFDyf/IkINN3ShV1UqVU0yc1AsDfw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LwV6l6rpbxiTRQuAE7nCrnXMmK3dA4wKKxRUJJVDgTP1wRdXF8xx/Be4f26cV2Eqa
 wzpwDtUUj8E7eE7G1rNt2KoLk77AqTaUBYo7gbsP13jii6umm5OcLtmPcB3lAHXaiw
 Aivuxx64KBVym0n+7XXa1yzdJFasKX3pWmTd0YRPvnzjhvwlpHAsR8WPD1bjlJxSf/
 bE3SVMvMOEnZ0vUGR1YTgmWH09dsMXuLCpTvx+4ggioywLUZeNwZAsINUrjXdPZwYO
 L8zCBYfs1swvGYSdeOwZv38NKLXBAMYqizxVVobulj4m4EMKpNwO//KygLF6ZtYwTV
 UKQnN5twyCX8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CCAACE61B65; Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167821082483.1693.5488669635546632139.git-patchwork-notify@kernel.org>
Date: Tue, 07 Mar 2023 17:40:24 +0000
References: <20230216140935.20447-1-frank.li@vivo.com>
In-Reply-To: <20230216140935.20447-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pZbIe-0001Kp-Mc
Subject: Re: [f2fs-dev] [PATCH v2,
 RESEND] f2fs: export compress_percent and compress_watermark entries
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

On Thu, 16 Feb 2023 22:09:35 +0800 you wrote:
> This patch export below sysfs entries for better control cached
> compress page count.
> 
> /sys/fs/f2fs/<disk>/compress_watermark
> /sys/fs/f2fs/<disk>/compress_percent
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,RESEND] f2fs: export compress_percent and compress_watermark entries
    https://git.kernel.org/jaegeuk/f2fs/c/a29f3722b128

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
