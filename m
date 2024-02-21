Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F24C48BEB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:10:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcr3G-0007qB-Td;
	Wed, 21 Feb 2024 18:10:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rcr3F-0007ps-5U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ti+2A32YJ9fpo3pbypNQ9Nh8PofVWdAhr2uMtYAFUF0=; b=MiwnhFHJPN5n28uTsVeemLe0O3
 owPV7yiS2L9EfdU4axyg2YQXt2TJS1NoeoJp88ie7d7NNEcQNOw1LnsW0n5hs+rKTdXtz495qce2B
 vhpVIsJYFLrF98Ja6/DTblXGyhxE761UHqDYCq9x8li/LT3Hssz1UPgYPkGKfUnMgSBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ti+2A32YJ9fpo3pbypNQ9Nh8PofVWdAhr2uMtYAFUF0=; b=Vk1ZgKcG7IQiUyWloFysRnDy2j
 0oARQIFxZfEefUhWXVN7Pipbc1jGM/LL1gCIT/5A9jUOZXNGNNX11oi4fd+dgoWkFASaLZKlVEfFw
 j8+9N2tZHd47+n3IH6lqkedXUFHTCitwLIhMvTqODYbxnNMqjWmcE5K8vV6qExmgjw4c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcr3D-0001Pn-Lw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 87088615A2;
 Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D1CC433C7;
 Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708539031;
 bh=fpf+8arTk6Z5iQdXwHgM6+5zvas75nnHpQQnSHAKwD8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=P1ZCwLfk2rUyT4GsM32Gy6mwVk4HWtyw91aGodg2bWt7MjexxNoEbwH38ZjZZtNso
 aMW2y63EsnjXr6V9MIn5yu35R7JP/e+RwvhOvtWOW+XlvKlkDxgrmUNvzoYc9WnmNn
 xEJeMLS8QQrgZbQ77nFGxDmJFMybqbg3O6e0Xy1L2CE6Vf2HxsdTTzBcU8Dvk2taAm
 XJGwJRWStZRxqH6pQGyE2lrR6n5MnniMmdOKn+y/xGn7SpkYvVty4lY0240/4WD1lY
 1soXKvtphie9sd0Oj3OQ7erRdZA5zVZVgUCt9HyC/9FAVbIaG5726CJgronOvfrRhc
 9qLlIe5G/5jqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D811BD84BB9; Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170853903087.7043.18353630972928163245.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1rcr3D-0001Pn-Lw
Subject: Re: [f2fs-dev] [PATCH v2 0/4] f2fs: fix panic issue in small
 capacity device
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 jaegeuk@kernel.org, niuzhiguo84@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 7 Feb 2024 10:01:00 +0800 you wrote:
> A panic issue happened in a reboot test in small capacity device
> as following:
> 1.The device size is 64MB, and main area has 24 segments, and
> CONFIG_F2FS_CHECK_FS is not enabled.
> 2.There is no any free segments left shown in free_segmap_info,
> then another write request cause get_new_segment get a out-of-bound
> segment with segno 24.
> 3.panic happen in update_sit_entry because access invalid bitmap
> pointer.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/4] f2fs: correct counting methods of free_segments in __set_inuse
    https://git.kernel.org/jaegeuk/f2fs/c/8bac4167fd14
  - [f2fs-dev,v2,2/4] f2fs: fix panic issue in update_sit_entry
    https://git.kernel.org/jaegeuk/f2fs/c/4acac2bf18d6
  - [f2fs-dev,v2,3/4] f2fs: enhance judgment conditions of GET_SEGNO
    (no matching commit)
  - [f2fs-dev,v2,4/4] f2fs: stop checkpoint when get a out-of-bounds segment
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
