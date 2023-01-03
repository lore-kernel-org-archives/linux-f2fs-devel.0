Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E4C53210
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jan 2023 18:50:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pCmMm-0001KW-CB;
	Tue, 03 Jan 2023 18:50:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pCmMj-0001KP-EW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 18:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fRBmHQQhL9qSurZLLoVztwPAyki2TKqFdML50yCzWR0=; b=hPRde51dT7yzsnX3OYithJOGav
 Hua5IkdvAHL6SGyl0TrG8oZSFYz2A/z92l3IEpzFIG6D8ROopygAh+P26AulesX51PPJNpwqrSbc7
 JKEqwFtE9c3fSdbfwQNBKw7zrXOomhFWKt4qpzxMrOCPoCNqFR682MwVtaOGvEzPLzm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fRBmHQQhL9qSurZLLoVztwPAyki2TKqFdML50yCzWR0=; b=G
 AzxFv+yqpTSAkRkNspFHn3/3iWMnkoqVOBf1IArTwUQn3xlrbYTfhhD2KCqV8f5inreqgQYEfN0X6
 Lu+suaOh3PRKh/yMt9i+5TBXi+BoauY2FTOFmKfxw0mEyIw6DiLskwhY05ikSzkjFgZU4tlBXvXGt
 0sz72ONxAIGo8eH8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pCmMi-0003vl-Tb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 18:50:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1FFFC614CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87EFEC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672771816;
 bh=+uIU9xfkcyX7RWNnAFD5cI8hKU1cIJSE0Mo1RpDDqe0=;
 h=Subject:From:Date:To:From;
 b=DUbxhG5mI52ehtu6H2GbMCLYe1i1UmFxybPUDE3a2B8pNJjeBEdnLkP37bEHqiuYX
 NWFI3mXkzFfnkY95hGhhbgzxJ+IIP36FHUgV3HuIXdRhTsKCjZMx/jEvmjjKTjssKt
 U2z0fhn8HiZ4+aBJhUvRmjW2DtApEzqsfQKWDS/Te8Tz02iRCZDK6vzQUdK6x/3vrl
 vd8Zq6l1UndFoGrc51n6iurFYE0OwpNhRMcs/xLXNjU2uUjF+PLnQK+ZRtPYuZ3sRf
 Miuuxgc74ajVqwLehIAh/oYv0o4xk7ggKtfrPKEW0zo0VMLGzFKQprYGhRabCB8hL5
 RMarBg+ec+o3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 68271E5724C for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 18:50:16 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167277181636.18849.2830383185297660901.git-patchwork-summary@kernel.org>
Date: Tue, 03 Jan 2023 18:50:16 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pCmMi-0003vl-Tb
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: fix per-block age-based extent_cache
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=705293
  Lore link: https://lore.kernel.org/r/20221217004659.2092427-1-jaegeuk@kernel.org
    Patches: [f2fs-dev,1/3] f2fs: initialize extent_cache parameter
             [f2fs-dev,2/3] f2fs: don't mix to use union values in extent_info
             [f2fs-dev,3/3] f2fs: should use a temp extent_info for lookup

Patch: [f2fs-dev] f2fs: let's avoid panic if extent_tree is not created
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=706609
  Lore link: https://lore.kernel.org/r/20221222235458.957816-1-jaegeuk@kernel.org


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
