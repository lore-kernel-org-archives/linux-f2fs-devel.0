Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B424CC63797
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 19:10:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMw1b-0004D6-19;
	Tue, 31 Jan 2023 19:10:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMw1W-0004Ct-UT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVNCeJTgs66hojhK9fwVJWK47aJhRDow74JuLGyYXmg=; b=BqitW5rwxf+SMCWuvEgP58RbSU
 Wc/ZG6M6a2O4viKoxZhV43+Ajei8ERZWRRmJgno6UK1KCDj4gjpyZ15DOjJ0YZC9Qz/svHfWdWpVp
 ePad5XERmSfkIA566LMsqHwUP2DlAWqfs8NuUirOxXLjxdEo7RE6dRhZlXf6M1C+FBG4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVNCeJTgs66hojhK9fwVJWK47aJhRDow74JuLGyYXmg=; b=l2/KVWlhDN4Y7snunA6+vP4vFV
 s9aOgAX44govGzkE2xdH02IncfgUvUm24anSs0UPomHrYWbN9VeKvgs9MFR3OnA7BjyukMbwihgi4
 dVmDIh6vWj6L+96oZIDmwX12e+ITfwUVIZUi6AZzE0fAKvOuA9R+WZ/iMGO9zjO0Q0mQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMw1S-0006XM-Ju for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 00DB9616C5;
 Tue, 31 Jan 2023 19:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62616C433A8;
 Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675192220;
 bh=9C5PDr6OI020i8CExGuBr9TUCXMNsJnEct3Kfz+VhCI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XhKx4Y8n/ghpCiZc5qHN1WazEY/Rbpmf7bDCBffHhjPhfr37O2XlxHP8ZipHR+aG1
 J+t1jQBesuTvIWWDbLv2zdBzanFEcWqP25xxr7J42+7wy8RFCwpqD+AXnKJtGVnOdF
 7HnRsfv2IrpH6eiTBD4lT34cd3FIVsy+hEiZNdxSnaL+UJg2lgOgPSOnyHKBDl0e3Q
 mn8a3Uw0p2xSApijr/DcQeCzE4liaET79+ij8TtT64qfn9kEMKL85mKzgK4Ua/osPz
 xJbEZkzpBuXA8VdpSK7BxWCJkq5Hge/SkcqRQ24yeo3pRulJTnJwpKA+Z7pq76UzLn
 Kq1sPCI8x3Hvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 33EE2E50D6E; Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167519222020.20142.16236320006789243348.git-patchwork-notify@kernel.org>
Date: Tue, 31 Jan 2023 19:10:20 +0000
References: <20230120161656.70308-1-frank.li@vivo.com>
In-Reply-To: <20230120161656.70308-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pMw1S-0006XM-Ju
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix to avoid potential memory
 corruption in __update_iostat_latency()
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, error27@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 21 Jan 2023 00:16:55 +0800 you wrote:
> Add iotype sanity check to avoid potential memory corruption.
> This is to fix the compile error below:
> 
> fs/f2fs/iostat.c:231 __update_iostat_latency() error: buffer overflow
> 'io_lat->peak_lat[type]' 3 <= 3
> 
> vim +228 fs/f2fs/iostat.c
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()
    https://git.kernel.org/jaegeuk/f2fs/c/dcbf2ae5504f
  - [f2fs-dev,v3,2/2] f2fs: use iostat_lat_type directly as a parameter in the iostat_update_and_unbind_ctx()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
