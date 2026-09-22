Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1340C98302
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHsnNMIz3cfV+l7WC25EccTBppXT5YzeMsXO/+0NwW4=; b=MoCzTnJZff345sHj4P8weyB1dD
	wt30WweGE30rcsm6ZUPFxzc/pVavmt+P55o8n0fMRZMC3sB5GC9c3QqVD3deIfylw5NVfI6p4Wbfp
	iYNwbc5S/OGWJsMjFRLg4WMRVtJRbLjAfWnrC5H3M9TI8pjI3sfHdf6d3l3GdGfo5kLk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x92Su-00046J-UT;
	Tue, 22 Sep 2026 15:31:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x92St-00046C-At
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLHV9+LwHObukot+dBkPuq1xcenN0BPej2dFqPlitiE=; b=MmAxCTL1YuKXrwFPkdOKG7cKld
 FtCr5S72cBvQsvwOhhzdNkHVg1ZnfK4J8n1rLjhaaAopR2VOev1l5V4fhRVsM+sGE3YXLlPSNrybY
 qQhrOefEEqU1qnDlJ569h/ahf9VQA0RnHRmFo8Rr+SWQolxhMsJXvAterAHmyCWHvJzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLHV9+LwHObukot+dBkPuq1xcenN0BPej2dFqPlitiE=; b=nWV5Sb9dfWrMoR4lkVZHybZ0az
 7U5LChbhmiObk2eJHUlnByyzgXpdDMTU9ksTBcs04pH0W72fBADOvjry+0kVxWtAUaZ1IC7SUIiN+
 Uiptw3NCoUATKs8Fi4xLYY5U5Hg9rXvsSiPuBDBnXqnY5Sbx/F/lOBZKaXX349B3lUCY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x92Sq-00040E-Ms for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6AD8C43E04
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0C11F000FF;
 Tue, 22 Sep 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091079;
 bh=gLHV9+LwHObukot+dBkPuq1xcenN0BPej2dFqPlitiE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Y7W9t6F7vM5oB+0WKjEp15WYPLyHRFH4aIPF1M5Q2GuvhzusSuqwuJejdHKQRlTdm
 iLLYEjUuWGhE+4XxaytYcQsfXenK4guCJi5AJfvz2qC8/ITEwKTUq6b+8KMIU+FVDS
 ZYAcKg9qCVAYo3spmANKrv88bOCV7AQ4h7FH3ob0GHXAkmNNEJQE/aX8EE5CG8Cb4t
 w3qlD1JuwzsThKAEcVoi9dvkou8ksXYQ+jyM6GH6oXzL5i8AgwkQUYrxFTb9y86zYl
 4wOcgpGDOTCzZ7Dg5c1UAtB7KW6L7Htg2zvjxV5T0kUsZTJ9BqGp0ajmMdG6ZhFpFo
 V6rwUJV/VlF+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939B03811A4B; Tue, 22 Sep 2026 15:30:11 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179009101040.4140645.6043365279524140950.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:30:10 +0000
References: <20260917073343.2823157-1-chao@kernel.org>
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x92Sq-00040E-Ms
Subject: Re: [f2fs-dev] [PATCH v9 00/12] f2fs: introduce metadata cache
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 17 Sep 2026 15:33:31 +0800 you wrote:
> This patchset introduces a self-managed metadata block cache in f2fs,
> decoupling meta blocks, node blocks, and compressed data blocks from
> the Linux VFS page cache and fake internal inodes.
> 
> === 1. Background & Motivation ===
> 
> Currently, F2FS uses fake VFS inodes (meta_inode, node_inode, and
> compress_inode) to manage internal block caching through the VFS page
> cache. Because of this implementation, the f2fs block size was
> historically coupled to the kernel page size.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v9,01/12] f2fs: cache: implement metadata cache
    https://git.kernel.org/jaegeuk/f2fs/c/4e80250bcfbc
  - [f2fs-dev,v9,02/12] f2fs: cache: initialize meta cache
    https://git.kernel.org/jaegeuk/f2fs/c/20fccd31926b
  - [f2fs-dev,v9,03/12] f2fs: cache: introduce shrinker
    https://git.kernel.org/jaegeuk/f2fs/c/fe1c66b4a6e1
  - [f2fs-dev,v9,04/12] f2fs: cache: introduce writeback thread
    https://git.kernel.org/jaegeuk/f2fs/c/f45afeabd5df
  - [f2fs-dev,v9,05/12] f2fs: cache: use meta cache
    https://git.kernel.org/jaegeuk/f2fs/c/7a1cf2a76b71
  - [f2fs-dev,v9,06/12] f2fs: cache: initialize node cache
    https://git.kernel.org/jaegeuk/f2fs/c/26185263c121
  - [f2fs-dev,v9,07/12] f2fs: cache: use node cache
    https://git.kernel.org/jaegeuk/f2fs/c/493b9dc8b52c
  - [f2fs-dev,v9,08/12] f2fs: cache: initialize compress cache
    https://git.kernel.org/jaegeuk/f2fs/c/bf452b33bdb6
  - [f2fs-dev,v9,09/12] f2fs: cache: use compress cache
    https://git.kernel.org/jaegeuk/f2fs/c/6a78d0488116
  - [f2fs-dev,v9,10/12] f2fs: cache: support fault injection
    https://git.kernel.org/jaegeuk/f2fs/c/4f9ad04b59c6
  - [f2fs-dev,v9,11/12] f2fs: cache: introduce tracepoints
    https://git.kernel.org/jaegeuk/f2fs/c/cc46c2e9336b
  - [f2fs-dev,v9,12/12] f2fs: cache: show per-cache usage in debugfs
    https://git.kernel.org/jaegeuk/f2fs/c/f17987c6219e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
