Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B0FCD37B7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZyjDSPFSVRwPEe30cE243XHz5oEt1zUWoxuhBwTVfEk=; b=fh8vNCdVp8XlTzBqpa0cZh37pb
	iU5rhNgnEo/BR2BdEa9k7TA8vN04ihu9CV3LRlQGEUc3mq5fxvk+ff2sQ7Pu/6QYqoaWQlxEQGq4s
	eAt8ZD2l2Xp2NueNG1Kw73Lzz6XtVIpa6oKkB9rbcabU6++NFtg9qhFO1e7nuSzQ7j0o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFf5-0006Lv-A7;
	Mon, 11 May 2026 01:42:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFf4-0006Ll-12
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m7aECYVsWesHg784n7391Y8VEAKVLXpVPRLxqBvqeaI=; b=OLC99tKACivy7lJNl6qA9Ix7Im
 3OXgHbDKJXSF7bEeY/zBEN3Tt4UqUEfI2hnzb1guLM2g6JhXHzapxM6nsOZt0UWM7cdqpHvevYFgH
 7cVNCWgRCLk5WS6418yF1mP6txBX0hNfIDOTVUMoPRPZsCRFa78ySK3nx512FHZawcYA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m7aECYVsWesHg784n7391Y8VEAKVLXpVPRLxqBvqeaI=; b=G187vT+L7mMaybhmJop7am5tXR
 vvMNn0wqLM6SjV71NvomXiLC9oT6UWXPSA6lVKFXE6/kb/uBP79Lcko66NLBXbnQ9ctG/NBI2yE4T
 ySoEjLvZxACFssik5gXal9SPxYHuuzFJHhktL1O+ZLTPJ/33/zt37jp9dWZZ9wkFpU+8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFf1-0007Bn-02 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D2046132B;
 Mon, 11 May 2026 01:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245B8C2BCB8;
 Mon, 11 May 2026 01:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463728;
 bh=5Gi+M/HKbDX6gvVy3B371gEpxFJ3HAQ6dqzG6cjcyeo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SsoQGVCweG2zQ6zbBVqmr3rftFn+jnSXvorDoDZcmHKjGJ1XJJt0CnIbVXTaoX3Ff
 FCi371Cu6AEGl0ALiDxsjLxxbqa8EtprhdfOsOFx7PIavEE4mWpX7DwZIBmi9vVSx+
 KmNtz68XxrNuvnko5tHz2Ubkl1Pg9DPzk19GPM9hpr54A9SArI5E+bKHsAbLt9wgIn
 55iw/X6Bjf1W02WYz36kf2RTmvYx74wni0GhNdEeyYhRaLrEWrhWz3WfBeHaPOcqDG
 TURCGtH2bQNINUzs0BkQp62BgOxXVoCmrj+M9Fk3PNa0+osBYOPwUOlLLf6RQfqIXO
 gOtF7cju0jcVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7CDC13930039; Mon, 11 May 2026 01:41:16 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846367504.1975880.12293006639309276631.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:15 +0000
References: <20260510042336.94751-1-kartikey406@gmail.com>
In-Reply-To: <20260510042336.94751-1-kartikey406@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
X-Headers-End: 1wMFf1-0007Bn-02
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: initialize ino_entry_info before
 checkpoint load
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org, syzbot+eec8f2693d71386bd600@syzkaller.appspotmail.com,
 stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 10 May 2026 09:53:36 +0530 you wrote:
> When f2fs_get_valid_checkpoint() fails during mount (e.g. due to an
> invalid checkpoint CRC on a malformed image), f2fs_fill_super() takes
> an error path that eventually calls iput() on the root inode. This
> invokes f2fs_drop_inode() -> f2fs_exist_written_data(), which acquires
> sbi->im[]->ino_lock. However, f2fs_init_ino_entry_info() has not run
> yet at this point, so the spinlock is uninitialized and lockdep
> complains:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: initialize ino_entry_info before checkpoint load
    https://git.kernel.org/jaegeuk/f2fs/c/16c55b3147cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
