Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6774AC5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2K4rTGLAEKEwAglxzaIGISvcsaaIVe99Tkxq8AvL0RM=; b=iU2ufyoJYn7jw2zhRr1sWS4/pj
	RQCJhAlGvIyNDE9ZWKfpyakxv0jJZ3EilJndNw87ngEmFVXzBN1jfUQZeWMh7/OEXTNsCo/YY93y2
	JBOnq9YG3XQo99VomLYNp0hH/UuVNWvNs9iQPlX+OTs0HWKYkcxpW1nBa3IM+d/t0Xak=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWQ-00043f-Dk;
	Fri, 21 Aug 2026 15:51:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWO-00043X-VK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTLiyKwXWRq3qYZhqLehDaUhb6BBr9VI/I8RzOx7J90=; b=bjlO49I2pLtOJoCNgGmItLf4B9
 GmF/avDoBkm9xp7WyeMYBZ1FczzZpV/i83DawR+Hh1YSXWRq3IKWPEU/zh4lnepFWBKdjZCGtYH3e
 NegQ1fcA70rBIVDQPqKZS8tWg8TBajhxV6D35kSehIxYAN8uGLs4zIZXrEwf/vfU4z+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTLiyKwXWRq3qYZhqLehDaUhb6BBr9VI/I8RzOx7J90=; b=RGwlnuLVlcMXI0pNFGSzMgIfMc
 Vb/iG1nNNrPUKzXp4jxVUpgCYZL7SaZ5x09cGAv1iwu+HNmdggOF0lRsQimXbb8EBc5XoPRZ/+SpU
 UuTmhEtBw41YOzLb9yTnoJy/5BRhoxKd+dIHcCkbmz2ghj+AV1xs9rENhBFuYMNYrBC0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWP-0005FM-3X for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFCD243D33;
 Fri, 21 Aug 2026 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B452B1F000E9;
 Fri, 21 Aug 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327463;
 bh=uTLiyKwXWRq3qYZhqLehDaUhb6BBr9VI/I8RzOx7J90=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Ee4P9JcM9VmM+5gwZzcCtIXZF6NHmT6px39ej0tZ+jCFtKfOsSXfbHIf5QRaWs4pH
 8orKmxH7TDtm3ovHjDqN4007Lqld2jnhCr386w8QnqsMfpszU68aaoOxkSF9YtrWb9
 LuaWxjySanjwsFKQH9k9UkeB/MjJhc84ECFt3Kf5qySHOt7I/d6TSiKa65JzOjFy+U
 yf3fOGHgUajOCfHKKLH0SjLD+GKb9ujMPaqKPWTqHL1cQy7WE01NR6tjxRLEid9I5R
 cXmAjkXUY56OofNKa9/C0b2DRMS80SXr7glIxeETHslbKKCeiyE5I5zmOehRQzsINW
 3eDhP3EYFG4TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93864380A979; Fri, 21 Aug 2026 15:50:14 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732741314.1339488.16297282367376020116.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:13 +0000
References: <20260820164340.2802152-1-daeho43@gmail.com>
In-Reply-To: <20260820164340.2802152-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1wxRWP-0005FM-3X
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 20 Aug 2026 09:43:40 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When free_segment_range() fails in f2fs_resize_fs(), no on-disk
> superblock or filesystem metadata has been modified yet, and
> free_segment_range() safely restores all in-memory counters before
> returning.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
    https://git.kernel.org/jaegeuk/f2fs/c/258c95150c26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
