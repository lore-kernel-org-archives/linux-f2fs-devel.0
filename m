Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31DBC77B72
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Apr 2023 16:20:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmdCu-0003oU-2J;
	Wed, 12 Apr 2023 16:20:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pmdCs-0003oN-Mq
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 16:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sdBNlygdCKrNTV26EqU1Jtu11uQx9LUI7ydIwnB9f/A=; b=iWMwjX24KIGWmKv/MC+QDrB7jC
 4ERJXb7qVDBiQ/l/91fR1qENUH1M+8k4J3D1l+iP/2LRI8QGnxSbec6WIie4/afSpV8Z5yGBR1nFE
 WJ9G/gNJp9XNPwo7kFq11r88FG1toHQ+nl0+rK0cWmZrjPaTcuhBN03K8sJ0FuhNxR5w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sdBNlygdCKrNTV26EqU1Jtu11uQx9LUI7ydIwnB9f/A=; b=L
 oC3ML+U1hjDJivnf6S77HAUgJH89xms4/3pnUNZMUdmMsqxqSGDCS14VUjmxw/2POAZAE27SCAbKS
 wvDgEqYH+SIzHz26tgWdBKIeunILiHB2knQlbJHq+2hNFVzoKqF+4i+oB/1mNt6dZkn3AAgOHoTkV
 rFup7TNx2ca98mpk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmdCr-005Rkm-3l for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 16:20:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AE87362D59
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE34C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681316419;
 bh=xPPYnHcEpPPQG6PA/PeoPqtioT4B3ocE+l8u8LyDdQk=;
 h=Subject:From:Date:To:From;
 b=L4lPUXQyMLzPE9rAfkmrMzduPy2J//osjiKUxziMxrAxAWIS5OdGCaPO+I6FRNjvq
 W6jERIdzZzo6GubDboXCNhyW6HLuotXHY9EKJZ1o5P4dfjm3SUpWmvGiNxXlF6h8Zt
 W6iXdQ4dUy5vhmePtwBDlzQLrIJfKhZMM+IP7Bk5XMCnV4+DSKC8kAkxNwc/vNQXwv
 FewHiowvKKCiZ2aum90p0H1olwPvtykVflw1zwgTHTUa1qJ0vZGIwBT+e5a/L+dVzi
 MmuPDj1Dw+Z9Sl/f7r1RkHF05HhRGYfg9rEsuhKnRX5adQimHEpcGPMg9S59xBuPLP
 CtEnidCyhWKRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 03780E52446 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 16:20:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168131641895.15557.18168724829302263593.git-patchwork-summary@kernel.org>
Date: Wed, 12 Apr 2023 16:20:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pmdCr-005Rkm-3l
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

Patch: [f2fs-dev] f2fs: fix to recover quota data correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736173
  Lore link: https://lore.kernel.org/r/20230402112706.42211-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: add radix_tree_preload_end in error case
  Submitter: Yohan Joung <jyh429@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=734185
  Lore link: https://lore.kernel.org/r/20230327135800.524-1-yohan.joung@sk.com

Patch: [f2fs-dev] f2fs: fix potential corruption when moving a directory
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=737778
  Lore link: https://lore.kernel.org/r/20230406195122.3917650-1-jaegeuk@kernel.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
