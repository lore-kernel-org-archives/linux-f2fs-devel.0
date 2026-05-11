Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9772CD37B2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+0ReFXLUtQOiY3nnHsfLksAZjKIh5k2WU7B44i4jPo=; b=Vi0A1fTYafq2zCnV1GEcgo2v+H
	o0qPXjGitAQRNS5crSHVZ4FRDxJ3RtCoqDtgajRYxRKe/IKprR/2RkQxojaSV/2HZKqikiJExUjTs
	tD8ZwBsKXD5kOh0Nh6JX59Fhq3yTnzdmuyG1BqF/2JiL8PGb19h8o4FON6B+4z/HiUXU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFf1-0000BE-Os;
	Mon, 11 May 2026 01:42:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFf0-0000B4-9U
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P5PqXEKm+NKbEFGsuorbr29nWkDwKPdcJWQHdBcJfLA=; b=QvqKp4Z6zozMkMgLLp2wrQMgg6
 jdmAWrOm0r2OAnyf4MSEYzNSdsWwIYWS0/B+Szl+BEHo8wiXsxiFtwG4Cj2d3rk7Jq52YpCwnSCaO
 A4LSPlPSopewHLVeyjXwVdaws9a/OL4VpZOO+r9vebnoJueIWfXcQhfXnUuPR+NsXMq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P5PqXEKm+NKbEFGsuorbr29nWkDwKPdcJWQHdBcJfLA=; b=TIbAumt6BVkUZE7nDQB4zqtq/6
 tjVGIzkwFgk81hMmI2QxYGk3r7phNqoGCvS4/f28AADgBWXkGV7rKoxwFSJKBHY+TaRqPe+edcOYr
 HAqiRuJDqbZO2kVt2apug39cVDV9l7oVoYgMGpMkLn/TGz+UBMw6KoWGb7qh+8zBepxQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFez-0007Bi-JX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D4D9C61146;
 Mon, 11 May 2026 01:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DADC2BCC9;
 Mon, 11 May 2026 01:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463726;
 bh=mn71lkbbPT+j8beWbOqtrmwPLoADdcpQd1cKks8hE68=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ZX2nYsFbgvO5yNSpBTKqWXdYp7QPTAiVctGimUsJRu4WB4gOfv+r7QL9wqMXMb+r/
 H7du6ah79m0ZgUPwb5P71eutTF/7+ra4aPEXT8aUB2FzwKi05fGf7Q7Vd1bGNv+PPz
 qOWuB0zYzF1KYhyG9oqR4bEU55kKC2yLb1bfJn+ThGF2Shgep9WVHHS7/DNrF0OHKT
 2ox4bxOspUK7XzYM74RqBLQodDIadJeSsRKfgyl5WN2f8ukbsXxf/stqdHj9mR488G
 9N4Jk3/5D5nlKLx9ZGx7RHqbtD0Y/a3Pn/U+LRGxV449uSN0cEsEy1xQAeVkJ96dtK
 F+hjlMGRzMsWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02CA93930039; Mon, 11 May 2026 01:41:15 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846367379.1975880.11629604282967011707.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:13 +0000
References: <20260502124157.3406780-1-ruipengqi3@gmail.com>
In-Reply-To: <20260502124157.3406780-1-ruipengqi3@gmail.com>
To: Ruipeng Qi <ruipengqi3@gmail.com>
X-Headers-End: 1wMFez-0007Bi-JX
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix potential deadlock in
 f2fs_balance_fs()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  2 May 2026 20:41:57 +0800 you wrote:
> From: Ruipeng Qi <ruipengqi3@gmail.com>
> 
> When the f2fs filesystem space is nearly exhausted, we encounter deadlock
> issues as below:
> 
> INFO: task A:1890 blocked for more than 120 seconds.
>       Tainted: G           O       6.12.41-g3fe07ddf05ab #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:A    state:D stack:0     pid:1890  tgid:1626  ppid:1153   flags:0x00000204
> Call trace:
>  __switch_to+0xf4/0x158
>  __schedule+0x27c/0x908
>  schedule+0x3c/0x118
>  io_schedule+0x44/0x68
>  folio_wait_bit_common+0x174/0x370
>  folio_wait_bit+0x20/0x38
>  folio_wait_writeback+0x54/0xc8
>  truncate_inode_partial_folio+0x70/0x1e0
>  truncate_inode_pages_range+0x1b0/0x450
>  truncate_pagecache+0x54/0x88
>  f2fs_file_write_iter+0x3e8/0xb80
>  do_iter_readv_writev+0xf0/0x1e0
>  vfs_writev+0x138/0x2c8
>  do_writev+0x88/0x130
>  __arm64_sys_writev+0x28/0x40
>  invoke_syscall+0x50/0x120
>  el0_svc_common.constprop.0+0xc8/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x30/0xf8
>  el0t_64_sync_handler+0x120/0x130
>  el0t_64_sync+0x190/0x198
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix potential deadlock in f2fs_balance_fs()
    https://git.kernel.org/jaegeuk/f2fs/c/65ab67d250f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
