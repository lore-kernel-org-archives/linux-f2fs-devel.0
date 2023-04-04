Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3E4C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 01:54:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjVse-000891-PW;
	Tue, 04 Apr 2023 01:54:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pjVsd-00088v-3y
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 01:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Mhbt2wvzf0g+E5CENpKeCU37FL2PozJN74UkhE+DTA=; b=PByb+ihHZFOShFFCXOqBaITRia
 omP01Mz+j5z2B19h6zRUATIDKtWIJg+Rs+kUGz04IttIHtnRCyZka/FDoz4FiICYzRijXR9+fXO2F
 PSLX6sXlEBaD64sT6UmgYxXMkJVIWls2/bGcftYJy7oQyb4AetAiKwc93pP7yUHJAPLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+Mhbt2wvzf0g+E5CENpKeCU37FL2PozJN74UkhE+DTA=; b=D
 cGTz66TOGG+VH2I9+ssg/fCBqRqffMQjDGwVKVgbMFYOYJYsgW95ykfidaMmiHnoKcux8S6pqhCZn
 qQ1J9iau48/JSAntF0MYkzHy6BVZo4ZMDV0tWXGULjPEj/UgrdhgjG5z8840GCRSrcwQG/+ethJrP
 4MXfA/EwWI5dzi0U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjVsb-00EBZ8-MA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 01:54:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D82C6231C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 01:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC00C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 01:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680573271;
 bh=rTtSntewwRy2d0gFNn5CgjPRvqIwUgDo02YFvAmN+c0=;
 h=Subject:From:Date:To:From;
 b=QE31bJShCZh8jGCi/7BJYnhBgF5NgLIc0zLSwCIloS3lJuMOqQyfgXQm0/dwJOJ14
 EMpPqHFHuF8msFD6J7A9dLHfZ9WSCh0pfh/eQCXpTNb3JWdWKBeO9wUDcJNJcWoWSg
 nmacXYLhciwB/VQHQSxWQDtVv4QNCyAIBjoI9p+Y6GwwsvBSRAHum2myJEuvPtmAik
 FxQbaHKh/QnejKESDAT4aknGymD4F1fHIYEd1wDCRyPe7srwpBowkBA04OAcJ/hrM5
 fwE5MyrU4YdOUyR+bgxeiWj60EU6bIfpp+mUCIRTbj5kYDjCPQD0cfuVvbp5Qv7WE7
 6VTBN0fOmU1ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 6C6DBE5EA86 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 01:54:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168057327144.21470.7835132855396344932.git-patchwork-summary@kernel.org>
Date: Tue, 04 Apr 2023 01:54:31 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pjVsb-00EBZ8-MA
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

Patch: [f2fs-dev] f2fs: fix null pointer panic in tracepoint in __replace_atomic_write_block
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736473
  Lore link: https://lore.kernel.org/r/20230403165038.3018949-1-jaegeuk@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
