Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6123C678DE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 19:20:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFgeB-0002dA-GQ;
	Wed, 11 Jan 2023 19:20:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pFgeA-0002d4-5U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBSEU5wriSpol+SSjTG3gudSi3ZeWhYCgiV70zODXqI=; b=RO158CZNnXnMuNrXMjmQhkrq5q
 tlbmCIG7sfJF8jA+oWryz6ENk2NVxPmK3ujcMy21JcWu9HrPsBJlCv3wr0vrm+16WdqbJlIfFNnYv
 4W+5TeEUZe8fPMpA5NxqJCK4rNfq/xVf4WysdKxrrYKz3zuYk1UySj5Q6TY43kSxUoCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBSEU5wriSpol+SSjTG3gudSi3ZeWhYCgiV70zODXqI=; b=VW+Zzafa/ZiYhxJRog9Aet+gjV
 LnfeFdVHeGBAtkP53GRTrbLjYo3yTzmn0X+8tRmvpHzuYV7+C3W1eFR5jL3aqdB84XHl0tTyh49kZ
 JX8xWloy9ULod/oqHlJ2Wm37Wwi+ZJlLNOkzITIujww8JhuHP7kzga16XoC3Vt8ZFMnU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFge8-0001VK-KW for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 19:20:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5B6B0B81CC7;
 Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06539C433D2;
 Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673464818;
 bh=i7Qp59A3TmyXYbXmFvhfzEdfZw5mam2mOwVXokz7Dvw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Z88Vj4W1wyLVNVP41scf48p4yDzWqGirMHVH1sXYKIAdIXNnhH9AeSne6plfL6V9E
 2F6YtZgBWCKk2X+29vWarhk8Ek3g+bENea7qK+2nSxIyrrpFDexiXU9Lx2jcU5bG0G
 dsocGlujRfs/0qZBxT9SoxfrJaZRJ0sp5md8GZ821Cgiqx0lfrP4VQtSN7YkgVplcZ
 pdfvLaT2OcGKG/ehJ1moimPmyxwf7SihQ4n/igiNbE+QL6EiH2vSKOSsQIfncFfR44
 8NlOmzlkxHaG3MpJhFVBHvzagsldPZy8y0ciO+GWLqdt6GMfTKLFZNzfq1qAN0WTGS
 FmnjqcOFoJP3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C3F6FE4D025; Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167346481779.5008.8969169400238709620.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jan 2023 19:20:17 +0000
References: <20221220191212.58042-1-frank.li@vivo.com>
In-Reply-To: <20221220191212.58042-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pFge8-0001VK-KW
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a f2fs_ prefix to punch_hole() and
 expand_inode_data()
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

On Wed, 21 Dec 2022 03:12:12 +0800 you wrote:
> For example, f2fs_collapse_range(), f2fs_collapse_range(),
> f2fs_insert_range(), the functions used in f2fs_fallocate()
> are all prefixed with f2fs_, so let's keep the name consistent.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: add a f2fs_ prefix to punch_hole() and expand_inode_data()
    https://git.kernel.org/jaegeuk/f2fs/c/1cd7565449de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
