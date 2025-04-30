Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D628C3ABA5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Apr 2025 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpLpkG+aVLEa3TLwYvk+LLIH0Sx9pt1JO1vygIXQxP4=; b=Qn+8NgZ+gDylDJwm6QsTg+6APP
	HCqtSJnqGc/BqHbTlwIhUl84V6Ymmskql1IvHCfHCMaa2uHO9+u7HW83EJHoKDyjnX5DFnm/xMATC
	zTsHOrrsgn5cYzZbKPSzzgbex6AKoXt6p2m9noAmu2ZLmDO/ZTsj8appk0aL2G4cm/mM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u9wkD-00045V-JK;
	Wed, 30 Apr 2025 02:00:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u9wkC-00045O-7t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Apr 2025 02:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqG/Q6lvdGfxk7HEmRdimfuWB14mXdv9cdztQKwRd9M=; b=bnJ2DLlkkS1PX+/cyKVo8DNgFw
 DNyOa1RWLt++IYBLORV9R4ufy33bIDD5RcmEDQNeFmnGOgOffUssHqUCD/Qp+poFa3oG/xob1H67w
 PsPQ+kF+Q7lRSbzXHgX/FjSSvYPZQ2urxp29O2g/YGpNW7x18XyWFP2YsQbvSqiue+h4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqG/Q6lvdGfxk7HEmRdimfuWB14mXdv9cdztQKwRd9M=; b=fz8i79bLCXV0ilZn8t1oSuHmQ9
 n0idohFk54SZ0ok4GSZi08diZjaJK26kc2R86csNa8Nhm2NZZ6x5ES82W1jbh74Eo0JZwEjdiFWR5
 bC6/EHAuRRAnWfOKV2i+KNnef8DqF5oA2/ppBX6JFNyn1InvO+1BN7rie3fwdqiZ9L4s=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u9wjw-0004wU-Dr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Apr 2025 02:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 00BF34AABF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Apr 2025 01:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C94C4CEE3;
 Wed, 30 Apr 2025 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745978389;
 bh=kXX33O6mDavdDO9coCSiBlNNPLi01Y+IZo/HAouKwS0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RjR7rg9pVG+Yo7gW9jfzoR27O+eFLxNj7ra0z4eLz5L9Sd7PlNiNFt92BKnvmlAzt
 cWenP4+n/Y4mu7goygzUZ1v0etpeEUT8m3eQI2xtafCLhSRSI2bYloq9BbupbpOHpl
 6iO36cskaTP33GkxLcmH3u9AHFLrj3PDBZuVofFVEBMOEpFtsjgjnHSzXooWWBTEz6
 XvliUQo9l+Dyo7E8jme5MXwlwkLsQ/AcmGKHxYkrtaGEbAN/UzK++lVdcD+YRhBwWC
 xiQlvKF1Z8YatO0fl0ixWxamP11eT7z9tiwU1pLwdLRHpmesCdFZxr1+0EoEH+9g88
 eU7hBgIaWGWzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33D033822D4E; Wed, 30 Apr 2025 02:00:29 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174597842800.1861815.12345517608809854649.git-patchwork-notify@kernel.org>
Date: Wed, 30 Apr 2025 02:00:28 +0000
References: <20250425095055.1129285-1-chao@kernel.org>
In-Reply-To: <20250425095055.1129285-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u9wjw-0004wU-Dr
Subject: Re: [f2fs-dev] [PATCH] f2fs: support FAULT_TIMEOUT
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

On Fri, 25 Apr 2025 17:50:55 +0800 you wrote:
> Support to inject a timeout fault into function, currently it only
> support to inject timeout to commit_atomic_write flow to reproduce
> inconsistent bug, like the bug fixed by commit f098aeba04c9 ("f2fs:
> fix to avoid atomicity corruption of atomic file").
> 
> By default, the new type fault will inject 1000ms timeout, and the
> timeout process can be interrupted by SIGKILL.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: support FAULT_TIMEOUT
    https://git.kernel.org/jaegeuk/f2fs/c/7724284838ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
