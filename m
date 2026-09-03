Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B4BC79F80
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qfoxJq5MN3ZFOEmlh3J5xB6FLRPXmEirpGdbZSi2WCM=; b=bUn9bzgJLpMrsAIb0AU61R6HO5
	FoM91eRSebs5ptaw5/bwVbRqA/b6HGyjbMnlgv6Ryvhai/t15MU1WTKCV5UOCXTApQO3WGXvyTwjO
	Ad29RUpV4Qb1ELRUBs4b/QKVkNt47VTO87Udtw0J3SeTK0SwEr7ONrEUCkhc1EWx3hLE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2A1w-0002fi-Fr;
	Thu, 03 Sep 2026 16:11:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x2A1u-0002fc-Q4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TC7qskCw5kJpE976Jz8dvSFmZY8anYr/GGjGUZ3lDwc=; b=MIEZda5SoaTJyQWxF1W5NjytDL
 QPa+7HAfNViBNUJLphDM9cDWN1tKOsl4xN/obsirihZr3Lkowh2LrZjqLNLwhMzKqIaIMXW2ohncx
 pIa63mn1+6fm8hwOtknAauffCTBrd8+2tUPj7INeHzMDHsEvQl+EzG0hItkf6g1U3V0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TC7qskCw5kJpE976Jz8dvSFmZY8anYr/GGjGUZ3lDwc=; b=i
 fcR/sVSEamPPTtlzNdOjih6J4bfAyXLDcZbdPyOcCtM3Sb4ZSYbrT2jTuH/gpwJJjOLH2DhPFubHz
 jG05CoRAyMNqR09gxpxfYlr49ytyP5mYMHv8ZjXc4uMBSOs5k1bzOFTZct53h1m8Iv2qpGgTsRhyt
 MnOXfj4bmCPM0Yrk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2A1s-0004aa-Sd for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 16:11:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7814D42AC8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Sep 2026 16:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF161F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Sep 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788451863;
 bh=TC7qskCw5kJpE976Jz8dvSFmZY8anYr/GGjGUZ3lDwc=;
 h=Subject:From:Date:To;
 b=Tz8Fyj3ZFN6hVfIgUPIYUXvkyoJns6fI1f+a/7FOPf7etQzpgRzwKz6x01CYmH286
 v6rpmq+RrpU8SWP7ynyvYGoV03puXdwOoO+Lou27KUM5mubjKHGlZnAi+tAXV0yGaW
 +N+BdL9X1zXZzE492rCACzJw/gSlghw/UB8OycbOrxGwoc4pyHwTnu1iDH02ANuiTr
 k6R1O9gsHHQPAYCfXMdXLSH8smOKlqC/kgYm6b+ADM2cBjg5iVlJ2MydSTjXWWtaqg
 z0bncqI6MVY/nsT1zk+7QBKELR2CdtDQncfofgliC1ONv6MuWVm5CIiEVzIo96mH52
 iQlCv0QXa/hXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D381238119CB for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  3 Sep 2026 16:10:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178845180450.3423963.4526772310519574711.git-patchwork-summary@kernel.org>
Date: Thu, 03 Sep 2026 16:10:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x2A1s-0004aa-Sd
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

Patch: Remove PG_private by using page/folio->private checks instead
  Submitter: Zi Yan <ziy@nvidia.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1138502
  Lore link: https://lore.kernel.org/r/20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com

Patch: Remove PG_private by using page/folio->private checks instead
  Submitter: Zi Yan <ziy@nvidia.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1154790
  Lore link: https://lore.kernel.org/r/20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com

Patch: [f2fs-dev,v3] f2fs: wait for inode record work before clearing ino bitmaps
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1155979
  Lore link: https://lore.kernel.org/r/20260902090611.564876-1-qiwenjie@xiaomi.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
