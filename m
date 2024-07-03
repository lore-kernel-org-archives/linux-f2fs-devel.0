Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9E6C2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:20:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sP1mn-0005ZG-HR;
	Wed, 03 Jul 2024 15:20:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sP1ml-0005ZA-Rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jul 2024 15:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mHIodGXxvYX1U7kJGE87AFGjoBF9wX/Y3HVHEaoehrs=; b=c+30i/QAe7Ut/GCZrgdsUdZ5Dn
 wPE62EgapACExEL4zZpM8XUlqdRztTimlxiEmw+xULzFyEFcv4nKlUtlraiSrU8E6B6y6SLs2dw7t
 v8agRAG621U3Ac8snuKPXIF3nlkO7V5fCV9N1FQXFb0tgwaWFH67zX/dONWWQsZ2jPdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mHIodGXxvYX1U7kJGE87AFGjoBF9wX/Y3HVHEaoehrs=; b=K
 70qveCmZBG2OWNqsMKQKknBRRtXw3IvJKsU3JhpC0MQkSt5dDsJGjPYOplqAZ+3vEIm0Kufsglvwt
 oOqVOFry25V5n4rtXOG2bYAQtU6iQrxhQI7te4uG5cc6ua/1IeSxg2dvvHPGQMJM02s9iCYFVvr6E
 XblSp41k8Ew+aSCk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sP1ml-0000Xs-Bm for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jul 2024 15:20:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3A96A61245
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Jul 2024 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E41A4C3277B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720020031;
 bh=B+/HWX5blK8vbrFlYvCE4rWfpG5BAg6SKCYePELSTbE=;
 h=Subject:From:Date:To:From;
 b=omnv5xwoCtqM8QYDn9/XwH+D86T9hvlEzcS9TN8adHynRJTOvjetcorXcKdlSC3eY
 WX/LooYi/xNE1LQXB4/5z3vP6g5BZTICnTbq4T9kJOV0VCiSyLfWAL31BcX08flrNs
 XYm69eAIhAZ+5MZQMf7jVm7DDuWABYGeK1eqsBuD/Ifrx3EMgV7wQEdJbYOGZU6KYx
 aSO0EiKrilJ2sCjR6bNCgjQ3yhBdSPEJ+kvhvS2euaNp7hMOzKvVhGlg6C4iz3tDaO
 mKkLilCh9sppb4d5abv+uhmKxsLIEDAAOecIK6D8RA6nTyEgTQidJ/Y+yk/r0gXTCS
 KDpw3qEJ2rgMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DA90AC433A2 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172002003188.26849.4350551957733481351.git-patchwork-summary@kernel.org>
Date: Wed, 03 Jul 2024 15:20:31 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1sP1ml-0000Xs-Bm
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

Patch: [f2fs-dev] f2fs: remove redundant sanity check in sanity_check_inode()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=859451
  Lore link: https://lore.kernel.org/r/20240606095551.4089055-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
