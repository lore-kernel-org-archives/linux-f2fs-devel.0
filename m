Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BD1C25B77
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5aws-00059Y-QZ;
	Sat, 11 May 2024 00:50:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awr-000596-G3
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GWQuZzuyV6WTCS0jNx+Yq1enbrY3Sq7EateBQZZG5kY=; b=bq864/cLqMLy9wg3DaMF3rMaVu
 CQ2lTUj7J05+n80vbExUrvmwnuPj5HCwX3mDDDMKo7A696f2D3ZnYmruwEM+fClT8CKAjejAq9Y5g
 pk4dyBftWf+0zMJTA7YXwJhZO/EwWHRRlZ3LV0Mzd3STm2phvpfq7wbPhMyOHdE6P+vY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GWQuZzuyV6WTCS0jNx+Yq1enbrY3Sq7EateBQZZG5kY=; b=Zz8gJsX36p/MjLtqMaAI51WIrq
 OMhZ4mYP3ccrhlaV7QPG5alH/IDHIwmoPqW0xNr9a1wkC7RBGEHlBTKCU1W2leFzVLz4QSsgleXra
 ax+e4ObiJC5PiKQYH7J1GrpyLU7oNOwwq+4KFIHTIZWlBK4OLUiyWsiXA8GMy4/EGhZ8=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awr-0004ze-Uj for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6AD23CE1F40
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DB18C4DDE8;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388634;
 bh=7+8lbIyUYwurNknKC/k7UJyRmT+SDoPbDodvcJKpVIg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gL01o3whIHfyxjv1QztCCV3oNfoXLA9NFcWyXN6pEG0pauWrOApIiwDyHU79QlX0i
 qm9fSOsNU3lmB/FuFpsh7Ei7rhby92LiNUkx4Dz5zg/DxWd5ceTtNzhrbVXAsbeb6/
 A2KdtePislDGBftnBgfMzQaGJRHIaE2vCa1iC1aQ9AfCQSlqdq5+T0V/RVRZuSS5Sr
 Ir0jQyIT5vAMeMjoEOb5yqcDX67wiOICPuJFK5yvR8BqQE7w5IjhPV90iUzo13UZAZ
 6mj/vRLneTM9b1PrxhM7PrCsgQz9FDhzDfAxyb28GfGJPo1MYtOTkqJhVMoF89u/Qa
 ELfH1YThSLOaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 336EAC54BA1; Sat, 11 May 2024 00:50:34 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863420.11229.14176789629360065013.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240510033339.300331-1-chao@kernel.org>
In-Reply-To: <20240510033339.300331-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5awr-0004ze-Uj
Subject: Re: [f2fs-dev] [PATCH v3 5/5] f2fs: compress: don't allow unaligned
 truncation on released compress inode
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

On Fri, 10 May 2024 11:33:39 +0800 you wrote:
> f2fs image may be corrupted after below testcase:
> - mkfs.f2fs -O extra_attr,compression -f /dev/vdb
> - mount /dev/vdb /mnt/f2fs
> - touch /mnt/f2fs/file
> - f2fs_io setflags compression /mnt/f2fs/file
> - dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=4
> - f2fs_io release_cblocks /mnt/f2fs/file
> - truncate -s 8192 /mnt/f2fs/file
> - umount /mnt/f2fs
> - fsck.f2fs /dev/vdb
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
    https://git.kernel.org/jaegeuk/f2fs/c/29ed2b5dd521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
