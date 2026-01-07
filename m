Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE46CF6BEB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nohIBUqT/tVCiXsyFHDPVIBcQYhBGB9+nsJe/XU+4qc=; b=fBud3revQQy7onejkmfuW3v5o8
	quKFy3Ka9zO/RJAjFQAsc69jGsBtEZnSox0TBW+QtVt/kUrrtkOrBzRc6BRuO8mSvUBtWJMpnxRUy
	AGD5w+QQjlQ7Me5fldPGglKt5GM7RcX8m5m+KP2kHIORpIOkFAlsnqRc7IOTw153UFLs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdKJ0-0006pm-No;
	Wed, 07 Jan 2026 03:33:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vdKIz-0006pY-Tz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUKPXsCBu57VWXvy6WCbthLGMRHzxxsZ9GcVDHJtvJI=; b=Svia4meAta5o/y050gF3SKbxmV
 Q5FxZZ9OVZeg7TX/HqufxurVJC9hAGE2kbCu5plTCdYntkd6CIxTMQLLCKD9sizRZIw0zBgNmxEVl
 7J14Evyn/m4Vata5/vdtavTOpZHIHz/+4NY0lOPUc3/9PS//0MNxrC0GPs2c0PBzUR8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUKPXsCBu57VWXvy6WCbthLGMRHzxxsZ9GcVDHJtvJI=; b=lvLHrJMM/NWppi817ajg7+GFz/
 CGbELQ/4yoVIS4kvZpScmi5FQL08Qe+2ytZxVElQ67qUCVzz1eeTPf/Q7FR6U5ePa3fyI0TvcQuON
 RgcuHIKborZ910WN3r9EZKwqHnYFc/0Mv6C469RRt5IoXXv8dzRp/H6Fy6NHiu0W2mHk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdKJ0-0004YY-6K for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E293643BC8;
 Wed,  7 Jan 2026 03:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A21C4CEF7;
 Wed,  7 Jan 2026 03:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767756823;
 bh=vq5/5rssmuy5MLgIjKV5Q4smjXPTJKXr/y9bD/cPk5o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WFnayqSyUG8/WobARZaidE+cVYOzA3jM8R6miRnkI2FlCGOzWj1aQIULp/AnvjLvw
 D80/AfmiEmtTbVm3VksqhKN9h/vW8113m53d1Z0eW5m25H8/VwcXjz31fhFSpwfJup
 CLTgMEpXBj9mfM3keMfLymP9JhFhyZOfaLWtEkmmv/RNB9pYgGWajYLxv4eBbUY8xw
 5sQSs1HuySb/nD56GBcLo0gtDi4GLgDM7Ne2ccp0DwIwnfbI2Dl8GfXsLfT/NUNwBc
 yfduQ7lGbR137Q0Frw1P8VwyRJ08Iqt47c+0B5cCr1g9fmnGRukYGDy0wZ2zRxS/rY
 GkdrCvW2RefDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 78898380CEF5; Wed,  7 Jan 2026 03:30:22 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176775662102.2218650.13503531226058930322.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 03:30:21 +0000
References: <20251231130514.1061051-2-yangyongpeng.storage@gmail.com>
In-Reply-To: <20251231130514.1061051-2-yangyongpeng.storage@gmail.com>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
X-Headers-End: 1vdKJ0-0004YY-6K
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix out-of-bounds access in sysfs
 attribute read/write
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
Cc: jinbaoliu365@gmail.com, yangyongpeng@xiaomi.com, liujinbao1@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 yangyongpeng.storage@outlook.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 31 Dec 2025 21:05:14 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Some f2fs sysfs attributes suffer from out-of-bounds memory access and
> incorrect handling of integer values whose size is not 4 bytes.
> 
> For example:
> vm:~# echo 65537 > /sys/fs/f2fs/vde/gc_pin_file_thresh
> vm:~# cat /sys/fs/f2fs/vde/gc_pin_file_thresh
> 65537
> vm:~# echo 4294967297 > /sys/fs/f2fs/vde/atgc_age_threshold
> vm:~# cat /sys/fs/f2fs/vde/atgc_age_threshold
> 1
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix out-of-bounds access in sysfs attribute read/write
    https://git.kernel.org/jaegeuk/f2fs/c/98ea0039dbfd
  - [f2fs-dev,2/2] f2fs: change seq_file_ra_mul and max_io_bytes to unsigned int
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
