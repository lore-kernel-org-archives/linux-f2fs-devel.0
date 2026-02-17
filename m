Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12867E9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uDWu+qJYdikKBTC1JEoaQkDzi16VLEdDqvxFKo5Ld8I=; b=I7NLAw/y2M4pUsvIi/tlvrqJMF
	pypC6j1Sm67eb4ls4jRsu9J8M+jYHziMxGLE383erHHMBHMcwEiGhkg8UHq1y+OlEF26rPOapH/hU
	Yzi6IGPzwd293J+dxl6V169XbEuagEJ9hh/Dh9joJUuzI1Hl2ueXEUXrOXEmYH+IXWjs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSPF-0004Ju-EO;
	Tue, 17 Feb 2026 21:14:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vsSPD-0004JV-G0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3sBi0yyU5EUFw2ZL1lx8mOIR36OdDRX00ACXGiwE4y8=; b=SbCZQYV6CrSFqbzOYA2CYxv5Sw
 8z8TG+FLa4Ak9SxzmX4AK3JgbbTrRqmsExdTQ5qxyrcKTLj+CV/xkb1Mmgyl7nTm4/9j0GM6NmPdB
 NCwqXHXHFidsnFMegSNrUA4dB905uxm9U3DGKrxvbWvZmWKB4MYZOsO7VMRQaOXbXYVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3sBi0yyU5EUFw2ZL1lx8mOIR36OdDRX00ACXGiwE4y8=; b=SVhs2isAFJ0qSldQErrtinkvgm
 meCnGYmBCDc7PdhZESpwDiEvzGHRSWjIfZmEm0Q+DcGpvIhkfUBfJAAqHCrh5DN/LkvLLMmhmAlBj
 XRuP9KDGNS0LUHd+m9IVSXnGZC1POgOqvStx0tOZf/qhFmWbdzapUHCRYcZEm5+e88iQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSPD-0001TY-HJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BFE5D6185A;
 Tue, 17 Feb 2026 21:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7486AC2BC86;
 Tue, 17 Feb 2026 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771362880;
 bh=5PKRA6JisViHy/Wt+cxaLmoaEMt0eP0saSrcTq0zDDI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=nYDLMu4EsZ+ybxrnDEGJ0hhXnV3XzXDcAUNSHNW9WD1vmFRw7eK7sqfsOKZchNkdQ
 iWsJ/BLiHUb1zxwbZEL53A4ROd5F5RqRP9DFRpxoPZxC1FyR+kM5x1EwCQVgd0y0uo
 tspuUfkt+BOs6dctpP9v3K+aCf6rjdPBDyjEQQT9bBrqPfcwCo5B1KQWUmvdM4Lp0c
 zidBp52jkgRn1EPdGPglSWNzNvdbSO+PMCdsh2+ny+JiD15l1swPfNY04ev2WRqD5o
 BZwhk4buxzsV5HQ2f8JLto9W73xXwKDf1PPvdYpP9zuTIMFL0ZPl1XwUKdMii+xqQM
 82YR0p6MUHM2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 84FE23806667; Tue, 17 Feb 2026 21:14:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177136287232.643511.13012047389860653614.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:32 +0000
References: <20260202060754.270269-2-hch@lst.de>
In-Reply-To: <20260202060754.270269-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1vsSPD-0001TY-HJ
Subject: Re: [f2fs-dev] [PATCH 01/11] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
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
Cc: fsverity@lists.linux.dev, brauner@kernel.org, tytso@mit.edu, jack@suse.cz,
 aalbersh@redhat.com, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, dsterba@suse.com,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@kernel.org>:

On Mon,  2 Feb 2026 07:06:30 +0100 you wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/pagecache.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,01/11] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
    https://git.kernel.org/jaegeuk/f2fs/c/23eec9fd64b2
  - [f2fs-dev,02/11] readahead: push invalidate_lock out of page_cache_ra_unbounded
    (no matching commit)
  - [f2fs-dev,03/11] ext4: move ->read_folio and ->readahead to readahead.c
    (no matching commit)
  - [f2fs-dev,04/11] fsverity: kick off hash readahead at data I/O submission time
    (no matching commit)
  - [f2fs-dev,05/11] fsverity: deconstify the inode pointer in struct fsverity_info
    https://git.kernel.org/jaegeuk/f2fs/c/7e36e044958d
  - [f2fs-dev,06/11] fsverity: push out fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,07/11] fs: consolidate fsverity_info lookup in buffer.c
    https://git.kernel.org/jaegeuk/f2fs/c/f6ae956dfb34
  - [f2fs-dev,08/11] ext4: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,09/11] f2fs: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,10/11] btrfs: consolidate fsverity_info lookup
    https://git.kernel.org/jaegeuk/f2fs/c/b0160e4501bb
  - [f2fs-dev,11/11] fsverity: use a hashtable to find the fsverity_info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
