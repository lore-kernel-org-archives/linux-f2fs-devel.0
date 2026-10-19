Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304B6079D4B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cw1I/cV0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gZ7Vt8eK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WZzVe2Ng;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9li19/3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lD4SpykQ7BGWj1sdIi13/JX25A36Jb8meYB65ufwKFY=; b=Cw1I/cV0TxIAYGIGQUFd6PfwVz
	GceYdW7UYnPWTfBacwZjd1SMfgZy+y1ieDg7PFsPAwxYh/6uZNAU0EEa2GXQW/FKha3nAGAXI9rkC
	L3T7AWaa86CwlglSUuPR3YjW940nMpBYqEs7RD4SSSU7eZjO7t8Qn8WvxMB/bnGUopAM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTW-0001JE-Pb;
	Mon, 19 Oct 2026 15:40:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTM-0001Ik-Uu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+V77N/C1hhL9FyqAqomXKSSOjqKQTkqb31ANrBdi4k=; b=gZ7Vt8eKGEG/QIz6zQoNZadCP2
 qXEw57CV5cIEiXqZGTiwUiZETZq8z1BZ41QKP6VfxlTXsgPRPbrjwpFN3DFI0WMFHpwzSfM3L83ET
 ipVVOPWMnCLiG/ZFtxt4RYplYwkl12ZWQWBg30BZn9IuuQqFRRQ1CM5ecaeieQfYBn0c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+V77N/C1hhL9FyqAqomXKSSOjqKQTkqb31ANrBdi4k=; b=WZzVe2NgYvMA9ZrTJbGjbP+M0O
 vstolFFzRtzpkgZfG+x38EUynn9v3QKq2cLNpLmxyh8A+CKUbbMjPzU/BVECOQ7x3dnkQcfYRFcSh
 YoQSw2lNE5hMpphN/pVcfuFOiiYb1RJROO+eORx+2mDUsvNlAb3hXFiYn9mDQH2YmjGw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTH-0006vS-TR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 572EE60DBE;
 Mon, 19 Oct 2026 15:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A96F1F000C4;
 Mon, 19 Oct 2026 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424414;
 bh=G+V77N/C1hhL9FyqAqomXKSSOjqKQTkqb31ANrBdi4k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=T9li19/3fZy52ILjRKJqVsjGWYfINbXA8858L5XmVyCnH7WghntxOSPg6VboSID57
 CjsneiJm3CNeusbrI3ClAU7R7JbbIYjkrEQ6DelqbYXedZii0zFrCIKD5L3Qx7v6AK
 2MsR6XEbqt1kbqWkaDe/jjOpHVvIVlA6vX2kQYdFGnr2KfQfcy8FtpWZoWnZkD6xCw
 VA3KMWAN16k008CRM7yvZYQ3BVbxivcFGRMsx3LezV2Tqxx+XxNrb7P1a3oCYTERiV
 v58FZPjwNfT6tTQbwd3jSCvRSeXdYMqbboMQ5/KGviGFsYvuyJhMv0zabeFUiC6KkV
 5OrzODbwt8O6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F151E3811A71; Mon, 19 Oct 2026 15:40:13 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242441252.2714099.14576361716575033852.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:12 +0000
References: <20261014112629.59861-1-jsjlee1020@gmail.com>
In-Reply-To: <20261014112629.59861-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTH-0006vS-TR
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix submit accounting for IPU writeback
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

On Wed, 14 Oct 2026 11:26:29 +0000 you wrote:
> f2fs_write_cache_pages() uses the submitted count, which is set to
> fio.submitted in f2fs_write_single_data_page(), to update nwritten
> and decrement wbc->nr_to_write.
> 
> In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
> However, in the IPU path, fio->submitted is never set and remains zero.
> As a result, successful IPU writes are not accounted for.
> This can cause asynchronous writeback to continue beyond its budget.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix submit accounting for IPU writeback
    https://git.kernel.org/jaegeuk/f2fs/c/6d1f622b9c06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
