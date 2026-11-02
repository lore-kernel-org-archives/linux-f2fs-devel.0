Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989326072C5F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i0T4IoRq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ELVRG5qP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E0qSsDMN;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv4PV/+M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6LUWvGmjBYUwInkYm/vT6lqdLro1Si+ZuW3XIN1D32o=; b=i0T4IoRqzsHlKq
	r/nI/8TyhwYrSkRiVHn84jRDpQcZKCrDK2QFAtvXP7oZo7whavt0sEMe/JtcjWBgV9TCw/YAS1nex
	L7hwud1M2U34e8MjCQNNp/lEGuf780rj6F+gQO4XdH756soaAXYSE2aYQ7jY+e+9RJAxQiqm255k+
	LWc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNuvQ-000000007zv-1P48;
	Mon, 02 Nov 2026 16:30:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xNuvO-000000007zj-3TVg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQ6GbPYMtNVed1QlpIMD9BCIvq0E83bOXm/krHws+PI=; b=ELVRG5qPE6Xq8aTSNKendzEF4l
 HCVwFsIQmzXDQNSg+p+KZqc7h6gxa4wVXZJrq8qRKTo/JhRarp7M2OJ3902psxPXHAt46UcrEIxxx
 LmkK2v3GG137azkQ/CrJgVYN6GWgoaG1mzFE9baGJh+Rnf2pruAciPY1QXjrpJ3tDkCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQ6GbPYMtNVed1QlpIMD9BCIvq0E83bOXm/krHws+PI=; b=E0qSsDMNxR+9WP9LZIZohCjHk7
 HrTqqBJPVKRJ7Pnqk6Q8lg/ZP+tNQ03lKe/a6rZrGI/A+4e4WLccsfhbpZPzIFg310Yd9sPcVW/7S
 97d823EaOfZL3+ws5rM5PCNjydXsfEIlOFCp3p6ovqgUuKtocjlcUOWd/0dsVWV8D5Qg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNuvN-000000005HR-1lIP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:30:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D29A160A74
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  2 Nov 2026 16:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D981F00A17;
 Mon,  2 Nov 2026 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637015;
 bh=jQ6GbPYMtNVed1QlpIMD9BCIvq0E83bOXm/krHws+PI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Rv4PV/+MPAdYY4I32EzmVdNiGpHkj9lKleI5ydSfzj8xISYJIze/WFcBS9Hp0NpYG
 4GZlrBgCSvVedb34m0mQYytUfA/YiU/Sq/ZU55zrIkpyK8dQoaPb+tQMvQfFAL70G7
 QRQg/db62C14Xto9OccnxpC0n/KcO5BqnhW25yLyXD5sTD5s237CBz2wFw09pR79WH
 rLDmpRhPlkumJWEXDz4SQ305dIBRWzykCMszclUhEkhiGDWZmk4IA9gUujPJgQ4Kg1
 WJ8SqwGppHRFirIdzj0bl+V28Y6gqsqJIIXB3pnChuJxzELmy81PR5owoxPmye8rRa
 qGVP3mokbIEDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D209380821F; Mon,  2 Nov 2026 16:30:15 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179363701404.39295.8939045880809671371.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:30:14 +0000
References: <20261028050615.259268-1-jaegeuk@kernel.org>
In-Reply-To: <20261028050615.259268-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNuvN-000000005HR-1lIP
Subject: Re: [f2fs-dev] [PATCH] f2fs: do f2fs_zero_post_eof_page for all the
 time
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 28 Oct 2026 05:06:15 +0000 you wrote:
> This fixes xfstests/generic/794, since the issue is not related to the
> posix=strict mode only.
> 
> Cc: stable@kernel.org
> Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: do f2fs_zero_post_eof_page for all the time
    https://git.kernel.org/jaegeuk/f2fs/c/31fa11a9401d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
