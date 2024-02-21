Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D643BC48BEB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:10:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcr3O-0007s7-W4;
	Wed, 21 Feb 2024 18:10:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rcr3N-0007ra-10
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SRApGIBWuzkdrCNYbHd104AgHQqF9CxhaInnd4Qk56k=; b=bxk8hn47lWNQYF/juIhi5fbnyf
 gV81iAwjpVyAH6ZgrOVuOkin819LnPLN48njJ+xWIkdMA8wqqT0gUPxfFQoBfaxGkn3gNXBtjHi33
 kdnsPpqzbGrXIl5GwvFPg/qa2kTHMt3WVM+VUASLGPCnJ6sGIM7f94Ms3wKOeAkj5X9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SRApGIBWuzkdrCNYbHd104AgHQqF9CxhaInnd4Qk56k=; b=BKqx0raLVRlTgS4m0b67my5IwQ
 GQKEKI3O/z7PB24vbDqg5Dhxi/0YvRcCk9g0YCJpL008baoSlTm1KPLT+YJLqri7R6yC9Qntb0jaH
 jH1DoioqpfJVa2RarJQ4BnpZDGJ4P5AVH2gVGh4A9RhW3ZBxETy60RtmFbu3Ed/RZK/A=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcr3L-0001Su-DB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EFAA5CE1F27
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4316FC41679;
 Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708539031;
 bh=P68oB+HZpF2+QQkiji48wICkD3gj4McmB7ESLj4w458=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=EfXdMhEbsrCeqZdq0pwQal+qtvAQpOnV1xu4HoyGYlDRZqNGhUpNt0xmsImXMeqOB
 xFQOrtopfYqLTGBtyqoDCs2X/Xf+JruncleDwxcj/iInSqkEhwcx6jSgcJU/UzsdMS
 /ZBXSbRiEC0ntbmxgedk1oX35Fifo4WGj+mD7pYduMLvO52NG8kIGKUMxSWYEd2jfJ
 DxxVklx/+qTWLWpeZdmo5BQhOEoqB2qi5FXwMQdE0hF/lm9xYwT/giql8rQfeR8/PO
 LPHw5wH2dN6hN8DDF8N/GppNz5x2712brueoiAq2RJhq0wZoGcrXNQlv+H01+2yBsf
 EJBU6/qy3sIVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 27C4ED84BB9; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170853903115.7043.15916338851504288763.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:31 +0000
References: <20240212160818.1020903-1-chao@kernel.org>
In-Reply-To: <20240212160818.1020903-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rcr3L-0001Su-DB
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to check zstd compress
 level correctly in mount option
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Feb 2024 00:08:18 +0800 you wrote:
> f2fs only support to config zstd compress level w/ a positive number due
> to layout design, but since commit e0c1b49f5b67 ("lib: zstd: Upgrade to
> latest upstream zstd version 1.4.10"), zstd supports negative compress
> level, so that zstd_min_clevel() may return a negative number, then w/
> below mount option, .compress_level can be configed w/ a negative number,
> which is not allowed to f2fs, let's add check condition to avoid it.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: fix to check zstd compress level correctly in mount option
    https://git.kernel.org/jaegeuk/f2fs/c/ff059dcdda57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
