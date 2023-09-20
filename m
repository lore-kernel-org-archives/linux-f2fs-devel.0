Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E44C04AA7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Sep 2023 15:50:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qizTQ-000612-Rf;
	Wed, 20 Sep 2023 15:50:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qizTJ-00060s-Td
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMpsaklu/NPtap1sVPH1OmWCw98HuxNn7V8wdAm1HAk=; b=H/bdWwJuFKzQumc9DHje269FJO
 ct801rCCpjo+iyLtWlgW+QH1cFjlq4kbIS/ZdrwaFJj0Cub25153DCvDiv5C6ty2SCup0ZfPjHCzO
 jxVnGlgge74Scc9ODd+WKuThQfsAs78u6APXOTg+1JG3cX9Mqo4ZNJqevr6Sv1+ed+1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMpsaklu/NPtap1sVPH1OmWCw98HuxNn7V8wdAm1HAk=; b=GYoTgX2rYiYYOyFv3hCYV9YQii
 FNWo0CoB+iWkhOPx0GCltPZ+252aSeps72aajtxvlRGHs7IDUQ0LF74e/XDdKq8Az745Sz0XbUeLq
 8DQ1oWXAMFDyT6U+V1Dxi6tJdoQvfU1A4MApZQCJ28wr2xbEz4WyYJu3OWTLhGtTVTbw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qizTG-00GvPq-U1 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 4DE75CE1B28
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2023 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64451C433CC;
 Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695225025;
 bh=LPE6+j2moV2jZAwig9ZRFQxDO5eBHD3zNmuotyL0WyE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XbgkrEQ4W4x9NCAJHZAXE5UJATS6dDywBYfa0FZ9s8CmXfjj/kf0I7o1iV4lqcbRb
 /forzMvEwI4+BBD4iiSgL6gM5XVM3f2eGyoW8v8jXTFb/1fyuKxRjfaLPsOBKDC74B
 HasL1zloOLxVfYD+rj2LoPHpZHC0Ie8aus/+MtVCeCkmbxpE9e4ysB1KQI20JOQlqr
 sN4tC++H1VkDYBogFMrqFLj9WE/Z8iXjbHGreQvGr4LbaWL1knQY4r+sx69dgIBfBu
 sFmr4HiBNTyCR4nPV0/QpNR93PIG+Dtfr5sg247+Pz8oVgljspMVvD18kZD4LH8BL1
 OBvqf6uk5VZPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 41A6FE11F4C; Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169522502526.22557.11170809241417939586.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 15:50:25 +0000
References: <20230912205015.2582133-1-jaegeuk@kernel.org>
In-Reply-To: <20230912205015.2582133-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qizTG-00GvPq-U1
Subject: Re: [f2fs-dev] [PATCH] f2fs: set the default compress_level on ioctl
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 12 Sep 2023 13:50:15 -0700 you wrote:
> Otherwise, we'll get a broken inode.
> 
>  # touch $FILE
>  # f2fs_io setflags compression $FILE
>  # f2fs_io set_coption 2 8 $FILE
> 
> [  112.227612] F2FS-fs (dm-51): sanity_check_compress_inode: inode (ino=8d3fe) has unsupported compress level: 0, run fsck to fix
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: set the default compress_level on ioctl
    https://git.kernel.org/jaegeuk/f2fs/c/f5f3bd903a5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
