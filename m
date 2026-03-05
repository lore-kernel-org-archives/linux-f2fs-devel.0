Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662C7F47CB8
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SX0AOpd195Fq4xyuyUJZA/YkXc/+BoUhOR03m1PtP4I=; b=eTaqtEtb/BACcpzhCLoAFxvYAY
	bZ193MWFIjbCuFUFDJu9qNiVzEWeZQulc/ol/h+82molMDP1Z2mWswLaxhrYmQL6yP9qkoowFORUH
	VyMXB4zpkOIJvK4/LhQYF/agojdWFgKB33ymmzYV1uCR/CrRCVa5Hheqpo/3swkdRDWM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vyE8X-0005pG-DO;
	Thu, 05 Mar 2026 19:13:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vyE8W-0005ov-EW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:13:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f0H+tgvbUoUD7ssVEirabvl4/l4TeyMFfApiusR3vtY=; b=I3nKG4cYnkE6KwIBWSiFNkfkET
 JaHtbEUh4WPP5kmCkd6ek7te2bulhYVl3N8ia/18px+ZihiX7QLpKxYWTY8Zkbp7d+bw9lnpoiMxq
 KBl7efSeG4OPZRMmk6KO/7K9EmbbVzhRwFx1XNc8ylotWHhLOrwm7Ct0ay9+OsAbI//Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f0H+tgvbUoUD7ssVEirabvl4/l4TeyMFfApiusR3vtY=; b=TqyLeAKhZ2+rSXsAaa+AYkeGB4
 wz2VjFD2o8AkS/EEJLxVdroqATf/hy4OF1QilXVU7uDrmMPW/Nus5HAJSL+ffy+NTQwi/YfWc0a2+
 VOnWdtGJltH/TjK8GOm88Tn06KQlKJG6NIRoW7JXQn57s91m19a7Aq7eXMSKGX97uHxE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vyE5W-0001uy-AN for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:10:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B7E64451B;
 Thu,  5 Mar 2026 19:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE817C2BCB3;
 Thu,  5 Mar 2026 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772737811;
 bh=n4qTCbtao9JGaBTDzgW2e6OtFsZ8Crl6mZHiOtg6akk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=uShF6XncyAAnHOhHKhN9EuhDdwOI2Ca5DvZlJbLrZebboYi4kAvOaMiUjgNuP4xx4
 /1gza5wwKsc9l0Q3nxhKA6JoSGwq0xpPtVD3FVqixeIC+2/VjsvycOlN1OjqEGFjFh
 dtEvplzjaeyRnLFkuyvsbXtQLUETd3HNyclwfyEzGc82IwWvsLTotSy/GFgKIafX/M
 9iYf9qKDSON2WScfM5mVSD3ptXHjoaeIPnPQ74vMmy/5Yx7Oe4mOaSnNvxIh7a3h51
 3HkL138a78H6VINRHWUxGPaFEpgjtbWyc4UZcEMc8mryvVrvFDs6g1xkJ+LCcE+PCW
 54AF2QFRSdX1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02F123808200; Thu,  5 Mar 2026 19:10:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177273781154.3248266.8962650813192788193.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 19:10:11 +0000
References: <20260227073052.3940958-2-monty_pavel@sina.com>
In-Reply-To: <20260227073052.3940958-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1vyE5W-0001uy-AN
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix UAF caused by decrementing
 sbi->nr_pages[] in f2fs_write_end_io()
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: syzbot+6e4cb1cac5efc96ea0ca@syzkaller.appspotmail.com, jaegeuk@kernel.org,
 yangyongpeng@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 27 Feb 2026 15:30:52 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The xfstests case "generic/107" and syzbot have both reported a NULL
> pointer dereference.
> 
> The concurrent scenario that triggers the panic is as follows:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/16219ca5493d
  - [f2fs-dev,2/2] f2fs: drop unused sbi parameter from f2fs_in_warm_node_list()
    https://git.kernel.org/jaegeuk/f2fs/c/5f04e90eedd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
