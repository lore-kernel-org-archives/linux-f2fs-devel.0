Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3054AC001DC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7D-00062t-Sl;
	Mon, 17 Jul 2023 17:34:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS7A-00062f-RS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YCE5L/OOIxNC0GbAA+PcFZTStWr3k5C/tSnBcm3LOCw=; b=Guu7GL6UmTEo8ZIkkkMCCTDMiI
 tGL8++uIVXE7eN0NokGuA/FudeU8S2L1L7SCaKii1y34C1WGd7eAZNP99R7aNgGuPhGA3IArC+M6X
 MV8qiNRAIkqSB/IviKIPP9FT8f5+3PsEWCLkt8znuQOMhlsB5OEQL5GgW+pF8FlI7qtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YCE5L/OOIxNC0GbAA+PcFZTStWr3k5C/tSnBcm3LOCw=; b=RXNu8Hh/8P8fkdrDuHHThoszfw
 e7E8qJYzTiNhKKmqWQSTbX9sKSVtr/CAY5PLiwzpMN2ynEUajMEK+kLW84Gha4wtvCRcprosd1j0t
 68K8NRNc9+4KVg3SryD6qy+IBcNOzFVEGTkfnJWPOYYVBhgKLjnypz0G/fdPFCCjcBsg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7C-000145-P9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1D065611A5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03FA2C433C7;
 Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615262;
 bh=l9fnYPUEU4XFFKmH0AcPyY4PDnFuy0+gUPjAep7XsVM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CExiXQ92mVHqzUQ+lKfGH53U6rRbT4nRw4Pzy7cwswWdAUycAHRVY4leCkNFc4+b+
 371vFB60YnA796WQX5YV6gAFm/kAEUV6Xe9JohYvFAFlnEvB1J96uDcpGsOpJOCgQF
 PNT5Z9KO+QQkUPjjhvlfb9kWfdeFEZJ4eDpX2Igw6Kpxym793J8w4pgRgy0NRQQeWE
 E+AtgBeBVi7GiOApuKuPqUTR1PmeBgo+JZ+CAycsk/Q3qpxcdz5n+Z9M/XVDFF+EV0
 W2U7uvjN76zlV4RduEHc3LHJVx/FmccjP2el0/26ZeUGsWW0yWX87lz2O33nkSuz2E
 hTcY1WSJQlMBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D16BCE29F34; Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526185.4078.17033386338905134361.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
References: <20230710061058.2303767-1-chao@kernel.org>
In-Reply-To: <20230710061058.2303767-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qLS7C-000145-P9
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't handle error case of
 f2fs_compress_alloc_page()
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

On Mon, 10 Jul 2023 14:10:58 +0800 you wrote:
> f2fs_compress_alloc_page() uses mempool to allocate memory, it never
> fail, don't handle error case in its callers.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: don't handle error case of f2fs_compress_alloc_page()
    https://git.kernel.org/jaegeuk/f2fs/c/df19023418cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
