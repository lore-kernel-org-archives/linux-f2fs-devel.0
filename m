Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F91EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jul 2023 00:18:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qHChZ-0003EM-6U;
	Thu, 06 Jul 2023 00:18:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qHChS-0003CK-Fi
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jul 2023 00:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MaQ5HTpvRDVj2iWKmPOH3Nhl9F8d0ZIzQxcXoJ9MG28=; b=el0+0S78tW3j7LRkaJDUl7L5Pn
 EQB2ZeHDd4QMJ9JH9yRE+siedFG/CGHcfX6bAK/v2r3hAADKab8Q8iYPwY9zvf23s/tXwyO9Po3Zh
 i6DyNlaw4OkZW7lSbiA8XOzbzOGEOqGuOlNNevEpJwgWf0zAK35NLGVs1WCKWSIEIxho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MaQ5HTpvRDVj2iWKmPOH3Nhl9F8d0ZIzQxcXoJ9MG28=; b=kr9Ew1l+6fCoBWPgZL2dbgaQ9B
 HEeQbIXjBha/XjDFYSfl/2IT5OcERiS4r9W2cmG0sGd1Cw2zPIHrtluEL1HON5xUpneaAbONCd4fC
 YcreTHp/2QLC79B/S88Lj36cW4/BJg0FBLElGlIlkCGkzybq6rfFses8RvXDWsEXBsdg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qHChR-0006GF-NK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jul 2023 00:18:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 84E1F61785;
 Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2605C433CB;
 Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688602694;
 bh=jeWeqDBXdXSrmkvHTwsjlgtHwli8j2NwSy0V67m5OpY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LFc6trB/jWJ2d9sOD7qtD7F1TkVJxJA3m5cI+rfXCYLfQX/QeyZjdfTItM058ymbA
 oJs6O1qOWB60hFpY3OLmjnXfE0nT0lUT/GJSPcm3bQKVw/qvEOO3F4CwLed9tt08ZP
 STKAwSJaAdz3CvUKCr0rJt5tX6eip7tve5uIAC7vI6irUyCbuQlrqGebnj1zXX6AZh
 oQHN6ySkUg3nySOTWW3r8CmmVnqOo8N3NLtgq6n9TThLBWWV2+ABnQISSSTQOTxhnh
 eKRSv9ffqMh/Bl+H2ItsxP+g33rHwwQKyr6/4T2ZAF7bR25rk5BvWbIWA1rshIgCk2
 kFP1S/HYPCesw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B0483C561EE; Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168860269470.29151.2457227220614428868.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 00:18:14 +0000
References: <20230424054926.26927-2-hch@lst.de>
In-Reply-To: <20230424054926.26927-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1qHChR-0006GF-NK
Subject: Re: [f2fs-dev] [PATCH 01/17] fs: unexport
 buffer_check_dirty_writeback
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
Cc: axboe@kernel.dk, cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 miklos@szeredi.hu, djwong@kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Mon, 24 Apr 2023 07:49:10 +0200 you wrote:
> buffer_check_dirty_writeback is only used by the block device aops,
> remove the export.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/buffer.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,01/17] fs: unexport buffer_check_dirty_writeback
    https://git.kernel.org/jaegeuk/f2fs/c/4bb218a65a43
  - [f2fs-dev,02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
    https://git.kernel.org/jaegeuk/f2fs/c/bda2795a630b
  - [f2fs-dev,03/17] fs: rename and move block_page_mkwrite_return
    (no matching commit)
  - [f2fs-dev,04/17] fs: remove emergency_thaw_bdev
    (no matching commit)
  - [f2fs-dev,05/17] filemap: update ki_pos in generic_perform_write
    (no matching commit)
  - [f2fs-dev,06/17] filemap: add a kiocb_write_and_wait helper
    https://git.kernel.org/jaegeuk/f2fs/c/3c435a0fe35c
  - [f2fs-dev,07/17] filemap: add a kiocb_invalidate_pages helper
    https://git.kernel.org/jaegeuk/f2fs/c/e003f74afbd2
  - [f2fs-dev,08/17] filemap: add a kiocb_invalidate_post_write helper
    (no matching commit)
  - [f2fs-dev,09/17] fs: factor out a direct_write_fallback helper
    (no matching commit)
  - [f2fs-dev,10/17] iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
    (no matching commit)
  - [f2fs-dev,11/17] iomap: assign current->backing_dev_info in iomap_file_buffered_write
    (no matching commit)
  - [f2fs-dev,12/17] fuse: use direct_write_fallback
    (no matching commit)
  - [f2fs-dev,13/17] block: don't plug in blkdev_write_iter
    https://git.kernel.org/jaegeuk/f2fs/c/712c7364655f
  - [f2fs-dev,14/17] block: open code __generic_file_write_iter for blkdev writes
    (no matching commit)
  - [f2fs-dev,15/17] block: stop setting ->direct_IO
    (no matching commit)
  - [f2fs-dev,16/17] block: use iomap for writes to block devices
    (no matching commit)
  - [f2fs-dev,17/17] fs: add CONFIG_BUFFER_HEAD
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
