Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5DC3ABCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJIw-0002k5-UB;
	Mon, 16 Sep 2024 21:30:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJIu-0002jx-G2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pu8z1QClLjOzW/3iitBbgVdod37pj3vZhXozjQMdmdk=; b=A3+3u2viwJSE1ci7Kiw1Toi1ZE
 z2LbysNAYYvfOdZtDN2/qRHWUbmmoq838ndKICNUoEpjDkigKYdvl4VvWRQWhYZ1Ius2eqBOEGHJ9
 KMBlLY4La5Z+9x+LdEhGIRzK3iy9AylS7d1q5P1d0SyAjCtAEcc/a8ma9MKktaHg/3KA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pu8z1QClLjOzW/3iitBbgVdod37pj3vZhXozjQMdmdk=; b=U
 NVOmUvIMcdeRkWW0tWyKGKvHcYPua7x7wyIGFoIRAXCCVVZzceLcLN8Me9sx2dhPZFenyTEy6+dxL
 v8JllwlTD+9W6AjFPDS5YeDta26gIfF8BMI/4dAOSZoRQHgxr/X0yatQ/qABFc7R6O0oT61ToKZM9
 wb9jM61mEPNMCf90=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJIt-0000Ny-PF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A7ECC5C0582
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Sep 2024 21:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF0C4CEC4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Sep 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522229;
 bh=pS6xxi2DMmWnOsyDdiZAFWHoHGeL0Da7NPCnPUbJ9KA=;
 h=Subject:From:Date:To:From;
 b=XoE2FkNKrEz260WhbxmmIB7r81/S7RuSh6K1VLKXKuUL9r/4jgcxZxmMJYeRH+sNc
 1uE5oD3Pbcrws8+gcO8lszIIn8FHbCHi/w2lMAl2BS4fvjjUqHh3VtYLYb5G6GroJz
 BhwMUbmXKA54g0N008uQDNroqtME/6GosRnnhbzMHFTT+WysqEOEwUY8JbWGa3lV46
 7NA+WemTSCyl8k4tvzE6DnIjvekCeFz3S/cme/K3JzQbDq7AqxaMmr7j3knYm+dbzn
 wF+0rqZT5Z6IzrWUS8994OKCKi7zhmCZu4hgaEfaOsF8voO84GAfrUo2qIAQFqcjJF
 ERxrEaw3UEJCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B1E713806644 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Sep 2024 21:30:31 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223023.3820990.12099604873943131703.git-patchwork-summary@kernel.org>
Date: Mon, 16 Sep 2024 21:30:30 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1sqJIt-0000Ny-PF
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

Patch: [f2fs-dev,v2] f2fs: forcibly migrate to secure space for zoned device file pinning
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=889857
  Lore link: https://lore.kernel.org/r/20240912165958.386947-1-daeho43@gmail.com

Series: [f2fs-dev,v2,1/7] f2fs: make BG GC more aggressive for zoned devices
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=888613
  Lore link: https://lore.kernel.org/r/20240909221946.2004046-1-daeho43@gmail.com
    Patches: [f2fs-dev,v2,1/7] f2fs: make BG GC more aggressive for zoned devices
             [f2fs-dev,v2,3/7] f2fs: add reserved_segments sysfs node
             [f2fs-dev,v2,4/7] f2fs: increase BG GC migration window granularity when boosted for zoned devices
             [f2fs-dev,v2,5/7] f2fs: do FG_GC when GC boosting is required for zoned devices
             [f2fs-dev,v2,6/7] f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent
             [f2fs-dev,v2,7/7] f2fs: add valid block ratio not to do excessive GC for one time GC

Patch: [f2fs-dev] f2fs: fix to don't panic system for no free segment fault injection
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=888655
  Lore link: https://lore.kernel.org/r/20240910011619.3582861-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to check atomic_file in f2fs ioctl interfaces
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=886568
  Lore link: https://lore.kernel.org/r/20240904032047.1264706-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: prevent atomic file from being dirtied before commit
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=886885
  Lore link: https://lore.kernel.org/r/20240904153306.816988-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: get rid of online repaire on corrupted directory
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=887569
  Lore link: https://lore.kernel.org/r/20240906062724.3569496-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: allow F2FS_IPU_NOCACHE for pinned file
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=890457
  Lore link: https://lore.kernel.org/r/20240915032251.2300459-1-jaegeuk@kernel.org

Patch: [f2fs-dev,v2] f2fs: avoid unused block when dio write in LFS mode
  Submitter: Daejun Park <daejun7.park@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=887072
  Lore link: https://lore.kernel.org/r/20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1

Patch: [f2fs-dev] f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=888676
  Lore link: https://lore.kernel.org/r/20240910030713.3716318-1-chao@kernel.org


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
