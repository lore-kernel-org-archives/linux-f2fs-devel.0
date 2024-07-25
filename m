Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8C2C3DA61
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jul 2024 03:26:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWp7y-0006Od-41;
	Thu, 25 Jul 2024 03:26:50 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sWp7x-0006OT-33
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 03:26:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F9HBKv4THtm7DQDDkCp5ZXireMeOTMiu+mUGJ6pOpP0=; b=gpS63Znf/dsf7PlgG4ZSrOMo9M
 p7UUui/QphPntkUk2tmOfyOGongIT9jRq+lEF7bh2duWXrNDHkcdKHgBWNJvV54FoIMb/L9WyDaWg
 krqnN7J8X2CoBUSjDa/cqJ+GezBrWrr9YvVqL3mX3wBYA9SUH9Nyf5+CO4Dz0fX2Wvtc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F9HBKv4THtm7DQDDkCp5ZXireMeOTMiu+mUGJ6pOpP0=; b=Rw298rACsRfyFQJ667XbRqrMYn
 45YwGpOFevY5JLVH2rx9Fk6AT+7tpl5WBXiSeAAEJgTpajwibp2epmSj04YLML/o1KZ2HRv58WOAo
 di3Oyq3wu8preTYX9KOiFvM5DMJGFK8eZpxew10Kbw730aTWZuyGQ5yL5MShtmtRYYcU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sWp7w-0005re-Au for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jul 2024 03:26:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9C5BCCE12EC;
 Thu, 25 Jul 2024 03:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6390AC116B1;
 Thu, 25 Jul 2024 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721878000;
 bh=myy1FSn0Kxe1zQoxZ6SSh2q07lr40llh8kdQajzGCBg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LCRraxsee92KNhDchsFDUnboRTaowt9XM9iebkgve3BRIg8NGsmq/BsiJ/tOiDmBM
 uJSbS4PHFlpgR2V2bUGtmFDqaJTzELWiAO4OfC5WLE01mA5M6/g5j8EvOobMq4VwTO
 TTpWAgZvzD8QdrWh5RqP9Ek/1nsqOybuFbW7rrk5axAvG+Hr5Bm+beVKlg2X7Pk6Rb
 UzqOI8EERiAME8rpMU182bAKBFtw1rqmpT9eJv6Xs9RwDn/RuHf79hD4s0P2+g98kJ
 mDJacT56j0i+Sf1SZxPRdqyXBotbovfxMrERvKlM2QgnEKQJQa2xGnKxsSi40fRPAc
 /daKbOpozrjGw==
Message-ID: <37e07368-3000-46e2-822c-584b29011f6e@kernel.org>
Date: Thu, 25 Jul 2024 11:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724172838.11614-1-n.zhandarovich@fintech.ru>
X-Headers-End: 1sWp7w-0005re-Au
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix several potential integer
 overflows in file offsets
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
Cc: lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/25 1:28, Nikita Zhandarovich wrote:
> When dealing with large extents and calculating file offsets by
> summing up according extent offsets and lengths of unsigned int type,
> one may encounter possible integer overflow if the values are
> big enough.
> 
> Prevent this from happening by expanding one of the addends to
> (pgoff_t) type.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: d323d005ac4a ("f2fs: support file defragment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
