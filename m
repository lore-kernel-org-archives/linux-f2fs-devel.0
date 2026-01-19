Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A39DD29C2A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K0HZTLR6RRez6ZEiUzZPIv5NZzIs41oW2qHKGsxSHug=; b=A4Qa8MNmkNQpvN3VHYlWT/8FMN
	WhO8HTt39zIaWMJf8VbL4cpg1tpxePiByQQd3NjUBuRyFTytPR1teNV4qmhhvSeeUdk5b4+AX+QUZ
	cFEIp+FwZIsOLOI38vPlJElnIenZSQHwpgiN4kWKudVEx+Rdi1ezxmWaI4CDAwb25sv4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vhpiA-0002qP-Ue;
	Mon, 19 Jan 2026 13:54:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vhpi9-0002qH-Ij
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jan 2026 13:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VfGrMgGYbr7uXqWGF8Ox7RdZRUtiXKDnidUFqalJybY=; b=DSNw7tkntgoPDcGLsUBcFcl1X9
 X0n+YVvUULYwKM40FUBNwMkrVSdFk3YnDJTeL6yhL0JKSHrq3/GvxcuY4fLQgpo64MS2SuBjsFmCu
 EZAE1JrLvU8HBB59LClfuP6/BpL8UEvEgol6oVoz9U/iwpoPfm7L/SqrYJsC8ZAmTYVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VfGrMgGYbr7uXqWGF8Ox7RdZRUtiXKDnidUFqalJybY=; b=LRYn3A22dYvnS7yLGmPbalTtoy
 DV1udQeKc4zX/QREjS5pStq1Emp8Xs/Rx5IRLRlPzQbkuztpTkAfZ8OU2pzbDd5or1A/pstcby/FW
 s/9+V54W57L24gylmy7ZLJufL5y1mL/ek/1DlQUERCV/np+u5Oqf/nHyh/WUtLTFVcLQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vhpi9-0005r8-4J for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jan 2026 13:54:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92BBF442C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Jan 2026 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775ADC2BC86;
 Mon, 19 Jan 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768830858;
 bh=5Tc59E23gaWKE3KuqEIR+fxMvqAcX4za+ryAn60oV2o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PGu0gzfz6V/fBhL+5R1aKWzCB3zDHKmN8WWui3PFhxZjoAAPzDrubCGYLmYYpD/An
 fuYCSiRG0G/1sE4SRRNREk3l3Fzq1mB5S3JyXL/fbPJNOm3HZoRjtJG7y6zyGP0OkM
 jLy8NdDYWEQHjuAyLfM9x4ThWB/nbN8ymWv92hYuebO0PC1HY8RlM8IZ9WwHuA9ffm
 pFGENccE9Ll5I45GRhKDN7x8qAfKGh5r7ldj/VwdV0qenR76RcmdSGzdid7UDcAcRg
 5Gzh5jdr8AwWfzkG/IJCO+ZqADfhQNDTOHJOtga4t1eN3bMl4ddiqqTKCMK45oIOXM
 QfBMoTdZInsSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 796423A54A38; Mon, 19 Jan 2026 13:50:49 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176883064802.1419958.14283043323754266280.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 13:50:48 +0000
References: <20251215122803.3495320-1-chao@kernel.org>
In-Reply-To: <20251215122803.3495320-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vhpi9-0005r8-4J
Subject: Re: [f2fs-dev] [PATCH] f2fs: make FAULT_DISCARD obsolete
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

On Mon, 15 Dec 2025 20:28:03 +0800 you wrote:
> __blkdev_issue_discard() in __submit_discard_cmd() will never fail, so
> let's make FAULT_DISCARD fault injection obsolete.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  2 +-
>  Documentation/filesystems/f2fs.rst      |  2 +-
>  fs/f2fs/f2fs.h                          |  2 +-
>  fs/f2fs/segment.c                       | 18 +++---------------
>  4 files changed, 6 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: make FAULT_DISCARD obsolete
    https://git.kernel.org/jaegeuk/f2fs/c/1dd3b437d49c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
