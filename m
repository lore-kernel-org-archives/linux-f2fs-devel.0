Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77040EB2700
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5WbboVELXGO7l4tIfrT8vxPCibL5f7qRFsEb+ahwcAM=; b=LfGtRG6S2V291jXb7p+YSdbJ5+
	CQGTYHld64A13EVP4Ew1B8hwbanzJpNNl3vu4gFP71PH1FUp0BYZiDfT0YBO0hyWQcH+YgwYvyQ/Q
	oUjVAzc2TN14THi+gtU7mSsww7uDHe8s0HC3ymcgbd3tG0wH/Ozcc4F9XKHCFu5Fg4nY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vpvHo-0005cr-3Q;
	Tue, 10 Feb 2026 21:28:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vpvHm-0005cj-6F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 21:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qO+Vvq8ytd0vRUnEbLEEWHYPy2+J0qjg9TrxZxlUi4=; b=ewDgEdlj/vAV2Io8LuBex4GHg9
 GUEv7U8Sq2GiT1Cbif7vo4SIenkBCASgf9uhwBdx8ExjT94cFKkqghFC7AyeMS+cTux8/hoDDQ4VG
 UKZRiTzDOWmIckniIvMdN4SSwuhSI9okPBIT0Z6WuBDfRDn3DzoKRPQdnXGK3xCuvMCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qO+Vvq8ytd0vRUnEbLEEWHYPy2+J0qjg9TrxZxlUi4=; b=fpJ9odqX9C26Rvm77L9wGkdHgP
 /C8tvooiGGUg6YZsw6Fvfyb1Ycx1VZ4YHbg0d/AIPoY/4bWzYcQOtiRHom3ycc3eaXiXnlOufDVHp
 ostWbTy3p/9/xODkEyG5nB5d00s7zZFzcZr/4jGnGF4grYe9AK9cxx4jf8gPLlbVvPnc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vpvHl-00051U-Hx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Feb 2026 21:28:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 47D4F43D65
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Feb 2026 21:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FCEC116C6;
 Tue, 10 Feb 2026 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770758911;
 bh=fIBYEwGEO1iNWgZtZ6eeqHjkTFNGpyo0rtvSA/WVDwg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mb8ngU2BtyKdOTGES6FKiJVQJ0iqilc3gbCR74iJInsQtVYdyv6EwiCR8g/fGng2/
 qrc30ZNmjimtcyh0o+5NWlhmYW+8LujdW22QNUF06BmxK6qEpOCiZcHvtO9d308jU4
 22ykbTYXfe9tb+lMmArI/VjEIg4KGvmch9bWyc9WdexzAumdT4Qts+f83/scRbTHPs
 oR5eBW/OZfuH1p/NGQ/ys61J21PtZesSWHdQWaJIPaEBX75Odh7jg0TmGd2AGVmTN5
 KsjKVQHVtBd4mcTTdXEH4YXycTDjS9/ZZlqFdMy8IAZSy6ZiVa0q+wFqLqZra7jzQ5
 ktutvizX3RzmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 8507239E3B79; Tue, 10 Feb 2026 21:28:27 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177075890633.3671709.6089678750946061436.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 21:28:26 +0000
References: <20260204030501.85441-1-chao@kernel.org>
In-Reply-To: <20260204030501.85441-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vpvHl-00051U-Hx
Subject: Re: [f2fs-dev] [PATCH] f2fs: sysfs: introduce critical_task_priority
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

On Wed,  4 Feb 2026 11:05:01 +0800 you wrote:
> This patch introduces /sys/fs/f2fs/<disk>/critical_task_priority, w/
> this new sysfs interface, we can tune priority of f2fs_ckpt thread and
> f2fs_gc thread.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
>  fs/f2fs/checkpoint.c                    |  2 ++
>  fs/f2fs/f2fs.h                          |  4 ++++
>  fs/f2fs/gc.c                            |  2 ++
>  fs/f2fs/super.c                         |  1 +
>  fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
>  6 files changed, 34 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: sysfs: introduce critical_task_priority
    https://git.kernel.org/jaegeuk/f2fs/c/52190933c37a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
