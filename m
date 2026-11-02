Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A866072C5F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YszvcPHX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VrDJ4FL9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JJKNw3AR;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGIK1yXa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=FzFJHBnld6ps2AxZYpqOsg0+jaAoHLRF5W+CufoM6zA=; b=YszvcPHXoOSeJdWc8FISX3Z2tA
	8MWpjZu8XmmCCG+cd271YLMg4p91BxadqzLFGkhIOpDLeS5Y14GxgL6Sp63K6n2YEde/gjZHM+zrl
	XNty7RNny/ewd5JW5eDIR5fEPJj1liYHr1d6hFPtQFwv36ty9MT1LSz91T5VZaMaXvUw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNuvN-000000000KR-01Oa;
	Mon, 02 Nov 2026 16:30:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xNuvL-000000000KL-0kwa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8J91EDmyMLUcK6jJh/ZnlLK6Txxa/M7mAHOsUoPbX9o=; b=V
 rDJ4FL9Ht+yt210s/kVhlv/p5nMEIe0bJaYbZpCHD6hOP0Srhp2H7N5/PSVvEbRwoZZTgH1KDNizA
 Po18fjB1FMM8KdTv2uiwYnSZm7O796lvktKhuLEz3rx38Cw0fRbnCu9pWo5ZjBuv76e77jP2DbaqC
 tmVlIdNpaNUvcsb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8J91EDmyMLUcK6jJh/ZnlLK6Txxa/M7mAHOsUoPbX9o=; b=JJKNw3ARS0OFJb7kRClN2Xr38L
 ZVR3rYZ1pGbMxF26WLzWqQjz9nGVZ4oW47qcGB/EN6sBIHt8s4objGZTmDyHpDOrtMp0zJH8RjcbU
 qNj7jmiBLlo6a1U0g7wCCAUaZgKpJYmzgDDsbYvT5SJindmP/hSd3GH8IyfMBWi3mMrA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNuvI-0000000057q-20qO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BC2343C35
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  2 Nov 2026 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CFA1F00A17
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  2 Nov 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637011;
 bh=8J91EDmyMLUcK6jJh/ZnlLK6Txxa/M7mAHOsUoPbX9o=;
 h=Subject:From:Date:To;
 b=LGIK1yXaWEjC4Qfgwr2BHw46jbP0wAudPuLW6jTLMCYEgJWXHcuv9ED4YBrK+mSyg
 K53NTX12AC/KR9g6lFgzPIWqPBtFIvtr0MgSmla67Oyw6ZTQTB/iQMOyQ13NmQHkms
 P5idXF6pT5Ldu9iA6umoQMhVH4lR810e1J4thP3YQRghaGwmHTVzROkQKyDT5u3106
 WdvGaInJnhA6N/p3x7fEgfKkxxfIcLUKdhDrUIw49rh+4SQMBrV0KvayD3msv0yS7y
 yP6FLjSaDSJ1gpMjKLrI7QPM/+1oCC8Z0AZNzm5y7xiAeurm+gEwPitFA1gJhz//Pd
 cbJD/FhVH0Mjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EC278380821F for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  2 Nov 2026 16:30:10 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179363700953.39295.6475574277249662773.git-patchwork-summary@kernel.org>
Date: Mon, 02 Nov 2026 16:30:09 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNuvI-0000000057q-20qO
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: f2fs: support & optimize large folios for writable files
  Submitter: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
  Patchwork: https://patchwork.kernel.org/series/1182554/
  Lore link: https://lore.kernel.org/r/20261009161224.4163796-1-zhaonanzhe@xiaomi.com
    Patches: [f2fs-dev,v3,01/17] f2fs: extend folio state for large folio write path
             [f2fs-dev,v3,15/17] f2fs: handle block cloning within the same large folio

Series: f2fs: support & optimize large folios for writable files
  Submitter: Nanzhe Zhao <nzzhao.sigma@gmail.com>
  Patchwork: https://patchwork.kernel.org/series/1195564/
  Lore link: https://lore.kernel.org/r/20261028154407.1601430-1-nzzhao.sigma@gmail.com
    Patches: [f2fs-dev,v8,01/15] f2fs: extend folio state for large folio write path
             [f2fs-dev,v8,03/15] f2fs: support regular file buffered writes on large folios
             [f2fs-dev,v8,04/15] f2fs: support atomic file large folios buffered write
             [f2fs-dev,v8,07/15] f2fs: prepare mmap write faults for large folios
             [f2fs-dev,v8,09/15] f2fs: optimize small block size large folio read
             [f2fs-dev,v8,10/15] f2fs: support partial uptodate large folio read
             [f2fs-dev,v8,11/15] f2fs: handle partial truncate of large folio dirty subpages
             [f2fs-dev,v8,12/15] f2fs: fix zeroing paths for large folios
             [f2fs-dev,v8,13/15] f2fs: handle block cloning within the same large folio
             [f2fs-dev,v8,14/15] f2fs: allow large folio support to writeable files

Patch: [f2fs-dev] f2fs: do f2fs_zero_post_eof_page for all the time
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1195139/
  Lore link: https://lore.kernel.org/r/20261028050615.259268-1-jaegeuk@kernel.org


Total patches: 13

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
