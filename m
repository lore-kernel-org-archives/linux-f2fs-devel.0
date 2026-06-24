Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEACDE001
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YveQiC8PxGn2whiwFaSYR5jXOQMqKrrauCO8qjsoyu0=; b=TAxCSsJJrPVxsK/tvNIyTKphpk
	gqlHyychhj2j6aUpqZO+7LTun6jwnsjKzf2W/BSwF10T9y7I8KVWAZm2ZdGmTIGMGshqJnyI9eO2E
	BnzDAkdjMWMs5YQS+whQrd/OBcMtWEF2eQjJkKEs+KzFanQpoe7JvEs+PUegW4F47blI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcJTQ-0005jJ-5c;
	Wed, 24 Jun 2026 09:00:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wcJT1-0005ig-U9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H7dnvEvzEKYGFsUTzy9ti4ZW1NJZkg7pmn7MPJihWl4=; b=KQnxZWuBUSeM+FvoXKeLeYb+E8
 eYbRwYF6wQkBRPwvEnnxsRQxKpFPKHwjgHXLnu2FQW2jBLCFGtxycsO0Lxkb8fk/SfyS52K9758DG
 ob7Oz+ZPOFbnHPhdGPBdojXv7w2oPD6iIi0tE4pRMi1Q2E+XlvX/goyeIW4rMetz9464=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H7dnvEvzEKYGFsUTzy9ti4ZW1NJZkg7pmn7MPJihWl4=; b=Tmv5Ri4Vm3SvYqLlhw2aq6ghDS
 MynZ39gGDF7yLSb1Wjewi9F0gIcuGNNpGAHBezev1u5SJk4KBmYafbXSUPBDWShfoy0SZ+JKcaR8V
 AliRLiATLQGGSEHKqWFPsWTlF4ozy5ISsg67QaMsHL/4iZCTIfuGx9kzizq5ydthn1SM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcJSc-0000rc-9V for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39936601FF;
 Wed, 24 Jun 2026 08:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54151F000E9;
 Wed, 24 Jun 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782291583;
 bh=H7dnvEvzEKYGFsUTzy9ti4ZW1NJZkg7pmn7MPJihWl4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ahzIbRZIetUQgFo/22vOgZ+uJ+97WPRTt/pD3GlCEztRscpy02/0ux3ViqsxEjkwO
 easG6XV6XLRJJVyWE9Z9050kasspIvARRFZ+l6aqhTOBnE1iiYMWKHWeJ+rVNV9mfJ
 xI+jJfGnaFu71F5uEdtDR6kUbrg2DaN18xdzdDOmCGP4fORzHuSNP16EfO9WJAjZwJ
 zOiIG4gJkvSO6uM5Z8Kyiu1r10iziRQCVv4wj5mgXjIxk2KAFL19/uqEkRlXia6V/1
 p+iVRA8Y3rG9f/KUr9NezdPkNUNKX4KZKRf7iTlHbxXfa5t5CMQKTcD5pm+yjhkN0N
 dYZZAtdBS9Ghg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19A2E39EF964; Wed, 24 Jun 2026 08:59:34 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178229157279.2577930.17428386350924230713.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 08:59:32 +0000
References: <20260428083332.768693-2-aalbersh@kernel.org>
In-Reply-To: <20260428083332.768693-2-aalbersh@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
X-Headers-End: 1wcJSc-0000rc-9V
Subject: Re: [f2fs-dev] [PATCH v9 01/22] fsverity: report validation errors
 through fserror to fsnotify
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Tue, 28 Apr 2026 10:33:07 +0200 you wrote:
> Reported verification errors to fsnotify through recently added fserror
> interface.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v9,01/22] fsverity: report validation errors through fserror to fsnotify
    (no matching commit)
  - [f2fs-dev,v9,02/22] fsverity: expose ensure_fsverity_info()
    (no matching commit)
  - [f2fs-dev,v9,03/22] ovl: use core fsverity ensure info interface
    (no matching commit)
  - [f2fs-dev,v9,04/22] fsverity: generate and store zero-block hash
    https://git.kernel.org/jaegeuk/f2fs/c/07d09774e2bf
  - [f2fs-dev,v9,05/22] fsverity: pass digest size and hash of the all-zeroes block to ->write
    (no matching commit)
  - [f2fs-dev,v9,06/22] fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
    (no matching commit)
  - [f2fs-dev,v9,07/22] iomap: introduce IOMAP_F_FSVERITY and teach writeback to handle fsverity
    (no matching commit)
  - [f2fs-dev,v9,08/22] iomap: teach iomap to read files with fsverity
    (no matching commit)
  - [f2fs-dev,v9,09/22] iomap: introduce iomap_fsverity_write() for writing fsverity metadata
    https://git.kernel.org/jaegeuk/f2fs/c/36a36c4cac91
  - [f2fs-dev,v9,10/22] xfs: introduce fsverity on-disk changes
    (no matching commit)
  - [f2fs-dev,v9,11/22] xfs: initialize fs-verity on file open
    (no matching commit)
  - [f2fs-dev,v9,12/22] xfs: don't allow to enable DAX on fs-verity sealed inode
    (no matching commit)
  - [f2fs-dev,v9,13/22] xfs: disable direct read path for fs-verity files
    (no matching commit)
  - [f2fs-dev,v9,14/22] xfs: handle fsverity I/O in write/read path
    (no matching commit)
  - [f2fs-dev,v9,15/22] xfs: use read ioend for fsverity data verification
    (no matching commit)
  - [f2fs-dev,v9,16/22] xfs: add fs-verity support
    (no matching commit)
  - [f2fs-dev,v9,17/22] xfs: remove unwritten extents after preallocations in fsverity metadata
    (no matching commit)
  - [f2fs-dev,v9,18/22] xfs: add fs-verity ioctls
    (no matching commit)
  - [f2fs-dev,v9,19/22] xfs: advertise fs-verity being available on filesystem
    (no matching commit)
  - [f2fs-dev,v9,20/22] xfs: check and repair the verity inode flag state
    (no matching commit)
  - [f2fs-dev,v9,21/22] xfs: introduce health state for corrupted fsverity metadata
    (no matching commit)
  - [f2fs-dev,v9,22/22] xfs: enable ro-compat fs-verity flag
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
