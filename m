Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964A7C3ABCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJJ4-0002ka-8y;
	Mon, 16 Sep 2024 21:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJIz-0002kL-W8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aGKNt/k9BlSnLExZ2fd4muJSaGhSRTZ0GxBI2Y3Noy4=; b=j9/gGUn97dabcF2Z4Ol9zPhbW7
 4zOas9Sm2YKh/gHi7gE6rnDwV4E7lPRgP+IDJKtAqTSaRH/SGWBcfiA4ER/E3UaBkEAb90D63OIJ1
 tMEGmdqjOKW/sCH83A/GBK3wJekBMTTa/9a1tqbnR1FJQzYefq0ItEWh+0O4F1jAInu4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aGKNt/k9BlSnLExZ2fd4muJSaGhSRTZ0GxBI2Y3Noy4=; b=TO0SRkAvJRCfBK8Y+e4FuYhtpB
 jDxB/OCz+fcJQH7QxGvtMKlZapIGC/EuQ2Wwjxga/dnFb+WeOvlp5Cd/Pcg81Kiaxghlw+XTnCELV
 MdijVKb3ROAGiYXjhiKdaTSiTn/QZIWx2WkjCgZ4wsZy1g7XWDhYDrVKplu9ntHkdDwI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJIy-0000OU-UG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E20BF5C061C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Sep 2024 21:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65305C4CEC4;
 Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522234;
 bh=IElyhfDN78o1mbiZffXzf72XiMjmhYBD9pCERzxZN2k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DYb3rr07d3TzvsfgyI2elKTpoFP6pbCGOMlLQKhlrxN2ftizIJfSl/sr6u1fbA61w
 k2thi76x3XeAJ83fkewk0TldXZMNgdcOBuuthxn8Fn+kXgSWcz65zhfp7GI7nwRIFL
 KBGS/shaY2fGFe/xmjQCw89OZrTjCTufGkC4O8DgLVi7ygaVd3pwnKOvS9bQ6obpcS
 hnNbTQwotXnKro6caW7UaXPIaIOMW+7n6g7rNm9HNXPTNR68bPQw9T3zMP/KkOAJs0
 jnY9bqvdS4pdbAKX8ztitne6YvxZLV6bu+F0WCpobhj3avXBF+sCHCEoMCc4/YJX89
 c5SDC35Q/M1YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33E853806644; Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223599.3820990.7788824828027829337.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:35 +0000
References: <20240904032047.1264706-1-chao@kernel.org>
In-Reply-To: <20240904032047.1264706-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sqJIy-0000OU-UG
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check atomic_file in f2fs ioctl
 interfaces
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  4 Sep 2024 11:20:47 +0800 you wrote:
> Some f2fs ioctl interfaces like f2fs_ioc_set_pin_file(),
> f2fs_move_file_range(), and f2fs_defragment_range() missed to
> check atomic_write status, which may cause potential race issue,
> fix it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check atomic_file in f2fs ioctl interfaces
    https://git.kernel.org/jaegeuk/f2fs/c/bfe5c0265426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
