Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC5E9A04B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsP5oruDU3tqVlPUjSR5at17daTGs6asqnZ4Wzhtuhs=; b=HRexPRFiLbh01hw6DFx0MVW0Ga
	Rh49ZCC3wfPLvJ48vO2nD679Z1KEtxHP/+SePd7U0loZUn0G3ONALjD4rbrx6fXKfywLv1Bawi4Gt
	Z24dUyjx51sqnA+s4Eg9W5oJSND6ONmOUeCIm8BGOE8k6k/UOIM7px7Fgrj/CrG2xhEk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSPB-0006Gb-6j;
	Tue, 17 Feb 2026 21:14:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vsSP9-0006GV-Ld
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2Bo7x/MjRBaXVAYls5xWp9PcWy/XpDArRCO/SosFK8=; b=fJ3bQ5A+4kZjHF7V+U66oH7/Lr
 /kasE/iFYgFtZ4xvjBIaI+/8phFLWe9AG5cJhlbbsi97JQO44R0XR+fjpvGfy1eqRqGMV/rRLlrOJ
 biOfB8pZPIcXH7ukm1KBa+HlGkpisygyoVP9JwKfLonrMXmWIa3BXUtnD0fMrDmd5pNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v2Bo7x/MjRBaXVAYls5xWp9PcWy/XpDArRCO/SosFK8=; b=Q52efmGlNDnQE4R15Q1jRz+i9T
 7Z13ehudNH5xI6MexAzwKCvyFrwOlB2tOhzWNLzmhd/PNsSTgxj3nASCYsDG6lA0uwWK7c8Qjd1Vt
 Um+W9iMDuLMGp52awtTuofdMDNuXASGlUNxM3x0KjdgTChOlYWeA+TSHJh1pSoGvbDNc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSP8-0001TM-Td for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:14:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FF4240BCF;
 Tue, 17 Feb 2026 21:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD9C4CEF7;
 Tue, 17 Feb 2026 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771362876;
 bh=IUmsV+ZW94HXGIdU1vo18SjFXSfXhU6JnfKGHOOTBlE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Sb1sDYwJavRLaCVn88gyrDrXlCl0VDnAf62EpkDuPznZMYdbNVtd73gzpyyfSdJ/a
 WqACZhS/EGrPNEG45ARHMKVSGdP4aeQlnn6gf3sjgM1aEN6XQUPh1tFIPxa/SFcDZV
 zg+JLJ84QRyz9qMMJ6QRwLumUMlXlT/vueB7bcmbanb6s6FW/imJ3kiNi93Qoh9O4T
 yvIJ/cNS+jpX41ID+1Kh3XhScgnFe76gfOndPmsMTOoFu0qovNOVXnWM1GF4epkhvw
 mpLacztvHIMGsbHj6XNwKmeJ8uOk0LCt6hh+EbNCXNDb5hYrgzVZHIt+ZOM+kqd7aN
 rIRQXaYrAalKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 851203806667; Tue, 17 Feb 2026 21:14:29 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177136286807.643511.1738733092656907396.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 21:14:28 +0000
References: <20260128152630.627409-2-hch@lst.de>
In-Reply-To: <20260128152630.627409-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1vsSP8-0001TM-Td
Subject: Re: [f2fs-dev] [PATCH 01/15] fs,
 fsverity: reject size changes on fsverity files in setattr_prepare
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
 djwong@kernel.org, aalbersh@redhat.com, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, dsterba@suse.com,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@kernel.org>:

On Wed, 28 Jan 2026 16:26:13 +0100 you wrote:
> Add the check to reject truncates of fsverity files directly to
> setattr_prepare instead of requiring the file system to handle it.
> Besides removing boilerplate code, this also fixes the complete lack of
> such check in btrfs.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/15] fs, fsverity: reject size changes on fsverity files in setattr_prepare
    https://git.kernel.org/jaegeuk/f2fs/c/e9734653c523
  - [f2fs-dev,02/15] fs, fsverity: clear out fsverity_info from common code
    https://git.kernel.org/jaegeuk/f2fs/c/70098d932714
  - [f2fs-dev,03/15] ext4: don't build the fsverity work handler for !CONFIG_FS_VERITY
    https://git.kernel.org/jaegeuk/f2fs/c/fb2661645909
  - [f2fs-dev,04/15] f2fs: don't build the fsverity work handler for !CONFIG_FS_VERITY
    https://git.kernel.org/jaegeuk/f2fs/c/6f9fae2f738c
  - [f2fs-dev,05/15] fsverity: pass struct file to ->write_merkle_tree_block
    (no matching commit)
  - [f2fs-dev,06/15] fsverity: start consolidating pagecache code
    (no matching commit)
  - [f2fs-dev,07/15] fsverity: don't issue readahead for non-ENOENT errors from __filemap_get_folio
    (no matching commit)
  - [f2fs-dev,08/15] fsverity: kick off hash readahead at data I/O submission time
    (no matching commit)
  - [f2fs-dev,09/15] fsverity: deconstify the inode pointer in struct fsverity_info
    https://git.kernel.org/jaegeuk/f2fs/c/7e36e044958d
  - [f2fs-dev,10/15] fsverity: push out fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,11/15] fs: consolidate fsverity_info lookup in buffer.c
    https://git.kernel.org/jaegeuk/f2fs/c/f6ae956dfb34
  - [f2fs-dev,12/15] ext4: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,13/15] f2fs: consolidate fsverity_info lookup
    (no matching commit)
  - [f2fs-dev,14/15] btrfs: consolidate fsverity_info lookup
    https://git.kernel.org/jaegeuk/f2fs/c/b0160e4501bb
  - [f2fs-dev,15/15] fsverity: use a hashtable to find the fsverity_info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
