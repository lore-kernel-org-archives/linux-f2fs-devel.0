Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D27C48285
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jan 2024 20:50:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUv42-0004Eh-G5;
	Tue, 30 Jan 2024 20:50:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUv40-0004Eb-Uz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 20:50:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F4MeB32+15HrjUU9YOAwkRxjucKQULdSJ58XyvOwjiQ=; b=RTtHGC4Ioo1/nzGya2ZSn/YVzo
 hDTJzFX/j5g40+LbSG64sJke0ikgu072zqptPGC9/pnQVNE+oNu2OubZVoTH+Ar6AU5cymIA+kw2P
 Yg1yNlqp0HExTZmtd2GWbAAJvIjIWdE5cQ8HuSFjUdekl8hVTNUovIAgmHhTdZnQ5NRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F4MeB32+15HrjUU9YOAwkRxjucKQULdSJ58XyvOwjiQ=; b=A
 J/2C6RVjK4z0YTA2PuvaLx8n5ocMvfODFYrgRZnOWAsNAQuoqiH53znvNlku6ml8KgWYdxltKzLlG
 27UAZrnzSHHwtjN5fWSi+4Uq8x9y7/H2vqoJPogU5oDdyknL1qztlDWOUpKAS8Tj+xlELeHUz2//J
 3aZDEJSWCGCTiVRk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUv3w-00016W-KE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jan 2024 20:50:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 86F0BCE1CC8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9170C43390
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706647825;
 bh=T1TAjXzYQq1aQ0+p58r2occVjdNEFVC5IzLypzVnWPk=;
 h=Subject:From:Date:To:From;
 b=U0vFIsRPDO93v+If4eGLwMfeDMXS5b72pP/LbB/1g3bGbxieRRK+pIiCFLp5bWhOH
 ZxHhnHVcM9NHMgQOjVefIfydOyiqtltEBu02cAh/ZPwwzk3zISWcq8nsjU+e9GblPr
 jKyPQc9bcFQj3A0GFoNR47N7x/xDLYEqZ8NrW5lGVbLLLKSge6JZFA7CoEPSomlugz
 OelImRJgfWdFy5v/M/kgE7oVxX/8E+M+laZpk1aLJLQXWPHRH6U4cZ7Lts5YlFiKcp
 lGe8dkdFQHYBf5glKbayrAVlFs3XCYNyFZDo/iIYTjHG7fBByFYOdLBb7cXbRP7p93
 wWywC6tniR+Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B597FC4166F for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170664782574.32692.249143676066278948.git-patchwork-summary@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rUv3w-00016W-KE
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

Patch: [f2fs-dev] f2fs: fix to avoid potential panic during recovery
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=819529
  Lore link: https://lore.kernel.org/r/20240124144915.19445-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=818421
  Lore link: https://lore.kernel.org/r/20240122022313.3054810-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: use IS_INODE replace IS_DNODE in f2fs_flush_inline_data
  Submitter: Zhiguo Niu <zhiguo.niu@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=817423
  Lore link: https://lore.kernel.org/r/1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com

Patch: [f2fs-dev] f2fs: compress: remove some redundant codes in f2fs_cache_compressed_page
  Submitter: Zhiguo Niu <zhiguo.niu@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=817720
  Lore link: https://lore.kernel.org/r/1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
