Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909FC61DA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Feb 2023 03:40:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pOsMm-0006QO-Fd;
	Mon, 06 Feb 2023 03:40:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pOsMk-0006QI-UO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Feb 2023 03:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eZ+g0VOORujm0wVGD5a+nqEUpFles0MOwOIu0enNHOo=; b=e4Fxook3Ri0D5BhXMclo4mB8Ck
 OxxKOgRb9buWuwtfhmVChfRT8dX5GLUH8s+/LkDA4+N40evgle/Y2BTHF/aH2TW2CFKjfp3KJES9l
 GKRk2SGf79fVZtRowDp2Wq+mBnAEdJHldTBMEKtgDZ+CNypSB5cjMeOmE+Lhm5/s8RYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eZ+g0VOORujm0wVGD5a+nqEUpFles0MOwOIu0enNHOo=; b=YoOB8IN8jXWyzfbiyYW1t1CAKT
 91oyNrTD0h3aLUITrn5Y+KH7GcFsN+fBBU/IV2Nkde0voBS0SawJ5ZwAu4BxgzFRbUPezxCRuw7oA
 i7LBw7j54U2fyyffmWowEKQ5491DVerURYgyewQUbehweD3yCU2DoW3upQyYRn3rWcLE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pOsMi-0005dj-Tl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Feb 2023 03:40:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 38F4060ABF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 Feb 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCEAC4339E;
 Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675654819;
 bh=3lsHKYlG0rjr2JlV/zJCvNh38EhpdamnhOGOfmFdU3A=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=m8QfoChuBi6UKVquPysZISxu0Gm3T4biqEyZRiJOxk6cxvov4s8ItOhOwMKKUoaE6
 Ig4FYiVU2JrrvTtQcMgXaCpGlWCxN0ZhQ4DLoOLnbsSa5PTK+7FC1DnJ/xVsk2Zquy
 1aXXFNk8qZG424XbV7PzHg+jARQiZH7hv33rZ1OcSWkJk6fYfcZVQcRMqLNrDGYwuG
 5jbsPXeiqsxOSkaDH+QdhYQ9zIdz12Rl3z/QysmNZG3iODJwACI6hTHRvz4b3yd+j8
 k1h3h7BRcI+PVz2e6w27RqJjcK6mZ20xbO7pEWICiEW1e7skS8tHm+OmihdDuU2Wk9
 M4lftsW2/5uxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 6B0CBE55EFF; Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167565481942.5323.508420128518769085.git-patchwork-notify@kernel.org>
Date: Mon, 06 Feb 2023 03:40:19 +0000
References: <20230202070456.3497513-1-chao@kernel.org>
In-Reply-To: <20230202070456.3497513-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pOsMi-0005dj-Tl
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: reduce stack memory cost by using
 bitfield in struct f2fs_io_info
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
Cc: nathan@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Feb 2023 15:04:56 +0800 you wrote:
> This patch tries to use bitfield in struct f2fs_io_info to improve
> memory usage.
> 
> struct f2fs_io_info {
> ...
> 	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */
> 	unsigned int version:8;		/* version of the node */
> 	unsigned int submitted:1;	/* indicate IO submission */
> 	unsigned int in_list:1;		/* indicate fio is in io_list */
> 	unsigned int is_por:1;		/* indicate IO is from recovery or not */
> 	unsigned int retry:1;		/* need to reallocate block address */
> 	unsigned int encrypted:1;	/* indicate file is encrypted */
> 	unsigned int post_read:1;	/* require post read */
> ...
> };
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
    https://git.kernel.org/jaegeuk/f2fs/c/2eae077e6e46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
