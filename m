Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D395BFF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2026 04:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TxcAHJMxX+KGBUM7xAnq6yS4U3jVh7NYEzH5YbK15K4=; b=S5/AgwLG0IaDvBRv/9upJM281e
	5xju7T4DP2z32zDu9MvJ3Ailo+0JNI8SXl7glOQjIhtr+7eNp8rhZdYojCv50B2200YFkIbQg09+V
	a20T5ImW26k3v+s/hD5zUXx5PdGFqCO+L+jLRvumCiCzYDqc7k1+c+31Z53ji59HEtOs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIfsy-0005pE-HD;
	Fri, 01 May 2026 04:53:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wIfsw-0005p6-No
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 04:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Dco6HrWhRPm0GAAGJB/1t6RbRglOtjNdkvG29Zf8AI=; b=F43TV5/vU93sWHroV5ZLiFbbsF
 cXjLWrfHlcSnGaRnfi5mFt/Or+GS3i/grcY+KcHXMh99jLPr3+dD+6QN23QRGcpU8pZ+ewiBncao0
 Y6myw/gwFqp2bFGOqaw26MRgRA5NncP9C6upFUyw2LvpB2oDaWJTo7raiooBn0Gn6i64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Dco6HrWhRPm0GAAGJB/1t6RbRglOtjNdkvG29Zf8AI=; b=Ye360cYO5PHT2UFTfwI7otlaFx
 1Z4qURSoNNVydJKcUSmEQY3FTutcWu+jLCyHr8TF94Txy3yfWU0+KCKlaz1TJ75aqlXkwrSTlM/Mb
 wRcVN+1/NflAPoPhb4kCuiQnbETjNzKGUVfkZfyPoKfwItqp8y07qbwwB+WzpNGRgaEg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIfsw-00007H-3a for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 04:53:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B097241571;
 Fri,  1 May 2026 04:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D93C2BCB7;
 Fri,  1 May 2026 04:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777611223;
 bh=eGV76IqiTK7EY23nsKI7N3W9yrqT/UIke3DNHs3Dpz0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=JiNBZ+IFmqnEeu1uwnAtz2FKP2+E73+B9eXOKwDJH43vX+tWblOrJtjWEA6FQ76eH
 ChfytsxLFLQLBcBllk2/5YPwaFHX700jUEj7IsIo+929DcOJeXCAbygUnqbWFQpXi+
 pUIbYSek1S/lJDE3c2GFPfZQS1HrIO7ghfS9E1Q/v46kfO0l7fZSMwRP+ZsoLC8Qlv
 GoggIozVJ4lhLwilCEjOHgD7omjDCvdBr5JjuuXX5MHaOdkfa519Km7n2i1UqCYeua
 xx1XJc1g9U8+WgQnfh0ZoCzpT51D504VwNlue1fj00D83UJRabD3/zLTbdv4R7roL+
 +eTWnPs/jCILg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AEBA5380AA67; Fri,  1 May 2026 04:52:58 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177761117755.3324081.1342269065246738471.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 04:52:57 +0000
References: <20260417035126.3886702-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260417035126.3886702-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wIfsw-00007H-3a
Subject: Re: [f2fs-dev] [RFC PATCH v2] f2fs: map data writes to FDP streams
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 17 Apr 2026 11:51:26 +0800 you wrote:
> From: Wenjie Qi <qwjhust@gmail.com>
> 
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> F2FS already classifies DATA writes using its existing hot, warm and cold
> temperature policy, but it only passes that intent down as a write hint.
> That hint alone is not sufficient for NVMe FDP placement, because the
> current NVMe command path consumes `bio->bi_write_stream` rather than
> `bio->bi_write_hint` when selecting a placement ID.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RFC,v2] f2fs: map data writes to FDP streams
    https://git.kernel.org/jaegeuk/f2fs/c/b718ffb899fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
