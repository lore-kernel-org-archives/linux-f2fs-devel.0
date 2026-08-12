Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AFDC5CFDB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D4qyvigSeH37NCLaHnCnZG4s5RzPwahJX8fwkNu6dgo=; b=Pv1q42o9ypLFKn43PRVSrCV2K9
	sEpIHA4sb0e4utZoteoLYoiqU18PZGvOnvko9kn3LqthZE/uexLPw5wudb3sIOEPGBTGScpwAXeSq
	rBhGncgxP1ILMWk3h/YbF0MWM2blUCe8+FSk9219le54iwbewmNvD+RDRwSsqkKBy0YA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuFbR-0004wW-Af;
	Wed, 12 Aug 2026 20:31:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuFbF-0004vy-OW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CYjAoy8BP9E3RlYGILPY3F0ow1kY9HQCCFMfpBG1Ajc=; b=j5HQlQg4YisqJDWGNC+wMR2vDN
 lMuIEqodcw/L6VsMT2jLEy3eMEMpNt2Ex3uRHFl0/dynlHxCNUl/0zrTzT5lPG5LOigUPNgrq3ch2
 mxN9gQ0isRqhBuoobeS23Pg3bOMNFp9ukaRGlyC1vdwI5V0RVDik7nrXJ3zqmH38qpgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CYjAoy8BP9E3RlYGILPY3F0ow1kY9HQCCFMfpBG1Ajc=; b=G
 ELOSABLxxzVfR6GPUf/vl/wSXl97WjT3BItgul2CLybLO8tKlMZ9EeR+fGX8Rbaazja/ZN9Ns7zrB
 a6Z2anV9CxDukXF24VQYijPN7B6zY57ZSt3mamG6CnsC2JZuRNBrsk69+z5jiMJaGNhEgTIANZoGB
 XvxbEkfoX7W4AG/c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuFbG-0004xS-3n for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0245F4045A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 20:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE751F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786566648;
 bh=CYjAoy8BP9E3RlYGILPY3F0ow1kY9HQCCFMfpBG1Ajc=;
 h=Subject:From:Date:To;
 b=WaspZDJ4voLpBaNBBmkYKrkNy1p6pPCvoxzZRW8YNNgNX3OgCqCRDm49Fx/rlYe5I
 seOrGj8kdnh3rkaiWSpEsYHE/rifvRTqpHbpNN9MjVeXK2fAMZsikShGmBsy10J58X
 SxBJM/CPeKRAjLREE4KP4GQ4JX/RVYiJ+PbkaWCZdbWQYmSKCR6Q/44sKdcxJpYwus
 zhpR2GFL272HQf4N3+1YmZ98Xu+fk6NbNc5iJqABcHgyHNFuEEsG3BQYU9lwyBMy3D
 PMwRlQDEMl+TA8Qx9KO/0PgxYD7sNTDPmEClYXiXApdnwwYsAGI2PuzYL0EVkKQ10N
 FpvljeRe0Q8TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 590F1380CEC4 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 20:30:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178656660380.2090005.8163548606146451164.git-patchwork-summary@kernel.org>
Date: Wed, 12 Aug 2026 20:30:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wuFbG-0004xS-3n
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

Patch: [f2fs-dev,v2] f2fs: return symlink writeback errors
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1143427
  Lore link: https://lore.kernel.org/r/20260810133832.3530016-1-qiwenjie@xiaomi.com

Series: [f2fs-dev,v5,1/2] f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1143911
  Lore link: https://lore.kernel.org/r/20260811071637.4176024-1-chao@kernel.org
    Patches: [f2fs-dev,v5,1/2] f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
             [f2fs-dev,v5,2/2] f2fs: fix to zero post-EOF data when extending file size

Series: [f2fs-dev,v2,1/2] f2fs: unify add/remove ino entry API for all ino types
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1142808
  Lore link: https://lore.kernel.org/r/20260809012639.568485-1-chao@kernel.org
    Patches: [f2fs-dev,v2,1/2] f2fs: unify add/remove ino entry API for all ino types
             [f2fs-dev,v2,2/2] f2fs: reduce memory footprint of ino management


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
