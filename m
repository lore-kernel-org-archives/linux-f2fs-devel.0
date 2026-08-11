Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF6EC5AD7B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sos2kusydGUOwa38D3qLpT+mwF9h38Vzlk//mJnhljw=; b=EXqqFGYZmiCV3uhJf+N+K8lQ6x
	DIHebptQ/sdK4qOPIpcKz6Hw/p1DD5leI5TOqQigjdZutv3XtjOPjjy3O05TosTKoqIkckNyAvwfG
	0yPs4Gk7gfzoDxZjcd+qUMVms4OQIcOKiyAxrptRbR4PagaWYMsruhwJAid+FDdrptKo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wte8m-0001Df-QF;
	Tue, 11 Aug 2026 04:31:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wte8k-0001DL-FN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:31:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVHT6kX5QrKMowaO8OuCxNwy8gtjEdyCvSxNM/PQZy8=; b=OQkvDEJUoa4D6M11AMTP7EP49f
 svX29P41WhYQgU/CTwPO9kh7zfacLMgh84R0c8cxdvaGY2ZOBZevXF+trps4nTRxcRCTelPf34YdP
 LL71zwmMy9En8sznY1d2QdiFxK8iOBW+/W1rf1BfEwcnqbxccRHlYu0EUBKXPSLdT9Xg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVHT6kX5QrKMowaO8OuCxNwy8gtjEdyCvSxNM/PQZy8=; b=heD9r2oxHRN9CeDuiGlR1UD4uJ
 M+A72gZpPYWj5VNV6jerOteacDlu8HPhlJjbjpEBfnwMuMJwDu/yYaln52SMnVF64lQBab/DYvAcX
 oyAWnyWWyKrjUq5+7H4Y5ze7KHDxYh3RJEkHr6ODLZApp20oyArIORAUkezer5DI1bs0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wte8k-0008LP-Uj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 04:30:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1494600AF;
 Tue, 11 Aug 2026 04:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0571F000E9;
 Tue, 11 Aug 2026 04:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786422653;
 bh=TVHT6kX5QrKMowaO8OuCxNwy8gtjEdyCvSxNM/PQZy8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=WSPyUyLGM9zPw2P17TRIgxUPMQxNol9fzJEa7HW2BkRP42avFOpio9ihVnuvGCS1P
 WwVef364PACNZoVKSwkz06xfmDwtHVcW3pfyzndw6/JkPjZVDxJXG2axm3FNpWceZR
 6w5iDOtiUtEVOhow4J/c3gtGWy84DZkfa8+vqoj2//nDK0vOvvyx3i+DDsjArAfcoa
 iB7A9+lYtE6ur7XzQq7FnsYbv8qqczv3W8UG41dngEFvfe0KhBN/t150n8j/VEeqZB
 +QPRs84RSFcCf1Q+XFo8QFOFp7i6dMiziu5ZgIKrHbdvYB4s60II5pCyQmFKCTTXRf
 zQRxFwF9aY/eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198AA3926278; Tue, 11 Aug 2026 04:30:11 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178642260963.332426.908773733240280355.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 04:30:09 +0000
References: <20260806014813.1587003-1-daeho43@gmail.com>
In-Reply-To: <20260806014813.1587003-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1wte8k-0008LP-Uj
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Aug 2026 18:48:13 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7] f2fs: support dynamic reserve/release for device aliasing
    https://git.kernel.org/jaegeuk/f2fs/c/eae3faf210bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
