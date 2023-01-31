Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11FFC636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 19:10:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMw1d-0001zr-M0;
	Tue, 31 Jan 2023 19:10:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMw1Z-0001zG-E2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LmuSIjBYYFNtdGIVYUlp9YiYd/lTwT14xhxLAztx/Ts=; b=ErPh+/ZChEU8oQ3nXN/9ERwdIO
 p/Q0p/Jvw2mAC/cwA1U4P+e79pP1nJjQ0mDRN97s0RCX1B5BATQzF+BgxDG4alG1yPE2VV2NFe47A
 Ugf1rOIY8yK1X2Ewjn6uxG3+1QPPHgPty69CVYDeqZng0iFEzDb2iYOc5sxnnE9YN3I4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LmuSIjBYYFNtdGIVYUlp9YiYd/lTwT14xhxLAztx/Ts=; b=Ur6Q5hPi3+OqWsDWtL+RKMTsHP
 3CjrNGDY/fuFE/G06fFCZkdtZPLwyIXR+cgrnVJMcLJdJVKNFM6d9H6hqMMHQXGPcCCmrYKR9pfmK
 fROwFtwJtVtlPEprIUxqMlArtGO/5hVRmRD9ZdIPMA1d8PAYzqclMpB4d9WdWu9aqUlY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMw1S-0006XK-0T for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 60FA7616C9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 476A7C4339B;
 Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675192220;
 bh=T5Q9H5prmUYFArKJ1FQOqQBqKy6FlsRc85z+zs30y7k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=TH5mg2qUL915nqiJUlWFbRHI4zuQwAlCsXCT0Dgtuj50R3BTR74KgmiA+uArJ7L+7
 dG9i35UnGLjPW7MNCcz7woJaFio+D1AZQhqG+50rMVKQJidt32tr4vlBC0paaShQaV
 /xQu0OxZGvhshIaGxipJ2aA3GigBVufxNwN/iW2YTGkBHJOX3P/kJE8DYygmAQqZFw
 PgF+RZzmUCug0sEXRcNU6r8a1VFIC1TpaDoCuJqIm1m21SUCotqGWMGGpi311PjNNT
 3I0leHI9ZqFRJoerHKg6DWAdzH2FrrLLhdaNmWWhUiP9TQ4CYQCXRlF718CBCCcX9A
 iyE7vDs9TfQug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0C5BDE4D014; Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167519222004.20142.6380905471543710449.git-patchwork-notify@kernel.org>
Date: Tue, 31 Jan 2023 19:10:20 +0000
References: <20230109034453.490176-1-chao@kernel.org>
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pMw1S-0006XK-0T
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
    (no matching commit)
  - [f2fs-dev,2/5] f2fs: clear atomic_write_task in f2fs_abort_atomic_write()
    (no matching commit)
  - [f2fs-dev,3/5] f2fs: fix to abort atomic write only during do_exist()
    https://git.kernel.org/jaegeuk/f2fs/c/ae267fc1cfe9
  - [f2fs-dev,4/5] f2fs: fix to avoid race condition of f2fs_abort_atomic_write()
    (no matching commit)
  - [f2fs-dev,5/5] f2fs: fix to avoid race condition of atomic write
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
