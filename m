Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80CC28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:20:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsNsQ-0005tr-GX;
	Wed, 12 Mar 2025 15:20:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tsNsP-0005tl-PP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 15:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IdC7rAjjWmCbwye5eyWNhH3asiiOqHuKm0BM9TWjog4=; b=RvMH7qXWsWR1yAN7hhwsP0SBAq
 ZsJ9rEhQZ8j0wIYMel5cgr4hj29b7TKgfxoBfN8N+fUEqhTZnbRYW3QWFqhHwwufczp4EbFAbSi5o
 8bN93Q3zEtQImTnBNITXhZ78jEvBVhXxXezuwXV3OOzVjec/tVuEq1BjZHd1ogrUq4P4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IdC7rAjjWmCbwye5eyWNhH3asiiOqHuKm0BM9TWjog4=; b=O
 4g5RAgLnW8gB3lhLA6IiQGfPi7B43kB+yCqlsp26V9fTH04+frYZrrOliKqB5Ylol6fmV1kg0inSV
 Q5hiKE5+0sYTCqFeIB8Bh3FDNujAtBA1KMa8gTRa6mhSOznYQuwQgMBiclteaiqJ2QeT6fuV0mDWQ
 8hcK5Rn/C1geOS2I=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsNsJ-0006v4-Ie for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 15:20:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E81CEA4270D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Mar 2025 15:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85523C4CEDD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Mar 2025 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741792797;
 bh=epIcCvwiaZhU7oJU2qCOUU01+UUe/TjhA/cszfgeLrw=;
 h=Subject:From:Date:To:From;
 b=HeQ/RWUcesjngruudwhZSpmP22fNYxyuEE6AHhMl/b3tZ4kcyUlJDHzjMQYHYikKx
 Bp+Yd7FASGT4p+aRB0mIc3kF0NiwH0ypzXwBQIEnrW4HwmxOfTpeJZqbHpujpKnrU6
 jH+EjVY6lNJumXoujwqz55e20lqDUIoecIa2MryFLRk0K59bmsfD4y4TUqjqiCD5nO
 xzT+sXHioRuItBMZzpIOsENhuCrG7xyZpcizN2gIdOWlkBIkIhJ27BeyID0Mr/0a4r
 wMMmlCGB4glbMHG8FjvSIt3nunYBXQ1bcrpTAPzAj1r8fAALLEGPapiwpUQnQhVj4l
 E86ttXlOHCY+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F1A43380DBE4 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Mar 2025 15:20:32 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174179283159.831874.591229097591895257.git-patchwork-summary@kernel.org>
Date: Wed, 12 Mar 2025 15:20:31 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1tsNsJ-0006v4-Ie
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: fix to avoid running out of free segments
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=943024
  Lore link: https://lore.kernel.org/r/20250312090125.4014447-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
