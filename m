Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF8CC3ABA3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fP/i6Dv+VV5Q3SPs81H/kOJakoERpEQF8AnfdWEF96w=; b=Fa98ALjQa981hMDjhdLNrXCGfv
	b/IFMyNZjVaH77807KHnzf9wOoCZrFVB35z0g8ERibJDpRzS/Doqh+slSfiHb9LU8eQSKUfVbPNKJ
	vghbQJ/Ztlc+GIycLS4nKqvG8WqqCemwRxRSAF3ERYuoe/yZQCJk1u2mGP8QWuY0Vr94=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u9X9j-0007az-JA;
	Mon, 28 Apr 2025 22:40:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u9X9V-0007ad-NF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 22:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5EG6ARqWUnf4AKpY8kklwApEokTX9deegilECZyx2fs=; b=i4dY2Gwfuu+62MSTjndVBtOb6O
 c+1uRpt7n9YEu6sgi8pjdXAuQYHxwOQmCg5tFgk9x2322NDvs+Vx51qnrQDZCBIANtDFFmkjsJEsl
 NcSQDJsxyC29Kh+qsiF9r9OTGhkdVX50vpFNKq2kkWALQYXguJg4/gh5Aca8yK4E9VDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5EG6ARqWUnf4AKpY8kklwApEokTX9deegilECZyx2fs=; b=SFOESiHuVM2y2geINjJXHsfhgJ
 1hCpeRed3bMR3vKXRGWrkS/cQ88Iw/sryX/POhQw3hROPajISYNMomr2vZmtSK6N7Z1nzNorRqVxw
 CXPAbkwnXswYE4bbkiNd5pbKcnY78EMfjU1Z/PeA5THEM3ozLTuHiqBZa+MRM8APhWgc=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u9X9G-0002KL-3u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 22:40:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8F6A7A4B82E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Apr 2025 22:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145C6C4CEE4;
 Mon, 28 Apr 2025 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745880015;
 bh=v/Su/UmcjapUnnbzXElP2Fk3eCsS37fa0S8AqyfFp+M=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=rFqrFQC846A/wYL/4c19vZPQvb8fJ89UiUU7+qMORA+188ZDkZvnPOOTJsv5oKyLk
 HvAuWc0TVqH6fW2OK0nxCdr0YIY+/VuPeubPgLa3RAnYpzQjiP+2rL9N2rp35cpgPg
 pY3RMMeK7ehfMeqQKQhMplsDVSfU0q9twVSh2vnW+d8W+747yj8RfBEFz/WSToFbJ+
 HKTkGDv5wtuMcMnpb68f9Ch1x+5YO4PO5Fw7mm3PdyGSQ1nwsjYXf3ER8rgaozOFgc
 rx3k/rXxZwnp0eE8P+n03++6pCRQEew5XvW1zSQjQQOFAqxRNjEs0TQ3rWM0EKZvSC
 x9AhNyOIsAUcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33A343822D43; Mon, 28 Apr 2025 22:40:55 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174588005399.1067750.15578791704734066761.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 22:40:53 +0000
References: <20250414105237.728522-1-chao@kernel.org>
In-Reply-To: <20250414105237.728522-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u9X9G-0002KL-3u
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: clean up w/
 fscrypt_is_bounce_page()
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 14 Apr 2025 18:52:36 +0800 you wrote:
> Just cleanup, no logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: clean up w/ fscrypt_is_bounce_page()
    https://git.kernel.org/jaegeuk/f2fs/c/0c708e35cf26
  - [f2fs-dev,2/2] f2fs: fix to detect gcing page in f2fs_is_cp_guaranteed()
    https://git.kernel.org/jaegeuk/f2fs/c/aa1be8dd6416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
