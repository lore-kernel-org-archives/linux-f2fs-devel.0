Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869DCD98E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mm5WO8Q2GSPT74fdHu+OP43pYSnR+aViQsxxhnnfxzc=; b=TOuUhDKSqiTN2wVFDvGmItLgyy
	h/I99bZ0+1Vb2Fr3xfQ8Wnw2vjSQRBr6KkGdZ6ayQZ2+DTVQhkqQRO6YDPfkb2uKvvy74owyrF/JI
	kMG8/ZkkgmChtXMgWvL5dw0O+thAMor/gy+kvhwJxIj7CU3Ocxz1giOj1cNeVl2KHNgg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZrHc-0003iS-2m;
	Wed, 17 Jun 2026 14:30:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZrHa-0003iL-Nm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tcMmm66fy2boexN+2HQWlLQyE1UT42+Zjhka3b/DvZ4=; b=OYh9jVULdSD5vjeeRRyaQF5Src
 yLaB+m+9ZI38WWDlm0iqPftZVhjNoBiKpxpPAh2cBBmZYGIbOON8jEa9IAtwXaqj+OTWgBKrQV1AI
 KFxfi4OkOFhKSWFay4tqB44qtSwJl1PugUa890EikNemwGC3Ts+DM3YGVsBd4d4VEab8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tcMmm66fy2boexN+2HQWlLQyE1UT42+Zjhka3b/DvZ4=; b=YqT/UWNaSOQrBocaSluuBTeZr3
 dtaLJyecHqKpFCFdmHe9mIbLlPA9rqUba2cDKmVXk1TUbKvcCLGphjbqN3B+/7K256G3ensypp1Dh
 SAcaPY1eVtH5P8fGEaOJOpK2dPWKAtSWEwnIzDBKaFm57Rlyk6yKveSbsAFqcZK2GU2w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZrHY-000120-Sb for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:30:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 579D7600AB;
 Wed, 17 Jun 2026 14:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB471F000E9;
 Wed, 17 Jun 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781706610;
 bh=tcMmm66fy2boexN+2HQWlLQyE1UT42+Zjhka3b/DvZ4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=dA80/AuO4HowUNwLT3UKvrzr9aMX8vwVNCY+4Qw0TCTFSkYoXgah2eyfv6sH29GPT
 +T+vN3lP5GogPMnGtuymDQk0SZKzcDCsCMQPiLV/RgG6DNrsoy+2zJQCCRlAobluSq
 dsUUsQHvwDQPTkOmPJsP/uWvEB9rDMMmFziE5Xr0gfGTwsbb2qibzuqo7ai5hJyqxP
 EQysr0YIwKtZev8kG0pMtKrfKo1VIYRgQuxBmF/1b6emCckYLb3MOO6G0Pincht6Sq
 /hSfouEB/fKSvHBal96u9flniwI212Ncs8wSgOE5fDC5JsCypTu5Ea6+x4j97z3uwp
 Ae57B2eEGML6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 569703930E3E; Wed, 17 Jun 2026 14:30:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178170660389.1646430.11358036232536145597.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 14:30:03 +0000
References: <20260616030655.111933-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260616030655.111933-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wZrHY-000120-Sb
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: skip direct I/O iostat context when
 disabled
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
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Jun 2026 11:06:55 +0800 you wrote:
> F2FS iostat is optional and is disabled by default.  Direct I/O still
> allocates and binds a bio_iostat_ctx, updates the submit timestamp, and
> replaces bi_end_io for every DIO bio even when sbi->iostat_enable is
> false.
> 
> The byte accounting calls do not need an extra guard because
> f2fs_update_iostat() already checks sbi->iostat_enable.  Only skip the
> DIO bio context setup when iostat is disabled.  If iostat is enabled
> through sysfs before submission, the existing context allocation and
> latency accounting path is still used.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: skip direct I/O iostat context when disabled
    https://git.kernel.org/jaegeuk/f2fs/c/b51f606aa323

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
