Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6787CCD182
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PnlRRN8pZuLH4cOkWGXbeyYNJBXFHqsi9Fcm3FHE8aA=; b=VR40YmdA8tuD6BB+qWER1VUyJP
	/nGqmtidS6VMJvNRnhJYVSXlJQmouI9/NwhxCc9IKMDnkkTcUR4fS6ja1s5LlGupQ2E4rJYoNa81f
	huIg/QTpIt9TfWNHbI7EEaAOg0wmXKBv+QiUDDdb17qvfrLI8ZaVi1VjwWQw8NF69b+c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v4QG0-0003lY-PQ;
	Thu, 02 Oct 2025 20:50:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v4QFu-0003lO-NZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Oct 2025 20:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MgcIbTrl9j8Nu1XqqMsuv/i6yTlzfGJxq4eQQD2i91E=; b=Hy12d4i4mzebF2j4GDDOw0CxkC
 XV7tI/Z5am9WjBtoJiDB0d9xCD3amhswXP5nI2uzxU3RF87JMluO/4gg7gNA102/7yKybx3TQ9pOE
 iToNr2mawcUyLLED2dWDE0GtIoyySLNYlT5CleejI3QiWsTCgCZb0iKFX7fsL8imXA0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MgcIbTrl9j8Nu1XqqMsuv/i6yTlzfGJxq4eQQD2i91E=; b=HUWM8IVWVmx045X6rCmCWBsKjM
 FZTDI7t76AkI/vxdUh7mgAVdQHpZK0Sls80kD6xHMJuId0uTMZ/vsu7s2gHNt8uxwZZiqpE9TTHHN
 N5x9qaOSj14Q8oHDkUqikHTL1AGZDy0H14sF32FDXfyE8k9k+MtkaDfc6tegtRqlH2+M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v4QFu-0006wp-8r for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Oct 2025 20:50:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 850BB63DCC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Oct 2025 20:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34831C4CEF9;
 Thu,  2 Oct 2025 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759438215;
 bh=dWaLZLlgwysF2Co+urXzVTdaa8JC6sE5XfuYvZ5vCFc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=k2F6ycf5C41WDi8otHClr720iKpFJ/6r6F181Cg1YbRjlpUWaP73XQj85TiIw3sMD
 KrXOm4w0swxtpbaDmxffdFxZUNd+JZo8pwiq9qsMxlh+40suZf8h207wn+aEQYFhyx
 oehWuUb1K/fNR75T8f3PHYjdqlbF2lbNixSNWyMME8MhGxCN5syD8nNQk/w99Okiz0
 OTliSiHvt3/IgiMiS6a07wVeLzKTWZKUA598kY2hPCFGJ/aQbRHzduWyT/Q2iyW/fq
 Sx63ZeW3v1dK/7QCvx3Ooq4pr+WdDJCugE6Kgw+YdX0ySMr7dJ8GYF8nTFNeMu/Tbj
 +dfO6jAZCm7Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 344FF39D0C1A; Thu,  2 Oct 2025 20:50:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175943820701.3449937.17994967060851018856.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 20:50:07 +0000
References: <20251002015645.3588322-1-jaegeuk@kernel.org>
In-Reply-To: <20251002015645.3588322-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1v4QFu-0006wp-8r
Subject: Re: [f2fs-dev] [PATCH] f2fs: add missing dput() when printing the
 donation list
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Oct 2025 01:56:45 +0000 you wrote:
> We missed to call dput() on the grabbed dentry.
> 
> Fixes: f1a49c1b112b ("f2fs: show the list of donation files")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: add missing dput() when printing the donation list
    https://git.kernel.org/jaegeuk/f2fs/c/e34b65fd0c7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
