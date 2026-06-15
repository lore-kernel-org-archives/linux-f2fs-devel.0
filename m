Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009DCCD98E1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eO4C2aNqNl7qWEnp3VjfM1ZKNiivSOn5WNRs7X2FU7c=; b=ggjODxDjIkQN2LtiRDrgYVGzjD
	EphrynNmE4LFkAgo+Sry0MeEhjXP5/RvMJhWgXgm8ol0s/yFDJaB9Hq1Gs5zxGKELAaIhVXR/dxU5
	Bq28/4qScFWxX9bQIZuYfJBDSXLBILhz34aK0cb/ujgnRCea0PaO54g+5n7hDtcoLnp4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9Gf-0008JO-S7;
	Mon, 15 Jun 2026 15:30:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZ9GY-0008J7-NF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AnpkiEHVbIFwPl7cV5ytrwKnzQNDlDPJjewwP6FIOJY=; b=NDTsuJy8T7YAnns1r31SQ3mQwX
 EdAzQrNR2XO2sQz8ZjGHo2wxCZND2oTkDudM3isopVBN0iFCXq36IhG/nH+RPNc1fmpkRpbHv9iTL
 yDt/SKjszQM2aYXsj0ahWXrZlQ0akynYMCqsUtRS8/CMz/3LMfuIYC50k7ZkiIJUVx/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AnpkiEHVbIFwPl7cV5ytrwKnzQNDlDPJjewwP6FIOJY=; b=hZW0EUiNadNY+2cHYl74BLVYgP
 m+rVZvuEyoejoQOKqZ2oLTZkA/UY/JHca6CoDLybeOnlXABC2yh1hoMNidleBzdJu6E6Kr2lNP5Od
 qGTFZ0UVV5fmdpQlrBPFdBAIIflstBcQmhQi2r0mnWgnD/Prgpq8nl4fc3brRQ1AX2z0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9GX-0002ul-BD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A4754057A;
 Mon, 15 Jun 2026 15:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1251F000E9;
 Mon, 15 Jun 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537416;
 bh=AnpkiEHVbIFwPl7cV5ytrwKnzQNDlDPJjewwP6FIOJY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Zdv7GaxG9sry1PWmQxt2TCtT9QKgQ5Jw3UqLfUlAM+QG8rsbUXbJla0X88s/CAm7g
 cYrE9wpJ6nNuCOHIA8YKNXiU682GMVMqDaKUZ+c1VvTuyZhPxqUyNEz3cf9WR2xfIN
 dSU0z4pqcmabEBJN4cOKeTmTKI5P4/aCYqphgcy+DFN9yd7tsRHnk5eGlow42VH9Qc
 kBLWonPhjuQCw96a5cpfWQcRygV4TVjxmq9+fA1u1mR+x365uxXQlbDkGyzIr5rYZS
 arJUYUeeVju/e5e5XXADWGeDetGZ2+4pmYcbGlsAti/Yl1d3+uKbFuBjFcFI4QmVNA
 b18kFYgJUbYpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A423811A64; Mon, 15 Jun 2026 15:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178153741138.3946007.11156658533151898127.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:30:11 +0000
References: <20260525061456.231710-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260525061456.231710-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wZ9GX-0002ul-BD
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop checkpoint on compressed write IO
 error
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
Cc: yuchao0@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 25 May 2026 14:14:56 +0800 you wrote:
> Compressed data writes are accounted as F2FS_WB_CP_DATA because they
> write compressed pages through fio->compressed_page.  Their end_io path
> should therefore have the same checkpoint-stop behavior as ordinary
> F2FS_WB_CP_DATA writes.
> 
> However, f2fs_compress_write_end_io() only records -EIO in the inode
> mapping when the bio fails.  The filesystem can keep checkpointing after
> that failure, so a later checkpoint may persist metadata that points to
> compressed data blocks whose writeback failed.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: stop checkpoint on compressed write IO error
    https://git.kernel.org/jaegeuk/f2fs/c/d99bb310a134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
