Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEDCCA0ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPstllWRalUJGp/Gu47+QXYmKUs3Ox0Q3C6hLOSKKjg=; b=k+Oz+YJArNX61omxaHHh4xcBae
	FK+Qq/3WeyolGDrY+tGWaD5cAcBrjdcrqrbnElOat7f4ETxXIDUwF/mHTb1bKZsD5KZgGCkKpKI3y
	lV87qodgXjCLxonzXo5TZl0co8vqFesEjVIhpdTDjgYZLExxcX7Y5ZwGXys0Q0TSPSM0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1umxTQ-0006Oo-QE;
	Fri, 15 Aug 2025 16:40:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1umxTO-0006NP-MH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hinqvrdubEIx4nyZxx0JFbh3nHJBN2J4En0U/9ZY0v4=; b=brTM6pzI0Vg6iuI9EhEkvW03eK
 B61MI29pUj96GQIzSSQ2DRTM8m+lC/D9wP/9qGaKy78loouWrKkrmDe4e6v03Wz0rjjBIu6NLFFts
 bZBnAZz2JTWwGNkJ+CoWFi3EByMJLges8p9qVjEgXJ6GiE3VtFTXJms+h7AD3AOcA74I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hinqvrdubEIx4nyZxx0JFbh3nHJBN2J4En0U/9ZY0v4=; b=bLROIX8bsvIzArC6rl9ElS02JY
 haJQQaqAf/aNMuwNVkM0OYf75EUYXNrfeWAVDQrinLd0TSh1wFCZZJMVYGypJLncb0LoGpxZD+PK0
 ZKt0kkBXXtfU84VyOrnUaCSTpzdXoyEoDHYUyvcBcFtC8w04Mxgmn/aGgSGpUS1g+8rU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1umxTM-000184-Gd for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B2E1861142
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Aug 2025 16:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68238C4CEEB;
 Fri, 15 Aug 2025 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755275997;
 bh=p2Hrk0jNkFpeyIZ+yHC/114UdEbnaXh3w+7d1l+rP1w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gwnxqZd9mB57Jng0RG3NpBj7DJFW8UIbTzKj8hRWqcphyDm7+1AbBkhrMD+qOadzs
 cbDqJOPXXDHL9SEPpnGaG7Zh/2F14xXCRVvgOfSUezsGYpZy9CHET/uWlEEBBrLmR0
 sqAcNVraxXQDKrp09q+U/71M5TGaDXdPMFlwuwCre7x+aG+CA5ibrmGEtt+nHX0zfA
 4leLAKJbqvHaJN+fnC2mFVZKKPnihsVzAb6oZn2un3ekJKmTJW1pmzTJDwZvVExAi7
 bQ3UxOPzE254vIG9FvJFT+08IeFZzNYtJZydTXEaObw+OOoMq84QBqUUqU4k+hlJMl
 bXYsj7IsegdQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADE9D39D0C3D; Fri, 15 Aug 2025 16:40:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175527600850.1161945.18051756127566725689.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:08 +0000
References: <20250807014836.3780988-1-chao@kernel.org>
In-Reply-To: <20250807014836.3780988-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1umxTM-000184-Gd
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear unusable_cap for
 checkpoint=enable
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

On Thu,  7 Aug 2025 09:48:35 +0800 you wrote:
> mount -t f2fs -o checkpoint=disable:10% /dev/vdb /mnt/f2fs/
> mount -t f2fs -o remount,checkpoint=enable /dev/vdb /mnt/f2fs/
> 
> kernel log:
> F2FS-fs (vdb): Adjust unusable cap for checkpoint=disable = 204440 / 10%
> 
> If we has assigned checkpoint=enable mount option, unusable_cap{,_perc}
> parameters of checkpoint=disable should be reset, then calculation and
> log print could be avoid in adjust_unusable_cap_perc().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to clear unusable_cap for checkpoint=enable
    https://git.kernel.org/jaegeuk/f2fs/c/743d13d8a600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
