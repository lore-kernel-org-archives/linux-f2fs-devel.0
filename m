Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6F9CC6B1E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tgjzpHun0mlGrEFTMExXz9nCktClayBEoUAGrJD4Vgk=; b=QTI5xFi5d2C8Q6MYfOad+CXEp1
	Oiiljmu/6gTSWPSYB3hctoXDl8OdCZHh7aLOG4wrie/OtrMBhu4KQv3k33CIFJd7X0aycLagGY2en
	yKUtVO0g4nxYfdPqsbNO+FfPv8JQx9ZcHTqhCtirpHKYio/KsGcgtdPomH3eBTiTYQZo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl10-00022m-Ln;
	Tue, 13 Oct 2026 22:30:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0l-00022L-Hp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zeT6Je62U4MpD5oZAp2De33uFxXrD8/Xo0aRLr6jFls=; b=C6AVcITked7cIOa06CwFpZLZ0W
 8Jwn+D5KRtpRHtWPMywz0/RY5U4C8snxDub9qoJK6ojHoZfS8feVeJ+Y/mh+SjFAtCcned8whakiw
 5hZjqkk+r6ewAOeDrdjpVYHrYabOaEFzGA175NwzeKdpbhojGCuU3htYPAugs3uEbm44=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zeT6Je62U4MpD5oZAp2De33uFxXrD8/Xo0aRLr6jFls=; b=D
 wtjPlolBrahSX/MB7Foh6I5tIsHKlkL/Kdx/dEwZGKZ4g3GHqj7peo1zEc6UNszQgGhEFa1VhooYC
 EdJEaq/agwC++LixcJba++7CcPJQUd6UmIz/dJADGHVIrSJd84/LDPTTbmIfQX4MhTXFWxbw4bjlH
 6Fnf+0ufs/gVGtXo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0h-0001cq-31 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD5BE43E22
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12EF1F000FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930609;
 bh=zeT6Je62U4MpD5oZAp2De33uFxXrD8/Xo0aRLr6jFls=;
 h=Subject:From:Date:To;
 b=DzdbQxJi8AnzPBc2l6hYr+Lmo8qQ8eqFaC7IsbHtTP6bVOudBFgpfgso1plT9Sz1N
 k906f81WVaI3JOAlWrN3qLVZw3x7G3FHPAmr15Lqk7uwA56UWm/ipykRvVNKqdTsW2
 zt2dyLQC0Ef74Lbomr1gCA3zCIsjKGiNIm24eceqNc68OwrUGjiHh+sTk8ZGZubMxd
 f/QFfKt7vNnbyv+gnGKgnM3dVqoFLEqQ6XuQ/Krub0CYO3s5nWDx0BkGT64OGhl08D
 S9aIxzcWGChhMt+vh3AosFphMV90YOlxltJoSmq1WOAzcyFovRUVnoI1t6up+SgmTq
 1eo9+w9xUduDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 79F2139E4DBA for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193060814.1493834.7495972683379273028.git-patchwork-summary@kernel.org>
Date: Tue, 13 Oct 2026 22:30:08 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1xGl0h-0001cq-31
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

Patch: [f2fs-dev] f2fs: fix termination of f2fs_sync_meta_caches()
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182851/
  Lore link: https://lore.kernel.org/r/20261010074912.114840-1-jsjlee1020@gmail.com

Patch: [f2fs-dev,v1] f2fs: allow pinning empty compressed files
  Submitter: Joanne Chang <joannechien@google.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182273/
  Lore link: https://lore.kernel.org/r/20261009095335.749891-1-joannechien@google.com

Series: [f2fs-dev,1/2] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182827/
  Lore link: https://lore.kernel.org/r/20261010065546.1762091-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()
             [f2fs-dev,2/2] f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()

Series: [f2fs-dev,1/2] f2fs: cache: pin cached block in f2fs_end_cache_writeback()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177304/
  Lore link: https://lore.kernel.org/r/20260930235435.3789910-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: cache: pin cached block in f2fs_end_cache_writeback()
             [f2fs-dev,2/2] f2fs: cache: pin cached block in f2fs_unlock_cache()

Patch: [f2fs-dev] f2fs: cache: count the temporary pins apart from the regular references
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179854/
  Lore link: https://lore.kernel.org/r/20261005192114.1511660-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: allow empty strings for journaled quota options
  Submitter: Hengyu Liang <hengyul@cs.unc.edu>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1183078/
  Lore link: https://lore.kernel.org/r/20261010165750.509939-1-hengyul@cs.unc.edu

Patch: [f2fs-dev] f2fs: fix to invalidate curseg if change_curseg() fails
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1184647/
  Lore link: https://lore.kernel.org/r/20261013105538.3636822-1-chao@kernel.org

Patch: [f2fs-dev] Revert "f2fs: skip node_change lock for inline data writes"
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180795/
  Lore link: https://lore.kernel.org/r/20261007101738.2348038-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: convert inline quota files when turning quota on
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179192/
  Lore link: https://lore.kernel.org/r/20261004170456.4104287-1-daeho43@gmail.com

Series: [f2fs-dev,1/5] f2fs: cache: introduce metadata_cache sysfs node
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180846/
  Lore link: https://lore.kernel.org/r/20261007114949.2428048-1-chao@kernel.org
    Patches: [f2fs-dev,1/5] f2fs: cache: introduce metadata_cache sysfs node
             [f2fs-dev,2/5] f2fs: cache: shrink meta and node caches in f2fs_balance_fs_bg
             [f2fs-dev,4/5] f2fs: cache: support asynchronous write_end_io
             [f2fs-dev,5/5] f2fs: introduce max_atc_write_bio_entry_cnt

Patch: [f2fs-dev] MAINTAINERS: f2fs: add dev branch to git tree entry
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1182831/
  Lore link: https://lore.kernel.org/r/20261010065946.1763794-1-chao@kernel.org

Series: f2fs: support & optimize large folios for writable files
  Submitter: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
  Patchwork: https://patchwork.kernel.org/series/1182554/
  Lore link: https://lore.kernel.org/r/20261009161224.4163796-1-zhaonanzhe@xiaomi.com
    Patches: [f2fs-dev,v3,01/17] f2fs: extend folio state for large folio write path
             [f2fs-dev,v3,07/17] f2fs: remove mappedtodisk flag usage in mmap write path

Patch: [f2fs-dev] f2fs: fix defragment writeback range truncation on 32-bit
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179751/
  Lore link: https://lore.kernel.org/r/20261005154954.2097054-1-zhanxusheng@xiaomi.com

Patch: [f2fs-dev] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177310/
  Lore link: https://lore.kernel.org/r/20261001000616.3824366-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: check every cur_*_segno[] entry on readonly images
  Submitter: Kaixuan Li <kaixuanli0131@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1168881/
  Lore link: https://lore.kernel.org/r/20260918165507.1267942-1-kaixuanli0131@gmail.com

Patch: None
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1183727/
  Lore link: https://lore.kernel.org/r/20261012091737.308136-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to set sbi->log_blocksize in advance
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177309/
  Lore link: https://lore.kernel.org/r/20261001000450.3822520-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: zone: fix to avoid bio split on sequential zone
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180796/
  Lore link: https://lore.kernel.org/r/20261007101812.2348510-1-chao@kernel.org


Total patches: 24

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
