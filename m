Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF45AC54E41
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:50:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rfSlC-0008Ih-A1;
	Wed, 28 Feb 2024 22:50:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rfSl9-0008IX-2H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Feb 2024 22:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7pzvILSD3WuzHUuXX2CNYglpPuf9cqGYydQ8teGlv+c=; b=KcYnyfxd5Hm/f8m2l80tgm6tHs
 1AClDf9FY51vwzBG21j27cuF2D8W0UNx+PV45aEIPhhlrAuUBLRL1h+c237bP5FGNr9rFRrVEkGIF
 c0/TtFii8EdxUQFY1pQb/RDjJtnQEAJjfn262kx5Yfm7CpSyd/Lursn/A0vuR/dtpAN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7pzvILSD3WuzHUuXX2CNYglpPuf9cqGYydQ8teGlv+c=; b=QuCFWjjha8MAOTmGqoOmTusAO5
 Fyy5YOzkY8b+YCBoQLFniVKCht84l/H7KoAWQWVy/8nSugxVAUH1iK9/g2L29KzAT8YRqXdz4ZD3V
 ReQ4mBizi+n1hbU6MLICBXK+mge6mcoc70x13OhnUmXjKG3ql2rr2wKgdYYdEFwgxc/8=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rfSl5-0001hS-0y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Feb 2024 22:50:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 602C5CE231F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Feb 2024 22:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09D2C43394;
 Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709160631;
 bh=pq8vRdWD6j6IoWSZ4zPOwhJv/Db5Ok0GUTbeHCKV/+k=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mELIGUPldG1K0nHQYMA1MZ69VbmZPOymIuM6N7El4RCXHy4lO49sG+hlI7rFBXwOl
 WEpUV9iPT70yi+N43akaTpqtSkdDFMv/wjkRaN8yJhBq4TX2GLWmp6anY0JK8pjWt/
 zP4vV3JOF+25kSxpFTS4ROj0ws6Pd3mvtBrvKWSYxAQMuQrYeISKgApx+4tKaLbVKN
 Ni1vGQd+dK2pxXlHtIOfLgjNj3IgzVzpcBxP/YRteIo9o5oTd7fn0cFFbjnbwG96ra
 BM1pgb5SmhNrfT0Kd5SEvsPks5CDxkpL+8Apx3zrgsRqfShgOjyidyzHvydMdAX/UG
 puiX6mZa90gyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 7ACE9D88FAF; Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170916063149.28690.12475647856104740303.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 22:50:31 +0000
References: <20240222121851.883141-1-chao@kernel.org>
In-Reply-To: <20240222121851.883141-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rfSl5-0001hS-0y
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: delete f2fs_get_new_segment()
 declaration
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 22 Feb 2024 20:18:48 +0800 you wrote:
> Commit 093749e296e2 ("f2fs: support age threshold based garbage
> collection") added this declaration, but w/ definition, delete
> it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: delete f2fs_get_new_segment() declaration
    https://git.kernel.org/jaegeuk/f2fs/c/134c289f5e7d
  - [f2fs-dev,2/4] f2fs: fix to don't call f2fs_stop_checkpoint in spinlock coverage
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: fix to handle segment allocation failure correctly
    https://git.kernel.org/jaegeuk/f2fs/c/6ca83e9cdc51
  - [f2fs-dev,4/4] f2fs: introduce FAULT_NO_SEGMENT
    https://git.kernel.org/jaegeuk/f2fs/c/251a769d3f50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
