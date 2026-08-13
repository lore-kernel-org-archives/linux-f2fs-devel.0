Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C3C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQZs/vOL+tgt55JmVN65m2r3q7+IvOl1gm+fFeK8P30=; b=ekJMc7TWh7GRFynPeAjQvG2HQR
	tri87gSpBEL3Auw60rpTXylqc8gPRsR0eoY1loGeVTq3JYwKSl5Ems4CrsSCcpbqquDr+OVAUbNS4
	m6z2+SO7aiAMZzR103ape2OgQx4kmNVad2/LpAjiW3/YgR0s1duh9CEX/CR8hTnXPgS8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuXsv-00085O-Pz;
	Thu, 13 Aug 2026 16:02:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuXss-00083i-Pk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17AGzNjYzTu+Qu1HMf7HJ3Gvuph8avJQT4rc0fFN/1E=; b=gv1zUMMlnaTeUeZ2ibQsnYWWLn
 WMxBqFDVqjKobqQX1eEY2WBT2yi9Lxh039dwsCxRQk0bZdRWZpIsc5Y2Or/2wG+RUF7+LgmKbVjSV
 KfOi11PwUTIqIMR5EbNmd9deCOesa83REBQO/MzE9ayCkZf5A+PiwK00Tygv2mAgCuEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=17AGzNjYzTu+Qu1HMf7HJ3Gvuph8avJQT4rc0fFN/1E=; b=lUaiVTYX3ouhcl9ZQ3rQ/iec2N
 AgsiQKlEDmjEKcGDIYlQZd65w+22DoHBLcfz30Cgg+FaLzGJ+5xtFiMtgbN+7R/RIO6Hb6TeW916+
 lOMwxGngHhpliszlWTDCxWRUZCgl1eB/ZsUMyGKO3+Se1Jwdex54ohiPhY4/KxhXScj8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuXsa-0005mH-4a for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:02:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8EA360A72;
 Thu, 13 Aug 2026 16:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDE81F000E9;
 Thu, 13 Aug 2026 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786636914;
 bh=17AGzNjYzTu+Qu1HMf7HJ3Gvuph8avJQT4rc0fFN/1E=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=QaGR6xBYh7XOLaTEYK07JE0RIGZXjruyvltXDpeH3Qv9y6VGoUnm8xpSKd1kmIS5m
 8aZQXCd2uESkPH0HMmxUf9uLrqrNVzy6A63CELe1KFE6Z830AGwt+Jgxc5mgzyjYnS
 RjOMt7GADy25xUTaCxLDhEPsGlK9EkWVyPQDxRaBU3Lk2kVl46INkvaalHcrQsGaKA
 vZPoqxvgCiLaPjA7fIsfLwxZdq2Wptoj93Pstw9oNrPeCl2kKBgtdUkpd/67rhdvIz
 dmzNrPZkrwVDzeWF1gQR5vXf74kB8N7SG6WQRonJ2dvBI+QO3CVizJyglfh56tJ6Oe
 5Q+AxQdhE0TwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93875380CEE2; Thu, 13 Aug 2026 16:01:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178663686914.2934858.14952972896342801609.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 16:01:09 +0000
References: <20260812121756.278690-1-chao@kernel.org>
In-Reply-To: <20260812121756.278690-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wuXsa-0005mH-4a
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to reclaim space in
 f2fs_allocate_pinning_section()
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
 stable@kernel.org, linux-kernel@vger.kernel.org, daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Aug 2026 12:17:54 +0000 you wrote:
> It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
> otherwise, fallocate() on pinfile will fail easily even there is slash
> space in conventional zone.
> 
> [Testcase]
> nullblk_create.sh 512 2 1024 1024
> mkfs.f2fs /dev/nullb0 -f -m
> mount /dev/nullb0 /mnt/f2fs/
> touch /mnt/f2fs/pinfile
> f2fs_io pinfile set /mnt/f2fs/pinfile
> mkdir /mnt/f2fs/dir/
> for((i=0;i<3934;i++)) do { dd if=/dev/zero of=/mnt/f2fs/dir/$i bs=1M count=1;} done
> sync
> for((i=0;i<3934;i+=2)) do { rm /mnt/f2fs/dir/$i;} done
> for((i=0;i<1950;i++)) do { rm /mnt/f2fs/dir/$i;} done
> sync
> f2fs_io fallocate 0 0 $((1024*1024*1024)) /mnt/f2fs/pinfile
> sync
> stat /mnt/f2fs/pinfile
> f2fs_io fiemap 0 $((1024*1024*1024)) /mnt/f2fs/pinfile
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to reclaim space in f2fs_allocate_pinning_section()
    https://git.kernel.org/jaegeuk/f2fs/c/5502c956d6f3
  - [f2fs-dev,2/2] f2fs: fix to shrink gc_lock coverage in f2fs_gc_range()
    https://git.kernel.org/jaegeuk/f2fs/c/a53894831f5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
