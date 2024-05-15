Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2EC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 May 2024 04:20:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s7687-0004r9-BB;
	Wed, 15 May 2024 04:20:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s7684-0004q0-5n
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 May 2024 04:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z4nIYTwRUbASah8SxG7YVTmmU0r0BMQ7J88Bh9opegI=; b=kOfUvv/iVhbvkOjL+Idv7eJ3GG
 uA6aNoVL0j5TU3Cjbj5cLbLgaMrC706tC2J6ZfAPSIoHGzwJlTkhUFLlcQ4GO89z8RlVnJ7uqhuis
 t7HTyLofFrd7oBRB4UmkwRfK1GcLUNWcj0k0E9YDJTDYvwRtvVt2NkiPyOW1mR+BbFLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z4nIYTwRUbASah8SxG7YVTmmU0r0BMQ7J88Bh9opegI=; b=Z4x4EW8zvqzum0lF4mlJY30cjW
 2mYJB/x/NdahKVNhKXRI8a5xjVVlOzeXuNlK38uut6eaOBdvyr0IyTgf32zahEMtqobqmhuyP4VAJ
 K4We1nO6F4Q3euaWVP3M/XJzM8p7k+j2O7OceTC2VcMfioXhmEJDgLQJbueng81kwL0I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s7684-00009e-Jy for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 May 2024 04:20:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6DACB612E7;
 Wed, 15 May 2024 04:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B2C9C2BD11;
 Wed, 15 May 2024 04:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715746830;
 bh=IPVEhIi6lCtFGo0sCu4Gf678CrgSqtPa+8kjZYLJNZs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Lg3KclTg23Q4Ta5axXjPBz51TQyZCIUD+8ScpGpJNRiPzthEQeUYkRetchUhjG2Q3
 CWOlKqQTrAGVY6T1CElyF5yG6B7rYx+umwLmHTvnklZTQRp08Y4UEneaWIwUS60Kpb
 HydpbsF9vR2YD8KflZeP2HVj1E/C2Vsu7v0GezkmMIbXUUypWURlVpZSIq/OGcu76o
 3G/dAO5NvY59NipDXeIm6Gk1X7J5D5ByIS3Ac7JSUJqwJ/WGjQA4rOOfrRMzjWhxWT
 iPBeYQlXnTCIJiIAYT61AJgaefnci4pQnEaovRQ+vrqINd6V4Pqv+mgR/HzwtXDx1u
 clmq1V1/p+LIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EF361CF21DF; Wed, 15 May 2024 04:20:29 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171574682997.29254.10154206807293240549.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 04:20:29 +0000
References: <20240514113529.1498545-1-bo.wu@vivo.com>
In-Reply-To: <20240514113529.1498545-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
X-Headers-End: 1s7684-00009e-Jy
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize last_block_in_bio variable
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
Cc: wubo.oduw@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 14 May 2024 05:35:29 -0600 you wrote:
> Initialize last_block_in_bio of struct f2fs_bio_info and clean up code.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/data.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: initialize last_block_in_bio variable
    https://git.kernel.org/jaegeuk/f2fs/c/16409fdbb882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
