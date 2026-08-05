Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B9C56207
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StSYiIsBxp71D4xA5wJ+Kh/dwvhcNm91C0xs+n4vhTk=; b=Jeestd8DQLGduqSjhcN3Sc03C9
	yz7MzPulPZfljU+Km5S7L0fri6EnS/aExJ6aPgf/kCFsnxHCFyNoO9soClZ89vJwQ0t/HtPeyVSid
	+9OdpWbZ9E5F5F7s4FvmxLfYVmMYIa4xyg2bHEtLqzjS8q2ykb7VnGE2mNZkzKv6t8PY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3T-0001fv-Kh;
	Wed, 05 Aug 2026 21:21:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3P-0001fY-4s
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBAfDmBTrS4RbICPXLAAqohn/AEjIYJN050Ab/3SqCo=; b=UyfOpUYrrdaFVrd25fyj/H2/Tq
 EwejPzJf80YvZugUuG5k7F9ThHuG3Fyt4jfGFSmTKoHbarom+bMb4nCkmMLkZXSwA/rUGWmRwSSF2
 2JEUmSwQIWCHRy3xAnD7DEGHrqY6cASmHywHNp+yQII4koHmpp2n4H1iOigFtr+oMFQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBAfDmBTrS4RbICPXLAAqohn/AEjIYJN050Ab/3SqCo=; b=ZG5WEd5/oEhSNz9E+QcTEWsCO1
 HSsxEC8xRts857jiNfTA/4Z3bkaqMBEWQCRvuyTrcMGR5Vs/kTfFj6mV9g/aYUQBI6BFDoPCikOG+
 S6SwenJ9hNtNXbl/YTUoADepXTSOQGigQDf5MwUsktEnW1zvAszO04Qm+l31Xxh4G1Xs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3N-0007Ae-Ti for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E45560A80;
 Wed,  5 Aug 2026 21:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140CB1F00AC4;
 Wed,  5 Aug 2026 21:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964888;
 bh=VBAfDmBTrS4RbICPXLAAqohn/AEjIYJN050Ab/3SqCo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=nxiVkdsUe2VaL/LOJ0Oi2Sbt8/nLaJM9sf6MdSr465ZMGBP6pczxhT3PkwlW+rq3V
 5/2LV0JihhEzJ4e4DFrJUzziS13+YcZBiUj++HGgL14ZYc7yh8uH1lyar2CBjCBhhT
 2sb5/8GgQfxNQ00soe5whGTL2hanxSf4BcYuJ48eiF7u5Cs2WK120+xVHuhF6HK/5R
 7rfupX2A7Y9xdG5GCRJkTgdjfF05N1iD2Ro530E1pkuBQfvu2HLHN7VZusZk3b55iO
 3ZzWqF1qhaHvoCILnFgpvfacj67tK4eUzJaXlCvE8BY3cPZo9kascn0ndaVdHoeGev
 hQfUu94W5LEDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19827392FFD1; Wed,  5 Aug 2026 21:20:49 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484763.530543.1976176179653312885.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:47 +0000
References: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
In-Reply-To: <20260804005402.13026-1-chenchangcheng@kylinos.cn>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
X-Headers-End: 1wrj3N-0007Ae-Ti
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, ccc194101@163.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Aug 2026 08:54:02 +0800 you wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix valid block count leak on data block allocation failure
    https://git.kernel.org/jaegeuk/f2fs/c/0f9af07ecc1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
