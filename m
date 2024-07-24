Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1608C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:17:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWRYs-0002K9-Vt;
	Wed, 24 Jul 2024 02:17:02 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sWRYl-0002JT-Ks
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 02:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5duaD0Pc65lufv1/7QKrI3tC6sHkMWKbSOCCobCKtvU=; b=SvNwS+11WITy7AOH0Covd+CxzF
 moRMEEfoQqZRfEQKK0HbfBZQutqWLuddnxhP1Bv9scmCnfj+yttD1dKayZVZUoyW8bWZhtD7R9Mwi
 vu253b73C5ECzdvOD3jru0XFqtxmPKIsw6BkyTr+83Iw1cVRWs9hMZIdc4Clca0jZvN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5duaD0Pc65lufv1/7QKrI3tC6sHkMWKbSOCCobCKtvU=; b=etDiU/dEXhE7CTlxeKERndyN1E
 5CRb6qKPMgMl9ohdeV7reUGk21XX+kNP8ScDXjiZ64WMHB+GTCFBvEaZKca0P3XQ856UfNaSE9yrc
 3L1+rYsFaIonNxQhHxPezdDEsKR7xI0V2G6bmSkzU8KtOy2k1tQ86HIKfnIyRWxDHWSA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sWRYk-0002Hq-5c for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jul 2024 02:16:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6CE45CE0FA6;
 Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA7FC4AF09;
 Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721787406;
 bh=Gh1D1UnAgqcuPvjNd5sl0dahB4BkzjzMp0gQGvNq83I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ifdw7t/dPdOren4fjvvydJZbC5EB6RwCE4p+kutwUQcFegzzHZ1qd2S0ATKyTiyYv
 3j933m0muzI3SDMeaEbG84eQ7p/VXbnM0I8JRsA5Hxjz83B+3uilJ9GRoNjrX/J5ei
 FTmzznSVTd2YzF37ZcreaUM8D4G4Awlm2800PLn+LfQnq1ohKXUq9VNvxsx7TnYbtv
 f5JDPXMweBtVys9tghSGWcHFNj2k5ShVzRvZrZrVHDQwsfgD8knyN+1OdnWuhbl9iz
 3Q+JVpcnkCgJDEQ3oYEhcIfaBzj6HBQVFmzVZIApoK1/on0N3f/AAQYjkCqO91gJt9
 rSflyAsS2zelg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 8B737C4332D; Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172178740656.17759.15510988511656413539.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
In-Reply-To: <20240405121332.689228-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
X-Headers-End: 1sWRYk-0002Hq-5c
Subject: Re: [f2fs-dev] [PATCH v16 0/9] Cache insensitive cleanup for
 ext4/f2fs
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Fri,  5 Apr 2024 15:13:23 +0300 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v16.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v16,1/9] ext4: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/f776f02a2c96
  - [f2fs-dev,v16,2/9] f2fs: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/632f4054b229
  - [f2fs-dev,v16,3/9] libfs: Introduce case-insensitive string comparison helper
    (no matching commit)
  - [f2fs-dev,v16,4/9] ext4: Reuse generic_ci_match for ci comparisons
    (no matching commit)
  - [f2fs-dev,v16,5/9] f2fs: Reuse generic_ci_match for ci comparisons
    https://git.kernel.org/jaegeuk/f2fs/c/d66858eb0c72
  - [f2fs-dev,v16,6/9] ext4: Log error when lookup of encoded dentry fails
    (no matching commit)
  - [f2fs-dev,v16,7/9] f2fs: Log error when lookup of encoded dentry fails
    (no matching commit)
  - [f2fs-dev,v16,8/9] ext4: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/d98c822232f8
  - [f2fs-dev,v16,9/9] f2fs: Move CONFIG_UNICODE defguards into the code flow
    https://git.kernel.org/jaegeuk/f2fs/c/28add38d545f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
