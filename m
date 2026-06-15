Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FA6CD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oFIcc2ICHImQ/TkMMyap7mRley6/LYI4N1Bw32fXtWo=; b=bxYzzzVi2GvQ3C46ZOIwdBQZxt
	qCneJU1+0hMRoO+0yZeRhmoCxKO1jN6ToVVEGpbnuDzWcYssQLPscTzkIxBzCzU9nT9UfBf3fNAhf
	cET16KcyW/a2ENZoZpCWXTMI70khJTU/vb2bY2a4LyZwRhl0/KL48QKsbsX3dxJSLF/k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9Gd-0004MF-IL;
	Mon, 15 Jun 2026 15:30:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZ9GW-0004LZ-Oq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vHhA7MKdQh8rAtcegREfrfOuoxjtLSfqv3iYhxyv/Oo=; b=bYDson9pHmZRYxEjUDfKlBWPRk
 HmjbzYpWtZlA1SvISAhnE/38ZYaEZ6F/JbVV5h6T96kOPM5Axf5si903+tG343793rXmXADfS2GyV
 zJWZ18wFrS7ow1rPA3/uOESVRXU4pl25krTa9Qt/77mwYh9TtNIYFwvfd0GxyGZWBxfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vHhA7MKdQh8rAtcegREfrfOuoxjtLSfqv3iYhxyv/Oo=; b=g
 ViIsRKbNLMsEkH2MXFcxFAAz16XeXZIDr3ocKy8dEq4QP8ObTszV8uFec9fqlLt/Rl3O/Y+ICWevV
 7kkEVM6cCYEOYGbzBrygSkDJ+m1/cFb/h97Y0FBWc4gswO4ohJPvSrGEzrEGXaLYQROupAn3WK0gJ
 DnvT2U6mAp8NmdH4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9GV-0002uF-TI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8324D601E4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 15:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DD71F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537409;
 bh=vHhA7MKdQh8rAtcegREfrfOuoxjtLSfqv3iYhxyv/Oo=;
 h=Subject:From:Date:To;
 b=YH6AUJV5cKLc624BZoFB5Ty9zVjGjLaRgM6q9pJxGgRzeIvn4gslVpj3KZBux7Nsf
 NZFpwn68TWh+W+APA7mMSOUq84JWnA2YryizE9kTDYqfuj7hL5CIyWtDWos4GeTtHQ
 eK7unAX80IjHO4oBTeO6FioDspwU52TPzoAprsM6KeXf91Kcutxhd9Nk7ydHaEJRD7
 cwjjsdbHu8FTW525d2OAj72LL0dOI1svQUK+tG86v52KJgpE/jBY1C0Y/3lW2eRq1v
 d0wEQymMZdIpXgdAocIUSDcXJf7BqtxayzEXhlL8b9pB7T89wDJk9sEwrgtI7eRwxO
 /ykikmlH8kLWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 963093811A64 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 15:30:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178153740421.3946007.14916118422158982423.git-patchwork-summary@kernel.org>
Date: Mon, 15 Jun 2026 15:30:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wZ9GV-0002uF-TI
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

Patch: [f2fs-dev,v2] f2fs: validate orphan inode entry count
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1100717
  Lore link: https://lore.kernel.org/r/20260526053557.1096229-1-qiwenjie@xiaomi.com

Series: [f2fs-dev,1/2] Revert: "f2fs: check in-memory block bitmap"
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1099170
  Lore link: https://lore.kernel.org/r/20260522065912.1756240-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] Revert: "f2fs: check in-memory block bitmap"
             [f2fs-dev,2/2] Revert: "f2fs: check in-memory sit version bitmap"

Patch: [f2fs-dev] f2fs: skip inode folio lookup for cached overwrite
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1102575
  Lore link: https://lore.kernel.org/r/20260529022924.3655519-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: keep atomic write retry from zeroing original data
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1101617
  Lore link: https://lore.kernel.org/r/20260527120628.2255597-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: stop checkpoint on compressed write IO error
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1100206
  Lore link: https://lore.kernel.org/r/20260525061456.231710-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: fix to do sanity check on f2fs_get_node_folio_ra()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1099196
  Lore link: https://lore.kernel.org/r/20260522075329.12079-1-chao@kernel.org


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
