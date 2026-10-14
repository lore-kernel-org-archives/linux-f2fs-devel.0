Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA247CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=geV8Dl5jjWs81tRZ25R7Gnrrw1ufvMgNmHjWfJUrEDg=; b=VrV7Fplv86nC6qmbR4EV9v4YQm
	HKw2zBuEeDo0N3eqk/7ABottTGDfLgquwoxah/KlzDvJTn/mvWOVbdByecCJgZEBiUY8jOoTWzX0u
	WECknx6tQFeiSU/y+/VBzkJ0T6AJbLVxUcxVeB1w9kN/7mIFoFifT21fbSoLMboG1oiE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1F9-0001mK-Tp;
	Wed, 14 Oct 2026 15:50:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xH1F9-0001mE-2T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qBNoBolvqFcF+4bkLStTB0UG9Hld887GeWPcGqhpsn4=; b=FAjxe+FdB6CdmeLBxWYuI/WlFW
 d//7PUefa1b0/MbzBE+dPzpbwMYCRHhlSjyG5QU+SBET8RhOjXuP8oynt9dzNsVsJ12P57e0BCuNB
 +cKLgDbXc36JthUa7d4+IVbI2rrU9RLa8bX4Da3QhsS3Id4vjA2LwamrxxBTNCzWDv0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qBNoBolvqFcF+4bkLStTB0UG9Hld887GeWPcGqhpsn4=; b=d
 XvAx5lzXIsxVTAPmAaVLDS4kd6S5KxTwAPbGiiTJt33rrTQoeuamn03Rh1qgTrZwBp+oVn9DaJRA6
 Q2epL0sUeSZzVzhO2fThqYvLYg5duJaYrD5UgOCqE3yUvQo5YC2GDoSjmY20PyjicR9Lm1FcWC4Yz
 AbmdsnV1Yp+Rt+UY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH1F5-0002tn-1z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FDD46022E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 15:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274031F000C4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791993005;
 bh=qBNoBolvqFcF+4bkLStTB0UG9Hld887GeWPcGqhpsn4=;
 h=Subject:From:Date:To;
 b=cg4IpYtDpUMNyQcxu5BIy4YeSC3k+FGqw4I8S0zhTxAptr2a+5CqnUAYwvWTHQt5P
 vdsUcPpIumGNSSanNmU8ttQ/WkccBx5oJ0mBeYe5ExMNCRSouo89RKAWc48Lt03WlN
 HzbsS+i8DNShw5ONbAsv0GmwFIbtuPvoTfrlZa+EZndyHq/cnGMwwtExrkXimTNSY5
 PVNKuCggv9568kqVU3ULvzIHxvwlYT1Q2qSzp/saZNYtPe2qqxy/zNtPlwvYTJPigb
 54N25JBeqcxS3ItYMNYYS+z68vSZLBZIvWX7rCdI4txf87IcLJ5KS0Y8f5I4vlO5tZ
 IUyYic24oRedw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 0006539EDE30 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 15:50:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179199300360.2827562.4970496694617547201.git-patchwork-summary@kernel.org>
Date: Wed, 14 Oct 2026 15:50:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1xH1F5-0002tn-1z
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

Patch: [f2fs-dev] f2fs: avoid unnecessary reads in f2fs_update_meta_block()
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1178091/
  Lore link: https://lore.kernel.org/r/20261002064853.37782-1-jsjlee1020@gmail.com

Patch: [f2fs-dev,v2] f2fs: quota: fix quota flush failure during filesystem freeze
  Submitter: Jianan Huang <jnhuang95@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1183559/
  Lore link: https://lore.kernel.org/r/20261012025442.770777-1-jnhuang95@gmail.com

Patch: [f2fs-dev] f2fs: opt in to multigrain timestamps
  Submitter: Jeff Layton <jlayton@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1184026/
  Lore link: https://lore.kernel.org/r/20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org

Patch: [f2fs-dev] f2fs: return -EIO for a lost inode block after cp_error
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1184130/
  Lore link: https://lore.kernel.org/r/20261012182233.2685282-1-daeho43@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
