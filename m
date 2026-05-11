Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01871CD37B7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mzznsFavQX365gVrEK1R8p7ahvHHSsJtZolTAvap6U=; b=mZxxCBSx39f9qIjF+etXo81IJ4
	BPxjXWYqIeafbQpE2Rcoi9mv8Bna+3m6V408OvS27+TwFCNJ5d9x8iK6TWwHDr8AxCH+S40IlXB8o
	2LeUR8S8QQab6oqIJB4lfPuf9naddaAWMve90KBzh9QyBABWt9vCPGyCaCdaep/Mx+Rw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFf3-0007eh-Dx;
	Mon, 11 May 2026 01:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFf2-0007eR-6u
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k85OPsfKWF2RC4sbbNVtl36yYVyC1B8DNxa3qCj21dc=; b=HmKoO9bVI6wxbU8Sa6yKWbZwnm
 DM5D+oadoY469UAWOM6Mnl4Ho5wdeoSUqhlwC9NP11mUvwujyfn+guXxPCDHWvD2Ggd56vZmOroeb
 A3B3oPXkQjqljUtzXJzEhQsNdLBWOaXWuMcL8DUmzg5EGkhiltiUzoqkcABcfk+w+iLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k85OPsfKWF2RC4sbbNVtl36yYVyC1B8DNxa3qCj21dc=; b=XlSK0JHhdve7PT9/Jji1gRY0HP
 8rhbc1KooXhuCLYjD21bQnM0FtzDCAL0u+rfixPgsUXHXYbx5TBFNNDz8qsZhY/FwPVXdjzf5JBA9
 yTtWFA9YRso0ErH3ya1wCS8L3TjcRLKQjC0m06pmrntlG2wsBVgYV2ZZpJ5ioi7R+H6E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFf2-0007Bs-Dh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:42:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D3D8060154
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B74C2BCC9;
 Mon, 11 May 2026 01:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778463729;
 bh=NmVfKOaFjJgKYO/j5WdidI+H2mSSkRW+ppiPHA3/BAM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AE+u+HkvCiKXIR5j1713mTMkO74oDVUTr7B9v2dJr0+miqwYWUg9Ua+hwlqQNLh6H
 5dBlpns7cqfYQPLPmxAKQPffTE2CRu6XMqLpOCwdO0CX0e2faZjBHEuL/0f04FEtbH
 iQ+mBUFzHQqh3YCGArBlczC901KKjomavw87Gdw6tlqf5Bd2+WUFU2QCa2kblqRB06
 aHFw7HBU4muct/DpXLszOZ0AIyZk/0iMPrdpEZdlzym/I06g94A12DZfvylZr9Xk3J
 5GyaCUmelRvWbL7lwCWpKYo7S4Gis5mJQyF3wK8TaCZin54uY8rsIDtNMP88wX56b5
 NJeHTjde5ToRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02BE63930039; Mon, 11 May 2026 01:41:18 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846367654.1975880.13400565434269421291.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:41:16 +0000
References: <20260422104847.11243-1-chao@kernel.org>
In-Reply-To: <20260422104847.11243-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wMFf2-0007Bs-Dh
Subject: Re: [f2fs-dev] [PATCH] f2fs: doc: fix the wrong description for
 critical_task_priority
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

On Wed, 22 Apr 2026 18:48:47 +0800 you wrote:
> The default value should be 120 rather than 100, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: doc: fix the wrong description for critical_task_priority
    https://git.kernel.org/jaegeuk/f2fs/c/ff9e72dbcfad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
