Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD1CD37B2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8ZPbg67SwUBQkvj2uEN3s0n62HkS+SJuFesJAckGTE=; b=dKdOzzupdWaJmCYDB5wpsIOBvk
	E73rp4+g3jcKDRKgpCbmoSAImKeN3hAkCNngMy3gCt8nd+09EsehJFikoAZ4SbO3UxtAKT5hUwfhZ
	UD7CGML99beCfp7iXIyvR0OiBu77Spd9a8SNyO0iVLZm2fhaumseWcVE5K6WSEgJCfDQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFer-00054u-4e;
	Mon, 11 May 2026 01:42:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFep-00054m-DA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiELqFpxaDsxs4YnT+4JIn11rlw2C/XTcy2xNgZslsk=; b=WIXRF64sVVYMMxvlPuJQzJx+yi
 hZXhV60KXFaw5ar6g/PAn+RztoG3l40GTJsy5UWh76GaCo0j0wFmJeTTHE1e4+ylK/VAm8PpCpuNS
 9T1GnBLLoFzvYHcVoZkGxyqst/bW5dde0P9SW4NHe3C+AEzfkrOBG+vaIcE5qnpqTBPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiELqFpxaDsxs4YnT+4JIn11rlw2C/XTcy2xNgZslsk=; b=dZoClzcgoX6a4QiFHbHBy43YZC
 z2jT+t4iWHJNE4sJG4m6QbkeNrk14RnFHsnb9M+3HFFjjBe4aQB4q5Jc6Gj/0GKKbdCJCZ2DHffgk
 tQCe6REAXx76rIJ5+KGvbzvUEG4nVF3YKJUXSftcxzpNd4ScUEf0pFCHcTlo2mh3U3E8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFeo-0007BA-On for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20E6F440DC;
 Mon, 11 May 2026 01:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0366DC2BCB8;
 Mon, 11 May 2026 01:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463721;
 bh=NhWA/tMq4xGZNefuWO6VqTj5/0PmjBtaHZj7SA7H4DU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=JPgqVjhWEpTDzZENppPJjtZ1YPtOnuP83KywlJ3ezAFrxNIQlhJJfvcw00a/m+qTr
 4h8JMBUVDuB3t0en1LK7R8s2yyb+j2/gMak5cHLa8eA8nGG4FpnC8gGaNqXy8RWwN6
 AAlPsQ7PqW9lWBciEV6L1CvmPksyrxYj9vOswAEVCfwLGpkr+odnA5Cd+nSjOz0t9a
 /I0dZV+76drglHeHgALvoy4dCAc91IOybTfEkDgCbW641Qf655bXY9Kb64xmyL7gAU
 GLAvNfv5lQX+IyHm1/laAJtkObvATz51nI/ErZLlcmpaqnXxvcOEn+yTKcE4gIc0om
 lJcUC9y8NqYBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FD8D3930039; Mon, 11 May 2026 01:41:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846366788.1975880.13051192544864333031.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:07 +0000
References: <20260427131050.1526593-2-monty_pavel@sina.com>
In-Reply-To: <20260427131050.1526593-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1wMFeo-0007BA-On
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix incorrect FI_NO_EXTENT handling
 in __destroy_extent_node()
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
Cc: jaegeuk@kernel.org, yangyongpeng@xiaomi.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Apr 2026 21:10:51 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
> not reset the length of the largest extent to 0 and update the inode
> folio. Since modifications to the extent tree are disallowed afterward,
> the cached largest extent may become stale. This can trigger the
> following error in xfstests generic/388:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix incorrect FI_NO_EXTENT handling in __destroy_extent_node()
    https://git.kernel.org/jaegeuk/f2fs/c/5f8f16b73b46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
