Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8179C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lnT1k25jzIqQDvN2o/mRt03dSWc+nG11ZyRsS3PaWD4=; b=AIDzrK6oNPQ+7f9tA/m7lJXMIn
	HZKrO0Nsg5OiwNHYNYGXJIQKdBrh9Wb5pHZfNT5eRon+WGCDMXWEaKFsk3OsTUftQwniCXmXbTKeF
	MZRnys4CDDwDqULutQ20c0BHM1h/mv0OvEHcArZKDkQ37WDwpduH8KvRNbX4UwMvzIqE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x92St-0001yW-QU;
	Tue, 22 Sep 2026 15:31:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x92Ss-0001yQ-TZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7MyOHtnbv5Z1ooWxQhYYpkMsAutc+1zEeEjjSDOMEUo=; b=WsCnjq6Kp6cdj6kBZhco+Rqlg4
 kVkgkBERn4cVmJ7i3ocVtQVMuo2k6IV7BIfUiLzqgoHsIqUOFTTXJyHbKrucDLhy3MpiNCVWM4S4t
 h8f9Nhx0ULmGwpWOQkPw2UqUHSIcKzrib0w1bfxQ08G7ywxfddmLD2G+fsAmVSbjG+vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7MyOHtnbv5Z1ooWxQhYYpkMsAutc+1zEeEjjSDOMEUo=; b=W
 shMAW7hjU5S+8pkVnkE1Ksa7S0S+4AMjvrQeVV2R+rU40ymYSj26+TtZZ+AipCrD71qwWfum+EF8j
 P5s00ICGXMJ6y3um2+q8tfb40t5eIAM6Yw1KFoVJK2NfD2HLlUnvDKaFbW8f5QjIlUUOc8nqAi/a7
 7Cn3m6CrmXr7xw2I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x92Sp-000407-Lz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 597AE42E9D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4D21F000FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091078;
 bh=7MyOHtnbv5Z1ooWxQhYYpkMsAutc+1zEeEjjSDOMEUo=;
 h=Subject:From:Date:To;
 b=A07GfHbU1b7wXkjK/5P1W9zcOO6IMnTt02jYXG2QPwrCIhCuPvZ/snT+PPGddMd7b
 ijVghJYp4nsqWX88HwNoWoWMc/3+HKslMum9xBurq6KhAJoVGQUJ4M/GFAtNjwtKQJ
 WfucfeAzfvKo5sd8tqqrcQp/JW/hJhkQfwBxn60yjSf5yG5/FWOWZdG1lkbdKYUc5q
 60aKiZ/fFcvj3YZx0yEcwbCpBZiejNkDx3nQJ2Domoee6C0o8Mx6/ncHqKMJWDj0ak
 c5HOWBwpa3Q+VeVPeXTfUmbxx5v2CW9O0Bw4b+IJCDse7gvbWuQzFPqLH+LlMy7dBM
 0LyxpiMmOrG7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5935A3811A4B for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:30:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179009100895.4140645.11889139269606540198.git-patchwork-summary@kernel.org>
Date: Tue, 22 Sep 2026 15:30:08 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x92Sp-000407-Lz
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

Series: f2fs: introduce metadata cache
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1167171/
  Lore link: https://lore.kernel.org/r/20260917073343.2823157-1-chao@kernel.org
    Patches: [f2fs-dev,v9,01/12] f2fs: cache: implement metadata cache
             [f2fs-dev,v9,02/12] f2fs: cache: initialize meta cache
             [f2fs-dev,v9,03/12] f2fs: cache: introduce shrinker
             [f2fs-dev,v9,04/12] f2fs: cache: introduce writeback thread
             [f2fs-dev,v9,05/12] f2fs: cache: use meta cache
             [f2fs-dev,v9,06/12] f2fs: cache: initialize node cache
             [f2fs-dev,v9,07/12] f2fs: cache: use node cache
             [f2fs-dev,v9,08/12] f2fs: cache: initialize compress cache
             [f2fs-dev,v9,09/12] f2fs: cache: use compress cache
             [f2fs-dev,v9,10/12] f2fs: cache: support fault injection
             [f2fs-dev,v9,11/12] f2fs: cache: introduce tracepoints
             [f2fs-dev,v9,12/12] f2fs: cache: show per-cache usage in debugfs

Series: [f2fs-dev,v2,01/12] f2fs: cache: implement metadata cache
  Submitter: Chao Yu <chao@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1150938/
  Lore link: https://lore.kernel.org/r/20260824134731.3704352-2-chao@kernel.org
    Patches: [f2fs-dev,v2,01/12] f2fs: cache: implement metadata cache
             [f2fs-dev,v2,12/12] f2fs: cache: show per-cache usage in debugfs

Series: [f2fs-dev,1/2] f2fs: rename page_count with cache_count
  Submitter: Chao Yu <chao@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163306/
  Lore link: https://lore.kernel.org/r/20260911232510.1816298-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: rename page_count with cache_count
             [f2fs-dev,2/2] f2fs: rename nr_pages_to_skip with nr_caches_to_skip


Total patches: 16

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
