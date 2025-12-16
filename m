Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EF0D609D7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Dec 2025 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KBDbpuJZT49D8HioByjsLvxFyhlgtnA5tI+OsdlZVak=; b=O1pUVt3UuXCVDYqc5N/+WHBDMg
	I9+k2ldUFckioqAtsSvOeQKSYwR6Rd+RNp+4zSugQhRs903tlMARGUpw1YyqqanUrWTdt3sFYtnDA
	pH7LBOdREdnlzIzBYvm/UURZrw7ZWS4POiPTfp8xw33xNqWL9VaWlP5wpxgslbbt4iAU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vVadq-0006tQ-QG;
	Tue, 16 Dec 2025 19:23:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vVadp-0006tK-Cc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Dec 2025 19:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6uCaNsP3vl0m60975CpBTHh9PY1AzVuglcgh29ZD70c=; b=idQ3DBp3dRYzMjKaETWdhydUBt
 wJLyiYMSDMGlL+frSqQ2A5UHjZ0U301itIDawM5z/56qTOI2PzMmxVIxR/bOwpyuERTv7+zxBgCTX
 hTX75/duIAOu+drtFd8AAGar6B8dr+yhBKrGh5UAshZMCpjljTWHeJAi3vGCpTdhz5Hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6uCaNsP3vl0m60975CpBTHh9PY1AzVuglcgh29ZD70c=; b=O
 ihpCpMuDERJo/kv/6GutlriYmqqyK5WXJ3iKqDM0o4BhyGrUnCccmS725fin62rcQWTFSfloY1/Gd
 RA66ldF2p3H/5i/pX7CBHj6y3+Cr0AlA/GkQ+IbOXT+UF+QjB69wXbVPBj3ssdOJCIevrAbbD6+ps
 d/POb8Ooi6NNo4r8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vVado-0004nQ-L2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Dec 2025 19:23:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 346BD42A26
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Dec 2025 19:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EA1C4CEF1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Dec 2025 19:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765912994;
 bh=uAJN7GUVHTb2glmlxYwx9FBcetXWtCszA+Iw2//R5DQ=;
 h=Subject:From:Date:To:From;
 b=UnJUaEtC8OOQajZrKNxPFVBPWEWOSH48IwOeTnfax2U0UdsU6iRSiZ7A6a4scuFyB
 bt3qwESsfA+Ss4TStg1TOGG9161KIH8ogjS49jUOXQu5G6db457YhXZXhwxzBtUkjf
 NAqYJjEewqTfFtzsd3rv959yv199UAhPS6rTkyKJOJVssunvftbd291d2QVIrxH7nU
 rICeneGh72WbvbkITcCUl5KHcLj40jMCTu6g5Mr7G+gWbqvD0oCtcYxYLdjVj5t1dw
 IFsvGMN67uPZ0UU9465G6RBKSnkiX0chago2KmyV9MB1rfqfsN+BJ6VUqIPq1KeduX
 AiGgAOKdbetTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 BC5303808200 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Dec 2025 19:20:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176591280438.1247282.17036154063099690532.git-patchwork-summary@kernel.org>
Date: Tue, 16 Dec 2025 19:20:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1vVado-0004nQ-L2
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

Series: [f2fs-dev,1/2] f2fs: support large folio for immutable non-compressed case
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1026070
  Lore link: https://lore.kernel.org/r/20251120235446.1947532-1-jaegeuk@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: support large folio for immutable non-compressed case
             [f2fs-dev,2/2] f2fs: add a tracepoint to see large folio read submission

Patch: [f2fs-dev,v1] f2fs: improve check for enough free sections
  Submitter: Joanne Chang <joannechien@google.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1032585
  Lore link: https://lore.kernel.org/r/20251212084034.2878836-1-joannechien@google.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
