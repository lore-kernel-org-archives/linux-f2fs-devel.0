Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F1C44501
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MdEBDqhoFfhXnle18KmH1ymdulGtZuPeYcW2hIcCVhY=; b=DgWLHPWksBYPUjBmbyp9FLW9yO
	dyay0RfPTMZmIZWUmv+pEvCvudEDxkY8RjfiSjK+Mt5DIw5VvN8yaREhmS1cbf1WzCDyETlSr3LQY
	tn9hzydo9dlq+SiAnIhcyU+48ys40/OvKXApkTC9NjXtnwtAmjGQITKfROm/P/xkVJlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjTO9-0000sR-Jx;
	Tue, 14 Jul 2026 03:00:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wjTNz-0000s8-Ma
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U1Ew9sdAkTwinqhZNS5hN3OTTXQSqYS2Fzv9QnO/KXo=; b=QE8uPmFt11OXfMs1xsCFqdVgAS
 3q3BYzT5+c+TiyU1GLo0LjWfvh4TTq5I9oV+YNsVD+iaTQwdrEDhFCk8P0jaKEVV5uaUizz+Ktxn6
 FUQJ/mTnb+4FxvFUe00wulJ56zYsl7hV1gDzfbmE9BXopTF/YpfKYCNIIY/4yMg4yxhY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U1Ew9sdAkTwinqhZNS5hN3OTTXQSqYS2Fzv9QnO/KXo=; b=f
 IbzUkORi1uo655a5l1k59lLOX46G0olalzxMjRLjCscsy8MIhjWm/wWm4g+nw7eAeS4xjLr/VcIQ1
 fGIsCKQfqEG/wC9NNZbn70lr0dQZ0Cw3Tp0+ko2fuCWwhh0j0e9o7wcq6uNarAEXTmWmd2PoaGRhx
 9ZX2dEo44zBIezCs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjTNx-0000kW-65 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 03:00:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFD0F60103
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D031F00A3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783998029;
 bh=U1Ew9sdAkTwinqhZNS5hN3OTTXQSqYS2Fzv9QnO/KXo=;
 h=Subject:From:Date:To;
 b=EYjp1RgsVX0015Ca6LjAOwsDkRCx3LwU8LhiGsXXx9tvc36q8mHgmu+QQ8XIwipDK
 +SBs++SQHZQsB+zQd5OuJKS68xFVfrXwPrTX3LrT5qqWogIEUdjMz0gwMREzzCGyth
 wb+H2y+D0ZOIuTkwP5K0pjVyPMPgJEce6th1tsA6ICVBukz7lQJqBryiI7cXsXG9GE
 qeVXQEfMR4U1Gh1SopJ+5sux0Ttb8UaEv6y8nNolOTsWOqbac5h0i829IZWQK5PLPa
 aRH3AC2GKELAQfzGXoFi23X5hgCQAHXEUNFd4a4QRi6+CDjJJLgV4cepbMmscdVAqm
 y82rq02gXKk4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0C4E3924FB7 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:00:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178399800431.2939750.18328172018634896031.git-patchwork-summary@kernel.org>
Date: Tue, 14 Jul 2026 03:00:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wjTNx-0000kW-65
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

Series: [f2fs-dev,v2,1/2] f2fs: quota: do not use GFP_NOFS in f2fs_quota_read()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1123035
  Lore link: https://lore.kernel.org/r/20260707113934.3003158-1-chao@kernel.org
    Patches: [f2fs-dev,v2,1/2] f2fs: quota: do not use GFP_NOFS in f2fs_quota_read()
             [f2fs-dev,v2,2/2] f2fs: drop FGP_NOFS in f2fs_write_begin()

Patch: [f2fs-dev] f2fs: fix to avoid potential section-unaligned pinfile
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1118154
  Lore link: https://lore.kernel.org/r/20260629114918.224537-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix folio_nr_pages() race after put in large folio invalidate
  Submitter: zhaoyang.huang <zhaoyang.huang@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1126572
  Lore link: https://lore.kernel.org/r/20260713111944.924883-1-zhaoyang.huang@unisoc.com

Patch: [f2fs-dev,v2] f2fs: embed f2fs_gc_kthread in f2fs_sb_info
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1122341
  Lore link: https://lore.kernel.org/r/20260706123321.4015678-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to zero post-EOF data when extending file size
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1122089
  Lore link: https://lore.kernel.org/r/20260706072606.3709384-1-chao@kernel.org


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
