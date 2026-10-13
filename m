Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1987CC6B12
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afnsI2UdAOYH1a3VfSJfR5Pxv3jYpTn/dv+J5leivQg=; b=NMKjCm4NCu3hHiu4eW3hDdoDtY
	CRAH01XC9cnLqTohcQ7nMWIigA75VcSsDbupHpYM9gX9w+lf5vcStaOc8OmNAwBFZaNrbgX95FeoN
	9rFh0a4Zi6DcEjj+vm5KSCu4bjuhwMg087mkXb6Uw0+OVYC6Qsk8QpgPNMhWan8641S0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl10-0002Bg-Ca;
	Tue, 13 Oct 2026 22:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0o-0002B2-Fz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsH3ZBvKbRUSzhUyxaPt/C67sCyerjNV3qXB+t3cBCI=; b=b6Phi7yuoWAseMgjg8S6IvYKVc
 FowByRjyDo+QU7TZcoStZQuaRuyLL7cbiPk6t7w0ZFG0sCWXJfUQMB8ZhmEjyFIFJo9zZ0l9FETll
 oqN/EncnT5CRcrCvDRSdIlNxj0kKriiykYqPpeZI7tm4WcjkagSpZAt0GqSvRfs0sVeQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsH3ZBvKbRUSzhUyxaPt/C67sCyerjNV3qXB+t3cBCI=; b=jbriQKntaH3J5OUpMu9Rpvvu5f
 j3aWLrTApBIpHgMhGd5nMyjUwZ/2PPGsaT7FM/3c5X7Gv2hAodLaCbhAZ5665fbI8f1tHqfS77IZD
 T/l2uWXegNh2mS+3p17QobEXEqRN3f2yY9caT0kBl1BgNlZlTlJ5g6rjF3rRsB90tPM4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0n-0001d0-TU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DA2E43EA3;
 Tue, 13 Oct 2026 22:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820811F000FF;
 Tue, 13 Oct 2026 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930616;
 bh=EsH3ZBvKbRUSzhUyxaPt/C67sCyerjNV3qXB+t3cBCI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=FKO+5qAlgmiKTADGImIXvxYXa+vOBkIBR0tBPOFXajzDi/Rxpd4bOX9i7lreYnOf7
 2qDYzrvXIZRnrdmGM9RTPeOcbiFygBjCcS3GfoOJW0M8dHnDf0eoeqQT+mz6oV83h0
 D4GpAN5SxlJTta84pudye+m3I+2I3ypkD4pLVsSeo1T+rTo3QFMH2YepVET6N6yNpI
 /jog/v2gxscu3a5q9rcFX3Z725MnJoQuBFlrwHZGF20EAri7Q3GJqesXYA2Jf4YPhH
 qU6JE6zZ23ONS5rvrhbp4zCXRisAxYl1+p/FEQOzxqXgx4lmathsxgREDZ9zSc1wyd
 KDQD1I20vaVYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 774F539E4DBA; Tue, 13 Oct 2026 22:30:16 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061512.1493834.4792720096460143824.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:15 +0000
References: <20261005192114.1511660-1-daeho43@gmail.com>
In-Reply-To: <20261005192114.1511660-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1xGl0n-0001d0-TU
Subject: Re: [f2fs-dev] [PATCH] f2fs: cache: count the temporary pins apart
 from the regular references
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  5 Oct 2026 19:21:13 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> f2fs_unlock_cache() and f2fs_end_cache_writeback() take a temporary
> reference on the entry around clear_and_wake_up_bit(), so that the entry
> is not freed before wake_up_bit() returns. f2fs_destroy_cache() waits
> for the LOCKED and WRITEBACK bits and then expects the refcount to be 1,
> but the bit waits can return as soon as the bit is cleared, before the
> I/O completion drops the temporary reference. When the completion runs
> in process context and is preempted there (e.g. dm-flakey in
> generic/311), umount hits:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: cache: count the temporary pins apart from the regular references
    https://git.kernel.org/jaegeuk/f2fs/c/8596baf652f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
