Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A2C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:40:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzgbk-0002yF-IE;
	Wed, 24 Apr 2024 17:40:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rzgbj-0002y9-Rn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 17:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vP0dr14Tur6j65j0IhKe9FwtwdQ/wB0H/KKZCyZT1nY=; b=Q5SsD9eI2NRhQibg8SLVXr7fpY
 54EMOmLcBDeeSW8soThOuyyWuWZzFDJa/vYFsgB4Vdw2QInsiUcHLh6JOhYPv4Kc+uFrDGM1g8NKw
 5BtXXGjQt5Zbrhh07BEJ85O0Fk6RNM9E4Zw4iTK/bbTQQ+dNedhQQTZMc+CbwcN1r3Xk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vP0dr14Tur6j65j0IhKe9FwtwdQ/wB0H/KKZCyZT1nY=; b=B
 bQvCi9niWS2JG8+KFQMy84I9hUA3e+9/hJT54/PcaTP51yzVWdFjHtjrgqNcpr3BBzIpVM4G9sBkS
 mb/ArqkzhOZ7hif13rXvp07vJFAuHGmKipHkjbVmCBwhRO3De7mM2mZN79kuLKJZdu0Vo9Swj8LB/
 n3Njv0eUJsl6Qzz0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzgbi-0004l5-Q6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Apr 2024 17:40:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 00EB461B68
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 17:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B872C113CD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713980429;
 bh=1TuK/r4o6TuDmkzVSdcm3kHL8XYuZYKYB0KTwm3ZWBo=;
 h=Subject:From:Date:To:From;
 b=Mxfi6j5SvNP8x3iZ+MPFYveMSvIk5mUMFmzeoff9UMvwafngu/B41M5V3ZgdYxrif
 hLUstUsJ1CoEECygllyIFXbWVQrV5ZIvdNVAMiJsTYZVIF1CfKzwM9p8pynd2cP/PT
 9D46z1gQkGGhGTdvEneaxMgXvQMXrwAOLePE/olQ4zguZ+Q9yCxFADp2FXn4WX73F7
 0reyGVxzHwDTn7+BwDm5JNkXZ8GX1yu4++YODK6SiElflZHyfn8flqlrRd/VzaF0mZ
 InkDfz2EcJw3nFxh5Dnpq4g5rN9PiOQWDF+N6B+PX86aXCZMxgpBK4Tb+WS4zMglQr
 KsDe+sn7HFG9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 88194C595CE for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2024 17:40:29 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171398042949.20673.4662856675160142751.git-patchwork-summary@kernel.org>
Date: Wed, 24 Apr 2024 17:40:29 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rzgbi-0004l5-Q6
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: [f2fs-dev,1/3] f2fs: use folio_test_writeback
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=842987
  Lore link: https://lore.kernel.org/r/20240409203411.1885121-1-jaegeuk@kernel.org
    Patches: [f2fs-dev,1/3] f2fs: use folio_test_writeback
             [f2fs-dev,3/3] f2fs: fix false alarm on invalid block address


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
