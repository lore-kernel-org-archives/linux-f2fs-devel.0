Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0DFF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2026 04:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4RBADkWM/eG76vhu5bpAYD1L3v8Bnjw5RqV/ebwZNk0=; b=nF3zRbIg3P3OkxXv7pgp03G9iN
	psOuXSwQ+AfM/tSuVOFR8L05MbYz+oWEz5BOovPmIRCLQkqZ0xpkqOD3xqST84fFSM+ujprula+k7
	MHamBQXafALF71hp1PmFsVJ3I+Sq4SDA24VDqeYsIzeATt0FabEg9M6gu4Mi98stQdlc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIfsu-00058C-JM;
	Fri, 01 May 2026 04:53:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wIfst-000585-Vx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 04:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71Y2lOoe2vNV3vb/oKcs5c23MVWDj9mpNKjv6A+W+78=; b=dVhfAuF56GthTrVKIiO0ffQSzM
 iFSzJSOip1MP7jL+heTKRzs1Bd0++TrJU1/t8fVTebyJ4c8Yb5e/HzvRYsFUfvSIve1Tbl0ICt/gD
 jSl1Ef6MlRzRGCtC6BapME43qQl4J8gGmGs0oxgx9PZS55AFgZFI+oMCHsrRt2Rbzl/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=71Y2lOoe2vNV3vb/oKcs5c23MVWDj9mpNKjv6A+W+78=; b=K
 uycFR0BIchCuEp7vmyOaiOEK6yQFEc47Slk2b7o23gZwYyH/kzlK7n/FXpqVDEw3O9/8vlaf2gPxP
 8/7eJMBfaZliHuZQGru6u5BdZMdtcJVnjZGWAWlk6/bmVk9HX0CnyKAQ7gEWKyfidFoxG3/UxoEF1
 H+fagW3Wsiurfr6s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIfsq-00006E-R5 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 04:53:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 143EB60142
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 May 2026 04:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770E8C2BCB7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 May 2026 04:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777611222;
 bh=m8MFurJ1pSlg4uOb0scFhDmN+v2Hjw2wrIBfRwCjWSU=;
 h=Subject:From:Date:To:From;
 b=TO2iFaLtumrhwcu1sShOZF5TMad4mAnoAx+UrSNV02fRa1m34Bl8UlJPIwzoSpb8W
 ReoowVL/ukXe20Gfic07EjKck+Iz+sxLIpk1fmY2pPOe/fxvTz3DQOxIZxfXi6sNst
 hXmKf9p/SF+MgMaZLXWU81j6kz3CvFMG/No70vk0lvW2sTWLjmB4IbIpKDjoB9NpJE
 tYt+PMzvzhmStBNQUASCknRxuNMhpcbrsEDHlqGtvQgoveFv9gd3jhMCvX/xdmt+cT
 aQLsRUJFP5EJr7qGNtNwrS6IJloPMalTj54jMaLE2kxht3eNmxoihRF9L9Q7MyvYHX
 pHH17O7Ju5w4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7F9BD380AA67 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 May 2026 04:52:57 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177761117614.3324081.8923111098359616292.git-patchwork-summary@kernel.org>
Date: Fri, 01 May 2026 04:52:56 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wIfsq-00006E-R5
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

Patch: [f2fs-dev,RFC,v2] f2fs: map data writes to FDP streams
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1082295
  Lore link: https://lore.kernel.org/r/20260417035126.3886702-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev,GIT,PULL] fscrypt updates for 6.7
  Submitter: Eric Biggers <ebiggers@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=797448
  Lore link: https://lore.kernel.org/r/20231030040419.GA43439@sol.localdomain


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
