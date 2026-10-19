Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8460774D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NKouWgSX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WKAFpG5a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gia/uxpN;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkONaV4H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yI+TugOy53KrvY/L7WOYp/RxE1J4J1RULz8vb5+c7hg=; b=NKouWgSXG7bGdTgtGBIVBXsN08
	tQjxwge2wPc9J7P2KpNhmm2xa+VHfheE6Kn4F4YgNQjxQZy20AfQ0rt6lZCpYP82wKsX0jtxXGZUk
	CUWW/qYkeaSfwFlNnGy7kUK9hwiru5Ji+05ad7dsGk7GmAC6ndGyCxSTZ22F8OksZeNw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTT-0005rT-74;
	Mon, 19 Oct 2026 15:40:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTH-0005qh-Vp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ci68KtTSQTCl4pbfvwKLg1OkLhRNMIEHq1Jt8ehNTxo=; b=WKAFpG5a/WtDaCqHkawf2gorp9
 XSxQ6lkqPDKCeZVEUSLRyCDo6aj00JnyYX01Uz76FotocLvO+iUwTa2FUIp4Lzf5cVXN+AltGXkFp
 Rg/B64pWxx4d2CFx32L9DQ0Iz5dzDmVd4tp+OcdFR3qYoPgwlVRWEuefD0hbDVB+3GoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ci68KtTSQTCl4pbfvwKLg1OkLhRNMIEHq1Jt8ehNTxo=; b=gia/uxpNDrO8R7lmZuZsodO/xn
 OqThoE49kawORgLyoONTKkHDH9wwaURUKubi0LyShLHIrY4igYFe+VuNUtbsM7E0unUlc6Y2ZSj6G
 ar56V855yqvjL5zx8aWW9GcNsFbmot5m0QlImlTvXgZKKiLKEvUeSCJObKCYYt6udSs8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTG-0003jX-D1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D071D60DB7;
 Mon, 19 Oct 2026 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8428C1F000CB;
 Mon, 19 Oct 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424412;
 bh=ci68KtTSQTCl4pbfvwKLg1OkLhRNMIEHq1Jt8ehNTxo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=GkONaV4HRj8e4w3XbHTPLKmyvsviiS7aCu3NNC0DfdaN7+IJMrsTQG6M3XnflUFVe
 ll1qY4GGT8sjT4DkcJDY6l6HSCz+C2BdNOw/TJ8c2VxXCNi9r2smBYZAkplUfbaPXc
 7HEWWUC7R5hZm/CIe0qa88eyQDjaZ0ta30zyHnK6t9M4aTJF3TJxErSa20daSknFET
 S06VW3S+ZP1dBVhcOxqwI6RUupWtfpIZjlZSTT9BxPhAOKtViG/62nvNmY0wjsnD5w
 XOtJZussZOpV5HezZDeOdutJ7+4iFb/qX3Kgo/LpJNm4IJI00ZE5ICxRjyBLX1WPll
 EcKpeKpORF5eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7741A3811A71; Mon, 19 Oct 2026 15:40:12 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242441102.2714099.12259742398143364059.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:11 +0000
References: <20261015161714.1586334-1-daeho43@gmail.com>
In-Reply-To: <20261015161714.1586334-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTG-0003jX-D1
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't use truncate_inode_pages_final()
 on live inodes
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 15 Oct 2026 16:17:14 +0000 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> truncate_inode_pages_final() is meant to be called from ->evict_inode.
> It sets AS_EXITING on the mapping, and nothing ever clears it, to tell
> the VM that the inode is going away.
> 
> f2fs calls it in two places where the inode stays live:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't use truncate_inode_pages_final() on live inodes
    https://git.kernel.org/jaegeuk/f2fs/c/256d5e27eda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
