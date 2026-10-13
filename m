Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEAACC6B12
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ipuQ/7uQL06Oglq8ObLk0NJrBEJjo4hCQzSHevpjWw=; b=Mn+2Zkymod5+Tvjxy5j+gUet4C
	bktuDKIenuLUwG1wTOXbUXk6cEmlEjoTHAsPk0xwtuwRA94aFRgb8EVrN1A9uGiq1EWtUPKP232/d
	ajvbmevXLKayj8ofVweXD8+2PGeDqmNbm2RhQ8IHr127oaFq2wjwZAb4O7/fsdaUztwY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1E-0000dv-TS;
	Tue, 13 Oct 2026 22:30:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl1D-0000dd-AT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvj3O9c6RosAT0UyjB/2k5GJbzbN2n4aQ6TJnnls2VE=; b=i0akPvMcRYUSpQKiA5/cs+wa89
 V2eiGHbtif2fCLTQOiXEegc+p66fDivgCQCfnhZx35UOsg7FWKp5UGPJfES7LQGNa0DbZASXbn7uP
 V575v7wo9hpuO4w3Z2MI/A7QYeafO8MeC9dz4O1sKB40agGvwObi/tglDjtRwfvgtD1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvj3O9c6RosAT0UyjB/2k5GJbzbN2n4aQ6TJnnls2VE=; b=As+jjmSVJtAl4FbkZETM7LarKA
 FxVq4o7v73TDUu2DGRPA364S+v8HjfolIBNzPfvJX0OCALUi0dpkHK6PZ2EEgmbpGCc3440Hk5q9N
 bZS3GTYH5Y1Zh6v+KM4qm657WJWX7+xyxhQc8Hv7b8TR4c8tO4HQ+9klo8s2ora4ENn4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl19-0001dy-S3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F8F960A53;
 Tue, 13 Oct 2026 22:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B31F00893;
 Tue, 13 Oct 2026 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930638;
 bh=uvj3O9c6RosAT0UyjB/2k5GJbzbN2n4aQ6TJnnls2VE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=dyPmGJvkm70vJ23ZkLEA1xpCjBq7aSkis9VL7DV8yX4RyhZXQ5j9xmaCag9TMVzy2
 CkS8VMwWNKtl1UTwEpqU6L15z20S/VK5gsXe5ZW+06on1Ukmk54KSapKUSzC/jXjlC
 Vnmrl79cf45pUEe8ab4aoQz5DcNMa+bCHNzwG92AiAU3pKDSRvu35iPjKmeqCRLnq2
 h5WLDxqjY54W6pIn9dJdsIgNY2j5gJlZcoHsX8uoZ3lJhQE1tEpwf0o52L3Yuo484b
 0ud0Goh+nk56gbucxrRIPQuHrRrD/dmhR+4w0pldPpGN2pDkZC/VatFGDEJUIQnT8s
 A1bMcad7c9+vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F151439E4DBA; Tue, 13 Oct 2026 22:30:37 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063651.1493834.5827058831537711621.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:36 +0000
References: <20260918165507.1267942-1-kaixuanli0131@gmail.com>
In-Reply-To: <20260918165507.1267942-1-kaixuanli0131@gmail.com>
To: Kaixuan Li <kaixuanli0131@gmail.com>
X-Headers-End: 1xGl19-0001dy-S3
Subject: Re: [f2fs-dev] [PATCH] f2fs: check every cur_*_segno[] entry on
 readonly images
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 19 Sep 2026 00:55:07 +0800 you wrote:
> sanity_check_ckpt() bounds-checks cur_node_segno[] and cur_data_segno[]
> against main_segs, but on an image with the RO feature the goto that skips
> the duplicate-segno cross-checks also leaves the enclosing loop, so only
> index 0 of each array is ever checked.
> 
> An unchecked index reaches __set_sit_entry_type() through build_curseg() ->
> reset_curseg(), which writes se->type through &sit_i->sentries[segno]. With
> segment_count_main 120 and cur_data_segno[1] set to 200, KASAN reports
> three out-of-bounds writes during mount and the mount then succeeds.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check every cur_*_segno[] entry on readonly images
    https://git.kernel.org/jaegeuk/f2fs/c/9c4ee79190c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
