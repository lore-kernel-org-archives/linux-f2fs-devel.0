Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1491ECC6B15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QORj4Jrqx+tK/308scKcXYJUQgjwSKF1uzkICcdjwF0=; b=Clg9Y6yEjQggct48hOiiC75cvn
	BG7a8iy3+1WZTuVX4h4yBbfNkamGH6/GL3Sc9W42KGMtd6mKhn4JqE4lRBUk/9E7c3GwAnM6xmiSN
	V3WO7EinTqfzHEUpYfWzmTR23gz/YQzJJGfAhUE/PFyF9dtnskYzd6AMvbZlhcgr1jmk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl13-0000am-E4;
	Tue, 13 Oct 2026 22:30:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0l-0000aK-8y
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BSHmkURCUcWvxpyD/jCZQsnATspfn7E1v3Injzg7glE=; b=BxvT1kgqTXOQbaq/FtIgzTEOP4
 IC79gpM/eZVNLcORexWvenO8YSivHy0Ww25UO4uSgnNF9IVkqIDQCKASmLXzk1GqHt8N62yoL+N7p
 cb7hYiii6SgSYzEGNeWLK1EYOq9IRfpRM+saijhAM4yUTtoRCrJ5PLx3n+ma1jDIoLc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BSHmkURCUcWvxpyD/jCZQsnATspfn7E1v3Injzg7glE=; b=lmReMZg13mD5Xsb8rUNXBtuPyy
 /Y2G+ArV4mWfJ8dt4LF9GwRNifJwKHDQvMuIYoptP9k1IP37J4FG0Fg4uFp+Cm1P4PUOpP5pUd7hH
 05N6vEaeimCBpGoTHLaHwRgYuV75/sx6mlGz0j5d8W8OHvdmrz+UkBPxI+LQgcDTD7zc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0l-0001cv-5g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE90643DF0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FE01F000FF;
 Tue, 13 Oct 2026 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930613;
 bh=BSHmkURCUcWvxpyD/jCZQsnATspfn7E1v3Injzg7glE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=O29F58FuUvsAc/gsyRGVHW1IDQAKv4ZDQHls4L64AlP5GEvzOUfpCVnEdzF/fK1mB
 esy5EEaOk1ERUm4CQzCxyZl/0bPCbmu/AlmXagrM9asfw7zurhdNn0gx3l0X1S5fVx
 uYxl1NJbZhDxxf6+e+Rma/MljEpfBtCoI5xuINTA0hCnaHzWo4A9nZ1pWkyjDKhbXd
 SM6diOgGVXTm6zEgSNYzVVQfO/xTlJhziONAVThOGxFSYqI/9eUOO7GlHDFlghWk6J
 GQQ3fest+9Y8pSV+sM/gcmPzAA8T74ikv0Y9S6Awf1/WVa+60gsWPLI6zp6LdnVLED
 AkRhkdysCV/ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B43DA39E4DBA; Tue, 13 Oct 2026 22:30:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061226.1493834.2807763265154203620.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:12 +0000
References: <20261010065546.1762091-1-chao@kernel.org>
In-Reply-To: <20261010065546.1762091-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl0l-0001cv-5g
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to use bio_in_atomic() in
 f2fs_write_end_io()
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
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 14:55:45 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> f2fs_write_end_io() uses in_atomic() to decide whether a write bio which
> exceeds max_atc_write_bio_size or max_atc_write_bio_entry_cnt should be
> completed in sbi->wq rather than in the current context.
> 
> However, in_atomic() is not meant to be used outside core kernel code
> (checkpatch.pl warns about it), as it only looks at preempt_count(): it
> misses irqs-disabled and RCU read-side critical sections, and on kernels
> without CONFIG_PREEMPT_COUNT it cannot see spinlock-held sections at all.
> In those contexts, a large write bio will still be completed inline,
> which defeats the purpose of the above knobs.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/e4582e5f3b43
  - [f2fs-dev,2/2] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/a605d5d71a6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
