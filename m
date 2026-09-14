Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F84EC88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6KEBmhBGHjgYyKo8uHNANynF+9tnDOCFjN0gFSotYU=; b=gXM+UtjAZ7kb4bGd7kRsiCZmfk
	CUP28LlHWX8IuvKzcc4VVfclny9tFOrCIk8dPrGyr+cB/w6jYfBRTEXQkihgIR7auT/XM7W51hPwx
	aJg41L9PdtLXYgB6VlBI4JEynCCt0iKsdea0EREIXEo1ns8qq6SggR14HM/HppQCoE58=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eS-0004ZQ-4t;
	Mon, 14 Sep 2026 15:31:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eP-0004ZG-La
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Re1i4sxxoleOm+ySs5id+c1pqQekipxz63TkYx1a97Y=; b=jbpb7Gs+qrc3LYY79uUPPjMFtd
 IwBnRRscsNAkG90Ie8sgBiOP9PuYR1Xvp1GzSyy39A7/DccYuFs4IKFFM0E+C1zFe1uKWjXstF7Dg
 16UAWAE73NPJjFulrnB4ZhTheAdJJTkEhLHGnk7M7wMv/JhdK+RSKxbs/Hep461jjvoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Re1i4sxxoleOm+ySs5id+c1pqQekipxz63TkYx1a97Y=; b=ltqJ3Nk6qJtBjF7kR9nwKLwX2I
 n/AEGJXekI6kGsWo623PQqBy3Fu/qf2gNF80Ktup8f0liVV8O1YMi5QGN2/NLDkQuGszD8ukmpMmS
 PVk/bqXm9PY8vZIxZ+o7b8+TS3IFbbuqHlzEznRZuTaUlZ8Biw7vZdmZzQnaZMSWyQgM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eP-0000Hc-QW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41024601FB;
 Mon, 14 Sep 2026 15:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4371F000FF;
 Mon, 14 Sep 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399876;
 bh=Re1i4sxxoleOm+ySs5id+c1pqQekipxz63TkYx1a97Y=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=iZZjLU4/h5KOpGUjbl5lDSX2WJE3orl6Lqu+uEH2s1bJaILl8Fr9dLU/fcLRJ1ioI
 JONqn4kvX4j9Y5avy2xHVVg9oa+7EywBMxlLefGNrRpRdlTHESO1aXAFh1qVktTB69
 qU6aE/fmV+oFFkurd3mBJJthRUT3tP7i7W2oSV8rv3Q7mEWVQkVJpq9DNGzGDVPfxi
 3CqTVZsUx9vx12Ce1Nh7uAHOWqPWJRGbFqftWADOsmxcgVOemZgBUZXw2kqh5k8wrN
 Gl4ppbGtSnYp5LIQ0KEPTkkvc2ydGm5FcD3aAZP6rqPYioMcYxWk4WHjRFzKpVsq1q
 /ijvCBQOnWjpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56A063924A79; Mon, 14 Sep 2026 15:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981087.647967.11998154111003241428.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:10 +0000
References: <20260910141126.1309794-1-chao@kernel.org>
In-Reply-To: <20260910141126.1309794-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x68eP-0000Hc-QW
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix to handle race
 between truncate and writeback
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
Cc: jaegeuk@kernel.org, zhiguo.niu@unisoc.com,
 linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Sep 2026 22:11:26 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> fsstress reports a kernel BUG in f2fs_truncate_partial_cluster():
> 
> kernel BUG at fs/f2fs/compress.c:1238!
> RIP: 0010:f2fs_truncate_partial_cluster+0x292/0x2a0
> Call Trace:
>  <TASK>
>  f2fs_truncate+0xf6/0x210
>  f2fs_setattr+0x6b7/0x770
>  notify_change+0x33b/0x520
>  do_truncate+0xc2/0xf0
>  vfs_truncate+0x153/0x1d0
>  ksys_truncate+0x78/0xd0
>  __x64_sys_truncate+0x16/0x20
>  do_syscall_64+0xbe/0x540
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: compress: fix to handle race between truncate and writeback
    https://git.kernel.org/jaegeuk/f2fs/c/c0337e331b06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
