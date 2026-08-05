Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC2C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVxEwjINiD9oqizAlXPnSYhollXC6umbzYsJC0VwdG8=; b=Gl7Ajv5AGaNB6mRhPlti8Cy4W3
	Q/VBtV05ioL3H7frKHkyWlFnH+ubv3NLD4syqbLDZd3uGmBxcWQWyVOZKYEydqVY2YnTj6fWO01Tm
	EXhx8vmTesRH5yPpof/oOXwB3pYwpGNlR13LZJ7PdjXn87QKzlueTxUqrZxmClQ7IGWs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3c-0001hj-RW;
	Wed, 05 Aug 2026 21:21:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3a-0001hU-Tq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEDW/AmIMYc+O29gOvuStdUuNXYSoVViOuAFv3J1+6U=; b=HWpg16E7CxPV6De2Bge+DJO0YP
 ZR1Tr+gmK2627YZ5f+GKUt8Zbh+/lRQ97mKTjs6tzbfqO27i9QjkV8Edt170HPcITfvDjInbDwnsZ
 vIeaIWvXvbcJN5s7pVO0LcRtXshSn3KHc+rrvpc1TJr3TPEPRlstSjtwo/lDkbTIRjmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fEDW/AmIMYc+O29gOvuStdUuNXYSoVViOuAFv3J1+6U=; b=mzbn36YlXrCbXJxzu/HwiBrKzN
 vkVEZXp/5HYo/Dr3Rtkz3apThSSlesPkPSbBjGPdkProHMoGg4pyJv8gaGjDIVbCyn3Wol3QvJ6Vq
 m+jIMzdMWscGzMDcjAQPi75TYf5hOEd4mtTk+3545quhc+qZ0kvSbbOr7n2WtyXoMdic=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3d-00044U-QA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3198E43D3B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CCE1F00AC4;
 Wed,  5 Aug 2026 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964906;
 bh=fEDW/AmIMYc+O29gOvuStdUuNXYSoVViOuAFv3J1+6U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=jjHMkT8Dt9iw58PRl8eP3120CIXNPSm4krl+YqyLlyzBMnghCQUrtO1AfVH2hZyr6
 U8aOKSMfKeMfLOEkL2SAkdUamd9F0jCqraAkuDwwkb/ThRJNtvK0msSpWjjlB+5W+V
 DoB8HEyOdVbSf5pxsirm03BHoz6lGX5i7dyssT7IQv76dyR8epvK9fx0HkNOVbRNcd
 H+fuMLCZDPD1p/cg6RX9Isf63ENv3EbjpJlqAEetEjcDJpvSC4aJIeGiKbwvaJiA2S
 66c7LAK5r4sfBlZbPEeN/JOfKliLb9qvCT79cA4YcV2BlZCYgHVoKGt30lEmEO23TE
 Oq/W3m9p5Bqfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19790392FFD1; Wed,  5 Aug 2026 21:21:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596486563.530543.11673495069841206919.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:21:05 +0000
References: <20260623124823.1674416-1-chao@kernel.org>
In-Reply-To: <20260623124823.1674416-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wrj3d-00044U-QA
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid move_range and defragment
 on device_alias file
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 Jun 2026 20:48:23 +0800 you wrote:
> It's forbidden to migrate blocks of device alias file.
> 
> Cc: stable@kernel.org
> Fixes: 128d333f0dff ("f2fs: introduce device aliasing file")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid move_range and defragment on device_alias file
    https://git.kernel.org/jaegeuk/f2fs/c/1b4db09b7f10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
