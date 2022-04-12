Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC8BC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Apr 2022 09:49:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1neD9V-00007n-S7; Tue, 12 Apr 2022 09:49:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1neD9U-00007Z-Lt
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:49:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zAXLaEZNyeZlv6FO3BLygA5GGTQy041zwLruD/Tl3og=; b=G71iIw4AWqlCTtvzWNmtt9l2vd
 u11MY3mRqZ7As0OZoWbLP9WlhvUIfPwjejkE8f+koaf73SSbkrt13I8rmCoNsOve6Tchkiy2EEWr6
 PDIjINRN8/k7E+WcfLHy+cI1dsufp5N38U7LNpa044Jplr7+Lh//8nCsbq/9rSj46NOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zAXLaEZNyeZlv6FO3BLygA5GGTQy041zwLruD/Tl3og=; b=ay7EAodw4sOHm6/rD02riTbC7u
 EiLKW0DpA0fP8BUm1EeZw+HnlBbzeXXsMO5ghji2iqt6eKHpuwi7w26wrUOzEGibq7h6y/6RJ04bC
 SG+bWWnlW0SXrgZ9ClLsVkBetEIs9+jpNKtt0+ejGe9imKLXDvkLNLHlzJ7M82V+10S4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1neD9T-00038x-44
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Apr 2022 09:49:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D277D61886;
 Tue, 12 Apr 2022 09:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E2CC385A5;
 Tue, 12 Apr 2022 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649756962;
 bh=gYR2YBHwwyx9GaI6f6MK1uifVDe1QgQzsrtQ7laIKeU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OD5yENxhrqinRZ28NRL3z3M2cXMflFjo7rdvdCtxSCxp424qOJ4xZBCXY7G3h7jan
 gFAvOtajyghA11u56CcEIv0q8QqJ+sukQWtvPmf4/5LJJFEv/d9j7s6d12Ol7j47FA
 bxc3w6gRwbsOI4teqsdV5BgoVZErwUPu5JEnsRVDJPo+fjAtKOdYqJWTv4b0lkLKt8
 Kx/X43PP/NTMuNR/1iO2Xrmkx/vO+waCU6oeNucMOsDa8OMvV3v1l1gupRnFCNqS9K
 UlWSjoljm81z5ZemS8x2D9hsf+6S+sevNUTgv1TFLMgP5SXchUa9fiQYh5ZrwwZfcG
 AN+RmMmYdZXow==
Message-ID: <8b62a788-d5ba-b244-d9f1-2edecba9769f@kernel.org>
Date: Tue, 12 Apr 2022 17:49:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jakob Koschel <jakobkoschel@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220331223414.901960-1-jakobkoschel@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220331223414.901960-1-jakobkoschel@gmail.com>
X-Headers-End: 1neD9T-00038x-44
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix dereference of stale list iterator
 after loop body
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
Cc: linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>,
 linux-f2fs-devel@lists.sourceforge.net, Mike Rapoport <rppt@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/1 6:34, Jakob Koschel wrote:
> The list iterator variable will be a bogus pointer if no break was hit.
> Dereferencing it (cur->page in this case) could load an out-of-bounds/undefined
> value making it unsafe to use that in the comparision to determine if the
> specific element was found.
> 
> Since 'cur->page' *can* be out-ouf-bounds it cannot be guaranteed that
> by chance (or intention of an attacker) it matches the value of 'page'
> even though the correct element was not found.
> 
> This is fixed by using a separate list iterator variable for the loop
> and only setting the original variable if a suitable element was found.
> Then determing if the element was found is simply checking if the
> variable is set.
> 
> Fixes: 8c242db9b8c0 ("f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer")
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
