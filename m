Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701EC02183
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jan 2025 18:50:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXPWa-0006rK-SL;
	Mon, 13 Jan 2025 18:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tXPWZ-0006rC-G2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 18:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pa21Rj5MSLexetlBW5T9CVKJH2FtUpKPqzdY533W7Ak=; b=GoNp3nv0BYmVSGXgvsye/3L8Lm
 KFexz1gbyR08vykpTiyo+1Xy+ufspe7nW04NobMzoR80khOfdkR4wvtpEfm1/0SSZdh+mWHTufkKV
 D9FlzDyPFZK+xd7VPjL04jJpOLSozYt7jZbkv2mNtLDla8l12Rfaz49wpGsUqCPbeiwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pa21Rj5MSLexetlBW5T9CVKJH2FtUpKPqzdY533W7Ak=; b=eIMgj5NKWipkE1F9EUSigdby34
 AASGjwnZK/TG6f5D708CKqwAT+XmE6M7sDvXv6VO2hRBNdTcaUXlQ9B2pxKGbfmC2VHTeWey67ZAj
 iy5Cofo0hVy//RuDZj6xDAI+vUX3U0ty5Ivg5XCijogmdkfKKRcead+2Lbommcdtcm6w=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tXPWY-0006Hb-9o for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 18:50:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6378CA40141;
 Mon, 13 Jan 2025 18:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333F9C4CED6;
 Mon, 13 Jan 2025 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736794243;
 bh=cGIRtQSJ/ocbYYo4O1rpWZxByMOErMcZHIyxENMUmcw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bTD0ii+YaJWIwvezmN1PwWVK1xyml64cusW9EII8eeTeZy/8Fuzd1eg/XGOfVSMwS
 FGFBqgoCR0v62UjtT2IRxonBTaoKyt1DbZE4GU1WMYf0zbjAT/cQ1rOmRYb6uRExHM
 EpgqaK+kfzkjN9thsHscuhyF3lcwJfShx5iHw7fdMrm1JL3hy+Evm1oj+xqeS0wqrp
 cOcui1tGe+kEDXmsLlKHCCJ8JrBXKEhwasiXsYsoYsOMHXfq1uY2Chfhlu9o5gxBLq
 wvGd+B5cf0MCn+fkpgOySleZuHB4nyo3O3deofNJKvk5y8DcgCek1+N1s2yB4Tolrt
 YQNSCzw1MkSWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EBB3D380AA5F; Mon, 13 Jan 2025 18:51:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173679426576.3595970.5273717653997625175.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 18:51:05 +0000
References: <20250113030518.3639169-1-zangyangyang1@xiaomi.com>
In-Reply-To: <20250113030518.3639169-1-zangyangyang1@xiaomi.com>
To: YangYang Zang <zangyangyang66@gmail.com>
X-Headers-End: 1tXPWY-0006Hb-9o
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: fix using wrong 'submitted' value
 in f2fs_write_cache_pages
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
Cc: zangyangyang1@xiaomi.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 13 Jan 2025 11:05:18 +0800 you wrote:
> From: zangyangyang1 <zangyangyang1@xiaomi.com>
> 
> When f2fs_write_single_data_page fails, f2fs_write_cache_pages
> will use the last 'submitted' value incorrectly, which will cause
> 'nwritten' and 'wbc->nr_to_write' calculation errors
> 
> Signed-off-by: zangyangyang1 <zangyangyang1@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: fix using wrong 'submitted' value in f2fs_write_cache_pages
    https://git.kernel.org/jaegeuk/f2fs/c/c84c2424932d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
