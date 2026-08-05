Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43145C56208
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTH3qAlrgADdxLaHY8GA/bta2sFdbs780sQUkl2qYNg=; b=XpTgYfFEpLqNqnwJl4KUTiQ3Hz
	uXbW08VDQdM2gyyF6JjaRQshAb+pdRikSPhZPz+9VwS5qrkb0zNQh+KgKfCcE51iSxDNQ4pDDlRyL
	kJbX+08mGCJAnKucXr3ynL3ijxYpVbCYRD3xBbV84HLVRKz4s9HG/c2Dalk3edGssAQc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3Z-0003F6-4y;
	Wed, 05 Aug 2026 21:21:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3U-0003Ej-Fo
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O6YtwC0deqdIglwlGms9zcrnvOw9kqN5Y1AVA19SZbA=; b=aYIZIQn8lSCkrmKf8sWF3P0QXl
 EZt2zgzeaKpGert8mIDdkKTF2SPy0ycAWq4D8kjQ4j3UQisHoLO879SGvlyQApwEL7d2SJBH2UYFf
 ykHA8LfIqj2mShCHb6U52XIk4khsrWOMBpMaPD5MNlkQPAkv7hgOItTU9Q6EqMP1lASs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O6YtwC0deqdIglwlGms9zcrnvOw9kqN5Y1AVA19SZbA=; b=XrRfS0wn1nN19tn8r4IZzVFuLW
 pNnpJJQaPJNvTiBJjeOAIt5WPeyJ0W4umRGdly9rRKvMGYqdb0wt+YpDGsg/jBDn2CPXRwhlfP4Bu
 CaOLbjPFcXvHwSot+UO84n0xVmMCVk5gkznk+wjr4GcdcU58nmiWzXw1LJhkQDtDiqOg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3X-00044F-Em for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EC3960A6A;
 Wed,  5 Aug 2026 21:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F7F1F00A3D;
 Wed,  5 Aug 2026 21:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964894;
 bh=O6YtwC0deqdIglwlGms9zcrnvOw9kqN5Y1AVA19SZbA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=oAsixMVqjOq67gwe0ttlPFrkLeNE2h7WqQF1U65miW5lDGG7WSp613RnMt64HMfK9
 UjAOu0hSY8uX34rtYyZSHfqBEDzbokGe5hpoP05k5GNJCwpIVx9DiWVu7vu3c5A26U
 41/Rx7ZcVi4wZ1v7AvQJVcqxJJYHSNoyRUKWfiLep9GkLbwYNKH7Aa32AquaC7gltI
 jdgRaWLw4EnWqYy0kiyjhjhq/EINPlNMHkRDAPyUXief3kUYYuSfha991PT46EFGwF
 Y2CqZeGuuFZraH2LPkwFSkEhw3XmHBdoDCFzTkZEA4T4BZZ38dMJpfFO/J6ubV4Lu4
 9T1gP7QRkTmwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1977A392FFD1; Wed,  5 Aug 2026 21:20:55 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485363.530543.14341101353365338544.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:53 +0000
References: <20260805122947.675205-1-chao@kernel.org>
In-Reply-To: <20260805122947.675205-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wrj3X-00044F-Em
Subject: Re: [f2fs-dev] [PATCH] f2fs: print error information in
 f2fs_put_super()
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
Cc: jaegeuk@kernel.org, chaseyu@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Aug 2026 12:29:47 +0000 you wrote:
> From: Chao Yu <chaseyu@google.com>
> 
> So that we can how in which path we may missed to account the
> reference correclty: normal path or error handling path.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: print error information in f2fs_put_super()
    https://git.kernel.org/jaegeuk/f2fs/c/f80550644c81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
