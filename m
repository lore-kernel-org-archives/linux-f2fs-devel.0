Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3211CC5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EokJmsNyS3cB5eE0sPnyB60Z2MUsqB/879LBKJSWEnw=; b=c4TEWIDtkpHQhDCTtVIUPb7TV5
	6IsXN49eILawrSqzGKLkCfwJhsC9u9h9mi/atPyXrB84wx0gtxRuiweJBgXU/8EcmBb5LvUkXIj0K
	cBXa1AuUwGTh5Px+6Wgtec/ZIgp5FSxqxI28x0/3mgJhuRblY9VxCmz2Gz1o5xedGdQc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWX-0002gx-As;
	Fri, 21 Aug 2026 15:51:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWV-0002gp-AL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WlKtWu0F97uNMhqLylJ/bM7jfrR34jJl3x5Ep60a70o=; b=VkSE/sUuSSqgRspY40b0BgXMS0
 e20xPuy04WxQAy7d4vLBNHgidF+ir8otckxdIDK9XHefuz8j/bKJeu2tAYcs21X/SVA8+oTvf0yUK
 Njg0ANBlaFHEVH97w+dlMHEqz/mLrtVvSuLX4m4AMrxY2b//wG39YKdrh/+xI2KJ8ixU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WlKtWu0F97uNMhqLylJ/bM7jfrR34jJl3x5Ep60a70o=; b=Dyb09qqlo2H7mb//6Za0LNINHY
 zr4s4LM0MWZxBuGhnUXveDxOgUGPDNkAzh5yxruaAyxQNRux+T4W+JSsQUUY4j9iKOk3p/ztStvdI
 ok5d3wZOuR8OFqs5wJhvwpTQ62BgtNveiaHIU3ujg0p+JJDyEQQo9/ftuEpB/5RR7/3M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWR-0005FW-2W for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8352F61879
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA7A1F00A3A;
 Fri, 21 Aug 2026 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327465;
 bh=WlKtWu0F97uNMhqLylJ/bM7jfrR34jJl3x5Ep60a70o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=onyDm3FoQIRSrcOZGgIg+4HJUwAZRI8JCFzGkyQPOFscJCGr9vuW3YRYhKeJAAZPQ
 ivfaBy9Ebw0fZdlyeMmjHA4c6ftt9gYMTQ1C/AfMyordMPEAG0bckEEmljlwloP62o
 l0yfA3pTnew1bT/aQiVpNKYcC4J67Oqmg1gHDTxWbR/uU/92Fj3AEYOT+8RZ64hJ71
 AU8OGs28tCXu8iCfUgvP5N1nFWPGRKC7jvYHwMyMOR0tcqaptErBsShUomR8laDgnp
 bNy1pD6KiDI50UT+WzbGSM0UccQitL5B9d2VyPdUyQT4dyMnOWCt0XQnNbf3qWJcED
 Ss0w1desSddMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19789380A979; Fri, 21 Aug 2026 15:50:16 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732741463.1339488.679147412162451324.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:14 +0000
References: <20260819013107.3542105-1-chao@kernel.org>
In-Reply-To: <20260819013107.3542105-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wxRWR-0005FW-2W
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: reduce memory footprint of ino
 management
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

On Wed, 19 Aug 2026 09:31:07 +0800 you wrote:
> Currently, ino entries for APPEND_INO, UPDATE_INO, TRANS_DIR_INO, and
> XATTR_DIR_INO allocate a 'struct ino_entry' slab object and attach it to
> both a list and a radix tree solely for existence checks via
> f2fs_exist_written_data().
> 
> Since these ino types only track binary existence status, we can embed
> the information directly into radix tree value entries as a bitmap:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,2/2] f2fs: reduce memory footprint of ino management
    https://git.kernel.org/jaegeuk/f2fs/c/9a9ee7408a1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
