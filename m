Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAF4D5D688
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:30:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t999W-0005ay-Qq;
	Thu, 07 Nov 2024 20:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t999U-0005ao-JA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DG1+0Sue0A6dSlig1loJC+oJAK4wy91odhpKFViv748=; b=O8KRd0YPBNmpoNpIFS7SFvPYGb
 lDV9b0uNnXvfaoMhBkOf97MS3oeyafV2DqVXdAuE1miWm/6E9lnsGDAn3yKiBkM6+l2yIzwloxCut
 C6W1JezP0Wpt9d7/EVAZNuSXX2NPWA63gxBLnOTr2Gl62T46bfypM9IabFb1R2UYhejA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DG1+0Sue0A6dSlig1loJC+oJAK4wy91odhpKFViv748=; b=Tjogweqcl++dSIMM4UN3TtnI7h
 tLSs/10G3Xv967bst3siRONhTcmjHRbKOnttvrpIyUWa6jC5vQZ4F+CIooJUiAfdczQhG60RkoXiw
 0RU1358GhioCe8zC/pAmkqMcW9fj9ak9tMFLKdhBYwAY5MpBU+pmFkSb6yeLRSHKG8MM=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t999T-0003ud-VW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7C506A44AD3;
 Thu,  7 Nov 2024 20:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFCCC4CECC;
 Thu,  7 Nov 2024 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731011437;
 bh=SRw5c6vZEaEZIOBQZUZInuFqCOHYEQSoUqSyPlNpi2M=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QetRH1r1q8FzJMLkYGU98H8LWNtduPVUU0OBLwPq/F4Ek1YXQOOHiWgu6dyrsL9E/
 L3kAdRRETjo9fP1/jMRKsWOMBOIMDMTvZumxo2S/dyl0E12JW1hHQGelnII+9nyRS6
 94zK1Dy7+FZ1ivnV2SqZ5+3uJxg100VwyqV1G3+bqCxH+lIto0WxiTsqA8JzZY3DRO
 H9TY/VdJMGNuQdHn1lpyYe+f2lVbfeplLdemjGT+DfSOLAC9PT6Ez9l9ka7/UFC82g
 KQu2cvb3pQnxhQY4LVXG98st6E3bwyhojfFFduSY7gf/uxYVH5D30Zz1D79EVtPGo8
 6meERtJTpQQdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70E353809A80; Thu,  7 Nov 2024 20:30:47 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173101144603.2084993.2473689864185308218.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:46 +0000
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1t999T-0003ud-VW
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove redundant atomic file check
 in defragment
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 31 Oct 2024 13:59:52 +0800 you wrote:
> f2fs_is_atomic_file(inode) is checked in f2fs_defragment_range,
> so remove the redundant checking in f2fs_ioc_defragment.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: remove redundant atomic file check in defragment
    https://git.kernel.org/jaegeuk/f2fs/c/744e66cb8779
  - [f2fs-dev,2/2] f2fs: fix to adjust appropriate length for fiemap
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
