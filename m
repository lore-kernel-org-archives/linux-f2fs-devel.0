Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F2CC6B15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yv4fiYqTjlblzIr+0zfLb1lFDIkGNeeZmI2DJpMXxOA=; b=dSWnTAAhOM2PN5ioZU3MhFv3jl
	rXQ88RXjuYP7Q6UCdimcqrBraSuzDU8l2ruYFIHH9JwfwXOZG6kYtlpgDBhuXKM+sNK+qUOkzsHwb
	QLkH9btWSCK+VUPS6LR9LfqiW4nEguLjYWeOEqGNG1Lp7FeiOBU0cFHU8Yj7v1F0y3EU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl17-0002De-89;
	Tue, 13 Oct 2026 22:30:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl15-0002DB-9e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u+fnW1tPmbxu40oKMWMwFjVwadZ8TEhMJgUbBD5hFcc=; b=CUhKRu99Nvl2BCgpj++WhZyuV6
 F7HzqIxlsvjYTP8yP9E2aFW1i13ZQumLPbINVv9TRb784iXlPUo9g+q+o6+C6dqhYpnTxGsNqsdDW
 F1qyoJNJ8wuuElEAHTcxeJJAxGMElzzTX3Pd45JIML7oKWs8/8+fv12sAU6FggEhikPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u+fnW1tPmbxu40oKMWMwFjVwadZ8TEhMJgUbBD5hFcc=; b=HgE2ER/Z1CZFEBiasbKdbIQaqZ
 IEA2p+pRPv9hLFn/8BDws1y1JqrI9wcUvDFqmpkaI8qGH/siJonzMoUa6FPFpWVd7kvs3JnXKqMVk
 yhPDPKKjo5dnpMafln5BOxqtvSe2ga3BFJNLG9bl4peUimErMV2nZYPG/eg9GShG9h6M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl15-000651-D4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD5F960236;
 Tue, 13 Oct 2026 22:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BCC1F0089A;
 Tue, 13 Oct 2026 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930633;
 bh=u+fnW1tPmbxu40oKMWMwFjVwadZ8TEhMJgUbBD5hFcc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=gqRYlEbgl30iolJJRxI04b5/+vX2vDUf+gvmTH3AeTOOKftub8TF6ePRgQ1cR2+QQ
 Wbsn8pH1VfjK7UartKfdhwrDGiSTiIkwmWyWC4S2D5yPLA8YnXKY7sIXGXyJ//6D0u
 NIQxN652R8bmUqYvcwldzYIik0VfvPXl3lArPuovl3VFxYjmIc4l5C9WFv7U1vIIRK
 NS6Nq6jL4w8bg897dQF8+ERTCcV1cKPkwJDz9fOf1pIjz+NYVODSE4brQGInR+7CDi
 B/3p3E6ypRdsQeBSwEEC8/++3KHYtvybi9gLbSw4m+ryr2SVcZdu4gUCpHvERXCrg+
 /DqKbkxAolHgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 773CD39E4DBA; Tue, 13 Oct 2026 22:30:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063201.1493834.2435628094776916750.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:32 +0000
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGl15-000651-D4
Subject: Re: [f2fs-dev] [PATCH v3 00/17] f2fs: support & optimize large
 folios for writable files
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
Cc: baohua@kernel.org, nzzhao@126.com, jyescas@google.com,
 daehojeong@google.com, linux-kernel@vger.kernel.org, Dev.Jain@arm.com,
 David.Hildenbrand@arm.com, linux-f2fs-devel@lists.sourceforge.net,
 zhangbo56@xiaomi.com, kaleshsingh@google.com, jaegeuk@kernel.org,
 lipengfei28@xiaomi.com, Ryan.Roberts@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 00:12:07 +0800 you wrote:
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> It also extends f2fs_folio_state to coexist with f2fs page-private
> flags and to handle large folio write path and partial truncate of
> large folios correctly.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,01/17] f2fs: extend folio state for large folio write path
    (no matching commit)
  - [f2fs-dev,v3,02/17] f2fs: carry subpage offset and count in write IO
    (no matching commit)
  - [f2fs-dev,v3,03/17] f2fs: support regular file buffered writes on large folios
    (no matching commit)
  - [f2fs-dev,v3,04/17] f2fs: support atomic file large folios buffered write
    (no matching commit)
  - [f2fs-dev,v3,05/17] f2fs: support large folio writeback
    (no matching commit)
  - [f2fs-dev,v3,06/17] f2fs: account large folio dirty data at block granularity
    (no matching commit)
  - [f2fs-dev,v3,07/17] f2fs: remove mappedtodisk flag usage in mmap write path
    https://git.kernel.org/jaegeuk/f2fs/c/b3c984358925
  - [f2fs-dev,v3,08/17] f2fs: prepare mmap write faults for large folios
    (no matching commit)
  - [f2fs-dev,v3,09/17] f2fs: make GC migration large-folio aware
    (no matching commit)
  - [f2fs-dev,v3,10/17] f2fs: optimize small block size large folio read
    (no matching commit)
  - [f2fs-dev,v3,11/17] f2fs: support partial uptodate large folio read
    (no matching commit)
  - [f2fs-dev,v3,12/17] f2fs: handle partial truncate of large folio dirty subpages
    (no matching commit)
  - [f2fs-dev,v3,13/17] f2fs: wait for folio writeback before ffs_detach_free
    (no matching commit)
  - [f2fs-dev,v3,14/17] f2fs: fix zeroing paths for large folios
    (no matching commit)
  - [f2fs-dev,v3,15/17] f2fs: handle block cloning within the same large folio
    (no matching commit)
  - [f2fs-dev,v3,16/17] f2fs: allow large folio support to writeable files
    (no matching commit)
  - [f2fs-dev,v3,17/17] f2fs: make compressed files compatible with large folio
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
