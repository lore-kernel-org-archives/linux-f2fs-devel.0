Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24198606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LPcaZEhm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=asHosrvr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O0e++wJo;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9haCeH1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J7d4PFNKcooSVyKIV/YLcl0bRVAaib+0pip2/v+eUXA=; b=LPcaZEhmTYGewV
	QE7/TmTGvtUY5YufkoDrV5wyleNSytciHtnbE1/8C8E/kr9UIPgmGON1SYicjMowwMFFsIu4pjkap
	UEDZhwMISJDEQWNPV7C239HVIHUKTNhwBTMRG27IIx9fJU7r1OtvWhO6TB3TIZucbcimKhKiiAAx8
	zhs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO2jE-000000003CY-3YKH;
	Tue, 03 Nov 2026 00:50:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xO2jD-000000003CI-0CXV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5MqMEviFPtxk2smI/6/uFwg7z2yrrSNsVcQUUPOJjns=; b=asHosrvrCYrs1/FseKh24lb31n
 xmtMkngCWqJzioOdpGYevd8Jr/NgTm1KslmG2xpI3LBidITB3SrlvZcpUtCEPSvz3FaFls3bUs4IP
 kkbFULmq4WUYCKdS+jVzZUi9VirO3thHULQ2NZlv8Fi8xxiLyeK/rTiMZwZ5W1fVXwSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5MqMEviFPtxk2smI/6/uFwg7z2yrrSNsVcQUUPOJjns=; b=O0e++wJoCgIXNL/Lzl16Fun+to
 QyOG6Adx4bvZh0oZ89jyex1WzoAB6SIGsbQdRAUdAtX2r9nKEi0IlsEz6PosFp4BrxUJ1ewHS9C6s
 xgsPID6JloiO6683cAdDabeJJ3FJZH4W5w+z69YgjlmG+HTDsB8lQnbS+11vVilwsdj0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO2jC-000000002MY-1gR2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 00:50:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEBB4602C2;
 Tue,  3 Nov 2026 00:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8553F1F000C1;
 Tue,  3 Nov 2026 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793667012;
 bh=5MqMEviFPtxk2smI/6/uFwg7z2yrrSNsVcQUUPOJjns=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=e9haCeH1RDGNwYAf5G9DszI2hu0r1f9zDPL7mEFOnyHqJK3shPrY6696azFfTRGBD
 X7+r4/IJdgvt16Bj5cv1DOSJnR8lRVvy2aBt3xUu1tzB/WZyOlKwAmU2ESZDHN7NeM
 cr518SbjQujAVKe+SPeQA1xQLu2xL9N7A4FyQDqtOhVll1kfhGqtPjXtnuEAiRg3cF
 Ajc4aQMiKgqd67MguCYvJVrh6eVgXMUyHvOgOX6Ji5J6q6IPnFqFfS8bMfBo0IQD9c
 C3nWDrQWMP/cHpaxXhWL2w6NUtEGktwDAI6ZbvFyzMY358EHFrSOSL4nYMRfFQLIKn
 eUqrlqloJwM2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D0F3380821F; Tue,  3 Nov 2026 00:50:12 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179366701104.755181.6875860401998181621.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 00:50:11 +0000
References: <20261101230552.55034-1-dennylin0707@gmail.com>
In-Reply-To: <20261101230552.55034-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO2jC-000000002MY-1gR2
Subject: Re: [f2fs-dev] [PATCH] f2fs: report sub-block project quotas in
 statfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  1 Nov 2026 23:05:52 +0000 you wrote:
> f2fs_statfs_project() converts the selected block quota from bytes to
> filesystem blocks before checking whether a limit is set. A nonzero
> limit smaller than one filesystem block therefore becomes zero and
> skips the project block statistics.
> 
> For example, on a filesystem with 4 KiB blocks, setquota accepts a
> 1 KiB project hard limit, but df on the project-inherit directory
> reports the filesystem-wide capacity and free space instead of zero
> whole blocks. Quota enforcement still rejects a write that requires
> another data block.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: report sub-block project quotas in statfs
    https://git.kernel.org/jaegeuk/f2fs/c/9b12299b437e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
