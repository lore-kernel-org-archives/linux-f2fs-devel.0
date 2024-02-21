Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14798C5478B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:10:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcr3G-0001pf-JT;
	Wed, 21 Feb 2024 18:10:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rcr3F-0001pY-Pg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MJV/RL7O5sH7e27NdVo+3KvKhaYZLQM+V9QPkEwrDns=; b=BWj8E7a2JlkVRYEaugo9/3Etfy
 EFyCYbriO966N/cwWTsBxXKN4B5hYIwUGaeW/7vxxwid90wd6GSt8Gnu4XZCDpUok4HFNWWKvPNa6
 7kcJ9buWGTwt28ddujh7btH6DzAsuiRF5r2wh6Yfyo3Sa5eyDB7Lw5v6ME6QSF7BwXN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MJV/RL7O5sH7e27NdVo+3KvKhaYZLQM+V9QPkEwrDns=; b=jyW8ycnbpU5SnfywTToL+lrGNK
 jeiFKYSEfX/cNczeD2vZ3rBCiVJcY8X90s5mxuPNgk88bSv0ggzr+FRvwuNLzOUpehJ4tNjoTbEU3
 acBEwdAlNtHQi+apjynuAJK9njyWdDvLptrsU7X133nj6HSjeuzZe7DqQUYZB71DIDaM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcr3E-0001QL-FR for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5A796615A6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41AADC4166D;
 Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708539031;
 bh=Cn+JRPN2wIDYM95v/oHS3oFCII1P7bQgJXAqhNcOF1I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SPx2MTBPLj7p/PWWfcoRwENhD/ztj5c/YRViIOLzzFOgsPUKZ+ByAf/0SXiecQzV7
 gA1p4eVPnMTXqB6wPWxWrZcbKtyFMFtMakcLuEXAzkgWZGO2NNgcIGCp4XQ0LqvAox
 GgWCQuyRLseabJ0F4h4WEdFQi+r3uCVNEErjz9+gDW/ue6w+VZ179YhpoWCOETXbuZ
 25sCSkVkSsFkrkP3rXem4DS7DMYQUmewjPQBVY/XH2zJT2wv85hUFnEn9SEEd+P2MJ
 31wVhjmE5/P/Jm8ALP3ChfPH9QNwoOechiht+6Aku391lhnwra3Ya8fwGt2Mdq1Jti
 fKR4BrxUxMAqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 20489D84BCB; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170853903112.7043.10216556441891626581.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:31 +0000
References: <20240207070548.3095087-1-chao@kernel.org>
In-Reply-To: <20240207070548.3095087-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rcr3E-0001QL-FR
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to create selinux label during
 whiteout initialization
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 Feb 2024 15:05:48 +0800 you wrote:
> generic/700       - output mismatch (see /media/fstests/results//generic/700.out.bad)
>     --- tests/generic/700.out	2023-03-28 10:40:42.735529223 +0000
>     +++ /media/fstests/results//generic/700.out.bad	2024-02-06 04:37:56.000000000 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 700
>     +/mnt/scratch_f2fs/f1: security.selinux: No such attribute
>     +/mnt/scratch_f2fs/f2: security.selinux: No such attribute
>      Silence is golden
>     ...
>     (Run 'diff -u /media/fstests/tests/generic/700.out /media/fstests/results//generic/700.out.bad'  to see the entire diff)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to create selinux label during whiteout initialization
    https://git.kernel.org/jaegeuk/f2fs/c/697c9124d70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
