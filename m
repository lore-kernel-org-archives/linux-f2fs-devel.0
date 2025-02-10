Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99653C02198
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:00:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thX8o-0003EI-SV;
	Mon, 10 Feb 2025 17:00:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1thX8m-0003EB-Q2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CDepsnA+13v4X175Gm4/v01af7w+pXjFxZYqP/fnK5o=; b=NJG64YZk2j9Qy05mUE7SZca3Cy
 vIoSLXeU3bVXYdMHRqawzJbZwDLrAyma6CyogVTnrffuK0NS2r/cS5+4vCMJLtk/7wLinpvuydhdg
 B8xVeve95Anpg2IQ/4JTzIbMxNp2qI8KXf0hCxwszmilXRt9Gws5fRehZ7NIri1psD30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CDepsnA+13v4X175Gm4/v01af7w+pXjFxZYqP/fnK5o=; b=YegSsW1LkIX6nzkRBXhH2m0cjU
 g7A1O4nWW8Eqy2MbAiybl+2I7ysS9vAGwbNbjSWY1xyCFBo27MHu0YsitLEGNzCNgQsj4Yip0bU4Q
 AxgvnCtoimBBZkXwt9nXbnexfB9R6H4Uj5KFE0k3e7zdklAIv4j6Td/QpnQvVXrOh4TE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1thX8k-0002xI-SV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:00:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D6EFA5C5CA0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Feb 2025 16:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BC6C4CED1;
 Mon, 10 Feb 2025 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739206805;
 bh=lmAr9JZeFVtK4OBbMlB6jDLFUvyqpzGaFYMfhehq9tY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=L7AcfpjSUuVn/wWghYjCs/4wsp3Y2inLngkKSQQAKhR2NxUX//v8V5iJhp+3F/TdG
 y8d7a4X5gbgFwlNeyZqU5UfZ/sQEt/DovAfIDDxNgRLg53CfAa/6cdjC78cZve17Qu
 ZbMUNyfH7WgqgNSY/Wc019jeM1FO9QpKHN8pnPxtsGX7wxoWp7LCHQRBUclv9kYM/V
 Z4oZAwvEF2VJHN9ss6sQTLph8Kye+1/Edr0WDFoW7NNj+5U7a7BQqZH/rKxD8gTs4J
 Gi9ZYEZa290aOsIHh8oiFbui9wumRC5rjYjXBn6rfj7y+2eVYZwGau4X9qY9nuLzQK
 O/TaFO0FJxKYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAE18380AA66; Mon, 10 Feb 2025 17:00:34 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173920683379.3829927.11086061258734830665.git-patchwork-notify@kernel.org>
Date: Mon, 10 Feb 2025 17:00:33 +0000
References: <20250208023321.3736348-1-chao@kernel.org>
In-Reply-To: <20250208023321.3736348-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1thX8k-0002xI-SV
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: quota: fix to avoid warning in
 dquot_writeback_dquots()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  8 Feb 2025 10:33:21 +0800 you wrote:
> F2FS-fs (dm-59): checkpoint=enable has some unwritten data.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 8013 at fs/quota/dquot.c:691 dquot_writeback_dquots+0x2fc/0x308
> pc : dquot_writeback_dquots+0x2fc/0x308
> lr : f2fs_quota_sync+0xcc/0x1c4
> Call trace:
> dquot_writeback_dquots+0x2fc/0x308
> f2fs_quota_sync+0xcc/0x1c4
> f2fs_write_checkpoint+0x3d4/0x9b0
> f2fs_issue_checkpoint+0x1bc/0x2c0
> f2fs_sync_fs+0x54/0x150
> f2fs_do_sync_file+0x2f8/0x814
> __f2fs_ioctl+0x1960/0x3244
> f2fs_ioctl+0x54/0xe0
> __arm64_sys_ioctl+0xa8/0xe4
> invoke_syscall+0x58/0x114
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
    https://git.kernel.org/jaegeuk/f2fs/c/eb85c2410d6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
