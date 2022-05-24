Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D603C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 May 2022 19:53:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ntaas-0005BA-1O; Tue, 24 May 2022 19:53:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1ntaaq-0005B4-7z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 19:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ARyaeLcNqrmExdGnAHeueZY9ux/jQWTJm8RZYcgTjKY=; b=hqDfEk4PL0mSRiQ6LI9tn7uOCO
 WuHMhFcGzpsUforTVBprdfTu+/10wC8nS/itSvdEHZWt392jCSOsIfXI9tljmzg5brUrhx66i8w0D
 BkhY+a+snk9GSCNZ9YUxUKsIfBaKeU5C7tWaASo9JKiwcKIpLZnuGtoqwZv8hjLP2f1o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ARyaeLcNqrmExdGnAHeueZY9ux/jQWTJm8RZYcgTjKY=; b=axh6mFSyR1+cw6vnkGs70r6lNC
 fKz+1/tdTHX1gq8axceIRsSJzZBv0Oe2HdqkY0xaDvZWUzdtjxW2JfVE3t+rCQpnLsuv2n1vzOSf+
 sKb4IRWRhVorKMPGjRttQJEpDEaDgrWsMCC6YEN5Fsn54bHpLhoWoNoEucmpV8idm5WQ=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ntaao-006ZKc-0Q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 19:53:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8277FB81BA1;
 Tue, 24 May 2022 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28CFAC36AE5;
 Tue, 24 May 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653421994;
 bh=7vCQf4vTrafHpbFlTVFe9qAPgMyoesliZ7cB5zsfznE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=l7nVX+XLhiNFzMN0IvOoXAjS2btaJ/At8c3DNT5Wwu8r/LU3IYAD4o7dGumNySCAX
 25C5LLzWDn+zC7WRnNcfg1JxD/U/kWv9gxLRNAS3Q428K/p3t0Z30qAbz6/mskVsYF
 lp1lG0lMJh0rq8q7gtbwk93/ODvOPbSduCrWisWx3+/bcoDvyKy/zrsKNZYXZMM96p
 +vigOT/A2S7qrxwYfK04YcIKzNT2wdTOiIDve+6/ZpVRoKdOSC0QuddJHnPDcGA5Sm
 0OKOU+a78vQlmQ/YIn1Ckf274wuu2y3k8XACcgCzj2cBfE9GPDy2BnKSmuHIuOaz4d
 tGu4sK+qXKW+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0CD80F03943; Tue, 24 May 2022 19:53:14 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Yosyx2FYZOIOWs9g@sol.localdomain>
References: <Yosyx2FYZOIOWs9g@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yosyx2FYZOIOWs9g@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 218d921b581eadf312c8ef0e09113b111f104eeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f4cfdbef409971fd9d6b1faae4d7cc72af3e20
Message-Id: <165342199404.18932.5994094539908457947.pr-tracker-bot@kernel.org>
Date: Tue, 24 May 2022 19:53:14 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1ntaao-006ZKc-0Q
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 5.19
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 23 May 2022 00:07:51 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f4cfdbef409971fd9d6b1faae4d7cc72af3e20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
