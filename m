Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15173C3DA4B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:40:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sTMsY-0003Mm-SK;
	Mon, 15 Jul 2024 14:40:38 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sTMsX-0003Ma-W3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MINZcX1LZhzCAeIhWUe6QXo4chDujyPzTaGyu3p/g+o=; b=REWFIwwxOi4tb1jv+f+DSlIn+F
 1ZZMlOOkbN9+wLfvT4mcA5SK0jOvSPXLnlxPbjgxBNkadiNoKOmci5URO5oQE/ciiE9BSyRhWEP/3
 z1lNz6+YhqABxjOBTrz5fQJL/w9OHIyB9Ok2hLIzYR4ZsMseXa/+005bs3zUBnYlbXps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MINZcX1LZhzCAeIhWUe6QXo4chDujyPzTaGyu3p/g+o=; b=OmA6QE5zN8IGwOIJgqyfUJ/kcz
 Zu52PLUAylsEwK7qetOo4Lyc0FojIRisu/4faKdVGif69PzJe8YbzRRB8ejZeOGoTWd9KTG+TSsJX
 xMkxmc705Y9xmwlIOWMHFjH1B8juTJ1sOnHXVXBZnBVaGayW54xIqrCdBGcU3wpFWnvE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sTMsY-0003Dg-5C for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1062B611C3;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A3DC4AF0D;
 Mon, 15 Jul 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721054431;
 bh=nLTjZ4iku7w3CDYmTvYQeTxA3KeLggHY3Bv8PHGatPI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jj3Vlgh6ccvAGi1tcuZ/LYM6s18skXDN0AlW+zr8PGhDNu6MxlRWAsTGTo2C5b3TP
 sb+opPLh74dPKuwLBGTQHfUvK1cngwS9KFi8ypazvbnITevIx1hE7Cqqs82FB2JBg/
 oATQRT0dSGmBlGCAqSRLdng14UpGEhyFydstClJaWDcOq4+T/QxJ6ojKNmdjkCezu2
 fh3hAkG/r/VhI2rtZxGTLwfxJpaJGPKW+3wTmmImmQgPHUnf9JWax/pE+tVyy2bEkj
 CO2ZKkoOkXWMXgOdRV4I5+lNzs3i9QMNZ5gfsj9m5HKLlZy+DQi7fZNw4HlJxYARQp
 gRYBiwjjD++5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C1352C433E9; Mon, 15 Jul 2024 14:40:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172105443178.17443.14567102589970622555.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:31 +0000
References: <20240710012659.3415856-1-shengyong@oppo.com>
In-Reply-To: <20240710012659.3415856-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
X-Headers-End: 1sTMsY-0003Dg-5C
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: only fragment segment in the same
 section
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 daehojeong@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Jul 2024 09:26:59 +0800 you wrote:
> When new_curseg() is allocating a new segment, if mode=fragment:xxx is
> switched on in large section scenario, __get_next_segno() will select
> the next segno randomly in the range of [0, maxsegno] in order to
> fragment segments.
> 
> If the candidate segno is free, get_new_segment() will use it directly
> as the new segment.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: only fragment segment in the same section
    https://git.kernel.org/jaegeuk/f2fs/c/e3a19972a49f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
