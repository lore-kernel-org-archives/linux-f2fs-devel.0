Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B91CA101A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:52:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sk8bE-00014l-FD;
	Fri, 30 Aug 2024 20:52:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sk8bB-00014Y-MP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:52:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRxNFuHJBV4NScpJR4C+wk+hqEMCMm8lqIQaq/AWV1U=; b=jlHpCxtzsgMbPJcuCv2r/p1kfm
 yIHmgew4fk1ngjUokeUAcGi1J6sTnpUEvxgWL8bIG8ZJZtrG6BGiFjFgC5zLQwpaIL9LXxqGZJ5gQ
 t7ZpDJ0z1XzJKS0to99LKKN4j0YsYEGBFnarGyk71YDu7vKZ9m2clRO5WdatPbM0uPyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eRxNFuHJBV4NScpJR4C+wk+hqEMCMm8lqIQaq/AWV1U=; b=Wx7Tjv28wwOd2cr0z4bQZDBYpe
 /ewJiz3625Rp7nHJVD5NWmuBqnMMZH6bHQ+gHnwdBGyctr8g270IgIMY7VAO4OMs/cgSOgwhsPEEG
 b5g1vRi2jqVl5D8kuaegrpfNtT8D2kgRqhmsbLSwxvw1x0mkJ6F3FK7h3/kEH+Ox3jbU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sk8bA-0005nk-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:52:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 037F1A41AD7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203DC4CEC6;
 Fri, 30 Aug 2024 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725051109;
 bh=4Vmdu72nUVTxQXYckq6IBwekLTpwl0AskvoZbUnNnSw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=t+F6HfxgLbI227YOSEmxQMOjwOpFCRPRInLD49dQSWL6hZ+K7XqZlOcaPj/Zikci4
 KAu9I2ttKDZfb5PyX0v9O+E/JusyiZHjgvXPdeHwo3iZjvYZFFNA4OD+539WKYWti6
 4sB0Dcyymf2//GWZnXqZD/aVu/Wr6ThkbzmvrYRixvqmY/afDE9WmYKTreW3nW9gi4
 74HqcjK6hn627tObMjdL6wURtkymqggtbGkckSKAPI3yHHpKSTnclcb/31Qdz1Ch7Y
 F7mcE7tU3qfNq4ZBdv/QE9pE61mkrxrqy2CyBn8KJr25LtT6WaDAnpmihNhGl1ObJm
 dyZbpS04YWEpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70D9D3809A80; Fri, 30 Aug 2024 20:51:51 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172505111000.2712133.17949895219038625887.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:50 +0000
References: <20240812141242.4159033-1-chao@kernel.org>
In-Reply-To: <20240812141242.4159033-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sk8bA-0005nk-W4
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to wait page writeback before
 setting gcing flag
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Aug 2024 22:12:42 +0800 you wrote:
> Soft IRQ				Thread
> - f2fs_write_end_io
> 					- f2fs_defragment_range
> 					 - set_page_private_gcing
>  - type = WB_DATA_TYPE(page, false);
>  : assign type w/ F2FS_WB_CP_DATA
>  due to page_private_gcing() is true
>   - dec_page_count() w/ wrong type
>   - end_page_writeback()
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to wait page writeback before setting gcing flag
    https://git.kernel.org/jaegeuk/f2fs/c/a4d7f2b3238f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
