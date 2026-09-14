Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4254C88E78
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQDOP6vn/TnwNw+mz2l/nuf3Boa1wTnBKVT3l9zNLiY=; b=Kxd2UMAay279wLXq05raqNhqSn
	vjb0HcVCLu/hVia/VIR9UNhOPzcYQUFmxrQM656t561357oGnHcsjK7UlsHTWWVTtMk01jNEXSwCS
	KuwOOm9xxtBAVWzkL0F25U0M+OPPv45Ms0X+LV5RePyh9SrJItGecLWOzhejzTWgBVHw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eT-0002CN-UA;
	Mon, 14 Sep 2026 15:31:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eS-0002CC-AL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIaU1MK4mUN1n2LJQplC+wDgs0ECojrkK1qlSDjfHIM=; b=YWhUkIkq0Rx4QYu8WkY8oyXG7z
 BeHRDHOkYKlSuPS0wDZGdAWrWtYjG3LZcBi+lpvqJyD7LL+w2PnoE+QnV2VjFevhxQblWnuXyL80q
 BtJ1N/PVz5HdQG378vIv21SJZaHMPm7oAyPy2ygNBZJc2eZ/roQI1OXAbyRL0IRaBEYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIaU1MK4mUN1n2LJQplC+wDgs0ECojrkK1qlSDjfHIM=; b=Mq6aCtKEjAQDbvdBNjsHEH/m9x
 A/1YGev5VXHYxxpiAtrrisD8fdgvi+tVsenDRz40WNQC+2lVo/fA6d5vTCx/OmgzmyEbTOIbxrXT8
 4xtJ3cgkSyfKL7ZEhpFoImk7ri7k3lNN5qQjQVGBs4nfvzQmqt1s43e76xRpRfl/KvTs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eR-0003TJ-DD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B94C86025B;
 Mon, 14 Sep 2026 15:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A3C1F00893;
 Mon, 14 Sep 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399877;
 bh=IIaU1MK4mUN1n2LJQplC+wDgs0ECojrkK1qlSDjfHIM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=em6UoMxyMnzmhg0SAmr0kTTa0/oAR3ZodYmMK036WejTwDZSILrnGBNl+5r2ul3tr
 1fqiw/3BHG9Yudkxo0QMZwJBuujU9h+AxQ0WzmG6zRrntcHVmNrSJMw9EeQD+cdt3Y
 gKBGWzWADt74mnx13kjivD1I9R6uyRe1RhN8bmK8bDh5Tazg7/znLdjkfD4qO9BhKn
 R8PB+EksPrC5oiaECyZfG1xVQfr2ne+GP4seNAZ6qHrNvBsUMdv64qhOux3VsypGGb
 Q8uao4clw4RJUrV8nFMuUkmHFC2nyl3ayd+DwyCSrXkum3ashl8q46oT2/cmqDxsjY
 Db5sx6AbOgIHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0CA33924A79; Mon, 14 Sep 2026 15:30:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981237.647967.4356162890529018525.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:12 +0000
References: <20260906145614.2749-1-jsjlee1020@gmail.com>
In-Reply-To: <20260906145614.2749-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Headers-End: 1x68eR-0003TJ-DD
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip node_change lock for inline data
 writes
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

On Sun,  6 Sep 2026 14:56:11 +0000 you wrote:
> The node_change lock serializes block reservation in the PRE_AIO path
> against checkpoint preparation, since block reservation can create
> dirty node pages and update checkpoint accounting.
> 
> However, writes that remain within the inline data area return before
> the block reservation path. Thus, they do not call
> inc_valid_block_count(), change a node mapping from NULL_ADDR to
> NEW_ADDR, or create a dirty node page as a result of block reservation.
> They also do not update total_valid_block_count or
> alloc_valid_block_count.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: skip node_change lock for inline data writes
    https://git.kernel.org/jaegeuk/f2fs/c/66eec36c2421

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
