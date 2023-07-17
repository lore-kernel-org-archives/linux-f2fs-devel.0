Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEA9C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7I-0008T5-Uh;
	Mon, 17 Jul 2023 17:34:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS7B-0008Sg-OE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6q/q+dr/qzHlVsjymL0p5eNVXW8sRmIflYW61voSTP4=; b=ALwGLl2ZPb9vorvijm/qfnrU/c
 3z4FHweK4LsDQHafY/ZBtq7l2AeCm2O6ZdBIGDqLhgsroAm9WsdqYA3YL3spc7ilxuEMZlYTOnqO1
 jWEn3Ty+c+nbfeN/ix/xA2WGGPs9jDea+alwZXyUWbj9lqXZY308pkNjpl/jgEyts4HI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6q/q+dr/qzHlVsjymL0p5eNVXW8sRmIflYW61voSTP4=; b=J
 F9mB4l0oqCIMOUd9RTRvS8a5+zcPAbPZhpFBU6WC+gCydOwhhEB//+GmXqUKjiqTg1vzvhEpZHtSm
 jIueYDVcIWKKyTXNesbYxzSBf8T1qSKycdf5Bgwvg4q8jA8XChTajknWp/B4S78DKaxysGqhJciDr
 +NQ8wTjeB0fArsTo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7C-00013v-31 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 66EF361156
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA43AC433C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615261;
 bh=A3rUMV5jg0pRdXqNOzyj3ML5GQDoNyrxqoapHuDC/TQ=;
 h=Subject:From:Date:To:From;
 b=C/HKeJU4+UEnHVbT62bUKlrrnNl7hzT5xjwcAaEF+iv00EGl1lghu2mgm75PhN5HY
 A2iWXU4AVo6q475mGGYu9EPeXhuP1VwXQ383HdH0q6i6QFng+77o/RAWO+/MUxoqJs
 wvXXZo6mmsuiqWBDFCNRTeMAEv4QeeCcTO50Ul0YLFWQ0roQKyJt7GiiO8mOLhzkQ+
 NT97BWdRfQkNCWp2uRafYfKbL4uW6f0yxoSatZmqOv+KAwkcIGxlux6rgD/nF777eA
 YjfRbBjYcdTPwypZ8pj9YcxiIIjXI4nXMZNkz6tc2kT6TSBQAQI8YU6R8pCEgm4rJe
 c1j5N15nh7VWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B3FF6C561EE for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526173.4078.18250961950728927873.git-patchwork-summary@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1qLS7C-00013v-31
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

Series: [f2fs-dev,1/2] f2fs: allow f2fs_ioc_{, de}compress_file to be interrupted
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=764942
  Lore link: https://lore.kernel.org/r/20230711200806.4884-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: allow f2fs_ioc_{, de}compress_file to be interrupted
             [f2fs-dev,2/2] f2fs: compress: don't {, de}compress non-full cluster

Patch: [f2fs-dev,v3] f2fs: fix to avoid mmap vs set_compress_option case
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=762894
  Lore link: https://lore.kernel.org/r/20230706020614.2950782-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: don't handle error case of f2fs_compress_alloc_page()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=763873
  Lore link: https://lore.kernel.org/r/20230710061058.2303767-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: flush inode if atomic file is aborted
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=763482
  Lore link: https://lore.kernel.org/r/20230707141142.2276510-1-jaegeuk@kernel.org

Patch: [f2fs-dev] f2fs: get out of a repeat loop when getting a locked data page
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=733326
  Lore link: https://lore.kernel.org/r/20230323213919.1876157-1-jaegeuk@kernel.org

Patch: [f2fs-dev] f2fs: fix spelling in ABI documentation
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=763853
  Lore link: https://lore.kernel.org/r/20230710052324.2857-1-rdunlap@infradead.org


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
