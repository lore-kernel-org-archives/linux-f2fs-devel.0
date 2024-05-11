Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16911C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5awz-00044W-CA;
	Sat, 11 May 2024 00:50:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awx-00043w-Gh
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6OgTMsU0vgipx4fSQQuNhLHWBmq8eNfbR3UJ+jYaKE0=; b=FkOwcmWZk/KzVsR6qftHBbs2D5
 P2csBY8Qbdb0mvh9/Rx392Tfi0f58shLFH7Gi+Qe3JhzghKcwhHWS7d5xotnLiMAmUtjRKielbz3U
 2ZWKFPpTsdysZGD63IBNmP1LmT8KAkbLn3OKeV+Z+Rp/a8hcNCkvXP+HC/QLSA50jDC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6OgTMsU0vgipx4fSQQuNhLHWBmq8eNfbR3UJ+jYaKE0=; b=hpY3rXhekDDE/FhfQISGZcYQLR
 NMw8Z8FqlVolHaOZJeKk6fx8ZUk1YdCqNZrm8+5RoUz/smz6jP+4oY3o5G1dg3MHKLh36RVlzXJn3
 kXIWgvn7Hihf4DaKCw714o+aL55Az6PUGyWyCwphS5k4ZMd9R/F7P6pCXrom2dYeDfCY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5aww-00050n-V2 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 69A11CE1F2D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 345FBC4DDE7;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388634;
 bh=umpzRfqIbQjf2cQ3pWh/DFx/YMizin6Bv2YlZ01qB7w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DG2PIQNDZ2WQ5knTaNMQofd+vFkrj/8Lk4AJ9Ilohrc1wSrcsxtGnOUGfmqiNU+Ij
 btandg8l9XvpWW4uEQzEB7DHlsFnDpyt8D52GzjfJ+aO4U+EBbjjCjNyWo3Hem5Tvu
 DRd54W2RradldTUZvEu01KhbnsxSupD0dpHA17zFtYME7I8/6HJJhA0xSfQkQzvjWZ
 C6hk1cv9FDBcRMzimQYMpSkLOu0hxwVphDjargyZg/P5XxtPo4cpO3j5YhVrvR7gAV
 tSxAtlifxSR+rYrQVN46TQam5xBSZc2glLvUcbq1GXF4KKa51RSRvesIU9GVUXo9aY
 da3/cqXB4otNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2A88FE7C114; Sat, 11 May 2024 00:50:34 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863417.11229.16140970709452072250.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240507062019.1097683-1-chao@kernel.org>
In-Reply-To: <20240507062019.1097683-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5aww-00050n-V2
Subject: Re: [f2fs-dev] [PATCH v2 5/5] f2fs: compress: don't allow unaligned
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

On Tue,  7 May 2024 14:20:19 +0800 you wrote:
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
  - [f2fs-dev,v2,5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
    https://git.kernel.org/jaegeuk/f2fs/c/29ed2b5dd521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
