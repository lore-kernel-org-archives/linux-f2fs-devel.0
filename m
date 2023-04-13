Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7376EC77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 23:40:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pn6YG-0007m6-CN;
	Thu, 13 Apr 2023 23:40:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pn6YE-0007lz-J2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9YqjZjhyZYm2MVBkzTBBI4NdLNmUNT1JQOKs9R0ubR4=; b=nLPoVpK+7lqSJ/8hWV8bTp2AiG
 9xUGJaieAW8FBvdeMRC1bxMMc7XWsu6mRp4cQFbn3vOoCvzuenu5zOrhO6vyIOXvAdh3CgC+uicI1
 cZle4dEMfa00FJbFLt+08uJb8o9VAsvLtbXVMc94akWOD53gW7UUXQP4DS+6Io5zbebs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9YqjZjhyZYm2MVBkzTBBI4NdLNmUNT1JQOKs9R0ubR4=; b=e
 pEpfehXnAKKmUVpCxDKNbqb8VMyzbas8KuJ8aE2bTfVQ+8kd5RlGbWGhZmGeKwbNgfQ93BRgJBbx0
 UhR5e2au0fbWnpbO2Wql0y5yQHYy8ik61xmZu5FGzy9zvxQYbzirZrqwBCD3jpRzjioTFGqCqlIZZ
 26efl+Z2utzYZYmE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pn6YD-0005Mv-0G for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 79F486097C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E99C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681429218;
 bh=aD83G0XVZg2wJVpPUlVolrwVdIXgn/fCf4lTTYkfKdI=;
 h=Subject:From:Date:To:From;
 b=Z7j5oICugjJnq5D3yHdpvGUkYPFjM2KGxymyHkt0w6ogsQBwRFy7JpsgXnT62IPTM
 lunSLeXFCP/FcycSW7nxd0Pz8bkniPXRGO8tOJxGDvygioQtPZl7Wy1BwqDHxb7ayA
 IAT56s0+0Q5v3b0MncXgbMOvzmt/JcLaJprhcVK1MRO7EqtfRNzPMyOptWCJZpvAkX
 WbXnjZdoDcFD+kj4muYubTbIlYxKVM7mGAQe2qQ6Tqz4IcQ+K89ivp7MLoXXhlRXr1
 zolLLfPgt6tdkSrT3L7B+Z5lFJLBCt7JYVPoJkg6Up9hg1NY7ce1WDJUydzJLsymYn
 TcpVRJJGQ8hJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 A3B31C395C5 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168142921861.31957.13374831617691006612.git-patchwork-summary@kernel.org>
Date: Thu, 13 Apr 2023 23:40:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pn6YD-0005Mv-0G
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

Patch: [f2fs-dev] f2fs: fix passing relative address when discard zones
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=737814
  Lore link: https://lore.kernel.org/r/20230406221104.992322-1-daeho43@gmail.com

Patch: [f2fs-dev,1/1] f2fs: support iopoll method
  Submitter: Wu Bo <bo.wu@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=739447
  Lore link: https://lore.kernel.org/r/20230413101711.13682-1-bo.wu@vivo.com

Patch: [f2fs-dev] f2fs: remove batched_trim_sections node description
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736850
  Lore link: https://lore.kernel.org/r/20230404143832.18234-1-frank.li@vivo.com

Patch: [f2fs-dev] f2fs: fix to check return value of f2fs_do_truncate_blocks()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=737261
  Lore link: https://lore.kernel.org/r/20230405144453.930311-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to check return value of inc_valid_block_count()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=737262
  Lore link: https://lore.kernel.org/r/20230405144536.930370-1-chao@kernel.org


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
