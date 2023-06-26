Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52D1EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jun 2023 13:30:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qDmIb-0001FQ-0V;
	Mon, 26 Jun 2023 13:30:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qDmIV-0001FI-P5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 13:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjJBb25vED8CWKVGpi1K0ECckOcx/EXSJAbdiZGlFCw=; b=Rjd1q40ovflhmwrwdu3Y33j+pX
 rWVj0Q8nXzFZpIdYMVR7/sTtUUSXS9whb+cFg+yJB4DBiPslOn3JMf245bikHP3o/WQay2SqH49VH
 TsORF3ROYzWzJj16/1FE4wis2b76i1oAdAeOipEW7LWy0+Je+OcmbgPSOe8SAPNmv/+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hjJBb25vED8CWKVGpi1K0ECckOcx/EXSJAbdiZGlFCw=; b=E4SQsar9iYVS2T/hS+Pi8MXxdp
 daFt952LBF/EyrdIGNivYL9d0f3iX7XJxWL3owDYyFR6BBiLXvQ+pG0jiIoyrkr1yZU9Hr4j60fJd
 st6LGmdk/cBgE1l7F8F/SNzIa3o7FK91N3nmy0VUWcYDJRIBRGHLcydk/qjdYwKJ/D+g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qDmIV-0005fJ-C6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 13:30:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F39CA60CA5;
 Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57512C433C9;
 Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687786221;
 bh=uT9iYZr53tRCgJSEQLzD+bSX1zc/7rb1qVF4nDAIp8I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gu/6k51t3gTRxSghh4OE/qwupRvCcxZrU4lqCTucfl+r9ksecSacAA4Lb5I8UhCo8
 0UN+qqyt8ysWEfES8UjAcSpfq+fMaSS9gjNmExOq59W7W/lY1M4bJDoKEoQsACmwS/
 44AN1HU96oxlDUP/HgkCwa7HhxHfy8YtYiG8Rptr4ZhpFV4n+WgJvKXd7fKRzP5yg6
 MXxuOgUtNfY1Fi1Rc3NBNsTvMZY72Kodc9+G+9a/d39q9sL6HW0YxsaV6xQ2Xs4Wx5
 yhWNf/Gg1BKrREIVwqVcaRWjs+Sxo+xExtWXTdOgr7ZrCX1qQKraanWg8xiCo+6p8E
 VFZpRdn9tHjvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 380FDC4167B; Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168778622122.24530.10217255719781321675.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 13:30:21 +0000
References: <20230506151604.36890-1-frank.li@vivo.com>
In-Reply-To: <20230506151604.36890-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1qDmIV-0005fJ-C6
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: refactor struct f2fs_attr macro
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
Cc: jaegeuk@kernel.org, lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  6 May 2023 23:16:03 +0800 you wrote:
> This patch provides a large number of variants of F2FS_RW_ATTR
> and F2FS_RO_ATTR macros, reducing the number of parameters required
> to initialize the f2fs_attr structure.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304152234.wjaY3IYm-lkp@intel.com/
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: refactor struct f2fs_attr macro
    https://git.kernel.org/jaegeuk/f2fs/c/6201c478dedc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
