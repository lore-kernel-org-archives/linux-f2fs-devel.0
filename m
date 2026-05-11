Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9880CCD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=earbwZLWXCe96Wcw+KhDlmSAaimnphd0H3CNdQNv2vA=; b=RtPuwBBf/4oOOJM/zhURfSxK8k
	OF+EE5P56JFbE5sKeKkJSxWM4L2tpfFqtqEYtpDkxe5KKKT7HICy32YdDyRe5S9rRxRn88F1k7zBq
	XPvyMGSnqrp0NTer3XOFk3TCH0K/Coc6OizoRPhhjRD6schCqgVdnmJKX/3tu+SeGX8s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFeu-0000AH-CL;
	Mon, 11 May 2026 01:42:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFet-0000AA-96
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P8DpxbjPimrv1z8Oh5giGaFBGk/s5Bep95NZg0wt/Os=; b=Z50JQE1tEMrzbcS8Cd4TFh8d4x
 qP/R7H5uBIp9BiNutzDii9xGQpiV0lTNC23W2/6p6tcUS3v/u84hJ2+9BFyJUJS55IjGGL0DXm87Y
 7yxyCtPw51vcr2/kxTToSz7IgqJkXjYRSjrW0dQNo6Ch+DljkA+Yvru9Nn1hXc0DUtGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P8DpxbjPimrv1z8Oh5giGaFBGk/s5Bep95NZg0wt/Os=; b=e
 9MRafoSOApwPAOj1SWEScUeb/9XeaqR0ypREkG6cjU47XS2COu/z9NLYzX5lJQoHjvbQFa4O1jclK
 xqGd310SNhQ1lv3OVnNSWQ0sBWNtePtUTXquQIEJuv5OiS6ny6EouEo76IopnO9emDDZW0t4n5HSb
 +pT1V5NFMacE4Q24=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFer-0007BG-Pn for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7334C40BCE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EAFC2BCB8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463719;
 bh=v/dMyBo66i5+kx1FTnZDGnElSmIM/LQknL3HtYk9VHw=;
 h=Subject:From:Date:To:From;
 b=RCePcgs9xL3an1zQeZT5OTlJC2fo7TZFjLn7rOjE5MzbS4qp9oPrXr092sjv3GmYU
 fQ7REzXApY1spsCJSISm9EKujhQlK9R6VaBke3pcBHT0wNwt/Zvo+kWwEVaQ+8iGkI
 EQbHllXpFWwFFruJ1XuWZ84OxWq9K3ah6UFQ8lbGjox13IbxBGWlCvxM5oFH0qjO9P
 Hh22AkMhQCEiMGdaXj3sC4JQjgqterugC7N9vUhvDQiBoZHxMEqcoa1jB5Y5uvK/Jg
 Col98P+3TziQG/BeDiThIuSJ6gBtV4ShetQMtnskkZGasd1pyE6QitcV7nXiSBhbPb
 qaWZGG4CWPi/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7F95D3930039 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:41:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846366608.1975880.15837937421181738940.git-patchwork-summary@kernel.org>
Date: Mon, 11 May 2026 01:41:06 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wMFer-0007BG-Pn
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

Patch: [f2fs-dev,v2] f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()
  Submitter: Yongpeng Yang <monty_pavel@sina.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1086137
  Lore link: https://lore.kernel.org/r/20260427131050.1526593-2-monty_pavel@sina.com

Patch: [f2fs-dev] f2fs: annotate lockless NAT counter reads
  Submitter: Cen Zhang <zzzccc427@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1089901
  Lore link: https://lore.kernel.org/r/20260505125510.1369132-1-zzzccc427@gmail.com

Patch: [f2fs-dev] f2fs: annotate lockless last_time[] accesses
  Submitter: Cen Zhang <zzzccc427@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1090196
  Lore link: https://lore.kernel.org/r/20260506010709.3287111-1-zzzccc427@gmail.com

Patch: [f2fs-dev,GIT,PULL] fsverity updates for 7.0
  Submitter: Eric Biggers <ebiggers@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1053337
  Lore link: https://lore.kernel.org/r/20260212012652.GA8885@sol

Patch: [f2fs-dev,v3] f2fs: fix potential deadlock in f2fs_balance_fs()
  Submitter: Ruipeng Qi <ruipengqi3@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1088785
  Lore link: https://lore.kernel.org/r/20260502124157.3406780-1-ruipengqi3@gmail.com

Patch: [f2fs-dev,v2] f2fs: initialize ino_entry_info before checkpoint load
  Submitter: Deepanshu Kartikey <kartikey406@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1092169
  Lore link: https://lore.kernel.org/r/20260510042336.94751-1-kartikey406@gmail.com

Patch: [f2fs-dev] f2fs: doc: fix the wrong description for critical_task_priority
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1084283
  Lore link: https://lore.kernel.org/r/20260422104847.11243-1-chao@kernel.org


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
