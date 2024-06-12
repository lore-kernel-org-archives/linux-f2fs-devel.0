Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A6C41513
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:56:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sHQKm-0006xD-Sk;
	Wed, 12 Jun 2024 15:56:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sHQKb-0006vq-NB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYvj3ircbsMgow/S1FmVDneyye9eZ7O6UbqrLCqtIA8=; b=i4qtLhe+G6dmwEn7/zOKy7LZTT
 3bhYIMPiWBRvrXYe0zsOt0GwT7ShHqw4vND5V0yhWtQiNCGzEF2zqrBsujoRwaz5/363i5Xcst8Wq
 ebsNI+LkvWTqqnlmsR+TTEarzU1Mk48FFizW9BGN/sTC4KY5Yx+TN6nyn7zvoqBoL4uQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYvj3ircbsMgow/S1FmVDneyye9eZ7O6UbqrLCqtIA8=; b=F0YwBslYgMIuYziBlBTnY5V+hH
 FSkCdFi8K5oF7oa577i+gknQYs8c2SFhH9fIOaH/8teBdMVh+4e1F/QWSDoU+pRz53hdUvdcKX81U
 j4ACkODDe7i0NOtnr88dhkmLHCuY4ypxgT3PPlLIg5OibMh2tl9HZtsMXyN6lDYR/2Yc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sHQKa-0007SR-CV for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A5285CE21DD;
 Wed, 12 Jun 2024 15:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E7F4C4AF68;
 Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718207757;
 bh=47LLGyJx3n63fVJFIMhbJCouJ2KvXOEPCo6cPO4GGZQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WW+wSfbAAomyAeKf1LSvtfryt8kxqzuwLGL3TFDswDG+935E5W31eLoxtwmgUVsI5
 3u1EqTPTQb0XumXkosdATdfrXmIeUSjzVsbuZEoD/mPlSU3FYKVwj0WzSCPr89liZY
 FJ1JZZ1HkCKaTpWZE6LRi4wtYnH5hi71LM1ALq+JSBO1GWjSPdeh1PCjeOky5uVut9
 oTeqvqkxmoZGzmaKvsorSQdVXaSX+hbsjjI01OemSpDNXplhCyRMunGcvXy48dL9sA
 jQCb2Q1ozyE0tQRR08Sc6Vge+9ng+SXrYFDhbN5i4FYlHz1TlXnTYg46CizSu5Y8b6
 c/VDWLtt0em1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4924EC4361A; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171820775729.32393.7251723492802127361.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240523132948.2250254-1-chao@kernel.org>
In-Reply-To: <20240523132948.2250254-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sHQKa-0007SR-CV
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to force buffered IO on
 inline_data inode
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
Cc: jaegeuk@kernel.org, v-songbaohua@oppo.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 23 May 2024 21:29:48 +0800 you wrote:
> It will return all zero data when DIO reading from inline_data inode, it
> is because f2fs_iomap_begin() assign iomap->type w/ IOMAP_HOLE incorrectly
> for this case.
> 
> We can let iomap framework handle inline data via assigning iomap->type
> and iomap->inline_data correctly, however, it will be a little bit
> complicated when handling race case in between direct IO and buffered IO.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to force buffered IO on inline_data inode
    https://git.kernel.org/jaegeuk/f2fs/c/5c8764f8679e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
