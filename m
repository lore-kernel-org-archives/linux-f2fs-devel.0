Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CA0CA5FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=divPfNG2fB7ws6yaB8Otkb8lOdotSx7W+ssfEUMwIs8=; b=iiwp07twwnlRaHx6OzLn2PTI8y
	fGKrcUCW4sSytS9gXBnYQXbBoBJYcadTKBPqaL2Ub9xMdKsM0y08kfN/JKML82LlgG9CfflCJbyZZ
	nTzUDABn/mht2qERGI2vtyR4tXCuJ2qM/CMdhaz42TR4X1JDAw1kZoF2d9DMoHDL2B3E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBxyZ-0006uj-2x;
	Wed, 30 Sep 2026 17:20:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xBxyX-0006uT-AH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cvir7FGNRE/VEc9WIoKRAgXc+Oussymed5PbGztypFc=; b=TnpkC4KLt725Eq2BZpHJLWQH9N
 hedYjBhQZFo5bqBpOjU0QFZnvybUg1uAK7RW15kZv95IhEO7YvN/5V3cuJRUKcU9/IJm0xrJXYLt2
 zqR6E9D+m5Bt+XIa8He7ff1eawrznrSyzrxjoaON5ChLtIS+eyLtZFq8vwaxH7W9KBfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cvir7FGNRE/VEc9WIoKRAgXc+Oussymed5PbGztypFc=; b=O
 hKpvpuewYEzZB/7uhbqgWrs6rUK2H9lOgRbQJdN4siYhSjxhO1ya8jtSMBXWvW9qLx16g0bxWBPJA
 fLRaX129pqIUi6ZR2mB3AFahTA32r8emkD7FVlolaXyI6Q6dXXFdtsWi+CSbFtJ/R4i0xLAXoja3c
 rDN2jKL69mjegbRM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBxyV-0002Ts-4v for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDDDF41435
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 17:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C011F000FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788805;
 bh=cvir7FGNRE/VEc9WIoKRAgXc+Oussymed5PbGztypFc=;
 h=Subject:From:Date:To;
 b=b/LagLdnxPpA2nOttPsERJKOWcL1SMg0nTlt+5D4bQTbksEZdk75x3sL9yRb2dpjH
 kzCgsNhUO2Y7dCT1ddcDnTM2MC5Pxv1ZmD2ewv2d5Dr4JEkgNXLxL9l8uJFfv4tWtp
 249KX3uCBjY88AnjKtDbA7O4ikvP/u51i7UIaO7cyoL3D6RB0McjcsdGIx4V8D5VbU
 D5pFv8VcGVfHyuqCm7jPDDDVBLw5vH68vFgk5UXWQdhx0z5dHP9EfJDXXuc+QyTf95
 EwpxPZ30Lvg+j8neLy36yPXDD0H5TjS3rPyhmKrgnHg0/BOgBF5SezOvPR8ZkXRCEt
 gML5sq/mhbUqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 79DE53A566F2 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 17:20:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179078880401.2027760.18131477737259801727.git-patchwork-summary@kernel.org>
Date: Wed, 30 Sep 2026 17:20:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1xBxyV-0002Ts-4v
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: reject device aliasing without a multi-device configuration
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1168697/
  Lore link: https://lore.kernel.org/r/20260918133922.8163-1-jsjlee1020@gmail.com

Patch: [f2fs-dev] f2fs: quota: fix unused-label warning
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1167703/
  Lore link: https://lore.kernel.org/r/20260917142222.1591270-1-arnd@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
