Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D2EC83F26
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jul 2025 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IYAju93M/zbOSgDXBmZcKZPEHoiO3ABgtphd2gIcWvI=; b=feiYba5UA7aEVIUAkKnSrxvUCt
	KBxoYw0kOtHdWBnH8Fg28Ms0pyopjsUfjUfuQ+MRBzx7D6lSABAOgcOkApNN2W5exiA7tXZPPgOKa
	u7/0wljhg4TfEJUVtgHREmgdQGs7xYFZhPNhNkjhSW9FZBxpzjENMPHPkK3NCAn3sM9s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ugR3D-0003u3-W1;
	Mon, 28 Jul 2025 16:50:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ugR3C-0003tw-48
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 16:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQyLmV+fNLm3nYfmuDDUwHMof8K0vVYYR9enN5aJH7U=; b=AJQ2fzIJsgF4yZlO/1f4tCnTC9
 INDja3hdWlV4xpm4Flrta55NPub+32enBXzsD62ALZqSI88sl72AuoL1dAJapllPMswKuS4RI7UZ6
 Hb9xrBcTxdxRNqjaCHUDHhza7u39mHRS19JVnDwOjTFjfWNH64d6ar+2qugEls5xga1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oQyLmV+fNLm3nYfmuDDUwHMof8K0vVYYR9enN5aJH7U=; b=W
 YgOtLSaEPU2Rtj8ZsEL0dzMaSR6a/q4EE/VQwSxON1ciQWvAMzQj2QJSJ0lQwy6ZQ0QwFIYpL5aVT
 BkKAOlDHSbgy8wx8vLy3OTZUaggaSznweab6am5l8f1XsQKUSK9robvRVLCUcQYizElv+I9dT61rl
 ZTFc414gM7MUj3u0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ugR3B-0008Kf-Hu for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 16:50:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEE11601F8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jul 2025 16:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D22C4CEE7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jul 2025 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753721402;
 bh=iFvhDl1REanRt4+WofDCw9S4JB3BEIiPOKUGyJVv/G0=;
 h=Subject:From:Date:To:From;
 b=fgltXdUGQeFdyyjDJa5XJJyZeUvpvRDdMUs8Q0JKMu2PyP3V0/GkC4CzEvxCBBHig
 Ein2eXAoKkNNjJpu98RrJqF0ulQT6bPRd0+n760ziBBe46/q3VWKeEXkcDF+ejyXrD
 QhpL3MOxQ01nvSE2Jn/jgzlcdqsVg6ZFLEmd2HRMFI3vQMJFJjEoTM1tV4WcsESymv
 DWaI5k9ZJS4fMBTKzVQunauaxwzY36K4QC50haRR6EE1pp9E8y1vpSr/YFaDhq6+fW
 iyhfbuLCAaxM7TVLuJaxxTEwJy1alqboqCyfPU2IPAmFUAXDj/rJPJId/4QPCqK8t2
 N8QdwMlbeVGbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33BB0383BF5F for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jul 2025 16:50:20 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175372141876.776676.10588146656976669233.git-patchwork-summary@kernel.org>
Date: Mon, 28 Jul 2025 16:50:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1ugR3B-0008Kf-Hu
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

Series: [f2fs-dev,v3,1/2] f2fs: avoid redundant clean nat entry move in lru list
  Submitter: wangzijie <wangzijie1@honor.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=986291
  Lore link: https://lore.kernel.org/r/20250728050237.1563560-1-wangzijie1@honor.com
    Patches: [f2fs-dev,v3,1/2] f2fs: avoid redundant clean nat entry move in lru list
             [f2fs-dev,v3,2/2] f2fs: directly add newly allocated pre-dirty nat entry to dirty set list

Series: [f2fs-dev,1/3] f2fs: fix to update upper_p in __get_secs_required() correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=985401
  Lore link: https://lore.kernel.org/r/20250724080144.3689181-1-chao@kernel.org
    Patches: [f2fs-dev,1/3] f2fs: fix to update upper_p in __get_secs_required() correctly
             [f2fs-dev,2/3] f2fs: fix to calculate dirty data during has_not_enough_free_secs()
             [f2fs-dev,3/3] f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
