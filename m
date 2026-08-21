Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB7BC5DF93
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QkunAw/DWgVt8Cx6N+VMy3OVtWye3xo0X4rC+L82J5o=; b=Jxd6OH5ON04j4GRnxNkhIONaHz
	wKONrJN94t74YiH6f2Xi+9lu39zrMmU+YShpp/zlqnK5FqvU56yF8jB+C1gI/4fd5CuR15lEHdbR0
	0hi9c5uycnMvYsWO3RZ0+ZrlU1xLmMvZV+0ohNfliR+t0H+8Nko8zhs5Ii17OajoomZM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWL-000437-1M;
	Fri, 21 Aug 2026 15:51:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWJ-00042z-PL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CehXA5/5UcEf7fhT0Iw/KSIjLql9ZuLxenctivZuWy0=; b=JCf0bKgUrnZwlzvxP3XYyLY/Oa
 qtBs5EnOE2x9pjXl4RQjAbTak349dfEoMdSnX7uBShR41p8VfLUCa1sRr+xkmjw1ID2s9EPm1+Whx
 p5oX64th1LDwVl77OPf/iXEVCaVFOBSLPohPLocqtjTUaYw+SzB8msknploTr4WX0e9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CehXA5/5UcEf7fhT0Iw/KSIjLql9ZuLxenctivZuWy0=; b=FmQZVw359TUivmrg/Ce4KYdhws
 i1rr13JdcVu6aLBHjWVst5t1zkGly7CVw8yND42yIqrz45ywiNyCwlwwNiG3NDZj4ge3rYQo64I+S
 D3znL96QhSZx+LCn9FgwhT3vujDabLcDdHZgtIdVVnzfuGGiXe1b14aGMCB8IV9C/d5c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWJ-0005F0-3Z for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D098B41829
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CA11F000E9;
 Fri, 21 Aug 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327457;
 bh=CehXA5/5UcEf7fhT0Iw/KSIjLql9ZuLxenctivZuWy0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=BRdY0jPwYg02EpDY9T47mNUyc1r3r1HAkcf8/r+1ptChfcgevq7U78MPqvC0/3fYc
 lxfzFqQhRaEbsI6rcqPWIEKm/DetqUvQporeTPpoW7a32tdCieJnn1P6UWqK2Z+T2l
 MHWjmeXbn3p3Jr+byzOqCo1ScQPxlaERjDfH+mJeJYh+kkP7mKehDaSa0YjLfVoUZh
 y7iDZq0XQEUdltRkR/StJUDYhq9w/aT2+U19bc7xoZlNgsUoYlmhMWCTx/fZ/T4Sm/
 FW5bZJB0x6vjkutFl+yieAHkl8/hSqIvMJ1xW+TKUexh5VxEUVcOt+5yB5gEJJWQWy
 44HHguzMfnMhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A77380A979; Fri, 21 Aug 2026 15:50:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732740714.1339488.2738118422362472739.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:07 +0000
References: <20260817111916.1648354-1-chao@kernel.org>
In-Reply-To: <20260817111916.1648354-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wxRWJ-0005F0-3Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_{down, up}_(read,
 write}_trace() for nat_tree_lock
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

On Mon, 17 Aug 2026 11:19:16 +0000 you wrote:
> Under heavy workloads or during background GC/fallocate operations,
> nat_tree_lock can experience high lock contention between background
> readers (e.g. f2fs_get_node_info() in gc_data_segment) and writers
> (e.g. flush_nat_entries, set_node_addr, shrinker).
> 
> [375067.327986][T13777]  schedule+0x4c/0x114
> [375067.327997][T13777]  f2fs_get_node_info+0x438/0x5c4
> [375067.328002][T13777]  f2fs_get_inode_page+0x1e0/0x3f0
> [375067.328013][T13777]  f2fs_iget+0x88/0x1180
> [375067.328024][T13777]  f2fs_lookup+0x168/0x3a8
> [375067.328035][T13777]  path_openat+0xa28/0x1b04
> [375067.328046][T13777]  do_filp_open+0xac/0x130
> [375067.328056][T13777]  do_sys_openat2+0x140/0x21c
> [375067.328066][T13777]  __arm64_sys_openat+0x70/0x9c
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_{down, up}_(read, write}_trace() for nat_tree_lock
    https://git.kernel.org/jaegeuk/f2fs/c/f9c899ec50ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
