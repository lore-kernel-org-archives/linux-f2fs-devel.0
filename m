Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD6C5DF93
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=211m2e6+rChXkNYz32pfMSXgA7uMDUkHRhDBeC/PHlA=; b=NIDnlWwqhkzOSQU27Wnuvq300i
	/YEdeMm5dMpIp0IVljJcSO95bPpylV75bIGHSLIW9gX7b9tYQrCPqfgMINzR84mCsYkG4GJeHkcP0
	3gh73p88hNtwhXlpG+scUmwoIROVI4+wXQHKT7ZEw//JElT/GlfCiNcyPGfVkhAaO0yU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWP-0002SZ-LC;
	Fri, 21 Aug 2026 15:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWO-0002SM-RP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6wjr2t+T2ZZEmurJBrGQ+M266u9ejT5M+O+ELQ+F1s=; b=Tc/tr+v5HmoWy1IeCXdHZH2dTi
 9GdQvA2Rl7O9xsYPhADXYB6lbXXHzGr/YB2XwNPUDZan+r5hNg6zWO4Df+YXjIIEI1HwG6GTD6ce5
 ma8oM1ARO9QNzm8WRjIquMBSIz6uL712wYTzPjqdmdL++GwjZh4wZTmg5+3FEBDYAyEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B6wjr2t+T2ZZEmurJBrGQ+M266u9ejT5M+O+ELQ+F1s=; b=QWsW7MD10bRxsY1jFPAJHHJWBg
 oeiej8Sda6y6W644oozozu06GDUK8SjubKbUaQ6s0Sp4/jLVrU/CGeXUotT+wbasIkgjMUOveDni+
 XeT5QB9v4naCXLJEHf5txeJ9MfHSSa1JLAcTexoT0++dClT1aQMnjyE3jIdKB4cxcmjc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWO-0005FF-5f for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89C406187B;
 Fri, 21 Aug 2026 15:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76D1F00A3A;
 Fri, 21 Aug 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327462;
 bh=B6wjr2t+T2ZZEmurJBrGQ+M266u9ejT5M+O+ELQ+F1s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=DgcjubUhknuv2a8Ok9VR9MHPQG4MAP+cIusaJgkOAm8E4DWlnwznJfNEL0XIcfbat
 nspjOig23dnxLZPZX47yPqxmXXcwe7sVhUluZP/D9ZY1jFZt4MuZzNyjwfeTC5RyGC
 2Q/HRCeDzdRthF123N00Y2oLvjqt0iGfHblCp5CCQL92CiY/GoIJ1j/moddwXPkvVF
 uLwQHiD4nn56HGHR94cAr95gT2uCjdd92WhSTSVA0Pz9xoCcTDM60It3a2zRzNm+LS
 NDKShjEgnSILJTaNDSMf/yi6lwW5/dyM0wKrMkkFIb/jdHAdKLlaSJEXbhSziCWstf
 A9wFWAupvbS9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19840380A979; Fri, 21 Aug 2026 15:50:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732741163.1339488.13084551475061126977.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:11 +0000
References: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Headers-End: 1wxRWO-0005FF-5f
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix i_size when pinned fallocate
 partially fails
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 18 Aug 2026 22:55:35 +0800 you wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
> for pin file") moved the allocation loop's start down to a section
> boundary, but the error path still converts @expanded against @pg_start,
> which holds the unrounded start.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix i_size when pinned fallocate partially fails
    https://git.kernel.org/jaegeuk/f2fs/c/0f448bb3767e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
