Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8029ECC6B0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4eriJP509JuRg/UoeoqsOZKaKmOyNJdTRbvi0lcWkD4=; b=BvrM84BZnA3kkDq1dKDWmAm9ML
	Uymg+Xb1amb1/5byI0bW66jTmvmmU9dyPapb0BVK0V6WnvOvaiUXraZVhPyXEdiNWFkGYAaXLN7Ym
	GNl/YrsBZ/h2OqnreGKmAs6H7bqrqR7akcDl/g62o9+8dpcggPLSxr6f0DybP/0rGw/M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl19-0000cl-Ic;
	Tue, 13 Oct 2026 22:30:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl17-0000cI-Md
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4FFO1jOTQfYb9lMwj92EOznYJd3KapLk94/ZCQVw9MI=; b=RysevI12n7UK/cQtuhPy5tXzll
 iZv0vcv7hQmKY2R2+ET+dzDPzZ3snE7xVsFadiABpB0n+zt3C0dRXA4XrWr5V340dNofzP3TSmPuE
 B9Eaot1Fdylk7D1wCR+wy2YG0FJF6AnKkVhELbbFYeBN7ihYwBcc9ydOTWv7GDSKaW2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4FFO1jOTQfYb9lMwj92EOznYJd3KapLk94/ZCQVw9MI=; b=RIi2y2Q/BqSK8UfU6C+sjS31WU
 H//0/H+I3MtzuTvyhT66wn68pkpDOhRmcoyLZHlEAm1WYz3bwJdVU8UJpw7Nh325eP1W1oqdODHM3
 EKnQHPkrkgFcFGlvC19g9pngvxOt2SD38ry86rrnmZeoI6tFIojGHXtal1s+Gxxsi2DU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl16-0001dq-SZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 521AF60514;
 Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F751F0089B;
 Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930635;
 bh=4FFO1jOTQfYb9lMwj92EOznYJd3KapLk94/ZCQVw9MI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=WYNTdXRMYYAuVdphkXmwY2/dcnGGEay2ozBP96DnaPUA+FyTCYPbP9uR3sWYno9LD
 b6F0KJazOpgjt0jhNCioyo/oYbSKHXg021/x2+1Vjfg5HQz/Ql7MFeQvmvVksTnIXl
 H23lsOkHAdQdbx01szYw4l6PsmalrnobqPVum+4DfY7Nj+gLHigE9iq0nTH/234vpB
 1KUfadbw0wGx4jVIQAUlJCuaokiIytwhhVNsWRfXr3VhmHT2yrHFPItvh86Sz1ZC33
 nFHvBzpdc95cu9d+yJh6XSTbWAL+qbbWAHGn+u79KoEnjfMSlCENW9fAYmAdowfdlK
 KpAy53qEvQ5ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F141239E4DBA; Tue, 13 Oct 2026 22:30:34 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063351.1493834.17419518506732604429.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:33 +0000
References: <20261005154954.2097054-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20261005154954.2097054-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Headers-End: 1xGl16-0001dq-SZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix defragment writeback range
 truncation on 32-bit
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
Cc: jaegeuk@kernel.org, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  5 Oct 2026 23:49:54 +0800 you wrote:
> f2fs_defragment_range() flushes the range it is about to defragment:
> 
> 	filemap_write_and_wait_range(inode->i_mapping,
> 				pg_start << PAGE_SHIFT,
> 				(pg_end << PAGE_SHIFT) - 1);
> 
> pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
> shifts are evaluated in 32 bits and truncated before they are widened to
> the loff_t parameters.  pg_end is only capped by the file's page count,
> so for a file larger than 4 GiB the shift wraps.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix defragment writeback range truncation on 32-bit
    https://git.kernel.org/jaegeuk/f2fs/c/92154fe28c37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
