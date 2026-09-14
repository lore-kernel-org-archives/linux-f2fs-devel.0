Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF667C88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSByN4SDinLZZwQ5R7WNcuHXCYITLQNnrvwpFk4+2aY=; b=E6ZwLFD7KpXnNZ19u3hkMxz1lX
	Sh8uwCmIw/xEAljfcUajgKFFtw7O6iu8UFKLBA+7CsPxFQJIHZrPx0pk8y+gS4KOrDyfZn/eKh78g
	eZWe8GOS3c92UuDi1N5llnrZQ2rtdsLNxgIc+RrKqt7ordwUGEoLaJKcXjeRnu83MlHo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eL-0002Bd-HK;
	Mon, 14 Sep 2026 15:31:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eK-0002BW-Np
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4DUgiSH+lZul2n+OAFwMISNCwVAriL3J3ZG2dYHV594=; b=nKprp7gbA6O+l64VQT1OXPBA5s
 VMPn8snF0wEOoPK6nP70P/IkEBqW7WFXTSwmiuw9r4frySIixdksHotPYiQCJLAiRYDnqDbZv3s/G
 MuQ9cD5WDRElcI8wq/LlY1D1A0v52rZTt+2C/hgy5PhBd/x3RL3BKWvDYmZzEwpogee4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4DUgiSH+lZul2n+OAFwMISNCwVAriL3J3ZG2dYHV594=; b=fAvKcCC0UUeo98T20OXWvlZHeq
 krNL8ze7pDNFI8HTQ6PL8fmUTT7SLWHxzNdzTjYUzhNkOkVcoSKOy/tcaHAaRECnRTZazX1MrCDSx
 dE5aha7AGR432qeNMZ+gGvt/i+RfRdbtELv0fNYSABuTTR0XDOfojrfJHx5doEOYPRQk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eK-0000HV-RJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8FD6D43712;
 Mon, 14 Sep 2026 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722B01F000FF;
 Mon, 14 Sep 2026 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399871;
 bh=4DUgiSH+lZul2n+OAFwMISNCwVAriL3J3ZG2dYHV594=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=OwX+8AD32JiRqGFJEw4JcxAHwoQoyPJ2tdW5t7A90hjoe2WKd2LEE3glmhRxbwH36
 DvQ8iBD2yjuJbdfAkFV3rZXhTgTav5xYr8cMOlESAFk539t7Yf0RoNZWKVg+X1E9tr
 2J66TMlNpIyr5RhcqC1wD5zTbuEgjsTSr+y/TcRZbwHlfYg9D0X/aDhn2oOXCcfMJi
 idqtLGXyh0EXxnitUg9E+tUBk6E0B7xsNnwxbn1zFq//oyELSlOg21WJN3DzxIEkUM
 wStwe9W0zAyvLrqrR+YwCGQJvPr7ojZ/TA5XbwFI3RD2tZ/ZbqrB+ZV3ealvKPAcSP
 vkkvpgpTEF7gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D09923924A79; Mon, 14 Sep 2026 15:30:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939980663.647967.17495225245064367984.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:06 +0000
References: <20260909114615.1390443-1-jnhuang95@gmail.com>
In-Reply-To: <20260909114615.1390443-1-jnhuang95@gmail.com>
To: Jianan Huang <jnhuang95@gmail.com>
X-Headers-End: 1x68eK-0000HV-RJ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quota: fix stale lock holder on
 remount failure
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  9 Sep 2026 19:46:14 +0800 you wrote:
> F2FS remount can fail while duplicating a journalled quota file name.
> 
> f2fs_remount()
> - sbi->umount_lock_holder = current
> - kstrdup(F2FS_OPTION(sbi).s_qf_names[i])
>   : fails
> - free previously duplicated names
> - return -ENOMEM
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: quota: fix stale lock holder on remount failure
    https://git.kernel.org/jaegeuk/f2fs/c/3f140a60c92a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
