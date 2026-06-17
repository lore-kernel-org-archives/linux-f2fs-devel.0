Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF25CCD98E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yQOflFnANTug5MIBaw9ay4I1xbEnoXWQ5T9UqjPpBgA=; b=YRKKPQB9NvOGZ9TvucqMPl4r9+
	DvwWJsVJSzChgdDXNSZhB74PzPBDPQsAq54G34+u1Ntrr0PgYe3mLOS1zp/FjIIh6H6ylAGEJT82H
	mv0vqFgCdJWd43j7jaamKmFvZn92VCyqw9wEc4L+WUVplU7kN/jY/kOh2zGybltavRQE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZrHZ-0003Zj-HM;
	Wed, 17 Jun 2026 14:30:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZrHY-0003Za-92
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvyNoOtE7rBE1+HnSYp9ODGEyXH9VFGhK8rGSA0BCD4=; b=YouhgRvuSvluFQLHIk1QIB9zQB
 iz2EdXAkPU4b+J3l27il/FVjcO7TdVvIWtFI5p1JP8g/8miPXAXFPO5Z3cs/AO1IHg7VMY/iPOPJk
 zf+4nHok5yUsHMreM8pvIUOYPyn72qdrCZpMjJGkDXW+FqbI0zrEe5ff00L9evIcjh9g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MvyNoOtE7rBE1+HnSYp9ODGEyXH9VFGhK8rGSA0BCD4=; b=U
 zRHa5tZPAkuQAzPtsfcY1AfOc0q073a9A9Ovjv0jAXzde3qWZYnt5wme9bvKZTwWVRR1K0S1qaByS
 iVVpg/HnwBaaLzgadp5L6q8jhz7ndU2xXiwOByXt+/Uf1rI0vekaxhmwyO4lU2SPSuzch5jfPY37n
 5fzJOpyipv1J95/Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZrHX-00011j-L5 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 14:30:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD4D640D6F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 14:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CDD1F00A3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781706608;
 bh=MvyNoOtE7rBE1+HnSYp9ODGEyXH9VFGhK8rGSA0BCD4=;
 h=Subject:From:Date:To;
 b=eDwS+ITsIcPYs5WZA7WjMZRC0c7sbxPmUPIgzQNgoAQcLuUL3KH2MgJzPHNrn32z6
 irnVEJb78KRQQ8BlKpzXn3QsAD10ibXTq1xAep0EBT0zZBGjK7YBw/BAeU/7tIHoAf
 MpBhP6gXE+vuLfptSNQqOJsM4zguDIG00IJqRnyto/z44vptaPRX43Kum7qP0MO0SB
 HtSORVLvBJZCObGmgmimSL4FRtI0YYaLwP/3j24rPBE1T46tNd9kAXek8zs0/Tn0iE
 g9J3pgTvGauSdPUxItUO1rhHjTVga12Y79umYDWt90fMNcMhjwa/V6H6pLnTxaypZr
 UOXnyUUVoitgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D33E53930E3E for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 14:30:03 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178170660246.1646430.15154465527633335923.git-patchwork-summary@kernel.org>
Date: Wed, 17 Jun 2026 14:30:02 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wZrHX-00011j-L5
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

Patch: [f2fs-dev,v2] f2fs: skip direct I/O iostat context when disabled
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1112037
  Lore link: https://lore.kernel.org/r/20260616030655.111933-1-qiwenjie@xiaomi.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
