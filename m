Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A617AC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yCEMkMcKX5dDLIr66M/VRx/KZQ3EaTP1kay2s7UJOBU=; b=QbGZ7VJf4qYl/iLxBpG7FUu3KQ
	wIBIdWULbOL5XcGwq/D6evavewV9N+A+a71K+Q346WVhmG9dlpWDWY9csQVhU6UmItXQXsUB4/dM2
	hvs46lLGJd2KE1YD6AsdiLG3D07HxbETgogvQxdejCDMjF9eNbstkhgMltXU4W0gV57Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8g-0001Cx-EO;
	Tue, 11 Aug 2026 04:30:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8f-0001Cq-0J
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i6T7IOLUeNwkIBWiPmxztt8PSajMzyk6xByDX7mO4xU=; b=f+fZFRdnbqoxQNnjM8lwDnC6yt
 RFlcTg1O6idOGJPzLBJs9DIt0sCpgsAy5pojI/QQK7xx0Hyg7JtdkcHvPWPOv3xNlkmGRFzSBFMh/
 d+uQaO4qAQtnnvuiDWdVuofpLhcNUOxGibeW8fL7ZsSm+9sj9V2ik5u0ZNCumor/c1Eo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i6T7IOLUeNwkIBWiPmxztt8PSajMzyk6xByDX7mO4xU=; b=f
 mIsFnAyfwh4i0JBI55Hxyoxf2JcFG2f1D5EWLY59tNXrf4wWK1+ol3eBpUYQsgx+PycRu8Vjoad9g
 FRakapvB9taP69HUAlomNUiWZPrYZQjLfzjh1P+nHdb0bfgEpNlUSDrPLSD/MvybTCT2yWNyDPlyK
 1jtOYTRrUICpbyOg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8b-0001d5-OG for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB75B6001D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945241F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422647;
 bh=i6T7IOLUeNwkIBWiPmxztt8PSajMzyk6xByDX7mO4xU=;
 h=Subject:From:Date:To;
 b=a8tqxro3GXgDv98XsCmmzrwW9yKGVgmRHzkUEYb9UtOGmoE9JDv3EVf+57BtJLYE3
 DfJTVolPet9BzopVbxG9BjV7hfNqYTPTJ1ONDSwZh4xMIg2iwHa6stiZeoIkGOKHxz
 8/OW+Aw3M1yy8qUzXlzrNbzDerDgnjXRl3XNY4dc+iyzhxQHAYIi7mEu709D98G4lO
 8XXYGrg76wdhcsv5lRQ4tRY0CUPL/YwuQ2T1IjG/SfX58JqTU1jkl3LFuL/3BlQwjs
 kZsLIdmW59rqrycSWtz2qcWxWfcZeN9QFjXylEyVcae7AoOooQh08nDJykkGkJCK3y
 uaN1SYW/04TqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1C1303926278 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 04:30:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642260377.332426.8844890435483430443.git-patchwork-summary@kernel.org>
Date: Tue, 11 Aug 2026 04:30:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wte8b-0001d5-OG
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

Series: [f2fs-dev,1/2] f2fs: refactor f2fs_evict_inode having three major parts
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1142439
  Lore link: https://lore.kernel.org/r/20260807220235.384637-1-jaegeuk@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: refactor f2fs_evict_inode having three major parts

Patch: [f2fs-dev] f2fs: fix to pass folio->index to f2fs_sanity_check_node_footer()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1141492
  Lore link: https://lore.kernel.org/r/20260806123537.1516699-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: print error information in f2fs_put_super()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1141104
  Lore link: https://lore.kernel.org/r/20260806025224.2194078-1-chao@kernel.org

Patch: [f2fs-dev,v7] f2fs: support dynamic reserve/release for device aliasing
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1141085
  Lore link: https://lore.kernel.org/r/20260806014813.1587003-1-daeho43@gmail.com

Patch: [f2fs-dev,v3] f2fs: issue multi-device flushes in parallel
  Submitter: Yonggil Song <yonggil.song@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1141122
  Lore link: https://lore.kernel.org/r/20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
