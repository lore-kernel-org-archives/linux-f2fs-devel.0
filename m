Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE94C54EAA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Jan 2023 23:00:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMd8a-0003dP-Os;
	Mon, 30 Jan 2023 23:00:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMd8T-0003d1-Vt
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HbKOSdLOKlFyF1xxZntGe1YLY1E5Es8jAGr7Q0HXhdE=; b=m1yPjJaenyt+2IjHzldAomZjzs
 KJmiylfTUxr2/6cTm+EVCMUEN9w2Bo1KzvzMcOZhllBPEaRtWBOcotf9tS2CCua9hp8HllobyjcAN
 PL8ZbOG8eST1Tg9+vl0aVCSPmU+gaBzyVdzLe78qGN35xlnNQyt+yjCO5rT3BXBqdPKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HbKOSdLOKlFyF1xxZntGe1YLY1E5Es8jAGr7Q0HXhdE=; b=XL4zjyFdajPNnPF64LhU9CNRUW
 c804ZLl8cnSu0kCzgNQQvr0jxnylDpViHJyMYmpFlfxi8yKCMgMPrfasOxHq/0h4IgHCLqzJtOhP7
 C52eVaEhjUGWlMkCKkwVBvgQuowzUeUw1XdBj6vicxKOmdTAw4PCuvuZQV8Pd2zfq1tg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMd8R-0002fO-5B for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8A161612FA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF809C4339B;
 Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675119617;
 bh=8wG5NIsuKshWhb2XiCI9lAfT/vlNO8ZyFCtUknM3ANs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XzZUsRun1zvbD5R8j+IpZ8toL9en35Dt9IKNfR2Y7YJlT7n3yX/Aq0b5jjeNrdwLx
 jdReH5IJkI53OueNqokmBuWJtk0BIBcbMoDRaT392BmbTMDJQ7S/YZboVAxYqrlaXF
 0Coh2OZ/VrvCTijcH7ESr54u5+eijNteWokgV23L0dKiKNyp2wCq0Wcd9Q5lHtlxnw
 vbA8FgO4MJQgNY+u8Sy03eSaqmmjfHjIRu4UjsIdAt9glqbcLJsxpnHdmPTzfi4lkE
 D1J8ili7HsxUydzF7d9uolw1Lzm4H+/IQlrULkxWQHDOZ9KuzAl7uHMmmw79WKgE3B
 7eIgr9Twh5KOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C5423E4D014; Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167511961780.12751.1698186738415312806.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jan 2023 23:00:17 +0000
References: <20230109034453.490176-1-chao@kernel.org>
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pMd8R-0002fO-5B
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: introduce
 trace_f2fs_replace_atomic_write_block
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Jan 2023 11:44:49 +0800 you wrote:
> Commit 3db1de0e582c ("f2fs: change the current atomic write way")
> removed old tracepoints, but it missed to add new one, this patch
> fixes to introduce trace_f2fs_replace_atomic_write_block to trace
> atomic_write commit flow.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] f2fs: introduce trace_f2fs_replace_atomic_write_block
    https://git.kernel.org/jaegeuk/f2fs/c/2f3a9ae990a7
  - [f2fs-dev,2/5] f2fs: clear atomic_write_task in f2fs_abort_atomic_write()
    https://git.kernel.org/jaegeuk/f2fs/c/0e8d040bfa4c
  - [f2fs-dev,3/5] f2fs: fix to abort atomic write only during do_exist()
    (no matching commit)
  - [f2fs-dev,4/5] f2fs: fix to avoid race condition of f2fs_abort_atomic_write()
    https://git.kernel.org/jaegeuk/f2fs/c/f4c49874a80b
  - [f2fs-dev,5/5] f2fs: fix to avoid race condition of atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/f571253668a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
