Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8266C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ogFPXf+UJ43DnHQDxL3EVzNpHJJimiQ0PbFVlhdpjXU=; b=XhX0HcqvJ73OFGACC6zV6JgpXg
	GvEFh3LCyyxqJPA7mI85izGjqxdpdrZyrt/MJjT1B0/39dWH/LkNGasarWCj1d+2SJXISfV37mHek
	/IkBemO8ccJoZYS91Jgjd4+Lp6hIFruu9oiRrO5KOIyudYjIh3j2lESYmpILzU0uQLPY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzS4x-0004P3-EW;
	Thu, 27 Aug 2026 04:51:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wzS4v-0004Om-Je
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 04:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vvGk1crCtauscGk1nFnoBIsLPmCPQOJaGUPNpfjpKGA=; b=DNznQRAC/RZ7lqg8ONwEeCu44i
 VT8kLCK9vG9tvDq/n+vVSotsbHRVzKkWi8NgoCdAi14dIbIe1yKDGZ5sEu3jB8VbE4Mg2xkwfW8h4
 6wOip22NqMFF3ksovU30taiF4wI2sCr5PS7B5eKCm/OMfPpftRFllpQZg0Wn/vkgBm5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vvGk1crCtauscGk1nFnoBIsLPmCPQOJaGUPNpfjpKGA=; b=g23jLUgdrHuN1UgTqzKCVwx1Bx
 QCRO2v1zIakd+7nhfHkRCJt7dxjLeX8YmMLibSaG/HLkS06jxMSSSW2zTDo96bASm6j2uJ6FwI3tj
 +8GOqa4cOzWlF+QOESnH0Aq9T/5omFxIb6Lkxbwsm1KjiaxASAU9OLATKZAhvgOjk9fk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzS4v-0002nQ-Nx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 04:51:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13674600D0;
 Thu, 27 Aug 2026 04:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A31F000E9;
 Thu, 27 Aug 2026 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787806259;
 bh=vvGk1crCtauscGk1nFnoBIsLPmCPQOJaGUPNpfjpKGA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=lggyxxrhppmWvXX2pKus0eLv3iaiZMp/rJrGoF8VUFr/yOwbdyEmyGA7ZjR8OU5ws
 Vei08A6RfvD0siOxg71A/aiaU18JPe/oPCoxQVydkN2WHmHsnbzNLMAtnFaCpM7yYM
 1QDoy0zuDRRFTnoLDrJSZzzsEDfYCK7sBjiQggWaPQjHrZVZE4EDC6I+BbC7pGjDAy
 TQW4vBDH7MPVc1knRbjBQyzgqf15OnuYI+UVtoCfo4ui1Te0nHE7cY6xPjfhodReR7
 NNRek1V7+VNhZ1eTOEuGqLOMcOlSkFpfnZSup36cVEos2tSGXXuRMvGKtUYe4RrWoX
 dz4fSnqN3r+eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0A173809A09; Thu, 27 Aug 2026 04:50:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178780620540.1022614.4204248099313944136.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 04:50:05 +0000
References: <20260826153644.3726384-1-daeho43@gmail.com>
In-Reply-To: <20260826153644.3726384-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1wzS4v-0002nQ-Nx
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support resizable tail section and
 unify pinned allocation
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 26 Aug 2026 08:36:44 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Currently, zoned block devices restrict pinned file allocations to
> conventional zones at the beginning of the storage (before
> first_seq_zone_segno), triggering range GC when conventional space is
> exhausted.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: support resizable tail section and unify pinned allocation
    https://git.kernel.org/jaegeuk/f2fs/c/c966d29e01bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
