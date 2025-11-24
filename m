Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D02CFD34C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9inhDmDsX3hcQ0suNmIAit+lOeUhY+6q94BuR55FXpo=; b=G/iztKnopt6Eueh5ex90v0/MRj
	135GQ5ULtIxAyb2s9B/qvabSGnhvUAJjEVBwSwe7P9Vw/cCqViADgyBT2j7mAtLZVRQnwNfh/YUOh
	Khq4p5saJN+rDQwupaUv7eMTuAsBSu7aZLPOAUIsVIO5wqNU54y9j4+hbHf+9oVRpDPs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vNbeK-0008Vo-Uu;
	Mon, 24 Nov 2025 18:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vNbeG-0008Va-NK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Nov 2025 18:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l9ajbIX5y/xf/Qzk8QC66lEkE5QoyuQCz8SrC0LBVks=; b=FBtYDmUY5A40gUSmJxA4+c8EZY
 mYkaRyZMKZxT2ZUIOyeDkF1YGL2xTxfO/GGEh2oICTm1wKEF7y9SAS1wiYrulFmYm1uYd1MUDCRZZ
 gIAPtRrldKYmWcja1kp2/bknydz3mXA6lu/k9YHj9dUDlSojnfwNPEY9nymMVeVOzmYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l9ajbIX5y/xf/Qzk8QC66lEkE5QoyuQCz8SrC0LBVks=; b=J/l5DJLPDQSdvcUKuXKOWtpPqO
 LqLoHAqOKisMxYT6geCW5DStLgVBvoYQ7/tWYQa5/FgHhTHuJJ92RQZbO2uDsqXidwiCz6fX7tVCX
 oL7qMXkF4GcGUjOLvjFAS/YbTFaNVYBSm8GQ27Fgk11YbvUClXPqzh/QobyKqb00w3mo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vNbeG-0002ds-6n for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Nov 2025 18:50:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E1E5043CB5;
 Mon, 24 Nov 2025 18:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D84C4CEF1;
 Mon, 24 Nov 2025 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764010246;
 bh=bfsPXkJE7FB7meK8tjgJ4UMQE4p6ZXOLoA5SAQjd6vs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ZUUCA61inLWxUtwYFFabkJsuRTIwPb+Eqr/uezX1FHxu2IvLfiYjIS0gE/iWQp0DK
 3iKvcxuYFSbikJqEbr2q6sSqnOGqW/F5bffhD6OpjfHntgPml92ayaDwSOo4AAxo2u
 pTQdIBPNt9NVg7vXaNrC9ialV4kwrNAhPPIheGjZka0kpidKCxFYu7V2rH0sAOJ21w
 I2V03R6cfxiU5uFuFENLiyYL2WrJt8bF9Y+9FupcxGSCinsWo2wNPBAKmQfwEUDa2B
 81D1zbghkslUuQRxIWywjDmBj5dEamzjkhR158Qc6D2AteN17Cb6D31rMRIdNnzju5
 v2e7u1RU77f6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB0A23A86296; Mon, 24 Nov 2025 18:50:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176401020949.42009.2139954343027110885.git-patchwork-notify@kernel.org>
Date: Mon, 24 Nov 2025 18:50:09 +0000
References: <20251111121728.29433-1-liubaolin12138@163.com>
In-Reply-To: <20251111121728.29433-1-liubaolin12138@163.com>
To: Baolin Liu <liubaolin12138@163.com>
X-Headers-End: 1vNbeG-0002ds-6n
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: simplify list initialization in
 f2fs_recover_fsync_data()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, liubaolin@kylinos.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 11 Nov 2025 20:17:28 +0800 you wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> In f2fs_recover_fsync_data(),use LIST_HEAD() to declare and
> initialize the list_head in one step instead of using
> INIT_LIST_HEAD() separately.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: simplify list initialization in f2fs_recover_fsync_data()
    https://git.kernel.org/jaegeuk/f2fs/c/82fbca2067aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
