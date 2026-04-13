Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAF3F531DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fruEUXZ3LZspH8GnM2jvNdm+5Rrg7zEZmNkMqjzn2SM=; b=kW96YZsixHsRwmIIbtDdbFjumx
	00yq4bY84GepxJgD0M8jp10/CeuHlBpbDeEE78Bdc7oGjXDG9CedaUDZZujKm0djJEMJ79I08Wyur
	Ia9s8Bvq03FShZA1FFcPWUoUKyXoaRZ+YZ6+qa8FLWnGqrt4zCVGpPTBKcbTeyvoJ1+o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCQGs-0004UT-2q;
	Mon, 13 Apr 2026 23:00:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wCQGo-0004UL-0O
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 23:00:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HM1bF542g1YPfk3oQf6Rk/VAaTEJpFLBMQxDnsdulo=; b=HllGgzojU/frSKeqm9HnHdYqVf
 8wtxZsupe8/l6swvbCAlPOkSj3Yhhilj4Cb8zufqCP3dyYDeHSayLFWU6fla2njU3R5WIWxrUkGqF
 6mj6BeMySBAajuKAVetQHV4yth/brZwWVwbCsVih0Y/EQhBm05atm1ukhGJlQSTxJbFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0HM1bF542g1YPfk3oQf6Rk/VAaTEJpFLBMQxDnsdulo=; b=e
 4990xJRKYovar+Ndx9ioz3qCji3CXmTH8Tu4EF6+XMeKMtrUpzLmPOe9t/W6ltu/jtEb31XzaoEA9
 s/49s4cRefC8YRQXkV395fOKNBs65yhstmx/W/Sy7SQQH/exzf/wudjbdy5OTPF9LMeUiaRSloJjf
 WwXf1WirYXlZuJG4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCQGn-0005s3-Hk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 23:00:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EA7543F14
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 23:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F405C2BCAF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776121236;
 bh=7VwHUqWCgdQTu2i25YH6mmwiOR/vJ5eMQ4+WfJmMh+4=;
 h=Subject:From:Date:To:From;
 b=FGvxVNYgD4pfNn7bY7kN4PShWBHlkTsQsaEABPMkWlPrJOtg/3oClOCySos3pTDDf
 QomrUjiZYvNhK6Hz+EZl8k+uGzNWMlphRrH8lTt6zNqeROVCHe79bnE1hvS8uQ5QZO
 WhrFnUSXd1ZCFesD6QqxXao9EDIeQVX+zST4LSJDbgIHwQZa50dAlkcT2nhbK2IxwN
 iQ+MNRLmyJ4V6kWHke3YF5NgRQnnNLyZNHG0DgfsEQs7qEbL5YrCGi9YQh7xA7ZQ7J
 2uZISyDf5viIyaLKCWAWArF5WCWsfcvvDEIolmCAOjyuIilzz7BYCdyzBpihqbTDtq
 WGbp02ZW7Jkiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7CE2E3809A0B for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 23:00:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177612120713.590374.17142952453801660635.git-patchwork-summary@kernel.org>
Date: Mon, 13 Apr 2026 23:00:07 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wCQGn-0005s3-Hk
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: allow empty mount string for Opt_usr|grp|projjquota
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1075345
  Lore link: https://lore.kernel.org/r/20260331174326.231867-1-jaegeuk@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
