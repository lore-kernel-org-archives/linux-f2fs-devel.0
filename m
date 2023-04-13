Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9109DC77B6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 23:40:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pn6YG-0002Oi-IC;
	Thu, 13 Apr 2023 23:40:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pn6YE-0002Ob-Ic
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VRMUM/fEb+b8iVjl+mzBrW9pNkoRPu5BTPwcDuA3lY=; b=fAD7gBsZ9Q13bwQVRJuD5iT2Qy
 /FShuWwBBjuXq0Fpp7bqG1d4HnSiPcYySYYZV/+zmQMNG/1Wbp+LqYEqdnqSqggcdVjDffnypyUcB
 qpNrejwK0YXqjPa3AOQ9GSC7iQHA/tbkJlDxFOAo2TO3pFNJmZrMUs5H1emf++Oq0VQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2VRMUM/fEb+b8iVjl+mzBrW9pNkoRPu5BTPwcDuA3lY=; b=V9SBenrFVDWlD2zWcPIn9+Blaj
 Xv2pK+B03sltTwop+yVTqDz+q5vppUaHwGo9W488qZmcrkV1cPv7iljxlp7rR/nLtRG4U5jo5jvUb
 rVbAO9eLLicgdFWbtFObJvO4+ae8E3bkN7MSSkSChMUANvM5Ejrz/JaATBmicdsxZ+I0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pn6YD-0005Mx-3j for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1E064290;
 Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E75B2C4339C;
 Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681429218;
 bh=FCdRLP1bIR+b34FlLmWhChicvm3dOWNEYQM95/2rJzI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UgoR/eWJp0y4mA7FQrMKBtN466m9+67oim9i99p58jj1ykz6+P2p0KBASkr8QKhjp
 RWhHbBl4pHY0/B4QgYdIXrzioRPffnVBLBEQKBNBilqEOSr2lV1p/cSsiKaR5Ts9RH
 1xVlBHHrWZzJQ+sCNznIJ46vHW9narnU0oLw2Rd69qqbwr9lINqKpjzxIs6jiZMeGV
 Fd2QkAb4Ob1TCzyTKeUCtMTl6hdiETxgCXQdbPbkTe7BL26HvGMO++madyBXsAzROm
 4NBWanZrOmK5EkionVi86Gfofn8n3hPPVlJcbkqL761slnrQFlJQYjjH1wn5w0LSJd
 E+m+Y/yrU/ouw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BEF9BE4F0B3; Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168142921877.31957.15174753111449147359.git-patchwork-notify@kernel.org>
Date: Thu, 13 Apr 2023 23:40:18 +0000
References: <20230404143832.18234-1-frank.li@vivo.com>
In-Reply-To: <20230404143832.18234-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pn6YD-0005Mx-3j
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove batched_trim_sections node
 description
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

On Tue,  4 Apr 2023 22:38:31 +0800 you wrote:
> It's deprecated since commit 377224c47118 ("f2fs: don't split checkpoint
> in fstrim").
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove batched_trim_sections node description
    https://git.kernel.org/jaegeuk/f2fs/c/abae448626a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
