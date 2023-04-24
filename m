Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F67CC77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Apr 2023 18:10:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pr0dv-0006dN-BS;
	Mon, 24 Apr 2023 18:10:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pr0du-0006dG-5x
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m2L9JFXCAfy9OqiZYZf8sUcw5qlK0R0PsstVsvtXJzw=; b=BmCWLHLG+tYBn56k+zuXXMCXOd
 E/QKLt/QOahM3MUK7CEKPOL1xGgM8pFN+NCBsss+TaCNC9n78wEnfLwT/qUTUd+u+PfVkuT+u6IeV
 5HB4JZgUs/2BPTA2a8gfGyLvOyAZVZClz8zmcUcXZqgXO39KXCTTDW8S2fWsj9bsdL5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m2L9JFXCAfy9OqiZYZf8sUcw5qlK0R0PsstVsvtXJzw=; b=KZh4LFDc5guJME38vrle6TlNfe
 nsB7PmOLGuD2xVCrmLoVAaM+Y1zYDJd781IGQxwVG3nDs+cSaoGGO1PITF5DId6dzgwBZ72c++OxS
 Mmj/shDBLy0eX7Y+ulUZ1f0SssbvF/1EqeMT4BVPANQ4jBUAZBzKl9ZpzLcv3RnZiTEE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pr0dt-000FAi-GH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2C24B627FA;
 Mon, 24 Apr 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88887C433D2;
 Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682359819;
 bh=5xGyBUYnUwW4OTflQUHEhzZkbxr+LFXlTmTBB1kJWp0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=W+r2rsXI0iVlyqHVSGwwl7cwnjlrBMF8NJD+9g4bQcaG2n1wn0IAsvbP+21VbFXhr
 t900yl06XBJrSk7TMjm99lq6/lQxJBDicvuF0e4rRgCTj/rYBntRglDBZA7dHb6tIg
 CkhYCb+ntEMCD4oJ4TMzPgRDWaV/9L3/wxC2Sby0HSjrjg40GjORCUdtTGURBRtle6
 nWRRi2YXVr+/+JKf5+1PNkGJkZeUXFyRqpWzQ20o8ADitoVLa6xkOnc+EGCXWDBtMF
 R0l4KQY6BkoK0xINUU3b/htOs/3EM/pw/05P5mwgdbWSoCeD0nn3yeIkw8Q+7NjWrc
 OTsV4FGN4nIyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 61926E21ED9; Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168235981938.17900.13599013308884334410.git-patchwork-notify@kernel.org>
Date: Mon, 24 Apr 2023 18:10:19 +0000
References: <20230418060954.67585-1-hanqi@vivo.com>
In-Reply-To: <20230418060954.67585-1-hanqi@vivo.com>
To: Qi Han <hanqi@vivo.com>
X-Headers-End: 1pr0dt-000FAi-GH
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnessary comment in
 __may_age_extent_tree
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

On Tue, 18 Apr 2023 14:09:54 +0800 you wrote:
> This comment make no sense and is in the wrong place, so let's
> remove it.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>  fs/f2fs/extent_cache.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnessary comment in __may_age_extent_tree
    https://git.kernel.org/jaegeuk/f2fs/c/8375be2b6414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
