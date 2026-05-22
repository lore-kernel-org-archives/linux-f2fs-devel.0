Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23D5CD5BB3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdYXjl0jVUsCb+9mV+r5K24eDdF9tnv2toAsl10DOjw=; b=KJ8AjvGYWgayVXaIKRvSQFjgmd
	Cql//zOKwNVVhDujl7eO+HTopYzWcMlGK3PvnvUvAP6NjhtVSTna6hJC0+xkP3VtgRTeasqcORrB8
	VQz/Dvucu9qYVxRWnleMpTWC64QlSm3wS10bc6TVreqkMRu+X+3AA34cRuDDQ53D2d5w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQHWZ-00083t-Th;
	Fri, 22 May 2026 04:30:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wQHWX-00083l-9H
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Qlc+sG8yFO1c1ZHLlUVAfl6kx/UoRgXQXeqhq/I+Xk=; b=PPTWbyN6IisATNXALUsMYZwu/V
 bsHR3P5WESdzjFfWThCFQkCfkXIYlM4W3Dhpeo66P5XZ65JymkbM+DYZmIvHlKKXvbuQynwGx1pz+
 Eij8hKqfTZCvRCcJDedQvAs/F1LqoKGhF1ArAt11iKxbIfFWF8yxET0BcKozYKACImWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Qlc+sG8yFO1c1ZHLlUVAfl6kx/UoRgXQXeqhq/I+Xk=; b=DQYWufzvZI6Sc3Xj60k6iumsHb
 DRz1heYqfY9AZVosUgpeXklFzXqibr82uu3Zh5Kfn1LdP2kpPZz4TtShUrNmYM9H4Hfufurm6vI4G
 E3sP1Q1UUFw/tVku3xfx8ELD+X2HBz1tZJPZQJY3BVHglOWzLVXsO0/d8K6a0Q4Mu3Go=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQHWT-0007Sr-OY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:30:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F199444532;
 Fri, 22 May 2026 04:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45D31F00A3D;
 Fri, 22 May 2026 04:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779424199;
 bh=0Qlc+sG8yFO1c1ZHLlUVAfl6kx/UoRgXQXeqhq/I+Xk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=CsaU7LfPHUvB1OSUFA1bjEBFZqlX57SiVYPoA47Ft234DwZViR0Uw7QVYr+eL4IA1
 nir/F4lLz3KjU3At0t8sXHeZPkNu39bmEIylAFFJrBIR224cn4RhST5UwJgVshMWOd
 Ur4+FZZCnHy5Nm+Icdcpw/GBMi/BIcPGGBg3/zp0gKujnN8bb/nfzYnkjmdkR6vyuE
 a7zDlIvcY+uOtliwssllaW1xWVHhgcaXw6lQ2XSo2yYROQW/RYbN+wHQKMxZaJ329b
 MGZIdZwC5ISfA/+UaTzCBj/uqOfeK64MB+GmeMpZbpSGAJ+gj+PFzjdDiJy1Rb4zmp
 p0Vmfmc6/UrEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939643930E41; Fri, 22 May 2026 04:30:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177942420913.624124.6855697995437487075.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 04:30:09 +0000
References: <20260519011438.1168155-1-chao@kernel.org>
In-Reply-To: <20260519011438.1168155-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wQHWT-0007Sr-OY
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential deadlock in gc_merge
 path of f2fs_balance_fs()
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
Cc: chaseyu@google.com, ruipengqi3@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 19 May 2026 01:14:38 +0000 you wrote:
> When we mount device w/ gc_merge mount option, we may suffer below
> potential deadlock:
> 
> Kworker					GC trehad			Truncator
> - f2fs_write_cache_pages
>  - f2fs_write_single_data_page
>   - f2fs_do_write_data_page
>    - folio_start_writeback  --- set writeback flag on folio
>    - f2fs_outplace_write_data
>    : cached folio in internal bio cache
>   - f2fs_balance_fs
>    - wake_up(gc_thread)
>    : wake up gc thread to run foreground GC
>    - finish_wait(fggc_wq)
>    : wait on the waitqueue --- wait on GC thread to finish the work
> 									- truncate_inode_pages_range
> 									 - __filemap_get_folio(, FGP_LOCK)  --- lock folio
> 									 - truncate_inode_partial_folio
> 									  - folio_wait_writeback            --- wait on writeback being cleared
> 					- do_garbage_collect
> 					 - move_data_page
> 					  - f2fs_get_lock_data_folio
> 					   - lock on folio  --- blocked on folio's lock
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
    https://git.kernel.org/jaegeuk/f2fs/c/cf69827e772c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
