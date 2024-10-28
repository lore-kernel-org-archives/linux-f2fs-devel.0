Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45934D339A9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:40:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5TjR-0002KJ-Hp;
	Mon, 28 Oct 2024 17:40:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t5TjQ-0002KB-HW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 17:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zn+GMwXpCTUYjykl3dQxHOlWEnkY6wvEbrDKjDCVsXU=; b=anC1eh8PtKtdoUmWzvQAvUjDBp
 q/JUMgU/c8y6N5MT5x9nsHzIxXj+XatEgahQ7S7Szdl5gC/JYMPKf/PhuVtICi2wplpGmFkOh6pCL
 mNcRj4KHT9pDTnULlt19OCes1FutJgy9zdO9isFqg9o2dmwMu9jyYyQJeAh8srHcTFEE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zn+GMwXpCTUYjykl3dQxHOlWEnkY6wvEbrDKjDCVsXU=; b=aG9HA8YCaNMjiW78XwuTZheb80
 ZWKnRNCTJcLip2OltoIxxs+qEj+En+ptqo8MjFD4UBLs0zv/STUZIIzbSiqSr2ByALvvsDqL+QmrQ
 ia5DV0OFlKzag1OK+GOeSYim879AduZE5UVq2eMxry0BlfsOB2WgSQQSO2aB+tMbpCx0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5TjP-0005H9-Ba for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 17:40:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 78BCC5C5DCA;
 Mon, 28 Oct 2024 17:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505C6C4CEFB;
 Mon, 28 Oct 2024 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730137234;
 bh=QJdVL0zl/7RQZ5wBOC+lbZLbljUN2Y68RZmJB+6O3l8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=b5/XNgcVrN2bDWX/Nixs1YF89pyv1SYp5ZP8OX2wLrd/xRGMcYUeY5hJyijD5VEdv
 ThrYPtvmbjFpzjuIxy86Nf/VuJhiCLgoMjg/1NMQpvy1Slh5q+kG9ANmNDCbLKtH0j
 7W1DVAO530p9OkDuXu1338yseZ+2Hj2RsN6/Zo1O32tew+Vg1kqWS4+5/QoXuPRBtx
 n5mtA5lXRr65dcGHsE5F8wI9bB6Li57U1DyJ5vjJf7mOlq/boXhmVBYnQfeSea6J44
 ZVDCiLi6ZsfEECUE2P3MryasQi4ksZ5JPa8sWgPHRjVRRCTAynI+IkHozEHXr8/TAl
 9r64vrIvPHqsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADD99380AC1C; Mon, 28 Oct 2024 17:40:42 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173013724149.126843.14457893134521863981.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:41 +0000
References: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
In-Reply-To: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
To: Yongpeng Yang <yangyongpeng1@oppo.com>
X-Headers-End: 1t5TjP-0005H9-Ba
Subject: Re: [f2fs-dev] [PATCH] f2fs: check curseg->inited before
 write_sum_page in change_curseg
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

On Mon, 21 Oct 2024 12:48:01 +0800 you wrote:
> In the __f2fs_init_atgc_curseg->get_atssr_segment calling,
> curseg->segno is NULL_SEGNO, indicating that there is no summary
> block that needs to be written.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: check curseg->inited before write_sum_page in change_curseg
    https://git.kernel.org/jaegeuk/f2fs/c/f2bbbe277c22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
