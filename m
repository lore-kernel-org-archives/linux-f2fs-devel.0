Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A5607F49C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cwfrkrfb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cgTwEF8D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VgwSUVvp;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSsXXuLo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FAL/twtw0stwcNtNVCjIFiQezEdB77fWIHl9SOkUv9U=; b=CwfrkrfbHRzgnK/8QgZROL0vVI
	7z0gEakVg8bfhAayVnnPV0iqAHxXXb0+dUn5Lsgwe5ODkFGmk+Vi3mU13S1fs0BPxzrDCY5mDcz9E
	BgMT8PPQ1YVga3o+wSwhnRORI8I2hHldTP8OiO671Ujnp8anQ1U4ijqpcgI1pW87uCB0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTR-0007qL-56;
	Mon, 19 Oct 2026 15:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTM-0007q5-Gr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SXHZ+e1cGJsvyptNENWdo+6tGuBkN7AAyV9j8F1Mqck=; b=cgTwEF8D1gT65Ic1luBQzbEDhP
 JhFIKZN8JVEHDKsqE2IoyrkZBATQnRfoYGrefEfaofM4IBK0t561dHmElCdM0xcnK0U79aKib/Jsl
 00g+k8DGshJjyK/FYU5g+IpR5H23jVKtj/IqYx5io/qZb44fYG+ZJhPbUxnr3Cvq/Dz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SXHZ+e1cGJsvyptNENWdo+6tGuBkN7AAyV9j8F1Mqck=; b=VgwSUVvpoGJObOW/qBxMbAwvrF
 Lp8bETrBjoaUyhcu5gzLLhFwKQgocAqE1GGN3T+K+8zE+MIK199+QaorYxUNOOQAnQat/9UEHW7rX
 obh1Bsk8a5IU9KJTijGCoZzvp5CiNvLjf0HF6qrC8ICVUFIyiE2Ia5Vzd+2TALPipLFA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTJ-0003ji-2s for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1D684367C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 15:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD871F000C4;
 Mon, 19 Oct 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424415;
 bh=SXHZ+e1cGJsvyptNENWdo+6tGuBkN7AAyV9j8F1Mqck=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=nSsXXuLo+A1IjoOvSDFOH9lDpkDUfQ1pUe9P0eWRXH4bzMNHBftbOlTF87MzbLbkv
 R7PpgjU1dcPUMuCz38ATdb14eTF6WJ2Vq6vC+5LTbCskADo37Z8d6qoR5RZT1UQbUE
 qL71xu2vtNyMnZOh8W+VbdaaOVmJoLJSNOwRTYQHCNKEVYAPEXVownXCuboM6K/V3E
 qnqq1R8B8bZEJkf7c3vUZv8zXDJPg2u4o6PPHUz4KeQDUc5Lv62aAgogwM23e9iZrt
 NnIidhwr1LuhFantAuNjTrRcohouXlCOxZao/Zm8T7BFnvG0lIDVS7ijzlRQIxM3cG
 +lhjxD6o/x0TA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 773143811A71; Mon, 19 Oct 2026 15:40:15 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242441406.2714099.11346194792931754269.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:14 +0000
References: <20261019090032.1170825-1-chao@kernel.org>
In-Reply-To: <20261019090032.1170825-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTJ-0003ji-2s
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to don't fail to grab GC
 target block on zoned device
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 19 Oct 2026 09:00:32 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> With out-of-memory fault injection (inject_type=0x0080800f) on a zoned
> device, f2fs stopped checkpoint during GC:
> 
>  F2FS-fs (dm-0): inject kmalloc in f2fs_kmalloc of move_data_block+0xc0b/0x12b0
>  Workqueue: dm-1_zwplugs blk_zone_wplug_bio_work
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4d/0x70
>   f2fs_stop_checkpoint+0x1df/0x5d0
>   f2fs_write_end_bio+0xdbb/0x1320
>   blk_zone_wplug_bio_work+0x2aa/0x7d0
>   process_one_work+0x5c6/0xde0
>   worker_thread+0x403/0xb70
>   kthread+0x235/0x2e0
>   ret_from_fork+0x2f/0x70
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  F2FS-fs (dm-0): Stopped filesystem due to reason: 3
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: zone: fix to don't fail to grab GC target block on zoned device
    https://git.kernel.org/jaegeuk/f2fs/c/14f329117d10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
