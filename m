Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75937CA101C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:51:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sk8b3-0001R6-4R;
	Fri, 30 Aug 2024 20:51:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sk8b1-0001Qm-1n
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCpqnO4zMl0YejkCLuc04I0+Qny/4tjDVxASQE9Xu0I=; b=l3LFPGgKWfjtOofwnm9foPsqm2
 QWToBiu1noWUak+hzBUnoF8OQ32Mot8Sl5v1EnP3dpzD3Xet9F59CxSff5RjDwN2d26P67oZw3rxQ
 xzNahKwnv5JiN5Q8wkAnkg/qt6m/IpTlvSQOHCVL3/g17awHqS3hfoZynxz3aw1odTuM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCpqnO4zMl0YejkCLuc04I0+Qny/4tjDVxASQE9Xu0I=; b=e+BcykeBWrxHpI2h1ErqO+AcbP
 McYJiyKW8hYddBDBxGwIwNIx47J/igbhNADXl7Otk5h53WPP1807mAhirK/8dRC0SF36J7VPq+CI3
 pZLF8xT7J0dAfnaQUkHElwkG2T9laznL5JPQCPID/hjLMHBXjDNyxtLSOeWWQpVtNB9A=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sk8b0-0005mm-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AA3BCA41AC6;
 Fri, 30 Aug 2024 20:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA35C4CEC2;
 Fri, 30 Aug 2024 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725051099;
 bh=vPxzIksKckelCZPO/lJH6gBkLGJDcZWljmfpGuIjjHE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=K6KkzIwL6Ctr+iwW67Ua7xntF7iTQbEe8PUNj4KRZoHr79dfDNW8PNblFz9gx9mRa
 A1YP0uECJJ6qXSxkQi1/HWOckUxl31lQdat8psmtTqGoIOV0zmhHDk5oOTgePXPOGb
 X7Ey2AyltmA3LbauPooP+YqhNCHBe8k0CksFrLQJL/Qu3dhejSui4eTCdszan00Bs2
 4aplR37mv17nzeta88KjVyggrD6TbUL+C3vlLgVftYe5ShT8fw8kZUizB1ZY9lB7zk
 kXPSmcCbMgQjcW4VGBQYNEcYxtP52Hb+qYybBgNJkhSYiVXVmhPq5f3MSnU4qNlu5J
 uNEgjpAzE0MZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAED13809A80; Fri, 30 Aug 2024 20:51:40 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172505109977.2712133.16285332779262349295.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:39 +0000
References: <20240813141331.417067-1-chao@kernel.org>
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sk8b0-0005mm-B3
Subject: Re: [f2fs-dev] [PATCH 1/9] f2fs: convert
 f2fs_compress_ctx_add_page() to use folio
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Aug 2024 22:13:23 +0800 you wrote:
> onvert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/9] f2fs: convert f2fs_compress_ctx_add_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/2cbbc4f94317
  - [f2fs-dev,2/9] f2fs: convert f2fs_vm_page_mkwrite() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/8ed263450530
  - [f2fs-dev,3/9] f2fs: convert f2fs_clear_page_cache_dirty_tag() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/71aa6bbfc247
  - [f2fs-dev,4/9] f2fs: convert f2fs_write_inline_data() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/333ad04822f5
  - [f2fs-dev,5/9] f2fs: convert f2fs_write_single_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/65826f2732fa
  - [f2fs-dev,6/9] f2fs: convert f2fs_do_write_meta_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/9f9bbd634792
  - [f2fs-dev,7/9] f2fs: convert __f2fs_write_meta_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/1b9eb6539810
  - [f2fs-dev,8/9] f2fs: convert f2fs_read_multi_pages() to use folio
    (no matching commit)
  - [f2fs-dev,9/9] f2fs: convert f2fs_handle_page_eio() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/6d899d7e3999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
