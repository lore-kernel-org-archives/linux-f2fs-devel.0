Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AC3C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1Dlsyk+9jRLxC0TbiNNlNAA0s5kuy//G2KVgRyfChA=; b=G7/qctY6BSJlsSoOf1rHM3NJmK
	b0qEV0kcNkMxiGble3i4PVxgkW77HC+oFqBFBXk3EZyfbq2cg9rNBhX0yUm14Y0V06AwIG+PsiMsz
	SJm6mYu3KSpp06OkfE9oF9UHRwytQ9ntLNXGgR1dQn1RtaB1YtgKBI9eiz70kfHolGV4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3d-0008Ab-8c;
	Wed, 05 Aug 2026 21:21:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3b-0008AA-Rg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=POIG5wUNnozp2JrFP6brP6ig/f4ktVEtbb/m/xbmiSA=; b=fj3vXAD81TQpcneE9ngPPjT8s3
 gzuaIwmMdr3Yh+SX73R+IF9J9voo7EN2qF0GyqObOfRbybEVknvWhHV/KaxQWlWNVJKzULhsGy7Fo
 nnV8uDRCY56rTQzOLPei3xLtJKAh7vVywUkxLK63bcdgHzLWfDgEx1Qn/e05DOckvG6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=POIG5wUNnozp2JrFP6brP6ig/f4ktVEtbb/m/xbmiSA=; b=XjoZr7LJwZQ7ogpqC18MOlD2oL
 S4hnMceNbxNBa7mrkBP1td68L0P9dwl4n0/5GEpUX56QKqx6TeOeaeDJPVpUJANOm6zlkz5Whz8jo
 p9AsrKgHrrHqtv8SJX9imX8cET3xZI+8L8X/QYGHE3JRWbOAOBWW9ysyYQ8ZFWklpfmw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3b-00044U-GR for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC98B43B2E;
 Wed,  5 Aug 2026 21:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F19F1F000E9;
 Wed,  5 Aug 2026 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964898;
 bh=POIG5wUNnozp2JrFP6brP6ig/f4ktVEtbb/m/xbmiSA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=abxhiSM4Te1BbKGehvyaH9XZDo8PaTvqsZwf0+yusC7IgkKNoySR8C69/9yePOV+u
 jkKOLoogjXDV1xFIAyTdYsk+aqOvGtk8ov8/AINE6gUe4bGuGTiZCOCxL2q9h5145V
 yHW7wcmLHPSqFgNKRLRFd2EnSEvhQm6riyC6pyEPd+AQfdCKc9/QXxRYlqHo5Bc9eR
 lcRr9+nRNJ7BfE2tHaHG7SxB5O8LrupfVy40iPLoTktx2Terx9cxvs/cr2l0YMmD9d
 sn76fuxN9qowuaKqXEgZGMLGIp3eyaF4mGCf29w0C3UmT4ZXWABkmBWkB0j3SH7CkO
 RxExJNqMlzn4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93843392FFD1; Wed,  5 Aug 2026 21:20:59 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485813.530543.10823312438985135960.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:58 +0000
References: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3b-00044U-GR
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate MOVE_RANGE destination size
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 30 Jun 2026 11:17:00 +0800 you wrote:
> F2FS_IOC_MOVE_RANGE checks the source range, but not the destination end
> before updating i_size. A source hole can expose this: __clone_blkaddrs()
> skips NULL_ADDR entries and returns success, so the caller can still extend
> the destination inode with unchecked pos_out + len.
> 
> Reject destination overflow and use inode_newsize_ok() before extending
> the destination inode.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: validate MOVE_RANGE destination size
    https://git.kernel.org/jaegeuk/f2fs/c/e533889fc26a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
