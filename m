Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA40CD98E1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LlVNtTjJe94kh4/NRqN2deFDGgo90JQNotkyz7xZltQ=; b=YUKj+7gJN813IUCC+nKw9psnGp
	SM+385gUNiWPOdX3477qvvCS9j7vBPagwcKjqxnpWa3wBlrNmyG3T11zqRdTedijxCfrTo2LLYnrR
	lbX5OpYCBDHgyKkuYQyHrb3Ok6d6bPL0BR7+ugX4OzujCTekx7NLEH/EPPj/BuTzU8rc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZJsx-0007TB-Vx;
	Tue, 16 Jun 2026 02:50:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZJsu-0007Sj-TK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=juRHAjSe+0BdNITMb5EGhE9e/IWW1t6aiW+zWWoWSUI=; b=Ughtw1AtBvZa+pIJcpfmmqOve0
 jORBPp2R1sRC0MgvsSf2lJ/+2WBoh0D0Lp42NrovmXPfa5uy2EZrIowJPjvIyIOZuxO4Y6ZndclzZ
 UE6qgDo7gqgLtR62tP8ZV232T6b1eN5PuE0SPybsl2ze2Qb03PDaX8QdGHKlX98XfE1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=juRHAjSe+0BdNITMb5EGhE9e/IWW1t6aiW+zWWoWSUI=; b=P+nJWEpE+xCG6cr4T+q6gTPQR+
 9TFMXddUYh2lxiNjl+HHBxORgdtdpK1vx0jE4OqjWbdIMhnAM0psY4aezr1R9v0QObO9s2+mcNpSu
 NR27uSrr1QUI48NQi+PVr1bjEPQzqaLU/KS/VjfljzdteynljKAs6We5db+ozaYQumX8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZJsg-0008Pz-DF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E8DF600AB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 02:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC02B1F000E9;
 Tue, 16 Jun 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781578216;
 bh=juRHAjSe+0BdNITMb5EGhE9e/IWW1t6aiW+zWWoWSUI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=E2BTWQuPZcsqPHskJUWd2X1dKdCLtu32RH6AhRdJELeAJd9i/AdFheZf4Eo7KPfwS
 7kK/FJoa4Nlw+ympTq2Q+2Fz7L1c53uugjt7z3mYGLVIFnAwYlgnr19z9pS+3fiakK
 Go0PC7nO9d5vgkLlQWb0EJSfrkOS6zW+/5VznEevbnMpqIjHjQ5XUX9n+aKz3dTYOe
 fRtwh+/dFpQDz7gsBGn3qw0bQpaCt0p24u1lGTw1rYAvmzz0Zg9WxL/OtDJgi2R0gR
 myUjMHQ7HMyqt93Ebv6QRR0+kgE+Ufwei3kU+b9EjWd4Ra3zIGSBUb/j1dWyrww+kx
 G/LZz/y9u73nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 196C23839A26; Tue, 16 Jun 2026 02:50:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178157821063.407856.2821922506315460068.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:50:10 +0000
References: <20260615130822.2576088-1-chao@kernel.org>
In-Reply-To: <20260615130822.2576088-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wZJsg-0008Pz-DF
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: fix wrong description in printed
 log
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 15 Jun 2026 21:08:17 +0800 you wrote:
> This patch fixes wrong description in printed log:
> 
> "SSA and SIT" -> "SIT and SSA"
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,1/6] f2fs: fix wrong description in printed log
    https://git.kernel.org/jaegeuk/f2fs/c/123a88353dac
  - [f2fs-dev,2/6] f2fs: misc cleanup in f2fs_record_stop_reason()
    https://git.kernel.org/jaegeuk/f2fs/c/a1c83470ed0b
  - [f2fs-dev,3/6] f2fs: avoid unnecessary sanity check on ckpt_valid_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/701959ef9b9f
  - [f2fs-dev,4/6] f2fs: avoid unnecessary fscrypt_finalize_bounce_page()
    (no matching commit)
  - [f2fs-dev,5/6] f2fs: use fscrypt_finalize_bounce_page() for cleanup
    (no matching commit)
  - [f2fs-dev,6/6] f2fs: remove unneeded f2fs_is_compressed_page()
    https://git.kernel.org/jaegeuk/f2fs/c/7cc48ead1a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
