Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB006079D4B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HCgpZtXy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SVTafEuu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Md+oN+A+;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feaXNRN6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IHA9soufQU+KKgtodhguMnNefGQoei00TDiNBIJKuSs=; b=HCgpZtXyIVF5kzRAe3Bo1xtLmu
	yo0QHwUeyO1qMmWN2Y8dt/nyWjgqc5jMcNrXyA+H5766QW+M5YHGCyWeiRdqZzAHwRDcOfu61luMG
	TanldIdZvtGVomZZT6MagZVlhgXumfIur6TcMqj+jr5307Gr83+6ao0vfgI73ZRYSD/c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTQ-0005qv-Jw;
	Mon, 19 Oct 2026 15:40:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTB-0005qX-S8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M/1xL3MZm11GXw6WpzAR+JIoekgCzKK4tfebFii+FC4=; b=SVTafEuuBGohc/vic6ZACHXcAu
 YuCbQ1L6TOUm3X5aS4OnG6YiUGMkD5/9E+NRxHGGxz57Qqgwci7PpKqM6yJSc4CO52S++QJ0B5G0/
 3LhCLPc0854WXZlLq9v5JgYUMMPfNWSII4POLjXuFDYSogxE/MCq8jhZgOeESR2dv2rA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M/1xL3MZm11GXw6WpzAR+JIoekgCzKK4tfebFii+FC4=; b=M
 d+oN+A+IyeNXeIIGhjsoWDSyAYdMROaBjxi6+i2lQejXHGEVNadXz0mz3/OzE6oBIEOWLjDkctLd9
 tlldybDJ9nyrzxoid5+QviHbvoallzkaybg27NcC+71aa2JYR1Goa0qmW+D3WB5hD/sXS54OyW8WT
 zaVBAsP5xUd6+oAY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTA-0003jQ-Bf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 017D94098F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 15:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD5A1F000C5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424406;
 bh=M/1xL3MZm11GXw6WpzAR+JIoekgCzKK4tfebFii+FC4=;
 h=Subject:From:Date:To;
 b=feaXNRN6hNtAMdWx2CEw+hEWGp6q0IiWYJAPsPfUPFwHU1fdn1O9J8Qq9IDz/Z88z
 uKLn9xWDrA7MqQq00YODbfmQRVdKPPthgARi5zt3yG5hvzlU3Bc0CxZ5MonrNuaUnG
 r23GWMNxPAUiwms7x/6wZJFikWgcq8x18uhXPnRWlDV740opc/JeJzZ74l1qHpDj4O
 5OrQhOa4hQXmdRq93aZUhYliMftXcp2WHVYaOgTejC6Urt7O2hlj7PYMqLAr9VAYep
 jcbmko7/4AiJDusoLPpF3nyvYNZuWsqBWm0fgUIwKorFW8if21NkymsEV8nC7UtVg/
 HZomhnGGH25cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B6E673811A71 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 15:40:06 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242440532.2714099.16666625084599954182.git-patchwork-summary@kernel.org>
Date: Mon, 19 Oct 2026 15:40:05 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTA-0003jQ-Bf
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
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: [f2fs-dev,v2,1/2] f2fs: use BIT_ULL for mount option bitmasks
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1162990/
  Lore link: https://lore.kernel.org/r/20260911143549.909867-1-daeho43@gmail.com
    Patches: [f2fs-dev,v2,1/2] f2fs: use BIT_ULL for mount option bitmasks

Series: [f2fs-dev,1/2] f2fs: flush SIT journal during filesystem resize
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1153284/
  Lore link: https://lore.kernel.org/r/20260828141240.2391915-1-qiwenjie@xiaomi.com
    Patches: [f2fs-dev,1/2] f2fs: flush SIT journal during filesystem resize

Series: f2fs: fix online resize state
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186974/
  Lore link: https://lore.kernel.org/r/cover.1792116883.git.qiwenjie@xiaomi.com
    Patches: [f2fs-dev,v4,1/2] f2fs: flush SIT journal during filesystem resize
             [f2fs-dev,v4,2/2] f2fs: refresh pinned allocation boundary after resize

Patch: [f2fs-dev] f2fs: don't use truncate_inode_pages_final() on live inodes
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186638/
  Lore link: https://lore.kernel.org/r/20261015161714.1586334-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: fix submit accounting for IPU writeback
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1185497/
  Lore link: https://lore.kernel.org/r/20261014112629.59861-1-jsjlee1020@gmail.com

Patch: [f2fs-dev] f2fs: zone: fix to don't fail to grab GC target block on zoned device
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1188710/
  Lore link: https://lore.kernel.org/r/20261019090032.1170825-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to avoid potential reference count leak in do_garbage_collect()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1186864/
  Lore link: https://lore.kernel.org/r/20261016021737.4121867-1-chao@kernel.org


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
