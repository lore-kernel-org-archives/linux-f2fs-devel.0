Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD65C61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2PJT1BPi+WuEwSZ/4nqvUtXEhhfeXKj8kUXtTP7vsE=; b=dPABZM4KA1ohNCKSdWYDOAlF/i
	TwOu0QZ+wZmAZqQx7Tju1zm6ffVmMLH4VsF1xJLqGcc3QAkvmBc9UCo2BDYE3vwSPgtrHpORwhJuI
	in9XDSM7+gHnJVwXZTn1EVbfIVeiHeClSqWWN10zTOOlsDQ4ifEaxtuuLj6Bppo9a+cU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wytGu-00067C-TM;
	Tue, 25 Aug 2026 15:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wytGt-00066y-5K
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AZYqTRiRC1MK3iy8tE0K+lWCz282ENHvObu+czgdtns=; b=V9C1Hvov+nIiLPMsQRX90nAId+
 Cjz7MR6Hdu0aOyuSQiGa0mQU8lz4YilxNY+vmSXgXWcM0+m1Swa4NiSMbS9X9mDb/TEEOGE3mBW+3
 Rg+a91P7oTJstJkGt91o6CLC57oEppVWBr7g017Q7SEizjiJGz1s3F+FlF+9llOoz/Q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AZYqTRiRC1MK3iy8tE0K+lWCz282ENHvObu+czgdtns=; b=Xuv9SQnhmmhZX5vUSks/VZHrAu
 zsy0bYkhC/eOwjRRQYUmNVIdmEg8pd+LpQSJaHRzrm2PUeGSyMvgUYHdPA+wfs8neLG5d69JtJuu3
 FvJzFJhC3KhUO3AxXAeRuZOiCVMCcfdIbBvB/IbxzPtB0LhpOrjrGvCps8eLDyhXCPmo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wytGr-00024n-BK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 11EA8401B4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A791F00A3A;
 Tue, 25 Aug 2026 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787672459;
 bh=AZYqTRiRC1MK3iy8tE0K+lWCz282ENHvObu+czgdtns=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=aOUlX+FZpitsGGUfUy2rtl1niJoE0EvvlYjVTC7dqwlgBOLBXNLqtCJEX0B5AuJEC
 zN9kb80HQZEIZM3xT3dJtT979Q9d0bVqy1+urv/adbivkHqQprX0W8kpQacwgOJ+1h
 1wAwOCB39fMYKbGBGSIDUOnTJHUXHIMRULhoDONO4Ubs2LqnpG20sdQRDsZTbctq7Q
 a1sHjgs2y6SYn35Xj89Khd+76Fh2vr3uU4DtEMDl8T9DxH95JpHuIb4fYYnqbimr4v
 T08llkRN6ifzy3BIXHfsN0ShgIJ6lWN2srKyiVtEaRBmZZ9nLRkw39papJea4FkWag
 S4sl3TOTQEs5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 197983924FEE; Tue, 25 Aug 2026 15:40:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178767240663.3943858.7250949044919337170.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 15:40:06 +0000
References: <20260824131729.3694378-1-chao@kernel.org>
In-Reply-To: <20260824131729.3694378-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wytGr-00024n-BK
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadloop in
 f2fs_fsync_node_pages()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Aug 2026 21:17:29 +0800 you wrote:
> There is potential deadloop in race condition:
> 
> Thread A				Thread B
> - fsync
>  - f2fs_do_sync_file
>   - f2fs_fsync_node_pages
>    - last_fsync_dnode
>     - folio_get(last_folio)
> 					- f2fs_setattr
> 					 - f2fs_truncate
> 					  - f2fs_truncate_blocks
> 					   - f2fs_do_truncate_blocks
> 					    - f2fs_truncate_inode_blocks
> 					     - truncate_dnode
> 					      - truncate_node
> 					       - invalidate_mapping_pages
> 					        - folio->mapping = NULL
>    - is_node_folio alwasy return false
>    - atomic && !marked is always true,
>      then goto retry
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/ce366bfa821e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
