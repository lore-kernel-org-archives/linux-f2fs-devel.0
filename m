Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F7CAC5BD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GVroef6twxs5C2/FN3Kjezm4ZNZmCGPbPgsEYuCClgs=; b=SwVhgOMY1KSZqRCt0GaFcvDO3G
	73LeCoFUwyUiTLPD+BuKEKbvTpsB1yGdCwZ01GaIeolTr1LhBJD1GZoc8lgYsMNV60xwISYUYKbL0
	9LSxEGTnplUVJAriFNYHqgcA+c4iZxgNF33rYYXdybgKzOHDU8MFI4QybfOkMFf5qLDU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3MOO-0007za-OO;
	Mon, 29 Sep 2025 22:30:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v3MON-0007zJ-Ax
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+AS6uec0yTwSXvAUuGJw8F4jea3fLb3Zo8xH8nejts=; b=TguIdu82mkur5IQHX65TPfbLlf
 z13tw7slD6Grr7cwlAuG5gp+BYmQO1XDckMlbakeTHIkk77BwYz6aRdb9nFFYJ9NAMH+0lH+4Oy8Q
 M+0VRIzqpc7ndsWjNsgYotOZUpKDhdHbALw84758SzcU6EEcUeX943wfj1AMgEp0B+30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+AS6uec0yTwSXvAUuGJw8F4jea3fLb3Zo8xH8nejts=; b=SWH/cRErdXEWtjlKmbWic2DTDA
 LoWSXK+K16YFtq2NxTOsWrIwX30WxfJWxlAgISE91wnhNma6I0eU+XOj0xVXOMnWAOyBf9oqw/bkZ
 PhJyt+2LVW/rr5UrwIb9TPXcMHLAQOvfdTfzHzYQbMaDxvn3ap/mccODXVEh0i8ASFW8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3MOM-0005OL-QF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F82C60278;
 Mon, 29 Sep 2025 22:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E5C113D0;
 Mon, 29 Sep 2025 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759185040;
 bh=aQAK/k9mmfxKrAqNBeXS/dBzTkpkQcyv7mduu3pCvpo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=O91s7ILHHS0A0h03M6g070586dVXe2R7U1+bvZRPgrH39kKcq7K/fJBhQqOurDyiK
 AjmCuGVMgUSFTs/9aU2zKZqjWp004q41v5wugOrM2cO1p+/BXrT+os03JyjYcPwhOV
 StAYRQC76HBgnHL2cJ4fZffsVqcVWWkVSP7wUQAnsiWESpeR74lZOnwySBi/Vvz9rq
 wpC1eQh64pjixXl9K4Lfj0a0KFPqezy0p6SBvJhX7V3wILC9x2G9hAqy7E2gARfA++
 X2CxwdBmWVLxPo0h52H1gkM/z5WXsINw//zaZxNgt1HOF4QZM/i1wqiJW9VM6kHei5
 sTxg0Fs4znhVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADD9239D0C1A; Mon, 29 Sep 2025 22:30:35 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175918503424.1733438.15522047521357961173.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:34 +0000
References: <20250917023622.516052-1-wangzijie1@honor.com>
In-Reply-To: <20250917023622.516052-1-wangzijie1@honor.com>
To: wangzijie <wangzijie1@honor.com>
X-Headers-End: 1v3MOM-0005OL-QF
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for
 precache extents
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, feng.han@honor.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 17 Sep 2025 10:36:21 +0800 you wrote:
> Script to reproduce:
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: fix zero-sized extent for precache extents
    (no matching commit)
  - [f2fs-dev,v3,2/2] f2fs: fix infinite loop in __insert_extent_tree()
    https://git.kernel.org/jaegeuk/f2fs/c/23361bd54966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
