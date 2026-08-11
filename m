Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E1C5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcOsM900YDTR9uiaB0E7zn04Wh3RrW7eqxFsN00Y/hk=; b=nV8W9y8tC2NiOhUfqoSUefsyMM
	lmAOaT6GvqfkSi9i/1Uf8cbmmqAp7Gb2+owQcRXwPQNQsBheHC2fWGMK0UMm06ZBXNvxNcL/hcqu1
	+rUw3++Tws/Zt8MjMEOnlrmWk8jVTCvfMgc0i/8S44dP/C6Cj0O1mT1yCvYfFplX8qPs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8g-0002ty-8V;
	Tue, 11 Aug 2026 04:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8e-0002tp-Qh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SPFu2tOpk8VNy7obR/fUKgpbzhD9fY3W7xp+FXZKt9s=; b=Js3qEl/3cTb1UMzAL7vl308imd
 cRgjEkFhTDsS8+/zRKpHHcceh1q3tTexAQk7A0cLVj7q3z8mhYN7qaGP376xR5qvHFZcHtHzFpLPJ
 AJX8TVpR6iN1jrg0OdwONrgEJOgnMTcXyHFB+6E+LWHTrsMt/ZMYy6QEkHQqt6fWxF4M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SPFu2tOpk8VNy7obR/fUKgpbzhD9fY3W7xp+FXZKt9s=; b=EZCC/2vwQWvskONxo432+e/OGZ
 OyNHafSF4ahe6nlP5x3WuDtGAVk7VZMsrmeIGEr8PAttDkZfkmpAcJNLhEL6JBIDXr24m8pWYyZdq
 tz1MfZe7d4lyshpLSHTBRdpsuqQmnRCgrQl1wJdrzBPyseCRWEw98BXrO5YVtCVkiLd4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8e-0001dB-38 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97A0740163
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE191F00A3A;
 Tue, 11 Aug 2026 04:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422650;
 bh=SPFu2tOpk8VNy7obR/fUKgpbzhD9fY3W7xp+FXZKt9s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=bfapdcBKrHG+IWLl0eed3vfzVbQJtYe0kAIPGjlSXuQavzolVlhiqduajpRFLdUIn
 OIB18ucbWjA1S/7J7CVGhooLXwivFLs0Ve+V0l1n4N3E2mBlRy99whRw5sWSRVRZ+r
 7oTCfEnpReXMGEreChI1u0s3vcHZ0RoCkE7/T2v8q0wyQQVMlL78sfwkmjCZSyOvLQ
 9CNjsciAfDqw6lS1lPj3hK9PrcfGVmVNNkP635VZijVXwTiEXE5CWejeBEli7japx2
 MTFXwFZ+XJrtK+HGhgUQPYvPRrE0XYO/H35kTjCNf3HsR+pC8xnUszDjlVSGy8ABto
 PZOebUSWqiFXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198403926278; Tue, 11 Aug 2026 04:30:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642260663.332426.16745639324119870571.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 04:30:06 +0000
References: <20260806123537.1516699-1-chao@kernel.org>
In-Reply-To: <20260806123537.1516699-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wte8e-0001dB-38
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to pass folio->index to
 f2fs_sanity_check_node_footer()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Aug 2026 20:35:37 +0800 you wrote:
> Otherwise in f2fs_sanity_check_node_footer(), it will check the
> same nid incorrectly.
> 
> Cc: stable@kernel.org
> Fixes: 0a736109c9d2 ("f2fs: fix to do sanity check on node footer in __write_node_folio()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to pass folio->index to f2fs_sanity_check_node_footer()
    https://git.kernel.org/jaegeuk/f2fs/c/7e188e9f9437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
