Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6941ECC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5lZ9g7wALt75RCPEqF2jvvrBZsjMSdb9oyS4ORsocg=; b=SPjEJS/jJ5zOu4nr7bUS2WkWwR
	tUnBQdjGxOwx/sHb17Y8kW1fTmZ0WihxNdvJqaiDMfjuG5Rq6tpLg/PHCStj3cJeqPx0vR10VfQZM
	alGnONWOQKJEF1S4qMjRsTDrEEdSkzqh1cqbq+QLxhgLwxD/QeYka6CsL+dWqqI76JvY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1FE-00048X-2Z;
	Wed, 14 Oct 2026 15:50:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xH1FD-00048R-5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vy5L0IADakmxovD3ddn8BsJkT2KcxP49soL/GVfIYzM=; b=ePoqJ77+LXouxqGKzWfBGeMW9E
 lBzO09x861KmgiYV8Pzx65YTwooexweg4JjJWHe0J3AFfkY2tUdLiPUP8kEvlmJmF2BkTU19JuSN/
 Cy6TJeSN/TpkIXCY6bT8wTMR2pPujzCmKfFsyYvbXRUmyUZFsx/S95DueTsbqO+X0rlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vy5L0IADakmxovD3ddn8BsJkT2KcxP49soL/GVfIYzM=; b=N7VIz1FM4Zelkx7WsKvDcf7J5Q
 AGtN3xAjO6ERGM3q129mS3X74498P24mO7SONG7TAVZiokhWmdXUtf3MYk2lGGjzWsOoiBQArRona
 qStUdhIDomYuE2yFOW+cH5YFdTW1OZQ9tqOQrm1h4I5ojPeIMImM5rMHKs+KAOMljJag=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH1F9-0005lA-5C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FE5D60A64
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463BB1F000C4;
 Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791993009;
 bh=Vy5L0IADakmxovD3ddn8BsJkT2KcxP49soL/GVfIYzM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=HVNA3eRShJzaSe+0ElxIZZvTWzo3g00f88U8ASc0qND/3fNZpkg5bBSZfALGePbic
 QK59Qn9KixarG1nCHLe+1EWMFSAbeMmHxr7rij2Klurf8t1qT1rJ23MR9sH2TCnTHq
 1QShwn92fDzGBmtSN5Oh7VxAy1TKMwc210hMRVIivw89f7TJ9Dw8/ng4d4agAkK0rZ
 eMUypgMU4nGW/KrPsR8lgUf7i/9EQte17Fto8UZU74kJCTFFLLF8WipRVUFcDxWr5T
 eaaO9qSiwRkJJ1+6BOI/+Gy+wIYtKUDnQbAUPbBXAm474vfyRxNp0V+gcdpx9h9UxW
 3QP1n6RQGxt3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A2B539EDE30; Wed, 14 Oct 2026 15:50:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179199300776.2827562.15669777125122291916.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 15:50:07 +0000
References: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
In-Reply-To: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
X-Headers-End: 1xH1F9-0005lA-5C
Subject: Re: [f2fs-dev] [PATCH] f2fs: opt in to multigrain timestamps
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Oct 2026 11:46:10 -0400 you wrote:
> Set FS_MGTIME on f2fs_fs_type.
> 
> f2fs meets the multigrain requirements:
> - ctime updates use inode_set_ctime_current()
> - f2fs_getattr() calls generic_fillattr()
> - f2fs_setattr() calls setattr_copy()
> - s_time_gran is 1ns
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: opt in to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/714c68e85ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
