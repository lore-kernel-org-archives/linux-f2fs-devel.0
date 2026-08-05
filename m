Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DADC55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AXe21iLx1e9JUrQanKpVZPJR4muTq5JdZPqrGYeCxeE=; b=eMW/d3D+Sp/bastHetVES297uK
	Xuje7lQQlqLsxoh7V9rbxya9eTERaKf660xFfqx732RbIihhokdlMAqNrCNQMEpbjXNGu/82Mfj0f
	IBb/+qpLUnBYqQfoOADm8sHfsc5dgfKxLmqG/mO0uMilFyT9iz8/WMvlh/v9MwKmy2K4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3k-0008Cw-8t;
	Wed, 05 Aug 2026 21:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3h-0008C1-9l
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GQtccAjnRn7PKnQMx58skaphcp0foGAbHFEht1LPUCc=; b=NcJ+CpPfFrZGHTX+m6UXI9EsA0
 +j0tloD2Uqf4vQCyAKzkU52kI809HciDK6g620BmOlVroJZztW5m6vLsG3T21bOCOgDBD6R1smqVi
 qg0qqbS8pEg5vGzqXGmknZ0Ofvtx7uXZqUqFKOpCHSegrjRBqU6QI9XGjoCcTkDVSByc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GQtccAjnRn7PKnQMx58skaphcp0foGAbHFEht1LPUCc=; b=FGemkaPlkjN8yncjC3As/yA83w
 JNQDo4CnyWbvIKdNGrRz0GX90MshQGlcECwv+HuSlTE2CBry6gcWhf1TWJO0mXRxM0cTZZXNdgPb4
 9F6Tia5rnnyRQ4ZHInC20ODSoHK23ynIJUYH69hW9TcUDGOxEsZO7eTI/a1KRvD0tfg4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3h-000451-PI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC3FC43C84;
 Wed,  5 Aug 2026 21:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC0F1F00A3E;
 Wed,  5 Aug 2026 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964904;
 bh=GQtccAjnRn7PKnQMx58skaphcp0foGAbHFEht1LPUCc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=gCoH0j0/5Jk3el4vGb0Cvtq/2odUOuKS/DqUXLM0lIlYobwb8i0po5aqq4/7Cmxe2
 IwQPMqNPAfqv6HZW5n+U0BxVRSUUtp9ydmtaUSG12hmy1izvWEmJGz3piIGXR2iA8A
 5nwa8qgkIRyShd8Jr/TRcTOwtP8rRWAW0Hr+cn3+644FCGYkYxbspxDSIyAjU/KorI
 KdvnBYo3KcAUXKrtdIN88lG2TtGwDjcP4zJGbfXN4xFnSVoSNEId3e1b66k3d9s1fh
 X4HFRBjLcR3/DeqoLuJxtHeKaXRuGhqY20blDIztfFr+OAW7BTFm6aCeh3BvY+5big
 cVZKx0k7xTzTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 938CD392FFD1; Wed,  5 Aug 2026 21:21:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596486413.530543.9142075670329483117.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:21:04 +0000
References: <20260727074910.1965988-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260727074910.1965988-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3h-000451-PI
Subject: Re: [f2fs-dev] [PATCH] f2fs: return writeback error from collapse
 range
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Jul 2026 15:49:10 +0800 you wrote:
> f2fs_collapse_range() writes back pages moved by f2fs_do_collapse(),
> but ignores the return value. If writeback fails, the ioctl can still
> truncate page cache, shrink blocks, and report success.
> 
> Return the error before truncating page cache or updating the file size.
> 
> Fixes: b4ace3370324 ("f2fs: support FALLOC_FL_COLLAPSE_RANGE")
> Cc: stable@kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: return writeback error from collapse range
    https://git.kernel.org/jaegeuk/f2fs/c/f8a410880025

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
