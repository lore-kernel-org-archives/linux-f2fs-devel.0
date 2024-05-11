Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EE0C25B4F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5awo-00042T-LJ;
	Sat, 11 May 2024 00:50:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awm-00042H-4s
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fogu62ZUb1hRhtB8wur5kGZLHL4pkt3E8WFfYwV7Mbs=; b=UCmq3fdT3N/nDUut4LXOntyIEO
 y4XtcPKJc7wYCJ4Ou5AfA8SFG8F/C2zD9EA+bDBktHfgDWZMos7+6CFZ7Xhab3idOgj6Vh1UHzFbI
 zLGVTFg6kLA/uXWLjVBR4oDSjxPgATO+EEWMgrzkQdVkVPICX2dWneK0Xqz/OSjsIS7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fogu62ZUb1hRhtB8wur5kGZLHL4pkt3E8WFfYwV7Mbs=; b=bDUWtywA5MPfbyAltyaHcC6cGT
 5ZtzedMuuOuMWgKzX0Qo+S5TyLB+MKa8onwHhdTlPaDzwzgKrciHTde/I8TggH3YHRVnFoUTp7NBE
 ZAko36spN8dQtQ0iCqNis7xbGEo1z5gJ642kyghXsgN+9C77L4yn+g32ujbvjtX9lOaI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awk-0004yo-AK for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D4C9BCE1F32
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB33EC32786;
 Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388633;
 bh=R5U8t8MN0hqu7l7yU22M0NMbzTpnmhHxeE8rTHlv+ew=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gz28MCtpXPmTPfefkM4029fWb2/+g9qSGTYfkjjC1VYkUqpXnKjMP2R0EqOztr0Gw
 a+J2ITB5JhNUrZ5kfDfQ8ICmXYR60ntCvA9W8d0jNf5Jhq88SvPk7p8vCnosmAJIVU
 ChZUWxUyqaEVQlS1z6Wr5E7VaYkce5B5TP6yZIHpIzdfmaALyWt6nHnKBZZRJ2iAdl
 OCd+iXfjGZnY11sM33azMkgVfW/OWRAQOyU9bJF7pFZnLCYESpH5sZJrkq0Zx7jnj0
 XnGfZcnwdy/+s1JXYO8gFECsfsAATIjmmgFQYitgAExW2gAyXKHqfq5l5eyWyVk6aQ
 8hMBfM39yN4Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C3E03C54BA1; Sat, 11 May 2024 00:50:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863379.11229.10303320996620120996.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506104538.778116-1-chao@kernel.org>
In-Reply-To: <20240506104538.778116-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5awk-0004yo-AK
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove unused GC_FAILURE_PIN
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:45:37 +0800 you wrote:
> After commit 3db1de0e582c ("f2fs: change the current atomic write way"),
> we removed all GC_FAILURE_ATOMIC usage, let's change i_gc_failures[]
> array to i_pin_failure for cleanup.
> 
> Meanwhile, let's define i_current_depth and i_gc_failures as union
> variable due to they won't be valid at the same time.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: remove unused GC_FAILURE_PIN
    https://git.kernel.org/jaegeuk/f2fs/c/968c4f72b23c
  - [f2fs-dev,2/2] f2fs: fix to limit gc_pin_file_threshold
    https://git.kernel.org/jaegeuk/f2fs/c/c521a6ab4ad7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
