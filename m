Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A01C54E69
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:45:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rmJrf-0001Fb-85;
	Mon, 18 Mar 2024 20:45:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rmJrd-0001FU-7z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KRr5vJvOVjdoLGzYw2JNnhIiQWpaA1JFW97U99kV8ZI=; b=KdhgSg0pJnUetvKL4PP/47RiOg
 QSgTrb0X8rC1xKUpy75Optnd6RJKqkxJL/obluOmXfJ0UUHqdB4V1fD+7ePjiBTzzD0phifHlNHYn
 D6UZIiLCM6aa9dsT/w27tepmQFr6GR1tyagif0ZB8R7QUyzJD25FrxpfQ48cCIWjigJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KRr5vJvOVjdoLGzYw2JNnhIiQWpaA1JFW97U99kV8ZI=; b=ZZ0EU6su/NJNSCDB1MHq7Q+bSD
 fLlt9TnceDlFdASoUKySGHeppLyxh8HGDJmBzC7GF8NenQTLxkBuXNM61uVX8N7eJ8Lk1VKirmIRB
 lBNuBfWk+/roVTuprIEgqD8v1kpxqnzN9d7n3Hkri2sz+eSAWcL7RTC3yPG1BsJ4t1RU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rmJrR-0002IY-Ly for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 436E8CE0B69;
 Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 511AAC43330;
 Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710794733;
 bh=e1W0FzEGD39JFbH0tf9seE7OutBkd433XkofbK52qfo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=h7BbxxomMPArD9W8mF0GJMXkgFumxEJsSFX/qt7UZ2zJyCocu8jq5qzzH/SVf50tk
 5HJwPIoMfoYkKsyWBfxqpmsAsxMg65A85MG9I7CE0IohgtbXvjz53vuspr/fF4Oyi7
 AKgsKj6sQCoOAB13Oa0tG3BZhFlVtdrE/ZmkXtmV/krFuTON5ZZIltdzijhDJ00W6b
 ovVa85M57DEllvrA8H2QZvsIRMAUXFjS8gTcB/UQ2AkxlSJCalbiUhGKU0xiP1mjbG
 +K73MuT3hnHXjG8OnPcBUr/fj8f/BEUuRKn4ZVGDyPGF5NvzyYWJh904ZvsHpXRkTh
 v8GElcsxeJYbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 39D7317B6478; Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171079473323.25373.9240563130828543134.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <ZfiBt0gRe_Elp7hE@google.com>
In-Reply-To: <ZfiBt0gRe_Elp7hE@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rmJrR-0002IY-Ly
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.9-rc1
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 18 Mar 2024 11:02:31 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.9-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/c5d9ab85ebf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
