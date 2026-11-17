Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA97606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=baSTDip2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dlc5zb9u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gkANj5BN;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZZzJSDi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cJVUfFwsHKUhaYONUDyZi0uOC1g6ErgyC1ZHksp1xeI=; b=baSTDip2v+zfNg2LKr470MW7rX
	rdgzDT3f+77JK4vJFbDd3XwyPXdE4FMoRGUrzEka+uQGnw60ZTVesodhlMHSEjGmhq1sia1u0uPxy
	j0x0JmqzYcZwukUhORejrKI4imQx1I92fp4+jFl8fTD1xHaURNtBbW50JNg5EoCEEcWk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTMNv-0000000067v-2qRY;
	Tue, 17 Nov 2026 16:50:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xTMNu-0000000067l-1HUw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mo8ksUtwGwHjoo0R38txcsvmuLH11c4OuxzXhe92/z4=; b=d
 lc5zb9uSOgdED7P1r/daR/Kd6Q6/N3/HTEAhiKcmFBdPwE+CzgyCVrjgsp4wGCMQsCRKxxphxSP2C
 r8fgoRii4/bb3k9JIM67FhY30xQlr54X+KR1xWd9+JBHNS3y/ScZIzZ9TEVkwkR9Gsb120T4CVU2n
 24yn9C4lWP3upmdo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mo8ksUtwGwHjoo0R38txcsvmuLH11c4OuxzXhe92/z4=; b=gkANj5BN+eu0U0OsFY3SwDM5Py
 6U40l0G8v2QkY6TVvIAba4ErzpNWGDXbjT3YRudsyV7ixpONOLJRB4q3NO5KK4EGfXSdSORcZOS4i
 z/f1Jgl23cBkX7lRsSgyiePDPWzRvu47tttYBhBkvNF7QxF/O/yHKvwNx5C747z8gjuA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTMNs-000000007Mk-1dRT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74FAB6191F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4621F000C5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794934210;
 bh=Mo8ksUtwGwHjoo0R38txcsvmuLH11c4OuxzXhe92/z4=;
 h=Subject:From:Date:To;
 b=bZZzJSDiJwICIJ3MbGhPT06dSvuirOLgZD3UaK0c6yFONO92HDLSCXy1Q+ifExPZL
 xVahOUY8g3JQW4fVwkUtxMSrgJ/i4hj2mb/Xsjy++vn3ISSilePVJBc4uKX9rUstuH
 W9wmVP14jZpAspz+Lgytq/dJeCMqm7tKU+QBfQ79jV27t8RbzVebXs5raHTC2jT39U
 4/NWfTHzzHNSEQfR/Ut/xcOQZ9vQLFplgst3Xg2KhfAQPyeyrxHZa6f5G9jM3EZFRE
 84Ij1I2RXEw138OAuPK6eLccfQEJXhLPFhGSH1rXizMAjbGPNxVx/t802Z+CSGh1pD
 bxBPgcSA4dldA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F3B5B392706F for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 16:50:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179493420849.698822.11037008793194199735.git-patchwork-summary@kernel.org>
Date: Tue, 17 Nov 2026 16:50:08 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTMNs-000000007Mk-1dRT
Subject: [f2fs-dev] Patchwork summary for: f2fs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: f2fs: support block size smaller than PAGE_SIZE
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1212264/
  Lore link: https://lore.kernel.org/r/20261116040851.2849696-1-daeho43@gmail.com
    Patches: [f2fs-dev,v2,01/20] f2fs: use block-based index and size calculations in more paths
             [f2fs-dev,v2,02/20] f2fs: support subpage block size superblock and mount
             [f2fs-dev,v2,03/20] f2fs: extend f2fs_folio_state for subpage blocks
             [f2fs-dev,v2,04/20] f2fs: support subpage blocks in directory operations
             [f2fs-dev,v2,05/20] f2fs: convert inode dirty page counters to dirty block counters
             [f2fs-dev,v2,06/20] f2fs: support subpage blocks in data read path and GC
             [f2fs-dev,v2,07/20] f2fs: support subpage blocks in data write path and writeback
             [f2fs-dev,v2,08/20] f2fs: adapt range operations and mmap for subpage blocks
             [f2fs-dev,v2,09/20] f2fs: support subpage blocks in pinned files
             [f2fs-dev,v2,10/20] f2fs: support subpage blocks in collapse and insert range
             [f2fs-dev,v2,11/20] f2fs: support subpage blocks in move range
             [f2fs-dev,v2,12/20] f2fs: support subpage blocks in defragmentation
             [f2fs-dev,v2,13/20] f2fs: support subpage blocks in swapfile activation
             [f2fs-dev,v2,14/20] f2fs: support subpage blocks in fs-verity enablement
             [f2fs-dev,v2,15/20] f2fs: support subpage blocks in atomic writes
             [f2fs-dev,v2,16/20] f2fs: preserve inline data in subpage block mode
             [f2fs-dev,v2,17/20] f2fs: support subpage blocks in online resize
             [f2fs-dev,v2,18/20] f2fs: support subpage blocks in compression
             [f2fs-dev,v2,19/20] f2fs: count compress cache entries in pages for its memory limit
             [f2fs-dev,v2,20/20] f2fs: enable subpage block size support

Patch: [f2fs-dev] f2fs: don't BUG_ON a missing orphan inode at mount
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1202685/
  Lore link: https://lore.kernel.org/r/20261105034419.2701443-1-zhanxusheng1024@gmail.com


Total patches: 21

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
