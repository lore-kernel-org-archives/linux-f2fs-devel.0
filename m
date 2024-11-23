Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E9FD75E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 23 Nov 2024 15:50:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tEsP9-00061f-Sa;
	Sat, 23 Nov 2024 15:50:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tEsP8-00061Y-B0
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 23 Nov 2024 15:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xAIuNU5ZYng/C7qQieVjvYjkkYjU4omMn9PqprxTWSY=; b=GnyO0EBaI+1uhpVh4+kMIn1DgH
 UBS8gwg9toTJ7TitvCQ/Araq+LtyVnE+4HdY0+ZsPiYX+mqhaIb+Vic34HxtgPHePAVis+V12xPil
 /TZ+HPvVwmaaChU4OuSt3xMXO8nSCwqFGq1JYRDhlIlcENhlXkWG29Cn2G6qcRXDyUz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xAIuNU5ZYng/C7qQieVjvYjkkYjU4omMn9PqprxTWSY=; b=BZr61W23rHhwkYn7wgX1U+/XcM
 7QPzGbSEiyASqHuLQiNoFZXoO3xGwr+ucjAm9VpA5p85jgKlz0D1r90B/yPFAFm0xxIdIzgENsF1h
 jeSWZxVGmsTPQJN4HsXEpHB/yB6oit9ZDk2hqkibiZePOfNPs1mBqhMFNGvgm8H0+c2I=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tEsP7-0004M6-0y for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 23 Nov 2024 15:50:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28360A403DF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 23 Nov 2024 15:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05068C4CECD;
 Sat, 23 Nov 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732377026;
 bh=XT9zzKOdfdchStJsLUSyFcrd594yylJRHhSHXGI1VVg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DJtuPd2XOJby+FWLFQPznGujNiyucTulN0lI/PId/oFQUcpwQUxO8TPIOIXKytxZa
 FVT3PoTyQDrEMd4erPHGGoQCjKJEleuBtA1Y1l7t9EVaz8JyYjzYf2DQlcV9QHu8J9
 X6grHaYlc2CcnZdLX2dSPk0DM7bsIp4qqswy3WsjnQZUdx+2CMnz3RLmP5x2NvpG22
 wSF5vWXRu5WN4x6XEjJqmC/nrIPUghsp3855/O7Umqarzy8IQXQU3ARTh1GFjpiBIz
 38BaZn0Q5UpF8sjNkDLfy7XIfBOLiJSTUc6QxxPVAkdkhtRUdgaPQDY8Z2R4TJRyUo
 yZz3+3IMx/Uww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 71BCC3809A06; Sat, 23 Nov 2024 15:50:39 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173237703828.3018181.12274971002493220671.git-patchwork-notify@kernel.org>
Date: Sat, 23 Nov 2024 15:50:38 +0000
References: <20241120065850.1345670-1-chao@kernel.org>
In-Reply-To: <20241120065850.1345670-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tEsP7-0004M6-0y
Subject: Re: [f2fs-dev] [PATCH] f2fs: print message if fscorrupted was found
 in f2fs_new_node_page()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 20 Nov 2024 14:58:50 +0800 you wrote:
> If fs corruption occurs in f2fs_new_node_page(), let's print
> more information about corrupted metadata into kernel log.
> 
> Meanwhile, it updates to record ERROR_INCONSISTENT_NAT instead
> of ERROR_INVALID_BLKADDR if blkaddr in nat entry is not
> NULL_ADDR which means nat bitmap and nat entry is inconsistent.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: print message if fscorrupted was found in f2fs_new_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/81520c684ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
