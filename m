Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A017C5478A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:10:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcr3I-0007Uc-Qq;
	Wed, 21 Feb 2024 18:10:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rcr3H-0007UW-Qc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vsgyKT1p4Atrla+EutEyOqe5Ay5k+h5nnP9vUZvS2oY=; b=Z1tINbE5ubGw5kwATo/a8HALPa
 6EKPqQFDg8WZX3P7qjDCHv0kQCdOYD8PCmR71H0z4Lu657JGSK+NZAasjLB+rGrvBANGE0yUEIT7D
 frE5RTRqNawlhreugbRmsdmj13fqe1vttlmiYN11klmmbbd/P7iZNWlck8DX1sjCPP54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vsgyKT1p4Atrla+EutEyOqe5Ay5k+h5nnP9vUZvS2oY=; b=aHz5+pc1yd/jFO7atrz6nhqIl6
 FfGWJILlEKZvXlzPFh3wdBluDlCYRqAhtuxkmSgJ+zkb7E/btkmZFyJqOwbjko2pHvW+2Ex8gqaLg
 qH1GpcC0ZiUUYFSU5hAfm7n4qbtfez8qBcKyRY47P8/5048NqB1icz8qDVi7H9888lng=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcr3F-0001QP-O6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 18:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 61BDDCE1F24;
 Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102F8C43399;
 Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708539031;
 bh=m+WgYxlYIKix88Gefl0qOHfj0XJUP9gj9mnEbpOqYwk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PuLDK1fF7Z7eEJ/258n6I6WDfnqCl2/fyH+dUS6tLkQ9xxUpIZHaQKwI8UTrponrL
 MuUly7g0fl2X1yfRSQG5esKwtyO2KaBu1xkSZhj1/WsULNjY8JNbG4lp2PeuIGKEUz
 +FtMrn8C2SvwBX5HAWRRfy6HEv29Sbr+en0D8lKXCA92Yi72+Ac6ETZ4TsSZ8D+Kos
 oCc3npGr2JUd+m3FNFgnt1KlaPGx93QZsMDf0KPVTZOdhQzbfr1FRgu73QvaI1jQcq
 POiBC/yV0zP8Xqk6QMexhLj9jVzVQ2gd4UM3H0wgjZlrSbxMdR+u2ymVEZVWriHarv
 snVmisN3++14g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EA033D84BCC; Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170853903095.7043.8191554159559684336.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240215201633.2365333-1-daeho43@gmail.com>
In-Reply-To: <20240215201633.2365333-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1rcr3F-0001QP-O6
Subject: Re: [f2fs-dev] [PATCH] f2fs: support SEEK_DATA and SEEK_HOLE for
 compression files
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

On Thu, 15 Feb 2024 12:16:33 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fix to support SEEK_DATA and SEEK_HOLE for compression files
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: support SEEK_DATA and SEEK_HOLE for compression files
    https://git.kernel.org/jaegeuk/f2fs/c/ef952ede4a7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
