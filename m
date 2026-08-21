Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C7C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/YjuK46id+SOMlGchkbpoD4Ti74d52D04Slu7H1h33M=; b=XAe1gUbNCnhuGqU+d8WM7oPKVV
	0j0zViNj65ZNjGYECjhgU8wsNDMivRgzra/UKErXH9Dss/aQPuQztib0JJ3bwYYEO1nJljs6agPU0
	zRTWHJzOyyahjUhDTDIx1QcW00tDm69c4iB5IyvTJe5lKtO0R+BLg4WuIhy8LhXV8PRE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWM-0002g6-VN;
	Fri, 21 Aug 2026 15:51:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWL-0002fz-As
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IXCIhAifDO722+n9zfhUHvIDtqDLI4Ua10xt4TL3EII=; b=agDOlAU5q2KOf4/nUJialALlWu
 d2MWHFOhSnURVcqfsM/6XS9CeiBh28B3U96N9pBvrjbGY1QgwvKcR8pOxMblEbqFV1erFqxPpnnXV
 fK5wL8vLm6z8E7xfv93FfMFvtfvB0HGUNJ6kaLcKvWJDEM/wDK8Cn1Z7wfmnPxT2hDZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IXCIhAifDO722+n9zfhUHvIDtqDLI4Ua10xt4TL3EII=; b=JLP4zo2pRsR0L0cUe69L+ZpW5S
 faGyj26qAFRY9wlamzKOySCgGOy7eXapUhN28t0rYwNf+mSttI9rr+opv6ZdE5O8Dv50Ny8coHKnQ
 uoTAzTbWed53I2qw8eZj2xYxqTaP1z7cenupP5lAgZogNe0aBE48rU5hyfXLY1yNBZJM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWK-0005iW-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5886D414DC;
 Fri, 21 Aug 2026 15:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4C71F00A3D;
 Fri, 21 Aug 2026 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327459;
 bh=IXCIhAifDO722+n9zfhUHvIDtqDLI4Ua10xt4TL3EII=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=mNuWdFKMcFHaIDxD0nh053XwMLoweW+GVzTI+mbpHJfzCemLhk7srMBTpohAcDxoC
 fLfRT3AoqPSuw2s/a300yGRF84mgOAf66C4HjT8eGaA0e5WCeZrEDCTy8u2ls3aVZw
 MIEFa/gHtuYAPkfllPjWzG5jf8I/VIOqMo6zBWMOkH+Oi+cc9g0QdHlGk5uEnghEgr
 M8BgmeRUMWtq7YekUDYBIoPJULVvcnHDGSjYoCn3SO3mSt030J+JltPwmW/E+fHqS6
 95M1XZh8d/XRiBbguO2m9ISXzgtx3AmgsPnpSJNcRXjUuryqdEKXvA22D4DlRa9+H5
 pwe6AATZR+8KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19819380A979; Fri, 21 Aug 2026 15:50:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732740863.1339488.18145676709503198602.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:08 +0000
References: <20260821141742.2678300-1-daeho43@gmail.com>
In-Reply-To: <20260821141742.2678300-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1wxRWK-0005iW-Mf
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, christophe.jaillet@wanadoo.fr,
 kernel-team@android.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 21 Aug 2026 07:17:42 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
> encountering a device aliasing file bypasses the cleanup path.
> 
> Fix this by setting err to -EPERM and jumping to the proper cleanup
> labels (out_dir and out) instead of returning immediately.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix error handling on device alias check in rename and unlink
    https://git.kernel.org/jaegeuk/f2fs/c/27d0e27c096d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
