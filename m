Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EDBC6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 21:30:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjoEY-0005N9-CQ;
	Tue, 04 Apr 2023 21:30:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pjoEV-0005N2-WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 21:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=koToLaZdm7xVmR02lfBd1V//nKOoGFhxGgLdrPRLWEQ=; b=On1b4O8qnee4RK7Li1Zjq/dKnZ
 3Zf/iSqObIu4bPqf4cSa4vHS993EVDh4ZFF2kWFWDmk0kEFycrmIGQ6oEmDK6PfBF5fdZ5fYqknw1
 pCojhi9K6dK/hATB9z/J7DrwsgBt51t7uaRU2dGp3FgCyoeucaZ4NPhs+bRADaiBR1rs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=koToLaZdm7xVmR02lfBd1V//nKOoGFhxGgLdrPRLWEQ=; b=C
 Uh/+0cuA8hAhTqVqqYc7d0XSp+NPsYZI1ldh4G/6kxGYGW64r+X7RcYXvxXF31UnE1/3+piVBbfuV
 orDrlHSOkKXewatjeN/wQgYFGcAsgeK0n5V0aO+og2UJx3LA97eWcmDDVz3deM1v6ny5hYGzH5iLm
 3+yB10asLVERHPsk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjoEU-0005ES-Ie for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 21:30:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF7B6359D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA484C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680643819;
 bh=tLIGldmc6VJLJKhZIahXWVQun9qLKPKFj9Dz4Fg3ZHs=;
 h=Subject:From:Date:To:From;
 b=pW3n4buMDrxitdVV0PeDguoEuFSFM4AiIsh2Gcb49XrTUJWmqIpqGN13eAOZKVAh/
 d8fuN4Z7UoxFoBe6cDLfVmQlL/lhpJoQiVCMIXmzGZoiB7PHCKrTNgD2DxCNikLSfj
 Lf+Zr5o2b5YZEuwediLau8/1Efk96PoXtMs00hli4Sh9uq7IHZg8GNGjYHGREeciKP
 3g0gMevr1WSvFT8yVEKywPv7lyDLHyMSlVD91yjjRyBtCGoT1zCwRkvyNSf4slQ9BI
 2eTs4aC01g1yjuTo1s/++21/vTzLP3PgGUzrA5QwlJSXTCw+0W+WfMeZwnLE6CSH7I
 ycPcdktV3409g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D0955E5EA85 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168064381879.16246.14850843030360367320.git-patchwork-summary@kernel.org>
Date: Tue, 04 Apr 2023 21:30:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pjoEU-0005ES-Ie
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

Patch: [f2fs-dev,v2] f2fs: remove struct victim_selection default_v_ops
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736646
  Lore link: https://lore.kernel.org/r/20230404040051.50726-1-frank.li@vivo.com

Patch: [f2fs-dev,v2] f2fs: fix to check readonly condition correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736866
  Lore link: https://lore.kernel.org/r/20230404152807.4987-1-chao@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
