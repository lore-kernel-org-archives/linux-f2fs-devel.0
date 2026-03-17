Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02079FB5EA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aX0yDxeZCejLTvAYNoiInbhf7qVstroUvrqShcRSi/Y=; b=eYgYifNl01y68d88ctvmv4Rh+C
	0dsC5Jb/zFjW2O1kW9ELUke8HJOtxMi1D5uXAs3zsawIgMOZRH+tqgQXaIYYW+LgZJMg6NUN3KebA
	ezuRvOLGhY7oh0QkLCqSErSlQCa2SYwC072iugzjuQ7ZTJmpxElCfF1fIyIGsNZftcPI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2JaZ-0001Bi-VJ;
	Tue, 17 Mar 2026 01:51:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w2JaC-0001B1-Fj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 01:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TwS49WaxMaJOBpKHcVJcSeo0XoaGTFb/2atG0r2N1Vk=; b=SegYNCtRDBmmF3p+ezt2ZYYsLy
 3DPnK6CJCqz0ZuIjudEbSWjl/r4BbrMjHye+HPK9AhZVzhJh5rqwJCYkJOSXheiqinxpfNrMCUFd4
 RN1u0pQil4AjY3dPzImHznTuZXpsuQhF9emUQLlinjd2o1OhmKv4b37s84yxA3Di/RJ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TwS49WaxMaJOBpKHcVJcSeo0XoaGTFb/2atG0r2N1Vk=; b=KphvGnyU+8EUV21cv9cFSVDdFY
 POXSzm5TgN5rQIT7gIBYatLQvW28DWontubP1l7mvVNgZLsJ9IUsXoxM4d2e/stP0oe+S0uR+QrZP
 inmlUPabh6tHfU0tIg9QX08jsLCtg/srvrkNgToP3o9Bm76BFFhVT7cn2JLRS2akdz0o=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2JaC-0008AU-2E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 01:50:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 45F5260018;
 Tue, 17 Mar 2026 01:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A47C19421;
 Tue, 17 Mar 2026 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773712245;
 bh=77+S6pbGty8ki1+1cZsLqDbr/3mnZsIXW+R8WUtZUrY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=oWcaV3Cwmb6UADE4bjhQfGiY2G6NxvnPomB32Y7Ua6+nVbDSuofGuyS/EufOMz5RF
 TRRYSATW0yOf7vioxElcksJCgbv52sg3padzPLTOc+VlGYNiUSDUnRLe6POcBuhace
 M2N7Ov4581cFU/RReUhVK6/0I0/7ALuVbsvbufsCWT8K7tvAY7wOsith3JWhdXcsN+
 GFt0GCmLBvEkY7TIPpxGs6aOiOj+iOqS/9Rs6cNaqIvCc7GSuTAT8V1eIahP2hY5cy
 ckfi2vBkvY2UDUg3X3jspf+HecMeO8Cls6Tt44FVsGdb8oCqp0vBM3Pktw9XU6ZLBC
 xt0lolMBqS3Cw==
Message-ID: <ea00fedb-d291-40b7-90fa-d24b07b5eb62@kernel.org>
Date: Tue, 17 Mar 2026 09:50:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260316185922.2184759-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260316185922.2184759-1-daeho43@gmail.com>
X-Headers-End: 1w2JaC-0008AU-2E
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to skip empty sections in
 f2fs_get_victim
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/3/17 02:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In age-based victim selection (ATGC, AT_SSR, or GC_CB), f2fs_get_victim
> can encounter sections with zero valid blocks. This situation often
> arises when checkpoint is disabled or due to race conditions between
> SIT updates and dirty list management.
> 
> In such cases, f2fs_get_section_mtime() returns INVALID_MTIME, which
> subsequently triggers a fatal f2fs_bug_on(sbi, mtime == INVALID_MTIME)
> in add_victim_entry() or get_cb_cost().
> 
> This patch adds a check in f2fs_get_victim's selection loop to skip
> sections with no valid blocks. This prevents unnecessary age
> calculations for empty sections and avoids the associated kernel panic.
> This change also allows removing redundant checks in add_victim_entry().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
