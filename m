Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5F60895AE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QBxvdv0M;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KPpGyBP+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fuq1LYT+;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ciznAjsp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0K/UWlDnrowktVjVUTvK7gcsyHsOB+LuQQqLn3i26gg=; b=QBxvdv0MDDTet7
	y7qPHwJVpzwrqSM7V/ADdHjHAesL6K0u1l/u0g85zN6+eiyYGzPdpgDDibPafli0j2USRa28NVy23
	71zWsF3bv3NwcpWkCH0uoL29VAHsw5qKdS9Sy+kJ+OCEXw2Ed1UYBVimX2tHF/RILrYDoqs0+NGxf
	ksU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNuvR-000000002TR-1g8H;
	Mon, 02 Nov 2026 16:30:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xNuvO-000000002TJ-3VPc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5SF/q8pr/2pIISxjfoSE04GDV9J/4diNi7cS9BtLTyo=; b=KPpGyBP+ob+qEZ6/CFq+lC4W4e
 8r1eer5nWqnrRZSVS8VaBR6/76p+Bwjf65+3TMq530rfvHFNOcguyPF6FZTEJXJ3lJqbEWhgZDGuL
 dn11AE8IBh448nt6vASw5p3Sj2yz/WHXU0bWlT6sB+Z1NK/bEScL1Rk2tpy676VcTVGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5SF/q8pr/2pIISxjfoSE04GDV9J/4diNi7cS9BtLTyo=; b=fuq1LYT+42u8xSSblzvoD8J2eQ
 xWTrNc97qPv3jD8aSAOVy1qZWPyNg+RhyJ00mbZDxJTgR9Ca8anxilJDKeZs+HUcromZE9m904WSG
 Su/qDY3DI2cTrFQP2MMfjXJ2+k7fDp8KpkBZgQ8cYw7gwQi5c4DOFehwBS82wukhjAsQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNuvM-000000005HP-0Pn0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64EDF60A51;
 Mon,  2 Nov 2026 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3001F00A17;
 Mon,  2 Nov 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637014;
 bh=5SF/q8pr/2pIISxjfoSE04GDV9J/4diNi7cS9BtLTyo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ciznAjspHmO4moOwJm6immabK8shiofklXsWTDE1+bx2tjLWwSLXCegPdzIGbmpUv
 4N8lgAz//ShZfHI411NOlMVHsKeZT2ZOX3ZTUlIJzd5UaqlXayldAIN5/y6BkcmrqQ
 ojaz4WrLshfrtK9nTyJEayS0UCus4FDlJQkiQtEnsIkzQlMDA1LgoNtAwdS8EYlhPt
 i/IYjcQMGmht1rw/RSXGV+jxKQJwyqYv6cke2XS3eiTDF51ky7ypHTkcTdLeRBcoKc
 bcBGjOs/8b22m5dS+SWd1kJwmIsSDsWo8eIXHzhutxnq2nRYn3qccEqu/800bn4cdO
 Hkizi7T2F3fkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 03116380821F; Mon,  2 Nov 2026 16:30:14 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179363701254.39295.10495634103077499993.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:30:12 +0000
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNuvM-000000005HP-0Pn0
Subject: Re: [f2fs-dev] [PATCH v8 00/15] f2fs: support & optimize large
 folios for writable files
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
Cc: baohua@kernel.org, nzzhao@126.com, jyescas@google.com,
 daehojeong@google.com, zhaonanzhe@xiaomi.com, Dev.Jain@arm.com,
 linux-kernel@vger.kernel.org, David.Hildenbrand@arm.com,
 linux-f2fs-devel@lists.sourceforge.net, zhangbo56@xiaomi.com,
 kaleshsingh@google.com, jaegeuk@kernel.org, lipengfei28@xiaomi.com,
 Ryan.Roberts@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 28 Oct 2026 23:43:51 +0800 you wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v8,01/15] f2fs: extend folio state for large folio write path
    (no matching commit)
  - [f2fs-dev,v8,02/15] f2fs: carry subpage offset and count in write IO
    (no matching commit)
  - [f2fs-dev,v8,03/15] f2fs: support regular file buffered writes on large folios
    https://git.kernel.org/jaegeuk/f2fs/c/97c64ba5ddb7
  - [f2fs-dev,v8,04/15] f2fs: support atomic file large folios buffered write
    https://git.kernel.org/jaegeuk/f2fs/c/8ac2add73d76
  - [f2fs-dev,v8,05/15] f2fs: support large folio writeback
    (no matching commit)
  - [f2fs-dev,v8,06/15] f2fs: account large folio dirty data at block granularity
    (no matching commit)
  - [f2fs-dev,v8,07/15] f2fs: prepare mmap write faults for large folios
    https://git.kernel.org/jaegeuk/f2fs/c/ef600b86fa0d
  - [f2fs-dev,v8,08/15] f2fs: make GC migration large-folio aware
    (no matching commit)
  - [f2fs-dev,v8,09/15] f2fs: optimize small block size large folio read
    https://git.kernel.org/jaegeuk/f2fs/c/3db2859c36ab
  - [f2fs-dev,v8,10/15] f2fs: support partial uptodate large folio read
    https://git.kernel.org/jaegeuk/f2fs/c/3a54a923164e
  - [f2fs-dev,v8,11/15] f2fs: handle partial truncate of large folio dirty subpages
    https://git.kernel.org/jaegeuk/f2fs/c/a17b730b74d2
  - [f2fs-dev,v8,12/15] f2fs: fix zeroing paths for large folios
    https://git.kernel.org/jaegeuk/f2fs/c/feb4f88c369a
  - [f2fs-dev,v8,13/15] f2fs: handle block cloning within the same large folio
    https://git.kernel.org/jaegeuk/f2fs/c/25076e575f0e
  - [f2fs-dev,v8,14/15] f2fs: allow large folio support to writeable files
    https://git.kernel.org/jaegeuk/f2fs/c/987f5d0098a6
  - [f2fs-dev,v8,15/15] f2fs: make compressed files compatible with large folio
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
