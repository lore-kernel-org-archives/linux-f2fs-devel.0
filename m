Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CABC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 May 2022 19:53:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ntaau-0000NI-Of; Tue, 24 May 2022 19:53:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1ntaat-0000NC-7l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 19:53:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OjfyAeZhDkHl5U9YvPYsWySTFZ1XXM3tkhBKQqn+Cq8=; b=PGYnR0tI6+PhQ4pjmCvCOsn+di
 MXiZSGBZIxgqiF7gw20dn8PkJx3fwiUCN7HKFWvlbmcSDYUnBoujgPI7GNbvrxzFbHxs2b7XZHRYc
 OYhXQgSO0SebvsBWslJxlE6GloDGAuSdjJ4kapuyE2OVuPDa0nRtZ5yFTkWEz5p3Ld2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OjfyAeZhDkHl5U9YvPYsWySTFZ1XXM3tkhBKQqn+Cq8=; b=IqeSeLOe+Kx9jJWvzL53qOLrTJ
 R9Asg0a2SuhFTNOjsIunwB0PKshAHnUQ4CfOIzXutEx4h2HeUjvD4xFH98ngdXX3u7CoiQwAI507K
 akUKr7mVoDUluHomGKSGxpNek88Th3nU7Toq+q0WiBjY4fCPnoS334q//ju8YreEShdk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ntaaq-000384-Rs
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 May 2022 19:53:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AA539616CE;
 Tue, 24 May 2022 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA35C34115;
 Tue, 24 May 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653421994;
 bh=sIX5nepxizjoL5CUIZMMrQ7EMyDjBxLiWbw2JWQ11CY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=NEK2UjL9rBbHHy4NXYKRTLJyDgwZaVw/B6sBAkYZoAz/QfUPs9gYQSruZoRTRELvy
 PkoCh0nEVxvahDBr7mYA52TNVCUNJa4WsX9s3AJoX/ANec5ZgdmjwXMEXHfVxMzjEM
 CfxJucsq0bCCtz7BJ+bpT2dGiuJO115hzLXZYDeK/SatE9D2aahfJi0nurNKL5VH7I
 FKmLL6KQGYxs403zE1oKNcrwbQbi+F9vw0KxqApRnmf3XTRgdfDVm+Yc8VUcCYN9D8
 h87wwwjIYs3bAogORo7esUl74KxMCUhyvSBjFJyWm7DH+Ro1I9Xu4GFKTSqdHNT7zB
 QwOr7nGQD/gog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E8D99E8DD61; Tue, 24 May 2022 19:53:13 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <YoszVvtG55xJnUJ6@sol.localdomain>
References: <YoszVvtG55xJnUJ6@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoszVvtG55xJnUJ6@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: e6af1bb07704b53bad7771db1b05ee17abad11cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51518aa68c1ffb54f2fdfed5324af30325529b32
Message-Id: <165342199394.18932.13143767074670225290.pr-tracker-bot@kernel.org>
Date: Tue, 24 May 2022 19:53:13 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1ntaaq-000384-Rs
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 5.19
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
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 23 May 2022 00:10:14 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51518aa68c1ffb54f2fdfed5324af30325529b32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
