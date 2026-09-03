Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1486AC624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YXzFnvQ1ZwtXadlbK++F5aIt7C2JhX72Z0r4pjiRfVU=; b=EYKowXkUW9GtTEdYY5voTzDiuk
	m8t+VrEAGDZQby6UtdievJwthnABWNTzyh8kVYWsSlPOmCnNqhP2+VBijMLhXsMirrIdCaWwgN56W
	bHfkP9jb4ePUqbW2YP89tTfYLZDJGgvVVhtxCLPTWU+/nW3pEWSvJy7yLmMfkWP530OM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2A21-0005QC-5V;
	Thu, 03 Sep 2026 16:11:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x2A20-0005Q5-1C
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=szYR7Ma1mbriTcSwoUhkTC/Hc9tKuWEAhNgqLZbdKx8=; b=blOVLylRhVT5cMcWce/EDkiRc+
 0Hv+U62EhadH95sacyROzUuqwjebhuif9S6yEjLaGDGjZGtoI8gcez0/nDjnVe2DF5k5zdKmnvMkC
 XAi78xROY1/3x9vg8Mu5qGjxHDe7hWt5vZB4hpgBDMQxJiUjfwbAq1moRqkLGDtejwN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=szYR7Ma1mbriTcSwoUhkTC/Hc9tKuWEAhNgqLZbdKx8=; b=QtotRSDlxNeZIFyxlfNo/DTyQO
 uddOKIVhJ/d3ixapdzLfuVLcx7tbRRB4pL/8a+LfirWNfkfLNkcpgFDoqqDNjAdIEu2R2i59KfLm8
 cl1DzRafwqKYDnpm2SP0wK7Yqhw3oVP75pK39r9XwB2kJKxOe6jofnMgc6hfCd3/hSh8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2A1w-0001YT-UW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A681E43F3F;
 Thu,  3 Sep 2026 16:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8907B1F00A3D;
 Thu,  3 Sep 2026 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788451867;
 bh=szYR7Ma1mbriTcSwoUhkTC/Hc9tKuWEAhNgqLZbdKx8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=P3ZN+Kh+TV6V9T6HxFv960PkRoA3O+xcpyTu+eRwp1Pp9woU/C69bl1RZCHf6rSA3
 ywAU4y3wHlrqPCORpmVrqM39S1BTnZR3Xbb42j9upHN9ZB265yCTHmefzb3bz6S5yM
 FRlV4ukx3VfY+ozAftsnKHoZpdhz+ZDHZ60YrynMtePXSlG6oleI/j6IvGvRpPmFgn
 oSSbOJvl+g+xWd2A8d5baz7SB+y1aIIUCm1qLusz8YltGpHW538xxHuUj/mhjIZRi5
 BVjjbUgQV8WZCwPWe9eNk3+gljIDmEQLNdvnhfsqdanyn5FOHuRTaAKEsZHJdfixEg
 FWC7L5/49CQYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 199E838119CB; Thu,  3 Sep 2026 16:10:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178845180865.3423963.18175372043780250753.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 16:10:08 +0000
References: <20260902090611.564876-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260902090611.564876-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1x2A1w-0001YT-UW
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: wait for inode record work before
 clearing ino bitmaps
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

On Wed,  2 Sep 2026 17:06:11 +0800 you wrote:
> APPEND/UPDATE inode state recording was moved to the inode eviction
> workqueue. These entries were later converted to bitmap values stored in
> XArrays, but the workqueue drain was left behind in the list cleanup loop
> where it is now a no-op.
> 
> During unmount, inode eviction work can therefore remain queued when
> f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
> repopulate them before the workqueue is finally destroyed, leaking newly
> allocated XArray nodes when the F2FS superblock is freed.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: wait for inode record work before clearing ino bitmaps
    https://git.kernel.org/jaegeuk/f2fs/c/56bcda97b38a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
