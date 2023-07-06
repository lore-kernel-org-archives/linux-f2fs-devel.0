Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E94C07CA9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jul 2023 00:18:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qHChe-0008MR-BY;
	Thu, 06 Jul 2023 00:18:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qHChY-0008Lq-Po
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jul 2023 00:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5HRzWU1LRHfNMrRMYBDBMoX1iQYXRkPBgy9Wt0dCY9Y=; b=kmbdm/VMt+dnb6Z7UHq90FfPfh
 GoySV2CiYq1SI07Vdlhfoz9lTOtCelpRpIPnlDeB8AaupdDkbsi1sC1/Shhn4JBlxjzBgr1/wdFeI
 Cnxu1HyGffLV8wqGlChsGUSD5aaP9iOFWdztnYKzo9pslG3vZPTIE+iY3YEqku0NJgS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5HRzWU1LRHfNMrRMYBDBMoX1iQYXRkPBgy9Wt0dCY9Y=; b=KjNQ0iLQm0IS2yOaEph45YdGjB
 Cr/ELrsW/LFnJS+Gc0hAJrZdMPBG6xuDzizNGCmATnfenAzE54Uz0Wful+mK8OrEs8zIo1RfV2CCS
 sWdMSevQgUXEJKP/3zOBxEmB2XMHe5lFzyApaPrku9qdqldQzI4i7L1Xe8xhIMtlflvQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qHChY-007tJL-5i for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jul 2023 00:18:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 26775617F2;
 Thu,  6 Jul 2023 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC42FC433CC;
 Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688602695;
 bh=xIK8FsM0y6IdTXxoj2yUtX8ybh4E/hSNnrTgFUHcmA8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ksZHAgHMiqjHHNI+HBfmh/tl3uHBBT0nfbChSIFhUHykziJMCSV/dXLYK3T1W2p9U
 CirRv9+voPPJIwygedt30zAR6PpNsTqJ6iiu3TVFL5TNFBAhEa7XCLXru7Pxe8gh7q
 g4a2eOmEDNhcCl+xlsMDNsHW2SW6gLnNfgOwk7VSYh7OzpsGT9NjdI+ITbQ/WcG9Wn
 fIp3qfeQtscPJ+OpOWfQRZh4xECVMU2dlje1Cr3uA9UldOejm8bKH1tP/qXpJ7er3w
 3jYQGpCyQ1ko5Njz6BZi4VANr+UNx+6bTyfw+gMFEXf+gHhZEkKp+Ojf0kEDAn6G35
 fB5WZ+CX6Rz1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CC72CC6445A; Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168860269483.29151.4192794448591336624.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 00:18:14 +0000
References: <20230520000049.2226926-20-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-20-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
X-Headers-End: 1qHChY-007tJL-5i
Subject: Re: [f2fs-dev] [PATCH v21 19/30] f2fs: Provide a splice-read stub
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hdanton@sina.com,
 jack@suse.cz, david@redhat.com, logang@deltatee.com, jlayton@kernel.org,
 brauner@kernel.org, willy@infradead.org, linux-kernel@vger.kernel.org,
 hch@infradead.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, torvalds@linux-foundation.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Sat, 20 May 2023 01:00:38 +0100 you wrote:
> Provide a splice_read stub for f2fs.  This does some checks and tracing
> before calling filemap_splice_read() and will update the iostats
> afterwards.  Direct I/O is handled by the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jaegeuk Kim <jaegeuk@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: linux-f2fs-devel@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v21,19/30] f2fs: Provide a splice-read stub
    https://git.kernel.org/jaegeuk/f2fs/c/ceb11d0e2da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
