Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA7CEB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Jun 2023 18:00:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q9rGr-0005AI-8S;
	Thu, 15 Jun 2023 18:00:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q9rGn-0005A0-Je
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Jun 2023 18:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E7VcL87RezBZc5VHX+5WjU7a3ITymYmHwM2kMDyvXt8=; b=hbpdJh4D/fk/9FV41YXQUdze63
 PM3YOaaf2ajQWL3DyIpatJojaYHrA9qjZJ5/DdQvLkwV0c2Nid27tghOiKF71rqWNLP2jhXOU84uq
 0mdxp5AWpFNxIvF73lWG2ITGe8H36EUXYaAd7zAqsXT0QNL+Zd4twgXGilta5StHJXBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E7VcL87RezBZc5VHX+5WjU7a3ITymYmHwM2kMDyvXt8=; b=KANwF/Y47O3pvG14MjotcqHpXJ
 RZfSJqIdyp+bitHFvgDg0NJK+PNFuxb535GMn897flW/dcGiYW3KpfcezNXqkGhtTQjYCbq2yRZH+
 XaTjvr2yJbRuxxHCrq5Opxamn0C38UUuVIW5o1swRj1u21jYzeDshJKAxESToGEyZ1bY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q9rGn-004QtA-2O for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Jun 2023 18:00:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ABCC36222A;
 Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B72EC433CA;
 Thu, 15 Jun 2023 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686852023;
 bh=bxVjEWkxZnaxJ/JKb6C9OMV210qolC16gpN+9qdEWu0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=X53nK8sd2GoCuS8VNutNBdgy59gg7vjxkxZm5qJinXD/F57VyJVmkSlG9nVK89oKf
 KR+rDG9TDOxn9h+8Nw6l6JzgQTehFZF+qa4bNLmLTL/cHpnTMl1J/UKp0R6RSWrWlE
 rkdvaPHyNKUtb6BGxF9NSm5LvpRZdPR19RnP55/dDxjFp14oencH/daEHVrmBRXem4
 qg88pC78MqGRycR7FqXYaq7QGG6KWls6YVm8x3RwTUMcEXh5CK+tobdMGwfKHGdv5Z
 apFLpsH8bEAf4ghC7EQH8me5+ELYVFKLhvUH7SUYwu7p6YIbg2XVvVm5YR5Zx/i921
 LVAf/DXi0KaEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EAEDDE21EEB; Thu, 15 Jun 2023 18:00:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168685202293.7502.5200872561131261330.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jun 2023 18:00:22 +0000
References: <20230612030121.2393541-1-shengyong@oppo.com>
In-Reply-To: <20230612030121.2393541-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
X-Headers-End: 1q9rGn-004QtA-2O
Subject: Re: [f2fs-dev] [PATCH v4 0/6] f2fs: add
 f2fs_ioc_[get|set]_extra_attr
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
Cc: ebiggers@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Jun 2023 11:01:15 +0800 you wrote:
> This patchset introduces two ioctls to get or modify values in
> f2fs_inode's extra attribute area:
>   * f2fs_ioc_get_extra_attr
>   * f2fs_ioc_set_extra_attr
> 
> The argument of these two ioctls is `struct f2fs_extra_attr', which has
> three members:
>   * field: indicates which field in extra attribute area is handled
>   * attr: value or userspace pointer
>   * attr_size: size of `attr'
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/6] f2fs: add helper to check compression level
    (no matching commit)
  - [f2fs-dev,v4,2/6] f2fs: cleanup MIN_INLINE_XATTR_SIZE
    https://git.kernel.org/jaegeuk/f2fs/c/4acc6b9d6104
  - [f2fs-dev,v4,3/6] f2fs: add helper to get inode chksum from inode page
    (no matching commit)
  - [f2fs-dev,v4,4/6] f2fs: add f2fs_ioc_get_compress_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/1c5c646596c6
  - [f2fs-dev,v4,5/6] f2fs: add f2fs_ioc_[get|set]_extra_attr
    (no matching commit)
  - [f2fs-dev,v4,6/6] f2fs: access compression level and flags by extra attr ioctls
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
