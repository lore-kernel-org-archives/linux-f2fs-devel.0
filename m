Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F523C25B4F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5awm-0006R3-38;
	Sat, 11 May 2024 00:50:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awk-0006Qv-3Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3MVt0UiFgAet2QDl4SQyYQ0atXMs52SX1aFnokFI6H8=; b=DjUsF7zDXBOzZpTgvx+98ntof6
 sAUKnMiLo6LJhM2jpD5qMvTuPkqEXnp1QbU+ygvrGGrOe7x6sVOSmEQZwhbXiRySkN+UFVCydOdLk
 XCeutIpWRqRRbu9deeiwJlhyMoQ7vlqb50wnLXyNYYLUbL2TlY9nSx3l8593JWHmkbw0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3MVt0UiFgAet2QDl4SQyYQ0atXMs52SX1aFnokFI6H8=; b=DUTnnqWvVsnf0buIAPoWKNWJal
 yO7RoiaIIY2wOMOt/nqPe7JJEh1+oGqYmfX27JPk0vvPXl4eJpmLOsjQNeWlj/yQ57pGK8PtleYVU
 jkf+VXIj8Fs/PhZLS/sXdL3nnSn3z621xi6xMdwRQejrrlh6NubcUfpZXW9AYcZbziME=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awk-0004yp-DE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DEE98CE1F35;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF236C32783;
 Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388633;
 bh=IkWSIHrbqZTzX+fRBRe9yxXll9h/oBe+bhlmPQRjqqg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=uTO9iWfy46Efpenyx2YM6RyEWSplVynlC9UdGOWU7qe5eWsdhDAFL2DzyDUXudYRO
 IPKCoj6mNJxQfiG3OR+b4EgiXadDo1V59AmCZ3r5XScJbrKf3sFOqxkIsw7eToA7ih
 lq0gZSG89H8JHxsZSYnpShSx99GIA4YlVhOmYgrzQBbb2Y7bAsZAQqeJK76FaoZd3s
 WF1g+io2zV4kGT2By7OfPdeX7IesR/FedumsurRV9bSZh0oS2AAPnj40A1IwYrXfdQ
 HIKgOjPGFt20hBTJsVftwcfCbCszM85O0OvaN+GkV1s8qMddEWhz43tlFO+rzMC6hb
 v4+9loL4G0R1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CC03AE7C112; Sat, 11 May 2024 00:50:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863383.11229.16017084763139644395.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240510134908.3271725-1-daeho43@gmail.com>
In-Reply-To: <20240510134908.3271725-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1s5awk-0004yp-DE
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow dirty sections with zero
 valid block for checkpoint disabled
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 May 2024 06:49:08 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Following the semantic for dirty segments in checkpoint disabled mode,
> apply the same rule to dirty sections.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: allow dirty sections with zero valid block for checkpoint disabled
    https://git.kernel.org/jaegeuk/f2fs/c/f2526c5cf1d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
