Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF92C88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqYqVVzDGV92WNp/fUmR06ybAZiuznJ43ksPG/hCsnI=; b=fKJfFfa0pB4zb++uNb9QBwNU3/
	pEw/OK/Ll45gJ+ZrM8u1hgszLj8vUZoJcOGd7LkR92R5Nu9vlOekLXKiGS9+KHGsynW7m8nAnjiqm
	e+xOhVhyB6d7JvZ2gdQ1ZK4lOx5V6lyFsgHJsS91H79bqUJDPduQYv6DPGHjK25Gclpo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eZ-0004wZ-M8;
	Mon, 14 Sep 2026 15:31:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eY-0004wQ-D0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqSWZGYuhnFlJXQSdR+kjRpbfk1iIuI1HJbA/iOa23Y=; b=ib8wWTRwyCIXff0l7Ilp7sauWV
 y3BQLvILYIiOExZypHs9RRZ0O9OvouLbYtzRrxvU7VKJFrfL7f86MhgT6UZ+mOlh7erbxD/+24ojj
 ffjjKTAIDkR82XQJTYRCgiRm1A9EyHXUJX2S20rKIL23BAeIDArBPBkApUl6V+jMey3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqSWZGYuhnFlJXQSdR+kjRpbfk1iIuI1HJbA/iOa23Y=; b=lFBaGCW+OILmB3w2nBLVNSawuS
 0b3YdPdF+AOeXxxmWZ0AiOBVD5er9jc6lcx5/l8jA7CORA8VQFW6ZgDb61WxoqtfSKzhdId6l94j4
 mqN/+w9RHACT2WxzMiXHiZRbRUNoHYRHClp6aAWQ3uSd6rEElgf4/j/Mdggzm80gS9tA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eU-0000Ht-9c for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B780060261;
 Mon, 14 Sep 2026 15:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FAF1F00893;
 Mon, 14 Sep 2026 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399880;
 bh=xqSWZGYuhnFlJXQSdR+kjRpbfk1iIuI1HJbA/iOa23Y=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=VujuA2KihdFCeodvSWGo1fbwVB2MLxRvs+ISKWNyLtk1+Pw6nzvQt+WZuy/SQmSA+
 KVuYlUBkm0YxB0aNfqfM1t2/wuKV6QL5q2fOu8IrPc4A0d9UQLV4bRVodNkusS+TBh
 QmBpe0W/t5104bV2X1jYy4Rb8gF2TO+XCUtHoSSceL+ef2G0WuQ7JIpYUnEBrd7MJR
 HFNHMPN5QUiE7e7vi2vmqczq4JcsDkWZcfCaaCc6yLXs9JmaCXHtgZBIrNFMlrUTCU
 oewMycPTElaenOut9v+CIOS2XgFiM0PMh7V5Wm95n5ZtRpamm0aZHdG2A9PW5MFUIx
 /LFsjb+NDkf/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0AB73924A79; Mon, 14 Sep 2026 15:30:16 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981537.647967.8184641811799373916.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:15 +0000
References: <20260909190636.3151580-1-daeho43@gmail.com>
In-Reply-To: <20260909190636.3151580-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x68eU-0000Ht-9c
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix livelock in syncing dirty inodes
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  9 Sep 2026 12:06:36 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During checkpoint, f2fs_sync_dirty_inodes() and f2fs_sync_inode_meta()
> iterate over dirty inodes in their respective lists. If igrab() fails on
> an inode (e.g. because it is in the freeing state), the loop continues
> without moving the current inode to the tail of the list. As a result,
> subsequent iterations pick the same inode repeatedly, preventing other
> ready dirty inodes in the list from making forward progress and leading
> to a livelock.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix livelock in syncing dirty inodes
    https://git.kernel.org/jaegeuk/f2fs/c/e398da0b9131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
