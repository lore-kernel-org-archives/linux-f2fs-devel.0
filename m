Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3694C3ABA6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CMFE5opfwvbD2yJtKI6Y/mz6d4U19hlz+gH2RyFXRkc=; b=VzYTYMa+kL+0Nikk21d+lWjve4
	jgUpyaxA03OaZgoV/N9fqIg8DXdI5DgNCrU+DQOCuJq6Pmwm58GbPgUOxJifhrqXvhrDnoe2CSAbv
	VyWssXak7xBsjuAS5t69OxobUMOx1rlOYTPC7CZQmwXDKZxRTWmE4ciZVjYY3xR09Lgg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u9X9n-0000jc-B1;
	Mon, 28 Apr 2025 22:40:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u9X9c-0000j2-Kh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 22:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HKimIXNGiqRxMkmsWYINqU+Lno0Syllh/HEFB17I9a8=; b=exgW0NNJ4FMSHqlQfdT/d6ZDBa
 54yvKhOA2Odr/4TlITcDKrfLs91URqw4R4mJhLD3j/vzUn3z+pymfGJ+Uji9yxyVeTBh69czYwb/Q
 xTVBx8ygw3H3cKcpKM9WphAbxk3GrRBFm3ezSq2XG51iMBthJPP9+AynZbQuPoQTkJ5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HKimIXNGiqRxMkmsWYINqU+Lno0Syllh/HEFB17I9a8=; b=jznOX81xrG2sjEG+8CBp3tIntr
 7x8gzqWC8BK2tUxlFmF7cp6gwEymL4wwMRFvnOoS4FWZT4qXH60RZiVB0ezGctzLaAXEpOGutRuh5
 I0Utx62SELevlnxpDI/nhqB36m2adUDViBsLDhQk17QDYWimwc0jnEWZygt//2jhGrpY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u9X9I-0002KS-H7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Apr 2025 22:40:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 263FF4ABB1;
 Mon, 28 Apr 2025 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D189C4CEEA;
 Mon, 28 Apr 2025 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745880018;
 bh=xR58l5ApOwkgDREvZIoci6c6A90X/0HtsU5oc8bqiEc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=pxjCt+Mx1daBhAgH7Kg5hP60oSgkR2jVYst1meRjjHV8TRPyk0lZWN6F9ZS3V9vFe
 RF8W8qxGIo8WM3lTA1PNEHCIImaOzSUBezmqR1Cy0Wf/v/5zu8Cn4RhKY92wEwQmIf
 4mvQ2gvt6qQiiSohy6oZ/o/UQ7U//k9YCyHKCC1H0nUePxjcZdiqIfri57bQ1v2hhN
 CbM/YbtYC+6J83Thk83QOR0cZixk7ZuG9JgTyIziGbzaXXGy3WHE9WYta6BdSf1Z8x
 kvocfGJfbqM+nskk6chqeq3xI0r31DFBk5gg/OEdAJtVx0TdBwVYzOi8/ibt/CVurX
 OslD4f6xE+taw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33A163822D43; Mon, 28 Apr 2025 22:40:58 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174588005673.1067750.3162104682532482124.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 22:40:56 +0000
References: <20250410031019.2884852-1-chao@kernel.org>
In-Reply-To: <20250410031019.2884852-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u9X9I-0002KS-H7
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: zone: fix to calculate
 first_zoned_segno correctly
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 daehojeong@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Apr 2025 11:10:19 +0800 you wrote:
> A zoned device can has both conventional zones and sequential zones,
> so we should not treat first segment of zoned device as first_zoned_segno,
> instead, we need to check zone type for each zone during traversing zoned
> device to find first_zoned_segno.
> 
> Otherwise, for below case, first_zoned_segno will be 0, which could be
> wrong.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: zone: fix to calculate first_zoned_segno correctly
    https://git.kernel.org/jaegeuk/f2fs/c/dc6d9ef57fcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
