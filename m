Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869BCC3ABCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJJ1-0006w7-Oi;
	Mon, 16 Sep 2024 21:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJIz-0006vy-Hi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=THCdxlK8EY4aV8bqpMUlgSGegwd8dPSYmfoXgoQoyew=; b=NZnCg4LSQsPGmJCd1aBOrTmbiO
 cCZfYHwjiOELZGuV9LhWpGMW6zSqwX9UKkOHbHz0sk5SCR0q5LonQBhlnWkcVfCuRnzvJH0SkR7M7
 7IxKV6CtDd3H8XhuX/aNCS3aC4idUQ193GpIPGTYrRpknFDFnULdkAitfh0KAIdi3q0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=THCdxlK8EY4aV8bqpMUlgSGegwd8dPSYmfoXgoQoyew=; b=LGM46cmQz15ZXtjQz6gzNboLSe
 hMn+DekosFKLaYERUgbUGNtkCFzaOgYoaxbzPXyKoBcy+tPocWk2vb7gyumfdpwj9CXqi8WuvzBZe
 accH7oxroZj9DUgdT8Dmthf4n/hALM05n7yYKGK8Shsr/52uyYXPv/JQhtrb6kYGBB0o=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJIy-0000OK-93 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AC8A1A43270;
 Mon, 16 Sep 2024 21:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE84C4CECE;
 Mon, 16 Sep 2024 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522233;
 bh=TZJ1GBrIg57PXXnle/QW2Qy3nJQgUO8q3yXT38KZQdo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=i24MWzelxezgQxSfirUpYeLLLHeYAzmNit8b91Xpdk7CBOSrx5eFZ49KRW550cHhg
 IRtVfT7OlXttXRjQMvWL9ucN9po1OXyUZ1suGBO+8zR2ZhoES4l5K8i9oh+vJQ56jp
 XrJmIbaZZCOaRild1wTlXp09nbs9fqybO7yYP3sXM6xT+GIv1DI1Z3vl6gs/Y5WuaO
 53j3Qh9ZhNI/heP2pOvL3IFASIg1YXRLk2DNRJtCiWYmQ2F4eE8rlDBbTKATkKokFR
 yT4FVgjGd0Ru32MgTpBxkJL4fHYuHwGSENKp1IgnkhASQFjhCaA8BuE82hbYPd6i/j
 nT/0kZEEdQ+nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB2133806644; Mon, 16 Sep 2024 21:30:35 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223449.3820990.9890904559085171308.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:34 +0000
References: <20240910011619.3582861-1-chao@kernel.org>
In-Reply-To: <20240910011619.3582861-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sqJIy-0000OK-93
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to don't panic system for no free
 segment fault injection
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
Cc: syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Sep 2024 09:16:19 +0800 you wrote:
> f2fs: fix to don't panic system for no free segment fault injection
> 
> syzbot reports a f2fs bug as below:
> 
> F2FS-fs (loop0): inject no free segment in get_new_segment of __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
> F2FS-fs (loop0): Stopped filesystem due to reason: 7
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to don't panic system for no free segment fault injection
    https://git.kernel.org/jaegeuk/f2fs/c/65a6ce4726c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
