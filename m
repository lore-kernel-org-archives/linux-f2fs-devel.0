Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B627ECCA470
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Oct 2025 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iiCPCnYLRvRLnaimseZUsavihpArY0PJicymGxu3oyU=; b=HfGeQEQnpjZ4Htr3uuDWWKbyUW
	9XN5D6Wo2jqqcAhwkXxcf5WSTzoVrSsLVOtNHa50cRtlzP1JUcfl0PPDEuCBgb3ld5TUBI0oAThT+
	vFUOjmyRhhRNPNtyYbXygxXFzuHSJcXuluiMufnndkPJ2MX3HbEPILqKFtQ3tKNV/lHg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v5pAa-0002ce-2W;
	Mon, 06 Oct 2025 17:38:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v5pAY-0002cY-TM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 17:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3FqYUCJtRgBg3wKrJ8TliYE5Ewk88NVwcr0q/Yn6P4=; b=fBnOSHdmeBBFiA0UN7zjzdQIix
 uEL0CfJVtByD/i6ImGrNsNLRxaJy9jAQFMwme8qxJWK5cSR0rxIAlzvS5aHAUB2DlQUq7Kze1GaC3
 rWFfI4hlFOVmuKAJhQ1kAr0l9bxpEZRMjj9cG/pS0aLgzxaXbWyENHV3430o7or41NDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3FqYUCJtRgBg3wKrJ8TliYE5Ewk88NVwcr0q/Yn6P4=; b=Gwsy8gi3YxLlvG6QNKjQR2znhb
 zIvQRwPTH4vmtkroT4MRr5rmzJq0MnwimFP4ro1c9E9/nOHV45+GJAk09bNkIk8xDi3cfPpzn9iKJ
 iZvhW7Qod14Er+oMJqz8KKxFh6KvzMbyX1IQWsXPNwHaBRkcyxE4JKSy3VjN1a67G658=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v5pAY-0001g6-Cy for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 17:38:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 00EF243B3D;
 Mon,  6 Oct 2025 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AABC4CEF5;
 Mon,  6 Oct 2025 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759772311;
 bh=Oh5hYDV0H1cKbRUiUHONhkC9FY9iVP3YY0oPxwsBdMI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CaMM2Bp4ZCv2x9Fo5TLYVRrIE3hX9Fok+hS6qRPyS5xmGVS41P7I9IJyINiIP7Kwb
 rPDvNWxTL/QHGz+th1u35DFigkcVBI+0l4XU23C2J7nPHw79Gsq135TRfjJWJLlJQw
 e1QnXx5wQP5um2OM5rtymErODY17epMWYZEn4LK6YYmo7fIi8zo4Bz78OnL3MwNm3Q
 fEh0uZOGBznYqxIatKRHOOyVlDKhII+lMD8oxThiOQUvS8626tJVJImSgVwkl5G2ps
 +j/sZ8lMo+uHy/OAhrK4n9hKqRP9yM8VdSvvvo+rvI7XYWCGoWZAaHNjAqJq5pWIQ8
 1/ZHAgZ+Rih9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE00239D0C1A; Mon,  6 Oct 2025 17:38:22 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175977230150.1449062.13164485414655381958.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 17:38:21 +0000
References: <aOAOS864BmSwjfGm@google.com>
In-Reply-To: <aOAOS864BmSwjfGm@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1v5pAY-0001g6-Cy
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.18-rc1
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 3 Oct 2025 17:56:27 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs for 6.18-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/86d563ac5fb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
