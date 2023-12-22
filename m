Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237EEC46CD8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Dec 2023 09:42:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rGc3D-0001bF-ST;
	Fri, 22 Dec 2023 09:42:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rGc3C-0001b9-Qb
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 Dec 2023 09:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mKbLpRTzOUL9D2GqqUNpkKoUGEvx0jrmCSZwoTEkGt4=; b=J9gJCZFzRkwgnPFWp68OuZfP9X
 1UXO0C3U8O0FIjYnLT3etgROM/aIaAn/0hZxqwk3iRo/K1QPnlLK+pbAU3uQ3FZRSLowsMdu0pEf/
 tN4rUunLXxOHMiDi+TCx+es4vjJEhQiyayt9NRNF7zaDXrdnXXFn7BlDQEErhn2ZxqxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mKbLpRTzOUL9D2GqqUNpkKoUGEvx0jrmCSZwoTEkGt4=; b=ejIXEhNimw6h/8HHpYOgddGhWq
 g6hucu44Z3uA/UFaj/npmg5kSUoSWa8gWGCDzmz9TO7J3zoeHeYzArnPwHSP7RQZtPdR8AcxcYWQ5
 c+n2w3qGu9AAXr70/BCd8ZaD7m/4soFS2JhGJ+bHSN8BTKgtoOuPBZz6JNlfVWoVLRbQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rGc3C-0005UQ-HU for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 Dec 2023 09:42:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 24CF661B75;
 Fri, 22 Dec 2023 09:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934D6C433C9;
 Fri, 22 Dec 2023 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703238147;
 bh=z/tiJSMVWXqC12XFPo9+kkp+1TdZ2JIgbr5cdKaqwmQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vuk2jPz4wh4meIIQHckwcmFm8kuPJyl+gz4ciXVFVngNDoXqmthsvyRcTtIWmG/Uq
 g+j+tX1Ws+CWp3Mly68U41eBNwIxOhMup9AhHB+PaQp3CjG1BqFOri0IuvgX17l9SV
 ZT5oabiFLFT+sVN4eYkkPGH09X624L2mF+sJL8zxzXcyZ288oAQXXZPEGJkgsT/0Dn
 U0gZekzyfTMkwlA7glPNEDorrMBW7HPnTPT9vs3SZnx1vmkoUsxIpQdDj2ckSUa6Ay
 yzmQmrgn/zeKldXavNy2dGdQSsthZ2gxMC+0CJJIAwVfjrunuO3Jiwu0rRV3Ob2rtX
 Z87ZtduhUWhlw==
Message-ID: <e2b88b1d-7d76-4eed-9eea-f4cca188c2c2@kernel.org>
Date: Fri, 22 Dec 2023 17:42:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
 <20231222032901.3861649-2-yangyongpeng1@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231222032901.3861649-2-yangyongpeng1@oppo.com>
X-Headers-End: 1rGc3C-0005UQ-HU
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Add error handling for negative
 returns from do_garbage_collect
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/12/22 11:29, Yongpeng Yang wrote:
> The function do_garbage_collect can return a value less than 0 due
> to f2fs_cp_error being true or page allocation failure, as a result
> of calling f2fs_get_sum_page. However, f2fs_gc does not account for
> such cases, which could potentially lead to an abnormal total_freed
> and thus cause subsequent code to behave unexpectedly. Given that
> an f2fs_cp_error is irrecoverable, and considering that
> do_garbage_collect already retries page allocation errors through
> its call to f2fs_get_sum_page->f2fs_get_meta_page_retry, any error
> reported by do_garbage_collect should immediately terminate the
> current GC.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
