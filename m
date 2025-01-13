Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A45CC02184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jan 2025 18:50:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXPWa-0003pw-VE;
	Mon, 13 Jan 2025 18:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tXPWa-0003pm-Gs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 18:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCMltMe0+kq2xLzx1cmEhNuLtzGZsEh2sUfBnXjmN3w=; b=V5x/vfa06MUN9zJ7XMjB3QhlaF
 gt93pWpCoIlsOT/F0Ghp7sNezyW/VDteb9zv2fw8T5thggHcYKcKMNhEF51y+QhSJWA7Er0Snz/eP
 1seURX8UPW3U0TFKlO0CMHqsR+by7Lhc3lXTi4EVK3aTgU1XcEtH1NERjfjJKTkhkakA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCMltMe0+kq2xLzx1cmEhNuLtzGZsEh2sUfBnXjmN3w=; b=Ysbu0cZ6fQuyi8cjuJtLW0bU3z
 NAUgaxFo1tBAEbgcTpFytiWkHFItMpdjqi13BcMhAf9Z/U0oBVw3V2W/6iQXKFA/xm9h6+PR1p5eJ
 b7grduwKx8fCFE9OFK7NQfRW/JrUFXbxNPCjB7kfGBXcG3KMXcaxEba8XToj82LSXnvs=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tXPWZ-0006Hk-RW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 18:50:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E5989A41305;
 Mon, 13 Jan 2025 18:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F3CC4CED6;
 Mon, 13 Jan 2025 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736794244;
 bh=zeSJXRASAYSX7dPeuSebNj9o5X8E+dDnr497e6uqVy4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CTBMhpWX9DoxHcVXrU9mfZjxTJXaygATSDNDOc2CS0vPn1pTDcBvOXSGPFfQi7Sb4
 dLAkkABTtuzWVX+bKHZWNKkTUenM7X3nuaPaKcHItqcdZJ1GqSsXKYpynFgH+nQYTk
 XaIu5PwCMEku94oTL3cKMwcBgeegXk4xVy/pekI2puPxx8/zGmlh6xz0lcddvhGOb7
 r1XXxs8UuW2CY1BXRavyxdddtLZ8vpy+ijN4TUqeq2h6FzoLpG9WxLwdx0pJsf2Xip
 JkQaS79ZhSgKEFQn6+5UOF5isCzJvAlAADh7zEbRQ5vTJpJ9w43O+6lp9KXSOGjzVk
 CSsvlHndVVpdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 71195380AA5F; Mon, 13 Jan 2025 18:51:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173679426698.3595970.16381442881105205835.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 18:51:06 +0000
References: <20241223081044.1126291-1-yi.sun@unisoc.com>
In-Reply-To: <20241223081044.1126291-1-yi.sun@unisoc.com>
To: Yi Sun <yi.sun@unisoc.com>
X-Headers-End: 1tXPWZ-0006Hk-RW
Subject: Re: [f2fs-dev] [PATCH v4 0/4] Speed up f2fs truncate
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, sunyibuaa@gmail.com,
 jaegeuk@kernel.org, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 23 Dec 2024 16:10:40 +0800 you wrote:
> Deleting large files is time-consuming, and a large part
> of the time is spent in f2fs_invalidate_blocks()
> ->down_write(sit_info->sentry_lock) and up_write().
> 
> If some blocks are continuous, we can process these blocks
> at the same time. This can reduce the number of calls to
> the down_write() and the up_write(), thereby improving the
> overall speed of doing truncate.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/4] f2fs: introduce update_sit_entry_for_release/alloc()
    (no matching commit)
  - [f2fs-dev,v4,2/4] f2fs: update_sit_entry_for_release() supports consecutive blocks.
    (no matching commit)
  - [f2fs-dev,v4,3/4] f2fs: add parameter @len to f2fs_invalidate_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/e53c568f4603
  - [f2fs-dev,v4,4/4] f2fs: Optimize f2fs_truncate_data_blocks_range()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
