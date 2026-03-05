Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F853F47CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5kF7zoHT1tPPaKOwEVdfkLncmIiRcpbbj4G78wjsfE=; b=CGCm1laJXPN833hcEDtGqdRFMZ
	Cd1/NT6wOzDijcfBb5J3LpKL8qH+ySPQcohhO5NEt/w16UhjtWDZhzkFRk14NBAfJczIjxJ3+R6T3
	OIB9trDVpDahqj3XyP+UaMA/MZYQT903//OKaUKpCsTuuBmYjzHIHg8KyOrLmKRH2+4c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vyEBc-0002q0-5v;
	Thu, 05 Mar 2026 19:16:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vyEBb-0002po-3Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OAYqzZ2ObvXvoLlK859uhR1pC15KFl/kArM9sOoRfgQ=; b=F45nAXeuhMhxuYOClAYnf4aHAj
 sA9sfYa7y8JfJjdMt1OO5pCBsnxD8IH7zRXYWv24XRBeL2ObflazvHIX8QtfxEYjDcvVW0RL9LNjE
 jxaQZBy08c4URxhsu6egtOnu5ISb873Xv5uk+gX8DGRa7ttuaJKQG1SoLXa3oMoYWlJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OAYqzZ2ObvXvoLlK859uhR1pC15KFl/kArM9sOoRfgQ=; b=WnIvWMWL2v+Nk8n8FOVs/MF9MG
 EEtH6p4LTO5drJCKkK+vzj6uGXDuIXAmuEKSGeyLvIo2obE0BxRQQFFRLWoRxRL5ZT9bCnfRgNEpZ
 ajLERkV7RK6vxzjLgkqz1ZGBNAxrgNMJpndWX8BjtSgio3cggCTVgoFj33VIzIDqSKfw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vyE5Y-0001v1-15 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:10:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 75BA560126;
 Thu,  5 Mar 2026 19:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF9C116C6;
 Thu,  5 Mar 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772737813;
 bh=oY0XzNkHTv7yBJNoSUlxUyZOVkmAO3U/yiXwKeI/j98=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Q4jUTGWLECj4jp6XE7GmKranVjrwOSptoyMDj/CX7anbh73ZBNTRbo16xU8FbO8WW
 L5ZGl9Y3E2890ZK+LzEQwNGGi5hSPFeb1rn+IPww3nYgke7f/Ivr487IhgPUO4NniY
 AzpYnni6Pq8PjS1b1qD7yVN8KluJNWC39U72m6n+4sU601DPGDMaqgUK6p5ju3dKpl
 Gx5sYEY5cjXFJLbosxmVuHT3jZWWKfz6Z5EUB009bUbV2soQqaujfD0TAASXJl0PKV
 fXwMv9EY7coWcVFa4f4zVL3Dl3ec7GJoBVrrSyy/2J18eCTfExF0jCOoMOQwBpnr8G
 Ocltn7XMXFCeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FDB73808200; Thu,  5 Mar 2026 19:10:14 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177273781304.3248266.12940471035367152097.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 19:10:13 +0000
References: <20260305011810.4189655-1-huangjianan@xiaomi.com>
In-Reply-To: <20260305011810.4189655-1-huangjianan@xiaomi.com>
To: =?utf-8?b?6buE5L2z55S3IDxodWFuZ2ppYW5hbkB4aWFvbWkuY29tPg==?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
X-Headers-End: 1vyE5Y-0001v1-15
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid reading already updated pages
 during GC
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
Cc: shengyong1@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 wanghui33@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 5 Mar 2026 09:18:10 +0800 you wrote:
> We found the following issue during fuzz testing:
> 
> page: refcount:3 mapcount:0 mapping:00000000b6e89c65 index:0x18b2dc pfn:0x161ba9
> memcg:f8ffff800e269c00
> aops:f2fs_meta_aops ino:2
> flags: 0x52880000000080a9(locked|waiters|uptodate|lru|private|zone=1|kasantag=0x4a)
> raw: 52880000000080a9 fffffffec6e17588 fffffffec0ccc088 a7ffff8067063618
> raw: 000000000018b2dc 0000000000000009 00000003ffffffff f8ffff800e269c00
> page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate(folio))
> page_owner tracks the page as allocated
>  post_alloc_hook+0x58c/0x5ec
>  prep_new_page+0x34/0x284
>  get_page_from_freelist+0x2dcc/0x2e8c
>  __alloc_pages_noprof+0x280/0x76c
>  __folio_alloc_noprof+0x18/0xac
>  __filemap_get_folio+0x6bc/0xdc4
>  pagecache_get_page+0x3c/0x104
>  do_garbage_collect+0x5c78/0x77a4
>  f2fs_gc+0xd74/0x25f0
>  gc_thread_func+0xb28/0x2930
>  kthread+0x464/0x5d8
>  ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: avoid reading already updated pages during GC
    https://git.kernel.org/jaegeuk/f2fs/c/5d143972155e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
