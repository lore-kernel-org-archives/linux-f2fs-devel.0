Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A34C001DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7B-0006ul-NI;
	Mon, 17 Jul 2023 17:34:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS79-0006uf-LI
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3uE6qjXrRdAl70uNpxAehoFfN0o+G7+hF2sLdxNerWI=; b=ExlAKm4waKEBNVqcWxIzV87c+4
 jBU56Dar402Egpvx2B10SM/LRS4EAT9zn9fooz/kNc/AZlhW5G04ACUFlMwFGMpu4wUcN5YLeN918
 ug42Q1MkEtJgEfBiwL3dcGc7MW1Q9EY8tdPMgTA91rT1l1kcByhY4IOnb3hvS5mQRfUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3uE6qjXrRdAl70uNpxAehoFfN0o+G7+hF2sLdxNerWI=; b=B2GRoAzL+HjVwGOiL7JP79zgdM
 VCXmLVzCVnvTXoXei4lICTzYXSYL8yYWkmDvFtA/gMfNEyjtvkv5Tb9+IEk9mbocxjw2yO1oX6YwW
 OcVNU7p22TJhq9eEmCFNeywX6cyAWkm4fAk1nOQk2vHdfntTa1XSvAKhN4ZG/KQCy9rI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7C-00013w-6g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 82BFC6117B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB7A7C433CA;
 Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615262;
 bh=sWvrP4ixrAensNWjeWVXpoXmXS3QBHBVmKy2NaIEE3o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=GyB6VcKRYFCvnWLX9uTjLGZKSOcBgH+EHagbudwpzqH+iJkNjBIWoX8ebxI33rARO
 foSvxF/T7vcaRsfUQeQDSEv905bt0JintEqer2ggpR8c8/WU+69CjUcD/w78p+5whS
 OJNCL8aPiAOaK50DqAM3AN7COcooRzrBVsiRYIaz/xKI+sBeoyvdUT7phpoS9txn/U
 9UUbrSCAv2y8VIwY2n504GGcxzFkjTiQJdM72nDk/Cb+Udy3cQutwSvz8SlAfJyt0W
 VEMcRQjAGgCiiZNh8zG3iueRQ5YQbP1xWYn70lWxAt933i6UuPfKMs6UcTpjI6HGG6
 1vWICIe2VTAxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C9F29C59A4C; Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526181.4078.12987776501092675695.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
References: <20230706020614.2950782-1-chao@kernel.org>
In-Reply-To: <20230706020614.2950782-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qLS7C-00013w-6g
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to avoid mmap vs
 set_compress_option case
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Jul 2023 10:06:14 +0800 you wrote:
> Compression option in inode should not be changed after they have
> been used, however, it may happen in below race case:
> 
> Thread A				Thread B
> - f2fs_ioc_set_compress_option
>  - check f2fs_is_mmap_file()
>  - check get_dirty_pages()
>  - check F2FS_HAS_BLOCKS()
> 					- f2fs_file_mmap
> 					 - set_inode_flag(FI_MMAP_FILE)
> 					- fault
> 					 - do_page_mkwrite
> 					  - f2fs_vm_page_mkwrite
> 					  - f2fs_get_block_locked
> 					 - fault_dirty_shared_page
> 					  - set_page_dirty
>  - update i_compress_algorithm
>  - update i_log_cluster_size
>  - update i_cluster_size
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix to avoid mmap vs set_compress_option case
    https://git.kernel.org/jaegeuk/f2fs/c/3174a6dbb945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
